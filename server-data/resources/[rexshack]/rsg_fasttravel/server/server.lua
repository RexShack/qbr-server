
RegisterServerEvent('rsg_fasttravel:server:buyTicket')
AddEventHandler('rsg_fasttravel:server:buyTicket', function(pos, price)
	local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	local cashBalance = Player.PlayerData.money["cash"]
	if cashBalance >= price then
		Player.Functions.RemoveMoney("cash", price, "purchase-fasttravel")
		TriggerClientEvent('rsg_fasttravel:client:doTravel', src, pos)
	else 
		TriggerClientEvent('QBCore:Notify', src, 9, 'you don\'t have enough cash on you!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		TriggerClientEvent('rsg_fasttravel:client:closemenu', src)
	end
end)