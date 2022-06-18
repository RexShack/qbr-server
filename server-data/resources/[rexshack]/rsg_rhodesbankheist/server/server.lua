local sharedItems = exports['qbr-core']:GetItems()

-- give reward
RegisterServerEvent('rsg_rhodesbankheist:server:reward')
AddEventHandler('rsg_rhodesbankheist:server:reward', function()
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	local randomNumber = math.random(1,3)
	if randomNumber == 1 then
		Player.Functions.AddItem('goldbar', math.random(1,3))
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['goldbar'], "add")
	elseif randomNumber == 2 then
		Player.Functions.AddItem('goldbar', math.random(2,4))
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['goldbar'], "add")
	elseif randomNumber == 3 then
		Player.Functions.AddItem('goldbar', math.random(4,8))
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['goldbar'], "add")
	end
end)