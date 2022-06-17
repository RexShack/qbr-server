local sharedItems = exports['qbr-core']:GetItems()

-- use map to mine1
exports['qbr-core']:CreateUseableItem("mapmine1", function(source, item)
    local src = source
	TriggerClientEvent("rsg_mining:client:gotomine1", src, item.name)
end)

-- use map to mine2
exports['qbr-core']:CreateUseableItem("mapmine2", function(source, item)
    local src = source
	TriggerClientEvent("rsg_mining:client:gotomine2", src, item.name)
end)

-- use map to mine3
exports['qbr-core']:CreateUseableItem("mapmine3", function(source, item)
    local src = source
	TriggerClientEvent("rsg_mining:client:gotomine3", src, item.name)
end)

-- give reward
RegisterServerEvent('rsg_mining:server:giveMineReward')
AddEventHandler('rsg_mining:server:giveMineReward', function()
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	local randomNumber = math.random(1,100)
	
	if randomNumber > 0 and randomNumber <= 70 then
		local _subRan = math.random(1,5)
			if _subRan == 1 then
				Player.Functions.AddItem('copper', 1)
				TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['copper'], "add")
				TriggerClientEvent('QBCore:Notify', src, 9, 'you found some copper', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			elseif _subRan == 2 then
				Player.Functions.AddItem('aluminum', 1)
				TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['aluminum'], "add")
				TriggerClientEvent('QBCore:Notify', src, 9, 'you found some aluminum', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			elseif _subRan == 3 then
				Player.Functions.AddItem('iron', 1)
				TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['iron'], "add")
				TriggerClientEvent('QBCore:Notify', src, 9, 'you found some iron', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			elseif _subRan == 4 then
				Player.Functions.AddItem('steel', 1)
				TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['steel'], "add")
				TriggerClientEvent('QBCore:Notify', src, 9, 'you found some steel', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			else
			TriggerClientEvent('QBCore:Notify', src, 9, 'you did not find anything!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
			
	elseif randomNumber > 70 and randomNumber <= 100 then
		local _subRan = math.random(1,4)
			if _subRan == 1 then
				Player.Functions.AddItem('smallnugget', 1)
				TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['smallnugget'], "add")
				TriggerClientEvent('QBCore:Notify', src, 9, 'you found a small gold nugget', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			elseif _subRan == 2 then
				Player.Functions.AddItem('mediumnugget', 1)
				TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['mediumnugget'], "add")
				TriggerClientEvent('QBCore:Notify', src, 9, 'you found a medium gold nugget', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			elseif _subRan == 3 then
				Player.Functions.AddItem('largenugget', 1)
				TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['largenugget'], "add")
				TriggerClientEvent('QBCore:Notify', src, 9, 'you found a large gold nugget', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			else
			TriggerClientEvent('QBCore:Notify', src, 9, 'you did not find anything!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
    end
end)