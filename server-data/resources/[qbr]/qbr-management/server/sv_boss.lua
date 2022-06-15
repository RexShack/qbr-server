
local Accounts = {}

CreateThread(function()
	Wait(500)
	local bossmenu = MySQL.Sync.fetchAll('SELECT * FROM management_menu WHERE menu_type = "boss"', {})
	if not bossmenu then
		return
	end
	for k,v in pairs(bossmenu) do
		local k = tostring(v.job_name)
		local v = tonumber(v.amount)
		if k and v then
			Accounts[k] = v
		end
	end
end)

RegisterNetEvent("qbr-bossmenu:server:withdrawMoney", function(amount)
	local src = source
	local xPlayer = exports['qbr-core']:GetPlayer(src)
	local job = xPlayer.PlayerData.job.name

	if not Accounts[job] then
		Accounts[job] = 0
	end

	if Accounts[job] >= amount and amount > 0 then
		Accounts[job] = Accounts[job] - amount
		xPlayer.Functions.AddMoney("cash", amount)
	else
		TriggerClientEvent('QBCore:Notify', src, 9, "Invalid Amount!", 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		TriggerClientEvent('qbr-bossmenu:client:OpenMenu', src)
		return
	end

	MySQL.Async.execute('UPDATE management_menu SET amount = ? WHERE job_name = ? AND menu_type = "boss"', { Accounts[job], job})
	TriggerEvent('qbr-log:server:CreateLog', 'bossmenu', 'Withdraw Money', "blue", xPlayer.PlayerData.name.. "Withdrawal $" .. amount .. ' (' .. job .. ')', true)
	TriggerClientEvent('QBCore:Notify', src, 9, "You have withdrawn: $" ..amount, 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
	TriggerClientEvent('qbr-bossmenu:client:OpenMenu', src)
end)

RegisterNetEvent("qbr-bossmenu:server:depositMoney", function(amount)
	local src = source
	local xPlayer = exports['qbr-core']:GetPlayer(src)
	local job = xPlayer.PlayerData.job.name

	if not Accounts[job] then
		Accounts[job] = 0
	end

	if xPlayer.Functions.RemoveMoney("cash", amount) then
		Accounts[job] = Accounts[job] + amount
	else
		TriggerClientEvent('QBCore:Notify', src, 9, "Invalid Amount!", 2000, 0, 'mp_lobby_textures', 'cross')
		TriggerClientEvent('qbr-bossmenu:client:OpenMenu', src)
		return
	end

	MySQL.Async.execute('UPDATE management_menu SET amount = ? WHERE job_name = ? AND menu_type = "boss"', { Accounts[job], job })
	TriggerEvent('qbr-log:server:CreateLog', 'bossmenu', 'Deposit Money', "blue", xPlayer.PlayerData.name.. "Deposit $" .. amount .. ' (' .. job .. ')', true)
	TriggerClientEvent('QBCore:Notify', src, 9, "You have deposited: $" ..amount, 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
	TriggerClientEvent('qbr-bossmenu:client:OpenMenu', src)
end)

RegisterNetEvent("qbr-bossmenu:server:addAccountMoney", function(account, amount)
	if not Accounts[account] then
		Accounts[account] = 0
	end

	Accounts[account] = Accounts[account] + amount
	MySQL.Async.execute('UPDATE management_menu SET amount = ? WHERE job_name = ? AND menu_type = "boss"', { Accounts[account], account })
end)

RegisterNetEvent("qbr-bossmenu:server:removeAccountMoney", function(account, amount)
	if not Accounts[account] then
		Accounts[account] = 0
	end

	if Accounts[account] >= amount then
		Accounts[account] = Accounts[account] - amount
	end

	MySQL.Async.execute('UPDATE management_menu SET amount = ? WHERE job_name = ? AND menu_type = "boss"', { Accounts[account], account })
end)

exports['qbr-core']:CreateCallback('qbr-bossmenu:server:GetAccount', function(source, cb, jobname)
	local result = GetAccount(jobname)
	cb(result)
end)

-- Export
function GetAccount(account)
	return Accounts[account] or 0
end

-- Get Employees
exports['qbr-core']:CreateCallback('qbr-bossmenu:server:GetEmployees', function(source, cb, jobname)
	local src = source
	local employees = {}
	if not Accounts[jobname] then
		Accounts[jobname] = 0
	end
	local players = MySQL.Sync.fetchAll("SELECT * FROM `players` WHERE `job` LIKE '%".. jobname .."%'", {})
	if players[1] ~= nil then
		for key, value in pairs(players) do
			local isOnline = exports['qbr-core']:GetPlayerByCitizenId(value.citizenid)

			if isOnline then
				employees[#employees+1] = {
				empSource = isOnline.PlayerData.citizenid,
				grade = isOnline.PlayerData.job.grade,
				isboss = isOnline.PlayerData.job.isboss,
				name = '🟢 ' .. isOnline.PlayerData.charinfo.firstname .. ' ' .. isOnline.PlayerData.charinfo.lastname
				}
			else
				employees[#employees+1] = {
				empSource = value.citizenid,
				grade =  json.decode(value.job).grade,
				isboss = json.decode(value.job).isboss,
				name = '❌ ' ..  json.decode(value.charinfo).firstname .. ' ' .. json.decode(value.charinfo).lastname
				}
			end
		end
		table.sort(employees, function(a, b)
            return a.grade.level > b.grade.level
        end)
	end
	cb(employees)
end)

-- Grade Change
RegisterNetEvent('qbr-bossmenu:server:GradeUpdate', function(data)
	local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local Employee = exports['qbr-core']:GetPlayerByCitizenId(data.cid)
	if Employee then
		if Employee.Functions.SetJob(Player.PlayerData.job.name, data.grado) then
			TriggerClientEvent('QBCore:Notify', src, 9, "Sucessfulluy promoted!", 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source, "You have been promoted to" ..data.nomegrado..".", 2000, 0, 'hud_textures', 'check')
		else
			TriggerClientEvent('QBCore:Notify', src, 9, "Promotion grade does not exist.", 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	else
		TriggerClientEvent('QBCore:Notify', src, 9, "Civilian not in city.", 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
	TriggerClientEvent('qbr-bossmenu:client:OpenMenu', src)
end)

-- Fire Employee
RegisterNetEvent('qbr-bossmenu:server:FireEmployee', function(target)
	local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local Employee = exports['qbr-core']:GetPlayerByCitizenId(target)
	if Employee then
		if target ~= Player.PlayerData.citizenid then
			if Employee.Functions.SetJob("unemployed", '0') then
				TriggerEvent("qbr-log:server:CreateLog", "bossmenu", "Job Fire", "red", Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. ' successfully fired ' .. Employee.PlayerData.charinfo.firstname .. " " .. Employee.PlayerData.charinfo.lastname .. " (" .. Player.PlayerData.job.name .. ")", false)
				TriggerClientEvent('QBCore:Notify', src, 9, "Employee fired!", 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
				TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source , "You have been fired! Good luck.", 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
			else
				TriggerClientEvent('QBCore:Notify', src, 9, "Error..", 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
			end
		else
			TriggerClientEvent('QBCore:Notify', src, 9, "You can\'t fire yourself", 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	else
		local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ? LIMIT 1', { target })
		if player[1] ~= nil then
			Employee = player[1]
			local job = {}
			job.name = "unemployed"
			job.label = "Unemployed"
			job.payment = 500
			job.onduty = true
			job.isboss = false
			job.grade = {}
			job.grade.name = nil
			job.grade.level = 0
			MySQL.Async.execute('UPDATE players SET job = ? WHERE citizenid = ?', { json.encode(job), target })
			TriggerClientEvent('QBCore:Notify', src, 9, "Employee fired!", 2000, 0, 'hud_textures', 'check')
			TriggerEvent("qbr-log:server:CreateLog", "bossmenu", "Job Fire", "red", Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. ' successfully fired ' .. Employee.PlayerData.charinfo.firstname .. " " .. Employee.PlayerData.charinfo.lastname .. " (" .. Player.PlayerData.job.name .. ")", false)
		else
			TriggerClientEvent('QBCore:Notify', src, 9, "Civilian not in city.", 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end
	TriggerClientEvent('qbr-bossmenu:client:OpenMenu', src)
end)

-- Recruit Player
RegisterNetEvent('qbr-bossmenu:server:HireEmployee', function(recruit)
	local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local Target = exports['qbr-core']:GetPlayer(recruit)
	if Player.PlayerData.job.isboss == true then
		if Target and Target.Functions.SetJob(Player.PlayerData.job.name, 0) then
			TriggerClientEvent('QBCore:Notify', src, 9, "You hired " .. (Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname) .. " come " .. Player.PlayerData.job.label .. "", 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			TriggerClientEvent('QBCore:Notify', Target.PlayerData.source , "You were hired as " .. Player.PlayerData.job.label .. "", 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			TriggerEvent('qbr-log:server:CreateLog', 'bossmenu', 'Recruit', "lightgreen", (Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname).. " successfully recruited " .. (Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname) .. ' (' .. Player.PlayerData.job.name .. ')', true)
		end
	end
	TriggerClientEvent('qbr-bossmenu:client:OpenMenu', src)
end)

-- Get closest player sv
exports['qbr-core']:CreateCallback('qbr-bossmenu:getplayers', function(source, cb)
	local src = source
	local players = {}
	local PlayerPed = GetPlayerPed(src)
	local pCoords = GetEntityCoords(PlayerPed)
	for k, v in pairs(exports['qbr-core']:GetPlayers()) do
		local targetped = GetPlayerPed(v)
		local tCoords = GetEntityCoords(targetped)
		local dist = #(pCoords - tCoords)
		if PlayerPed ~= targetped and dist < 10 then
			local ped = exports['qbr-core']:GetPlayer(v)
			players[#players+1] = {
			id = v,
			coords = GetEntityCoords(targetped),
			name = ped.PlayerData.charinfo.firstname .. " " .. ped.PlayerData.charinfo.lastname,
			citizenid = ped.PlayerData.citizenid,
			sources = GetPlayerPed(ped.PlayerData.source),
			sourceplayer = ped.PlayerData.source
			}
		end
	end
		table.sort(players, function(a, b)
			return a.name < b.name
		end)
	cb(players)
end)
