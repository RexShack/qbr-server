
exports['qbr-core']:CreateUseableItem("beer", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("rsg_drinker:client:DrinkBeer", source, item.name)
    end
end)

exports['qbr-core']:CreateUseableItem("whiskey", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("rsg_drinker:client:DrinkWhiskey", source, item.name)
    end
end)

exports['qbr-core']:CreateUseableItem("moonshine", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("rsg_drinker:client:DrinkMoonshine", source, item.name)
    end
end)

exports['qbr-core']:CreateUseableItem("coffee", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("rsg_drinker:client:DrinkCoffee", source, item.name)
    end
end)