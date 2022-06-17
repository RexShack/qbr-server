local Small_Reward = math.random(1,3)
local Medium_Reward = math.random(2,4)
local Large_Reward = math.random(3,5)
local sharedItems = exports['qbr-core']:GetItems()

RegisterServerEvent("rsg_butcher:reward")
AddEventHandler("rsg_butcher:reward", function(amount, model)
	local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local money = amount
	local item = model

	if item == 'biggame' then
		Player.Functions.AddMoney('cash', money)
		Player.Functions.AddItem('raw_meat', Large_Reward)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['raw_meat'], "add")
	elseif item == 'venison' then
		Player.Functions.AddMoney('cash', money)
		Player.Functions.AddItem('raw_meat', Medium_Reward)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['raw_meat'], "add")
	elseif item == 'bird' then
		Player.Functions.AddMoney('cash', money)
		Player.Functions.AddItem('raw_meat', Small_Reward)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['raw_meat'], "add")
	elseif item == 'game' then
		Player.Functions.AddMoney('cash', money)
		Player.Functions.AddItem('raw_meat', Small_Reward)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['raw_meat'], "add")
	elseif item == 'stringy' then
		Player.Functions.AddMoney('cash', money)
		Player.Functions.AddItem('raw_meat', Small_Reward)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['raw_meat'], "add")
	elseif item == 'fish' then
		Player.Functions.AddMoney('cash', money)
		Player.Functions.AddItem('raw_meat', Small_Reward)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['raw_meat'], "add")
	end
end)