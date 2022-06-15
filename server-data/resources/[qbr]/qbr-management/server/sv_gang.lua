
local GangaccountGangs = {}

CreateThread(function()
	Wait(500)
	local gangmenu = MySQL.Sync.fetchAll('SELECT * FROM management_menu WHERE menu_type = "gang"', {})
	if not gangmenu then
		return
	end
	for k,v in pairs(gangmenu) do
		local k = tostring(v.job_name)
		local v = tonumber(v.amount)
		if k and v then
			GangaccountGangs[k] = v
		end
	end
end)

RegisterNetEvent("qbr-gangmenu:server:withdrawMoney", function(amount)
	local src = source
	local xPlayer = exports['qbr-core']:GetPlayer(src)
	local gang = xPlayer.PlayerData.gang.name

	if not GangaccountGangs[gang] then
		GangaccountGangs[gang] = 0
	end

	if GangaccountGangs[gang] >= amount and amount > 0 then
		GangaccountGangs[gang] = GangaccountGangs[gang] - amount
		xPlayer.Functions.AddMoney("cash", amount, 'Boss menu withdraw')
	else
		TriggerClientEvent('QBCore:Notify', src, 9, "Invalid amount!", 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		TriggerClientEvent('qbr-gangmenu:client:OpenMenu', src)
		return
	end

	MySQL.Async.execute('UPDATE management_menu SET amount = ? WHERE job_name = ? AND menu_type = "gang"', { GangaccountGangs[gang], gang })
	TriggerEvent('qbr-log:server:CreateLog', 'gangmenu', 'Withdraw Money', 'yellow', xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname .. ' successfully withdrew $' .. amount .. ' (' .. gang .. ')', false)
	TriggerClientEvent('QBCore:Notify', src, 9, "You have withdrawn: $" ..amount, 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
	TriggerClientEvent('qbr-gangmenu:client:OpenMenu', src)
end)

RegisterNetEvent("qbr-gangmenu:server:depositMoney", function(amount)
	local src = source
	local xPlayer = exports['qbr-core']:GetPlayer(src)
	local gang = xPlayer.PlayerData.gang.name

	if not GangaccountGangs[gang] then
		GangaccountGangs[gang] = 0
	end

	if xPlayer.Functions.RemoveMoney("cash", amount) then
		GangaccountGangs[gang] = GangaccountGangs[gang] + amount
	else
		TriggerClientEvent('QBCore:Notify', src, 9, "Invalid amount!", 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		TriggerClientEvent('qbr-gangmenu:client:OpenMenu', src)
		return
	end

	MySQL.Async.execute('UPDATE management_menu SET amount = ? WHERE job_name = ? AND menu_type = "gang"', { GangaccountGangs[gang], gang })
	TriggerEvent('qbr-log:server:CreateLog', 'gangmenu', 'Deposit Money', 'yellow', xPlayer.PlayerData.charinfo.firstname .. ' ' .. xPlayer.PlayerData.charinfo.lastname .. ' successfully deposited $' .. amount .. ' (' .. gang .. ')', false)
	TriggerClientEvent('QBCore:Notify', src, 9, "You have deposited: $" ..amount, 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
	TriggerClientEvent('qbr-gangmenu:client:OpenMenu', src)
end)

RegisterNetEvent("qbr-gangmenu:server:addaccountGangMoney", function(accountGang, amount)
	if not GangaccountGangs[accountGang] then
		GangaccountGangs[accountGang] = 0
	end

	GangaccountGangs[accountGang] = GangaccountGangs[accountGang] + amount
	MySQL.Async.execute('UPDATE management_menu SET amount = ? WHERE job_name = ? AND menu_type = "gang"', { GangaccountGangs[accountGang], accountGang })
end)

RegisterNetEvent("qbr-gangmenu:server:removeaccountGangMoney", function(accountGang, amount)
	if not GangaccountGangs[accountGang] then
		GangaccountGangs[accountGang] = 0
	end

	if GangaccountGangs[accountGang] >= amount then
		GangaccountGangs[accountGang] = GangaccountGangs[accountGang] - amount
	end

	MySQL.Async.execute('UPDATE management_menu SET amount = ? WHERE job_name = ? AND menu_type = "gang"', { GangaccountGangs[accountGang], accountGang })
end)

exports['qbr-core']:CreateCallback('qbr-gangmenu:server:GetAccount', function(source, cb, GangName)
	local gangmoney = GetaccountGang(GangName)
	cb(gangmoney)
end)

-- Export
function GetaccountGang(accountGang)
	return GangaccountGangs[accountGang] or 0
end

-- Get Employees
exports['qbr-core']:CreateCallback('qbr-gangmenu:server:GetEmployees', function(source, cb, gangname)
	local src = source
	local employees = {}
	if not GangaccountGangs[gangname] then
		GangaccountGangs[gangname] = 0
	end
	local players = MySQL.Sync.fetchAll("SELECT * FROM `players` WHERE `gang` LIKE '%".. gangname .."%'", {})
	if players[1] ~= nil then
		for key, value in pairs(players) do
			local isOnline = exports['qbr-core']:GetPlayerByCitizenId(value.citizenid)

			if isOnline then
				employees[#employees+1] = {
				empSource = isOnline.PlayerData.citizenid,
				grade = isOnline.PlayerData.gang.grade,
				isboss = isOnline.PlayerData.gang.isboss,
				name = '🟢' .. isOnline.PlayerData.charinfo.firstname .. ' ' .. isOnline.PlayerData.charinfo.lastname
				}
			else
				employees[#employees+1] = {
				empSource = value.citizenid,
				grade =  json.decode(value.gang).grade,
				isboss = json.decode(value.gang).isboss,
				name = '❌' ..  json.decode(value.charinfo).firstname .. ' ' .. json.decode(value.charinfo).lastname
				}
			end
		end
	end
	cb(employees)
end)

-- Grade Change
RegisterNetEvent('qbr-gangmenu:server:GradeUpdate', function(data)
	local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local Employee = exports['qbr-core']:GetPlayerByCitizenId(data.cid)
	if Employee then
		if Employee.Functions.SetGang(Player.PlayerData.gang.name, data.grado) then
			TriggerClientEvent('QBCore:Notify', src, 9, "Successfully promoted!", 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source, "You have been promoted to " ..data.nomegrado..".", 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
		else
			TriggerClientEvent('QBCore:Notify', src, 9, "Grade does not exist.", 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	else
		TriggerClientEvent('QBCore:Notify', src, 9, "Civilian is not in city.", 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
	TriggerClientEvent('qbr-gangmenu:client:OpenMenu', src)
end)

-- Fire Member
RegisterNetEvent('qbr-gangmenu:server:FireMember', function(target)
	local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local Employee = exports['qbr-core']:GetPlayerByCitizenId(target)
	if Employee then
		if target ~= Player.PlayerData.citizenid then
			if Employee.Functions.SetGang("none", '0') then
				TriggerEvent("qbr-log:server:CreateLog", "gangmenu", "Gang Fire", "orange", Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. ' successfully fired ' .. Employee.PlayerData.charinfo.firstname .. " " .. Employee.PlayerData.charinfo.lastname .. " (" .. Player.PlayerData.gang.name .. ")", false)
				TriggerClientEvent('QBCore:Notify', src, 9, "Gang Member fired!", 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
				TriggerClientEvent('QBCore:Notify', Employee.PlayerData.source , "You have been expelled from the gang!", 2000, 0, 'mp_lobby_textures', 'cross')
			else
				TriggerClientEvent('QBCore:Notify', src, 9, "Error.", 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
			end
		else
			TriggerClientEvent('QBCore:Notify', src, 9, "You can\'t kick yourself out of the gang!", 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	else
		local player = MySQL.Sync.fetchAll('SELECT * FROM players WHERE citizenid = ? LIMIT 1', {target})
		if player[1] ~= nil then
			Employee = player[1]
			local gang = {}
			gang.name = "none"
			gang.label = "No Affiliation"
			gang.payment = 0
			gang.onduty = true
			gang.isboss = false
			gang.grade = {}
			gang.grade.name = nil
			gang.grade.level = 0
			MySQL.Async.execute('UPDATE players SET gang = ? WHERE citizenid = ?', {json.encode(gang), target})
			TriggerClientEvent('QBCore:Notify', src, 9, "Gang member fired!", 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			TriggerEvent("qbr-log:server:CreateLog", "gangmenu", "Gang Fire", "orange", Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. ' successfully fired ' .. Employee.PlayerData.charinfo.firstname .. " " .. Employee.PlayerData.charinfo.lastname .. " (" .. Player.PlayerData.gang.name .. ")", false)
		else
			TriggerClientEvent('QBCore:Notify', src, 9, "Civilian is not in city.", 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end
	TriggerClientEvent('qbr-gangmenu:client:OpenMenu', src)
end)

-- Recruit Player
RegisterNetEvent('qbr-gangmenu:server:HireMember', function(recruit)
	local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local Target = exports['qbr-core']:GetPlayer(recruit)
	if Player.PlayerData.gang.isboss == true then
		if Target and Target.Functions.SetGang(Player.PlayerData.gang.name, 0) then
			TriggerClientEvent('QBCore:Notify', src, 9, "You hired " .. (Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname) .. " come " .. Player.PlayerData.gang.label .. "", 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			TriggerClientEvent('QBCore:Notify', Target.PlayerData.source , "You have been hired as " .. Player.PlayerData.gang.label .. "", 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			TriggerEvent('qbr-log:server:CreateLog', 'gangmenu', 'Recruit', 'yellow', (Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname).. ' successfully recruited ' .. Target.PlayerData.charinfo.firstname .. ' ' .. Target.PlayerData.charinfo.lastname .. ' (' .. Player.PlayerData.gang.name .. ')', false)
		end
	end
	TriggerClientEvent('qbr-gangmenu:client:OpenMenu', src)
end)

-- Get closest player sv
exports['qbr-core']:CreateCallback('qbr-gangmenu:getplayers', function(source, cb)
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
