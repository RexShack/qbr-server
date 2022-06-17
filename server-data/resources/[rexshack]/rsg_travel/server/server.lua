local sharedItems = exports['qbr-core']:GetItems()

RegisterServerEvent('rsg_travel:server:buyticket')
AddEventHandler('rsg_travel:server:buyticket', function(price)
	local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	local cashBalance = Player.PlayerData.money["cash"]
	if cashBalance >= price then
		Player.Functions.RemoveMoney("cash", price, "purchase-ticket")
		Player.Functions.AddItem('boatticket', 1)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['boatticket'], "add")
		TriggerClientEvent('QBCore:Notify', src, 9, 'boat ticket bought for $'..price, 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
	else 
		TriggerClientEvent('QBCore:Notify', src, 9, 'you don\'t have enough cash to do that!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)