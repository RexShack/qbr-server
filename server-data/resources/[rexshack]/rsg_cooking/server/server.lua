
exports['qbr-core']:CreateUseableItem("cookkit", function(source, item)
	local Player = exports['qbr-core']:GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("rsg_cooking:client:cookinggrill", source, item.name)
    end
end)

-- process small fish for cooking
exports['qbr-core']:CreateUseableItem("smallfish", function(source, item)
	local src = source
	TriggerClientEvent("rsg_cooking:client:smallfish", src)
end)

-- process mediumfish fish for cooking
exports['qbr-core']:CreateUseableItem("mediumfish", function(source, item)
	local src = source
	TriggerClientEvent("rsg_cooking:client:mediumfish", src)
end)

-- process largefish fish for cooking
exports['qbr-core']:CreateUseableItem("largefish", function(source, item)
	local src = source
	TriggerClientEvent("rsg_cooking:client:largefish", src)
end)