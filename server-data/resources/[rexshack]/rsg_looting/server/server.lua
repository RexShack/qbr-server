local sharedItems = exports['qbr-core']:GetItems()

local Small_Reward = math.random(1,10)
local Medium_Reward = math.random(10,25)
local Large_Reward = math.random(25,50)

RegisterServerEvent('rsg_looting:server:loot')
AddEventHandler('rsg_looting:server:loot', function(user)
    local src = tonumber(source)
	local randomNumber = math.random(1,100)
	
	if randomNumber > 0 and randomNumber <= 70 then
		local _subRan = math.random(1,2)
		if _subRan == 1 then
			local Player = exports['qbr-core']:GetPlayer(src)
			Player.Functions.AddItem('bloodmoney', Small_Reward)
			TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['bloodmoney'], "add")
			TriggerClientEvent('QBCore:Notify', src, 8, 'Looting Successsful!', 5000, 'you looted $'..Small_Reward, 'satchel_textures', 'satchel_nav_loot', 'COLOR_WHITE')
		else
			TriggerClientEvent('QBCore:Notify', src, 8, 'Looting Failed!', 5000, 'you did\'nt find anything!', 'satchel_textures', 'satchel_nav_loot', 'COLOR_WHITE')
		end
	
	elseif randomNumber > 80 and randomNumber <= 95 then
		local _subRan = math.random(1,2)
		if _subRan == 1 then
			local Player = exports['qbr-core']:GetPlayer(src)
			Player.Functions.AddItem('bloodmoney', Medium_Reward)
			TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['bloodmoney'], "add")
			TriggerClientEvent('QBCore:Notify', src, 8, 'Looting Successsful!', 5000, 'you looted $'..Medium_Reward, 'satchel_textures', 'satchel_nav_loot', 'COLOR_WHITE')
		else
			TriggerClientEvent('QBCore:Notify', src, 8, 'Looting Failed!', 5000, 'you did\'nt find anything!', 'satchel_textures', 'satchel_nav_loot', 'COLOR_WHITE')
		end
		
	elseif randomNumber > 95 and randomNumber <= 100 then
		local _subRan = math.random(1,2)
		if _subRan == 1 then
			local Player = exports['qbr-core']:GetPlayer(src)
			Player.Functions.AddItem('bloodmoney', Large_Reward)
			TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['bloodmoney'], "add")
			TriggerClientEvent('QBCore:Notify', src, 8, 'Looting Successsful!', 5000, 'you looted $'..Large_Reward, 'satchel_textures', 'satchel_nav_loot', 'COLOR_WHITE')
		else
			TriggerClientEvent('QBCore:Notify', src, 8, 'Looting Failed!', 5000, 'you did\'nt find anything!', 'satchel_textures', 'satchel_nav_loot', 'COLOR_WHITE')
		end
    end
end)