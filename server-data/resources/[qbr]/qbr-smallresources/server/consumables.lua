
-- Drink

exports['qbr-core']:CreateUseableItem("water_bottle", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Drink", source, item.name)
    end
end)

exports['qbr-core']:CreateUseableItem("coffee", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Drink", source, item.name)
    end
end)

-- DrinkAlcohol

exports['qbr-core']:CreateUseableItem("vodka", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name)
end)

exports['qbr-core']:CreateUseableItem("beer", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name)
end)

exports['qbr-core']:CreateUseableItem("whiskey", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
    TriggerClientEvent("consumables:client:DrinkAlcohol", source, item.name)
end)

-- EAT

exports['qbr-core']:CreateUseableItem("sandwich", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

exports['qbr-core']:CreateUseableItem("bread", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

exports['qbr-core']:CreateUseableItem("apple", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

exports['qbr-core']:CreateUseableItem("chocolate", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Eat", source, item.name)
    end
end)

-- OTHER

exports['qbr-core']:CreateUseableItem("cigarette", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Smoke", source, item.name)
    end
end)

exports['qbr-core']:CreateUseableItem("cigar", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
	if Player.Functions.RemoveItem(item.name, 1, item.slot) then
        TriggerClientEvent("consumables:client:Smoke", source, item.name)
    end
end)

exports['qbr-core']:CreateUseableItem("binoculars", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
    TriggerClientEvent("binoculars:Toggle", source)
end)

exports['qbr-core']:CreateUseableItem("dual", function(source, item)
    local Player = exports['qbr-core']:GetPlayer(source)
    TriggerClientEvent("qb:Dual", source)
end)