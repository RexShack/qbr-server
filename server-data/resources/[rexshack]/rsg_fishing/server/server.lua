local sharedItems = exports['qbr-core']:GetItems()

-- use fishingrod
exports['qbr-core']:CreateUseableItem("fishingrod", function(source, item)
    local src = tonumber(source)
	TriggerClientEvent("rsg_fishing:client:StartFishing", src, item.name)
end)

-- give fishing reward
RegisterServerEvent('rsg_fishing:server:fishcaught')
AddEventHandler('rsg_fishing:server:fishcaught', function()
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	local randomNumber = math.random(1,4)
	if randomNumber == 1 then
		Player.Functions.AddItem('smallfish', 1)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['smallfish'], "add")
		TriggerClientEvent('QBCore:Notify', src, 8, 'Fish Caught', 5000, 'you caught a small fish', 'inventory_items_mp', 'generic_bundle_fishing', 'COLOR_WHITE')
	elseif randomNumber == 2 then
		Player.Functions.AddItem('mediumfish', 1)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['mediumfish'], "add")
		TriggerClientEvent('QBCore:Notify', src, 8, 'Fish Caught', 5000, 'you caught a medium fish', 'inventory_items_mp', 'generic_bundle_fishing', 'COLOR_WHITE')
	elseif randomNumber == 3 then
		Player.Functions.AddItem('largefish', 1)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['largefish'], "add")
		TriggerClientEvent('QBCore:Notify', src, 8, 'Fish Caught', 5000, 'you caught a large fish', 'inventory_items_mp', 'generic_bundle_fishing', 'COLOR_WHITE')
	else
		TriggerClientEvent('QBCore:Notify', src, 9, 'these fish are not biting today!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)