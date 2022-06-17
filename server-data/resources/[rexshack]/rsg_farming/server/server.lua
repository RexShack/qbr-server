local sharedItems = exports['qbr-core']:GetItems()

-- use cornseed
exports['qbr-core']:CreateUseableItem("cornseed", function(source, item)
    local src = source
	TriggerClientEvent("rsg_farming:client:planting", src, item.name, `CRP_CORNSTALKS_CB_SIM`, `CRP_CORNSTALKS_CA_SIM`, `CRP_CORNSTALKS_AB_SIM`)
end)

-- use sugarseed
exports['qbr-core']:CreateUseableItem("sugarseed", function(source, item)
    local src = source
	TriggerClientEvent("rsg_farming:client:planting", src, item.name, `CRP_SUGARCANE_AA_SIM`, `CRP_SUGARCANE_AB_SIM`, `CRP_SUGARCANE_AC_SIM`)
end)

-- use tobaccoseed
exports['qbr-core']:CreateUseableItem("tobaccoseed", function(source, item)
    local src = source
	TriggerClientEvent("rsg_farming:client:planting", src, item.name, `CRP_TOBACCOPLANT_AA_SIM`, `CRP_TOBACCOPLANT_AB_SIM`, `CRP_TOBACCOPLANT_AC_SIM`)
end)

-- use carrotseed
exports['qbr-core']:CreateUseableItem("carrotseed", function(source, item)
    local src = source
	TriggerClientEvent("rsg_farming:client:planting", src, item.name, `CRP_CARROTS_AA_SIM`, `CRP_CARROTS_AA_SIM`, `CRP_CARROTS_AA_SIM`)
end)

-- use tomatoseed
exports['qbr-core']:CreateUseableItem("tomatoseed", function(source, item)
    local src = source
	TriggerClientEvent("rsg_farming:client:planting", src, item.name, `CRP_TOMATOES_AA_SIM`, `CRP_TOMATOES_AA_SIM`, `CRP_TOMATOES_AA_SIM`)
end)

-- use wateringcan
exports['qbr-core']:CreateUseableItem("wateringcan", function(source, item)
    local src = source
	TriggerClientEvent("rsg_farming:client:waterplant", src)
end)

-- give farming reward
RegisterServerEvent('rsg_farming:server:giveitem')
AddEventHandler('rsg_farming:server:giveitem', function(plant)
    local src = source
    local xPlayer = exports['qbr-core']:GetPlayer(src)
	local randomReward = math.random(1,7)
	-- corn
	if plant == `CRP_CORNSTALKS_AB_sim` then
		xPlayer.Functions.AddItem('corn', randomReward)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems["corn"], "add")
		TriggerClientEvent('QBCore:Notify', src, 8, 'Successful Harvest', 5000, 'you harvested '..randomReward..' corn', 'inventory_items_mp', 'generic_bundle_provisions', 'COLOR_WHITE')
	-- sugar
	elseif plant == `CRP_SUGARCANE_AC_sim` then
		xPlayer.Functions.AddItem('sugar', randomReward)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems["sugar"], "add")
		TriggerClientEvent('QBCore:Notify', src, 8, 'Successful Harvest', 5000, 'you harvested '..randomReward..' sugar', 'inventory_items_mp', 'generic_bundle_provisions', 'COLOR_WHITE')
	-- tobacco
	elseif plant == `CRP_TOBACCOPLANT_AC_sim` then
		xPlayer.Functions.AddItem('tobacco', randomReward)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems["tobacco"], "add")
		TriggerClientEvent('QBCore:Notify', src, 8, 'Successful Harvest', 5000, 'you harvested '..randomReward..' tobacco', 'inventory_items_mp', 'generic_bundle_provisions', 'COLOR_WHITE')
	-- carrot
	elseif plant == `CRP_CARROTS_AA_SIM` then
		xPlayer.Functions.AddItem('carrot', randomReward)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems["carrot"], "add")
		TriggerClientEvent('QBCore:Notify', src, 8, 'Successful Harvest', 5000, 'you harvested '..randomReward..' carrot', 'inventory_items_mp', 'generic_bundle_provisions', 'COLOR_WHITE')
	-- tomatoes
	elseif plant == `CRP_TOMATOES_AA_SIM` then
		xPlayer.Functions.AddItem('tomato', randomReward)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems["tomato"], "add")
		TriggerClientEvent('QBCore:Notify', src, 8, 'Successful Harvest', 5000, 'you harvested '..randomReward..' tomato', 'inventory_items_mp', 'generic_bundle_provisions', 'COLOR_WHITE')
	else
		TriggerClientEvent('QBCore:Notify', src, 9, 'something went wrong!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)