Citizen.CreateThread(function()
    while true do
        for _, sctyp in next, Config.BlacklistedScenarios['TYPES'] do
            SetScenarioTypeEnabled(sctyp, false)
        end
        for _, scgrp in next, Config.BlacklistedScenarios['GROUPS'] do
            SetScenarioGroupEnabled(scgrp, false)
        end
		Citizen.Wait(10000)
    end
end)

Citizen.CreateThread(function()
    while true do
        local vehiclePool = GetGamePool('CVehicle')
		local pedPool = GetGamePool('CPed')
		local objectPool = GetGamePool('CObject')
        for k,v in pairs(vehiclePool) do
            if Config.BlacklistedVehicles[GetEntityModel(v)] then
				SetEntityAsMissionEntity(v, true, true)
                DeleteVehicle(v)
				SetEntityAsNoLongerNeeded(v)
            end
        end
		for k,v in pairs(pedPool) do
			SetPedDropsWeaponsWhenDead(v, false)
			if Config.BlacklistedPeds[GetEntityModel(v)] then
				SetEntityAsMissionEntity(v, true, true)
				DeletePed(v)
				SetEntityAsNoLongerNeeded(v)
			end
		end
		for k,v in pairs(objectPool) do
			if Config.BlacklistedObjects[GetEntityModel(v)] then
				SetEntityAsMissionEntity(v, true, true)
				DeleteObject(v)
				SetEntityAsNoLongerNeeded(v)
			end
		end
        Citizen.Wait(250)
    end
end)

-- removes events and challenge notfications
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        local size = GetNumberOfEvents(0)   
        if size > 0 then
            for i = 0, size - 1 do
                local eventAtIndex = GetEventAtIndex(0, i)
                if eventAtIndex == GetHashKey("EVENT_CHALLENGE_GOAL_COMPLETE") or eventAtIndex == GetHashKey("EVENT_CHALLENGE_REWARD") or eventAtIndex == GetHashKey("EVENT_DAILY_CHALLENGE_STREAK_COMPLETED") then 
                    Citizen.InvokeNative(0x6035E8FBCA32AC5E)
                end
            end
        end
    end
end)

