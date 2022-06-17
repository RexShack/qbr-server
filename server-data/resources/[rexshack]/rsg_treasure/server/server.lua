local sharedItems = exports['qbr-core']:GetItems()

RegisterNetEvent('rsg_treasure:server:givereward', function()
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    local chance = math.random(1,100)
	-- common reward (95% chance)
    if chance <= 95 then -- reward : 3 x common
        local item1 = Config.CommonItems[math.random(1, #Config.CommonItems)]
		local item2 = Config.CommonItems[math.random(1, #Config.CommonItems)]
		local item3 = Config.CommonItems[math.random(1, #Config.CommonItems)]
        
        Player.Functions.AddItem(item1, math.random(1,3))
        TriggerClientEvent("inventory:client:ItemBox", src, sharedItems[item1], "add")
		Player.Functions.AddItem(item2, math.random(1,3))
        TriggerClientEvent("inventory:client:ItemBox", src, sharedItems[item2], "add")
		Player.Functions.AddItem(item3, math.random(1,3))
        TriggerClientEvent("inventory:client:ItemBox", src, sharedItems[item3], "add")
	-- rare reward (5% chance)
    elseif chance > 95 then -- reward : 1 x rare and 2 x common
        local item1 = Config.RareItems[math.random(1, #Config.RareItems)]
		local item2 = Config.CommonItems[math.random(1, #Config.CommonItems)]
		local item3 = Config.CommonItems[math.random(1, #Config.CommonItems)]
        
        Player.Functions.AddItem(item1, 1)
        TriggerClientEvent("inventory:client:ItemBox", src, sharedItems[item1], "add")
		Player.Functions.AddItem(item2, math.random(1,3))
        TriggerClientEvent("inventory:client:ItemBox", src, sharedItems[item2], "add")
		Player.Functions.AddItem(item3, math.random(1,3))
        TriggerClientEvent("inventory:client:ItemBox", src, sharedItems[item3], "add")
    else
        print("something went wrong")
    end 
end)