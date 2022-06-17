local alcoholCount = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if alcoholCount > 0 then
            Citizen.Wait(5000)
            alcoholCount = alcoholCount - 1
			--print("count change "..alcoholCount)
			if alcoholCount > 50 and alcoholCount < 300 then
                Citizen.InvokeNative(0x406CCF555B04FAD3 , PlayerPedId(), 1, 0.95) --drunk
			elseif alcoholCount > 300 then
				TriggerEvent('rsg_drinker:client:puke')
				Citizen.Wait(10000)
				TriggerEvent('rsg_drinker:client:cancelemote')
				TriggerEvent('rsg_drinker:client:sleep')
				Citizen.Wait(30000)
				TriggerEvent('rsg_drinker:client:cancelemote')
				alcoholCount = 149
			else
				Citizen.InvokeNative(0x406CCF555B04FAD3 , PlayerPedId(), 1, 0.0) --not drunk
            end
        else
            Citizen.Wait(2000)
        end
    end
end)

RegisterNetEvent("rsg_drinker:client:DrinkWhiskey")
AddEventHandler("rsg_drinker:client:DrinkWhiskey", function()
	local modelhash = GetHashKey('p_bottleJD01x')
    RequestModel(modelhash)
    while not HasModelLoaded(modelhash) do
        Wait(10)
    end
    local propEntity = CreateObject(modelhash, GetEntityCoords(PlayerPedId()), false, true, false, false, true)
    TaskItemInteraction_2(PlayerPedId(), -1199896558, propEntity, GetHashKey('p_bottleJD01x_ph_r_hand'), GetHashKey('DRINK_BOTTLE@Bottle_Cylinder_D1-3_H30-5_Neck_A13_B2-5_CHUG_TRANS'), 1, 0, -1.0)
    while true do
        Wait(500)
        if Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) == 1204708816 then
            alcoholCount = alcoholCount + 2			
			TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", exports['qbr-core']:GetPlayerData().metadata["thirst"] + 1)
			TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", exports['qbr-core']:GetPlayerData().metadata["hunger"] - 1)
        end
    end
end)

RegisterNetEvent("rsg_drinker:client:DrinkBeer")
AddEventHandler("rsg_drinker:client:DrinkBeer", function()
	local modelhash = GetHashKey('p_bottleBeer01x')
    RequestModel(modelhash)
    while not HasModelLoaded(modelhash) do
        Wait(10)
    end
    local propEntity = CreateObject(modelhash, GetEntityCoords(PlayerPedId()), false, true, false, false, true)
    TaskItemInteraction_2(PlayerPedId(), GetHashKey("CONSUMABLE_SALOON_BEER"), propEntity, GetHashKey('p_bottleBeer01x_PH_R_HAND'), 1587785400, 1, 0, -1082130432)
    while true do
        Wait(500)
        if Citizen.InvokeNative(0x6AA3DCA2C6F5EB6D, PlayerPedId()) == 1183277175 then
            alcoholCount = alcoholCount + 1
			TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", exports['qbr-core']:GetPlayerData().metadata["thirst"] + 1)
			TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", exports['qbr-core']:GetPlayerData().metadata["hunger"] - 1)
        end
    end
end)

RegisterNetEvent("rsg_drinker:client:DrinkCoffee")
AddEventHandler("rsg_drinker:client:DrinkCoffee", function()
	local modelhash = GetHashKey('P_MUGCOFFEE01X')
    RequestModel(modelhash)
    while not HasModelLoaded(modelhash) do
        Wait(10)
    end
    local propEntity = CreateObject(modelhash, GetEntityCoords(PlayerPedId()), true, false, false, false, true)

	Citizen.InvokeNative(0x669655FFB29EF1A9, propEntity, 0, "CTRL_cupFill", 1.0)
	TaskItemInteraction_2(PlayerPedId(), GetHashKey("CONSUMABLE_COFFEE"), propEntity, GetHashKey("P_MUGCOFFEE01X_PH_R_HAND"), GetHashKey("DRINK_COFFEE_HOLD"), 1, 0, -1082130432)
end)

RegisterNetEvent("rsg_drinker:client:DrinkMoonshine")
AddEventHandler("rsg_drinker:client:DrinkMoonshine", function()
    local dict = "amb_rest_drunk@world_human_drinking@male_a@idle_a"
    local playerPed = PlayerPedId()
    local pos = GetEntityCoords(playerPed)
    local prop = GetHashKey("p_masonjarmoonshine01x")
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(10)
    end
    RequestModel(prop)
    while not HasModelLoaded(prop) do
        Wait(10)
    end
    local tempObj2 = CreateObject(prop, pos.x, pos.y, pos.z, true, true, false)
    local boneIndex = GetEntityBoneIndexByName(playerPed, "SKEL_R_HAND")
    AttachEntityToEntity(tempObj2, playerPed, boneIndex, 0.05, -0.07, -0.05, -75.0, 60.0, 0.0, true, true, false, true,  1, true)
    TaskPlayAnim(PlayerPedId(), dict, "idle_a", 1.0, 8.0, -1, 31, 0, false, false, false)
    Citizen.Wait(10000)
    ClearPedTasks(PlayerPedId())
    DeleteObject(tempObj2)
    SetModelAsNoLongerNeeded(prop)
	TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", exports['qbr-core']:GetPlayerData().metadata["thirst"] + 25)
	TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", exports['qbr-core']:GetPlayerData().metadata["hunger"] - 10)
	alcoholCount = alcoholCount + 100	
end)

----- puke
RegisterCommand("puke", function(source, args, rawCommand)
    TriggerEvent('rsg_drinker:client:puke')
end)
    
RegisterNetEvent('rsg_drinker:client:puke')
AddEventHandler('rsg_drinker:client:puke', function()
    loadAnimDict('amb_misc@world_human_vomit@male_a@idle_b')
    TaskPlayAnim(PlayerPedId(), "amb_misc@world_human_vomit@male_a@idle_b", "idle_f", 8.0, -8.0, -1, 31, 0, true, 0, false, 0, false)
    RemoveAnimDict('amb_misc@world_human_vomit@male_a@idle_b')
end)

----- sleep
RegisterCommand("sleep1", function(source, args, rawCommand)
    TriggerEvent('rsg_drinker:client:sleep')
end)
    
RegisterNetEvent('rsg_drinker:client:sleep')
AddEventHandler('rsg_drinker:client:sleep', function()
    loadAnimDict('amb_rest@world_human_sleep_ground@arm@male_b@idle_b')
    TaskPlayAnim(PlayerPedId(), 'amb_rest@world_human_sleep_ground@arm@male_b@idle_b', 'idle_f', 8.0, -8.0, -1, 1, 0, true, false, false)
    RemoveAnimDict('amb_rest@world_human_sleep_ground@arm@male_b@idle_b')
end)

-- cancel emote
RegisterCommand("cancelemote", function(source, args, rawCommand)
    TriggerEvent('rsg_drinker:client:cancelemote')
end)
    
RegisterNetEvent('rsg_drinker:client:cancelemote')
AddEventHandler('rsg_drinker:client:cancelemote', function()
	local ped = PlayerPedId()
	ClearPedTasks(ped)
    ClearPedTasksImmediately(ped)
	SetCurrentPedWeapon(ped, GetHashKey("WEAPON_UNARMED"), true)
end)

function loadAnimDict(dict)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
end