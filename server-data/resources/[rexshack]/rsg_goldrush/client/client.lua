local sharedItems = exports['qbr-core']:GetItems()


CreateThread(function()
    for k, v in pairs(Config.GoldRushLocation) do
        exports['qbr-core']:createPrompt("goldclaim"..k, v.Coords, Config.Use, 'Check for Gold', {
            type = 'client',
            event = 'rsg_goldrush:client:goldclaim',
            args = {}
        })
    end
end)

-- goldcheck claim 1
RegisterNetEvent("rsg_goldrush:client:goldclaim", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem) 
		if hasItem then
			local player = PlayerPedId()
			TaskStartScenarioInPlace(player, `WORLD_HUMAN_BUCKET_POUR_LOW`, 0, true)
			Wait(8000)
			ClearPedTasks(player)
			SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
			exports['qbr-core']:Progressbar("check_for_gold", "Checking for Gold..", 30000, false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				TriggerServerEvent('rsg_goldrush::server:reward')
			end)
		else
			exports['rsg_notify']:DisplayNotification('you do not hold the lease to this claim!', 5000)
		end
	end, { ['claimlease'] = 1 })
end)


-- goto gold claim 1
RegisterNetEvent('rsg_goldrush:client:gotoclaim', function()
	local randLocation  = Config.GoldRushLocation[math.random(0,#Config.GoldRushLocation)].Coords
	StartGpsMultiRoute(GetHashKey("COLOR_RED"), true, true)
	AddPointToGpsMultiRoute(randLocation.x, randLocation.y, randLocation.z)
	SetGpsMultiRouteRender(true)
end)

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        for k,v in pairs(Config.GoldRushLocation) do 
			--This pr waiting.
            --exports['qbr-core']:deletePrompt('goldclaim'..k)
        end
    end
end)
