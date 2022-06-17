local sharedItems = exports['qbr-core']:GetItems()
local initialCooldownSeconds = 3600 -- cooldown time in seconds between treasure
local cooldownSecondsRemaining = 0 -- done to zero cooldown on restart

-- text to screen
function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end

-- detector part
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
		local isonmount = IsPedOnMount(ped)
		local weaponhash = Citizen.InvokeNative(0x8425C5F057012DAB, ped)
		for treasure, v in pairs(Config.Locations) do
			if weaponhash == -862059856 and cooldownSecondsRemaining == 0 and isonmount == false then
				local dist = #(pos - v.coords)
				if dist < 10 then
					Citizen.InvokeNative(0x437C08DB4FEBE2BD, ped, "MetalDetectorDetectionValue", 0.1, -1)
				end
				if dist < 9 then
					Citizen.InvokeNative(0x437C08DB4FEBE2BD, ped, "MetalDetectorDetectionValue", 0.2, -1)
				end
				if dist < 8 then
					Citizen.InvokeNative(0x437C08DB4FEBE2BD, ped, "MetalDetectorDetectionValue", 0.3, -1)
				end
				if dist < 7 then
					Citizen.InvokeNative(0x437C08DB4FEBE2BD, ped, "MetalDetectorDetectionValue", 0.4, -1)
				end
				if dist < 6 then
					Citizen.InvokeNative(0x437C08DB4FEBE2BD, ped, "MetalDetectorDetectionValue", 0.5, -1)
				end
				if dist < 5 then
					Citizen.InvokeNative(0x437C08DB4FEBE2BD, ped, "MetalDetectorDetectionValue", 0.6, -1)
				end
				if dist < 4 then
					Citizen.InvokeNative(0x437C08DB4FEBE2BD, ped, "MetalDetectorDetectionValue", 0.7, -1)
				end
				if dist < 3 then
					Citizen.InvokeNative(0x437C08DB4FEBE2BD, ped, "MetalDetectorDetectionValue", 0.8, -1)
				end
				if dist < 2 then
					Citizen.InvokeNative(0x437C08DB4FEBE2BD, ped, "MetalDetectorDetectionValue", 0.9, -1)
				end
				if dist < 1 then
					Citizen.InvokeNative(0x437C08DB4FEBE2BD, ped, "MetalDetectorDetectionValue", 1.0, -1)
					DrawText3Ds(v.coords.x, v.coords.y, v.coords.z + 1.0, "~g~E~w~ - Dig Treasure")
					if IsControlJustReleased(0, 0xCEFD9220) then -- [E]
						SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
						Citizen.InvokeNative(0x437C08DB4FEBE2BD, ped, "MetalDetectorDetectionValue", 0.0, -1)
						TriggerEvent('rsg_treasure:clent:digging', v.name)
						handleCooldown()
					end
				end
			end
		end
    end
end)

-- bleep the metal detector when near treasure
Citizen.CreateThread(function()
    while true do
        Wait(0)
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
		local isonmount = IsPedOnMount(ped)
		local weaponhash = Citizen.InvokeNative(0x8425C5F057012DAB, ped)
		for treasure, v in pairs(Config.Locations) do
			if weaponhash == -862059856 and cooldownSecondsRemaining == 0 and isonmount == false then
				local dist = #(pos - v.coords)
				if dist < 1 then
					TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, 'metaldetector', 0.5)
					Wait(500)
				elseif dist < 5 then
					TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, 'metaldetector', 0.3)
					Wait(1000)
				elseif dist < 10 then
					TriggerServerEvent("InteractSound_SV:PlayWithinDistance", 10, 'metaldetector', 0.1)
					Wait(2000)
				end
			end
		end
    end
end)

-- dig for treasure
RegisterNetEvent("rsg_treasure:clent:digging")
AddEventHandler("rsg_treasure:clent:digging", function(chest)
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem) 
		if hasItem then
			local randomNumber = math.random(1,100)
			if randomNumber > 90 then
				TriggerServerEvent('QBCore:Server:RemoveItem', 'shovel', 1)
				TriggerEvent('inventory:client:ItemBox', sharedItems['shovel'], 'remove')
				exports['qbr-core']:Notify(9, 'your shovel is broken', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
			else
				StartAnimation('script@mech@treasure_hunting@chest', 0, 'PBL_CHEST_01', 0, 1, true, 10000)
				Wait(10000)
				TriggerServerEvent('rsg_treasure:server:givereward', chest)
				active = false
			end
		else
			exports['qbr-core']:Notify(9, 'you don\'t have a shovel!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['shovel'] = 1 })
end)

-- dig up chest animation
function StartAnimation(animDict,flags,playbackListName,p3,p4,groundZ,time)
	Citizen.CreateThread(function()
		local player = PlayerPedId()
		local aCoord = GetEntityCoords(player)
		local pCoord = GetOffsetFromEntityInWorldCoords(PlayerPedId(), -10.0, 0.0, 0.0)
		local pRot = GetEntityRotation(player)

		if groundZ then
			local a, groundZ = GetGroundZAndNormalFor_3dCoord( aCoord.x, aCoord.y, aCoord.z + 10 )
			aCoord = {x=aCoord.x, y=aCoord.y, z=groundZ}
		end

		local animScene = Citizen.InvokeNative(0x1FCA98E33C1437B3, animDict, flags, playbackListName, 0, 1)
		Citizen.InvokeNative(0x020894BF17A02EF2, animScene, aCoord.x, aCoord.y, aCoord.z, pRot.x, pRot.y, pRot.z, 2) 
		Citizen.InvokeNative(0x8B720AD451CA2AB3, animScene, "player", player, 0)
	    
		local modelhash = GetHashKey('p_strongbox_muddy_01x')
		RequestModel(modelhash)
		while not HasModelLoaded(modelhash) do
			Wait(10)
		end
		local chest = CreateObjectNoOffset(modelhash, pCoord, true, true, false, true)
		Citizen.InvokeNative(0x8B720AD451CA2AB3, animScene, "CHEST", chest, 0)
		Citizen.InvokeNative(0xAF068580194D9DC7, animScene) 
		Citizen.Wait(1000)
		Citizen.InvokeNative(0xF4D94AF761768700, animScene) 
		if time then
			Citizen.Wait(tonumber(time))	
		else
			Citizen.Wait(10000) 
		end	    	
		Citizen.InvokeNative(0x84EEDB2C6E650000, animScene) 
   	end) 
end

-- cooldown
function handleCooldown()
    cooldownSecondsRemaining = initialCooldownSeconds
    Citizen.CreateThread(function()
        while cooldownSecondsRemaining > 0 do
            Citizen.Wait(1000)
            cooldownSecondsRemaining = cooldownSecondsRemaining - 1
        end
    end)
end