local sharedItems = exports['qbr-core']:GetItems()

RegisterNetEvent("rsg_holding:server:storepelt")
AddEventHandler("rsg_holding:server:storepelt", function(item)
	local src = tonumber(source)
	local Player = exports['qbr-core']:GetPlayer(src)
	Player.Functions.AddItem(item, 1)
	TriggerClientEvent('inventory:client:ItemBox', src, sharedItems[item], "add")
end)