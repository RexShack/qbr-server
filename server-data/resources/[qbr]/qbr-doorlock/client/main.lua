
local CoolDown = 0

Citizen.CreateThread(function()
	while true do
		for _,doorID in pairs(Config.DoorList) do
			if doorID.doors then
				for k,v in pairs(doorID.doors) do
					if not v.object or not DoesEntityExist(v.object) then
						local shapeTest = StartShapeTestBox(v.objCoords, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, true, 16)
						local rtnVal, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapeTest)
						v.object = entityHit
					end
				end
			else
				if not doorID.object or not DoesEntityExist(doorID.object) then
					local shapeTest = StartShapeTestBox(doorID.objCoords, 1.0, 1.0, 1.0, 0.0, 0.0, 0.0, true, 16)
					local rtnVal, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapeTest)
					doorID.object = entityHit
				end
			end
		end

		Citizen.Wait(1000)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local playerCoords, letSleep = GetEntityCoords(PlayerPedId()), true

		for k,doorID in ipairs(Config.DoorList) do
			local distance = #(playerCoords - doorID.textCoords)

			local maxDistance, displayText = 1.25, Lang:t("info.unlocked")

			if doorID.distance then
				maxDistance = doorID.distance
			end

			if distance < 50 then
				letSleep = false

				if doorID.doors then
					if doorID.locked then
						for _,v in ipairs(doorID.doors) do
							if Citizen.InvokeNative(0x160AA1B32F6139B8, v.doorid) ~= 3 then
								Citizen.InvokeNative(0xD99229FE93B46286, v.doorid,1,1,0,0,0,0)
								Citizen.InvokeNative(0x6BAB9442830C7F53, v.doorid, 3)
							end
							local current = GetEntityRotation(v.object).z - v.objYaw
							if v.objYaw and current > 0.5 or current < -0.5 then
								SetEntityRotation(v.object, 0.0, 0.0, v.objYaw, 2, true)
							end
							FreezeEntityPosition(v.object,true)
						end
					else
						for _,v in ipairs(doorID.doors) do
							if Citizen.InvokeNative(0x160AA1B32F6139B8, v.doorid) ~= false then
								Citizen.InvokeNative(0xD99229FE93B46286, v.doorid,1,1,0,0,0,0)
								Citizen.InvokeNative(0x6BAB9442830C7F53, v.doorid, 0)
							end
						end
						FreezeEntityPosition(doorID.object,false)
					end

				else
					if doorID.locked then
						if Citizen.InvokeNative(0x160AA1B32F6139B8, doorID.doorid) ~= 3 then
							Citizen.InvokeNative(0xD99229FE93B46286, doorID.doorid,1,1,0,0,0,0)
							Citizen.InvokeNative(0x6BAB9442830C7F53, doorID.doorid, 3)
						end
						local current = GetEntityRotation(doorID.object).z - doorID.objYaw
						if doorID.objYaw and current > 0.5 or current < -0.5 then
							SetEntityRotation(doorID.object, 0.0, 0.0, doorID.objYaw, 2, true)
						end
						FreezeEntityPosition(doorID.object,true)
					else
						if Citizen.InvokeNative(0x160AA1B32F6139B8, doorID.doorid) ~= false then
							Citizen.InvokeNative(0xD99229FE93B46286, doorID.doorid,1,1,0,0,0,0)
							Citizen.InvokeNative(0x6BAB9442830C7F53, doorID.doorid, 0)
						end
						FreezeEntityPosition(doorID.object,false)
					end
				end
			end

			if distance < maxDistance then
				if distance < 1.75 then
					if IsControlJustPressed(0,Config.KeyPress) and CoolDown < 1 then
						CoolDown = 1000
						local state = not doorID.locked
						TriggerServerEvent("qbr-doorlock:updatedoorsv", k, state)
					end
				end
			end

			if CoolDown > 0 then
				CoolDown = CoolDown - 1
			end
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

RegisterNetEvent('qbr-doorlock:changedoor')
AddEventHandler('qbr-doorlock:changedoor', function(doorID, state)
	ChangeStateText(Config.DoorList[doorID].textCoords, state)
	prop_name = 'P_KEY02X'
	local ped = PlayerPedId()
        local p1 = GetEntityCoords(ped, true)
        local p2 = Config.DoorList[doorID].textCoords
        local dx = p2.x - p1.x
        local dy = p2.y - p1.y

        local heading = GetHeadingFromVector_2d(dx, dy)
        SetPedDesiredHeading( ped, heading )

	local x,y,z = table.unpack(GetEntityCoords(ped, true))
	local prop = CreateObject(GetHashKey(prop_name), x, y, z + 0.2, true, true, true)
	local boneIndex = GetEntityBoneIndexByName(ped, "SKEL_R_Finger12")

	if not IsEntityPlayingAnim(ped, "script_common@jail_cell@unlock@key", "action", 3) then
		local waiting = 0
		if not HasAnimDictLoaded("script_common@jail_cell@unlock@key") then
			RequestAnimDict("script_common@jail_cell@unlock@key")
			while not HasAnimDictLoaded("script_common@jail_cell@unlock@key") do
				Citizen.Wait(100)
				RequestAnimDict("script_common@jail_cell@unlock@key")
			end
		end
			Wait(100)
		TaskPlayAnim(ped, 'script_common@jail_cell@unlock@key', 'action', 8.0, -8.0, 2500, 31, 0, true, 0, false, 0, false)
		RemoveAnimDict("script_common@jail_cell@unlock@key")
			Wait(750)
		AttachEntityToEntity(prop, ped,boneIndex, 0.02, 0.0120, -0.00850, 0.024, -160.0, 200.0, true, true, false, true, 1, true)
			Wait(250)
		TriggerServerEvent('qbr-doorlock:updateState', doorID, state, function(cb) end)
			Wait(1500)
		ClearPedSecondaryTask(ped)
		DeleteObject(prop)
	end
end)

function ChangeStateText(coords, state)
	Citizen.CreateThread(function()
		local timeout = 80
		local Text = ""
		local r,g,b = 0,0,0
		if state == false then
			Text =  Lang:t("info.unlocking")
			r,g,b = 51, 153, 51
		elseif state == true then
			Text = Lang:t("info.locking")
			r,g,b = 153, 1, 1
		end
		while timeout > 0 do
			Wait(0)
			timeout = timeout - 1
			DrawText3Ds(coords.x, coords.y, coords.z, Text, r, g, b)
		end
	end)
end

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())

    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
end

-- Set state for a door
RegisterNetEvent('qbr-doorlock:setState')
AddEventHandler('qbr-doorlock:setState', function(doorID, state)
	Config.DoorList[doorID].locked = state
end)
