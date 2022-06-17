
-- use moonshine kit
exports['qbr-core']:CreateUseableItem("moonshinekit", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent('rsg_moonshiner:client:moonshinekit', source, item.name)
    end
end)