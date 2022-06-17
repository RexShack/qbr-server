local sharedItems = exports['qbr-core']:GetItems()

-- sell blood money
RegisterServerEvent('rsg_outlaws:server:sellbloodmoney')
AddEventHandler('rsg_outlaws:server:sellbloodmoney', function(amount)
	local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	local amount = tonumber(amount)
	local checkbars = Player.Functions.GetItemByName("bloodmoney")
	if checkbars ~= nil then
		local amountbars = Player.Functions.GetItemByName('bloodmoney').amount
		if amountbars >= amount then
			bloodmoneyprice = Config.BloodMoneyPrice
			totalcash = (amount * bloodmoneyprice) 
			Player.Functions.RemoveItem('bloodmoney', amount)
			TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['bloodmoney'], "remove")
			Player.Functions.AddMoney('cash', totalcash)
			TriggerClientEvent('QBCore:Notify', src, 9, 'You sold ' ..amount.. ' blood money for $'..totalcash, 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
		else
			TriggerClientEvent('QBCore:Notify', src, 9, 'You do not have enough blood money to do that!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	else
		TriggerClientEvent('QBCore:Notify', src, 9, 'You do not have any blood money!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)

-- sell gold bars
RegisterServerEvent('rsg_outlaws:server:sellgoldbars')
AddEventHandler('rsg_outlaws:server:sellgoldbars', function(amount)
	local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	local amount = tonumber(amount)
	local checkbars = Player.Functions.GetItemByName("goldbar")
	if checkbars ~= nil then
		local amountbars = Player.Functions.GetItemByName('goldbar').amount
		if amountbars >= amount then
			goldbarprice = Config.GoldBarPrice
			totalcash = (amount * goldbarprice) 
			Player.Functions.RemoveItem('goldbar', amount)
			TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['goldbar'], "remove")
			Player.Functions.AddMoney('cash', totalcash)
			TriggerClientEvent('QBCore:Notify', src, 9, 'You sold ' ..amount.. ' gold bars for $'..totalcash, 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
		else
			TriggerClientEvent('QBCore:Notify', src, 9, 'You do not have enough gold bars to do that!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	else
		TriggerClientEvent('QBCore:Notify', src, 9, 'You do not have any gold bars!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)