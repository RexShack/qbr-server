
-- count tobacco leaves to dry
RegisterServerEvent('rsg_tobaccofactory:server:drytobaccoleaves')
AddEventHandler('rsg_tobaccofactory:server:drytobaccoleaves', function()
    local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local item = Player.Functions.GetItemByName('tobacco')
	if item ~= nil then
		local amount = item.amount
		TriggerClientEvent('rsg_tobaccofactory:client:dryleaves', src, amount)
	else
		TriggerClientEvent('rsg_notify:client:notifiy', src, 'you do not have any tobacco to dry!', 5000)
	end
end)

-- count dry tobacco leaves
RegisterServerEvent('rsg_tobaccofactory:server:makecigar')
AddEventHandler('rsg_tobaccofactory:server:makecigar', function()
    local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local item = Player.Functions.GetItemByName('tobaccodry')
	if item ~= nil then
		local amount = item.amount
		TriggerClientEvent('rsg_tobaccofactory:client:makecigar', src, amount)
	else
		TriggerClientEvent('rsg_notify:client:notifiy', src, 'you do not have any dry tobacco!', 5000)
	end
end)

-- count cigars
RegisterServerEvent('rsg_tobaccofactory:server:makecigarbox')
AddEventHandler('rsg_tobaccofactory:server:makecigarbox', function()
    local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local item = Player.Functions.GetItemByName('cigar')
	if item ~= nil then
		local amount = item.amount
		if amount >= 10 then
			TriggerClientEvent('rsg_tobaccofactory:client:makecigarbox', src, 1)
		else
			TriggerClientEvent('rsg_notify:client:notifiy', src, 'you need 10 cigars to pack a box!', 5000)
		end
	else
		TriggerClientEvent('rsg_notify:client:notifiy', src, 'you do not have any cigars!', 5000)
	end
end)