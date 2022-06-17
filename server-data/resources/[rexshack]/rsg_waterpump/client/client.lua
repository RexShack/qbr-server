-- pump prompt
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos, awayFromObject = GetEntityCoords(PlayerPedId()), true
		local pumpObject = GetClosestObjectOfType(pos, 5.0, GetHashKey("p_waterpump01x"), false, false, false)
		if pumpObject ~= 0 then
			local objectPos = GetEntityCoords(pumpObject)
			if #(pos - objectPos) < 3.0 then
				awayFromObject = false
				DrawText3Ds(objectPos.x, objectPos.y, objectPos.z + 1.0, "~g~J~w~ - USE")
				if IsControlJustReleased(0, 0xF3830D8E) then -- [J]
					TriggerEvent('rsg_waterpump:client:drinking')
				end
			end
		end
		if awayFromObject then
			Citizen.Wait(1000)
		end
	end
end)

-- well pump prompt
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos, awayFromObject = GetEntityCoords(PlayerPedId()), true
		local wellpumpObject = GetClosestObjectOfType(pos, 5.0, GetHashKey("p_wellpumpnbx01x"), false, false, false)
		if wellpumpObject ~= 0 then
			local objectPos = GetEntityCoords(wellpumpObject)
			if #(pos - objectPos) < 3.0 then
				awayFromObject = false
				DrawText3Ds(objectPos.x, objectPos.y, objectPos.z + 1.0, "~g~J~w~ - USE")
				if IsControlJustReleased(0, 0xF3830D8E) then -- [J]
					TriggerEvent('rsg_waterpump:client:drinking')
				end
			end
		end
		if awayFromObject then
			Citizen.Wait(1000)
		end
	end
end)

-- drink water
RegisterNetEvent('rsg_waterpump:client:drinking')
AddEventHandler('rsg_waterpump:client:drinking', function()
	exports['qbr-core']:Progressbar("cook_steak", "Drinking..", 10000, false, true, {
		disableMovement = true,
		disableCarMovement = false,
		disableMouse = false,
		disableCombat = true,
	}, {}, {}, {}, function() -- Done
		TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", exports['qbr-core']:GetPlayerData().metadata["thirst"] + 100)  -- adjust as required
	end)
end)

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(9)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end