local HouseBlips = {}
local targetHouse

Citizen.CreateThread(function()
    Wait(2000)
	CreateHouseprompt()
	TriggerServerEvent('rsg_properties:server:checkhouses')
end)

-- adding blips on the map forsale / owned
RegisterNetEvent('rsg_properties:client:setblips')
AddEventHandler('rsg_properties:client:setblips', function(housecheck)
	if housecheck ~= nil then
		for b,g in pairs (Config.Houses) do
			for h,j in pairs (housecheck) do
				if g.number == j then
					g.owned = true
				end
			end
		end
	end
	for k,v in pairs (Config.Houses) do
        if not v.owned then
			-- set not owned blips
            HouseBlips[v.number] = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, v.pos.x, v.pos.y, v.pos.z)
            SetBlipSprite(HouseBlips[v.number], 444204045)
            SetBlipScale(HouseBlips[v.number], 0.3)
            Citizen.InvokeNative(0x9CB1A1623062F402, HouseBlips[v.number], Config.BlipName)
		else
			-- set not owned blips
			HouseBlips[v.number] = Citizen.InvokeNative(0x554d9d53f696d002, 1664425300, v.pos.x, v.pos.y, v.pos.z)
            SetBlipSprite(HouseBlips[v.number], -1989725258)
            SetBlipScale(HouseBlips[v.number], 0.3)
            Citizen.InvokeNative(0x9CB1A1623062F402, HouseBlips[v.number], Config.OwnedBlipName)	
        end
    end
end)

-- house prompt
local Housegroup = GetRandomIntInRange(0, 0xffffff)
--local FacilitiesGroup = GetRandomIntInRange(0, 0xffffff)
local buying = 0
local active = false
local active2 = false

-- house prompt
local Houseprompt
function CreateHouseprompt()
    Citizen.CreateThread(function()
        local str = Config.BuyText
        Houseprompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(Houseprompt, 0xC7B5340A)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(Houseprompt, str)
        PromptSetEnabled(Houseprompt, true)
        PromptSetVisible(Houseprompt, true)
        PromptSetHoldMode(Houseprompt, true)
        PromptSetGroup(Houseprompt, Housegroup)
        PromptRegisterEnd(Houseprompt)
    end)
end

-- trigger house prompts
Citizen.CreateThread(function()
    while true do
        Wait(0)
		local cansleep = true
        local pedCoords = GetEntityCoords(PlayerPedId())
        for k,v in pairs (Config.Houses) do
            if not v.owned then
				local coords = vector3(v.buy.x, v.buy.y, v.buy.z)
				local dist = #(pedCoords - coords)
				if dist < 10 then
					cansleep = false
				end
                if dist < 2.0 then
				if not active then
                    local HouseGroupName  = CreateVarString(10, 'LITERAL_STRING', Config.BuyText2 .. " ~t4~" .. tostring(v.name) .. "~q~ " .. Config.BuyText3 .. " ~t6~$" .. tostring(v.price) .. "~q~")
                    PromptSetActiveGroupThisFrame(Housegroup, HouseGroupName) 
						if PromptHasHoldModeCompleted(Houseprompt) then
							active = true
							targetHouse = k
							TriggerServerEvent('rsg_properties:server:buyhouse', v.price, v.number)
						end
					end
					else
					if active == true and targetHouse == k then
						active = false
					end
                end
            end
        end
		if cansleep then
			Wait(1000)
		end
    end
end)

RegisterNetEvent('rsg_properties:client:buyhouse')
AddEventHandler('rsg_properties:client:buyhouse', function(price, id)
    Citizen.CreateThread(function()
        for z,c in pairs(Config.Houses) do
            if c.number == id then
                c.owned = true
            end
        end
    end)
	TriggerServerEvent('rsg_properties:server:checkhouses')
end)

------------------------------------HOUSE MENU--------------------------------------

-- house menu
Citizen.CreateThread(function()
    for menu, v in pairs(Config.Houses) do
        exports['qbr-core']:createPrompt(v.number..'-stash', v.menu, 0xF3830D8E, 'Open Stash', { -- ["J"]
            type = 'client',
            event = 'rsg_properties:client:housestash',
            args = {v.number},
        })
		exports['qbr-core']:createPrompt(v.number..'-clothing', v.menu, 0xC7B5340A, 'Open Outfits', { -- ["ENTER"]
            type = 'client',
            event = 'qbr-clothing:client:openMenu',
            args = {false, 'outfitMenu'},
        })
    end
end)

------------------------------------STASH-------------------------------------------

-- house stash
RegisterNetEvent('rsg_properties:client:housestash', function(house)
	local PlayerHouse = exports['qbr-core']:GetPlayerData().metadata["house"]
	if PlayerHouse == house then
		TriggerServerEvent("inventory:server:OpenInventory", "stash", house, { maxweight = Config.StashWeight, slots = Config.StashSlots, })
		TriggerEvent("inventory:client:SetCurrentStash", house)
	else
		exports['qbr-core']:Notify(9, 'you don\'t have access to this stash', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)

------------------------------------DOORS-------------------------------------------
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
					DrawText3D(doorID.textCoords.x, doorID.textCoords.y, doorID.textCoords.z, " " ,doorID.locked)
					if IsControlJustPressed(0,Config.KeyPress) and CoolDown < 1 then
						CoolDown = 1000
						local state = not doorID.locked
						TriggerServerEvent("rsg_properties:updatedoorsv", k, state)
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

RegisterNetEvent('rsg_properties:changedoor')
AddEventHandler('rsg_properties:changedoor', function(doorID, state)
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
		TriggerServerEvent('rsg_properties:updateState', doorID, state, function(cb) end)
			Wait(1500)
		ClearPedSecondaryTask(ped)
		DeleteObject(prop)
	end
end)

-- door lock image
function DrawText3D(x, y, z, text , state)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())

    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    if state then
        DrawSprite("generic_textures", "lock", _x, _y + 0.0125, 0.04, 0.045, 0.1, 100, 1, 1, 255, 0)
    else
        DrawSprite("generic_textures", "lock", _x, _y + 0.0125, 0.04, 0.045, 0.1, 67, 160, 71, 255, 0)
    end
end

-- Set state for a door
RegisterNetEvent('rsg_properties:setState')
AddEventHandler('rsg_properties:setState', function(doorID, state)
	Config.DoorList[doorID].locked = state
end)
------------------------------------END DOORS---------------------------------------