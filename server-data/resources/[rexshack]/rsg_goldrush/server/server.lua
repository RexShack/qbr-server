local sharedItems = exports['qbr-core']:GetItems()

exports['qbr-core']:CreateUseableItem("claimlease", function(source, item)
    local src = tonumber(source)
	TriggerClientEvent("rsg_goldrush:client:gotoclaim", src, item.name)
end)

-- give reward
RegisterServerEvent('rsg_goldrush::server:reward')
AddEventHandler('rsg_goldrush::server:reward', function()
    local src = tonumber(source)
	local Player = exports['qbr-core']:GetPlayer(source)
	local randomNumber = math.random(1,4)
	if randomNumber == 1 then
		local smallamount = 3
		Player.Functions.AddItem('smallnugget', smallamount)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['smallnugget'], "add")
		TriggerClientEvent('rsg_notify:client:notifiy', src, 'you found '..smallamount..' small nuggets', 5000)
	elseif randomNumber == 2 then
		local mediumamount = 2
		Player.Functions.AddItem('mediumnugget', mediumamount)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['mediumnugget'], "add")
		TriggerClientEvent('rsg_notify:client:notifiy', src, 'you found '..mediumamount..' medium nuggets', 5000)
	elseif randomNumber == 3 then
		local largeamount = 1
		Player.Functions.AddItem('largenugget', largeamount)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['largenugget'], "add")
		TriggerClientEvent('rsg_notify:client:notifiy', src, 'you found '..largeamount..' large nugget', 5000)
	else
		TriggerClientEvent('rsg_notify:client:notifiy', src, "no luck this time", 5000)
	end
end)