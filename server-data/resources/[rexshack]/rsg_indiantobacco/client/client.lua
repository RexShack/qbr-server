local sharedItems = exports['qbr-core']:GetItems()
isLoggedIn = false
PlayerJob = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerJob = exports['qbr-core']:GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

local SpawnedPlants = {}
local InteractedPlant = nil
local HarvestedPlants = {}
local canHarvest = true
local closestPlant = nil
local isDoingAction = false

Citizen.CreateThread(function()
    while true do
    Wait(150)

    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local inRange = false

    for i = 1, #Config.Plants do
        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z, true)

		if dist < 50.0 then
			inRange = true
			local hasSpawned = false
			local needsUpgrade = false
			local upgradeId = nil
			local tableRemove = nil

			for z = 1, #SpawnedPlants do
				local p = SpawnedPlants[z]
				if p.id == Config.Plants[i].id then
					hasSpawned = true
				end
			end

			if not hasSpawned then
				local hash = GetHashKey('indtobacco_p')
				while not HasModelLoaded(hash) do
					Wait(10)
					RequestModel(hash)
				end
				RequestModel(hash)
				local data = {}
				data.id = Config.Plants[i].id
				data.obj = CreateObject(hash, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z -1.2, false, false, false) 
				SetEntityAsMissionEntity(data.obj, true)
				FreezeEntityPosition(data.obj, true)
				table.insert(SpawnedPlants, data)
				hasSpawned = false
			end
		end
    end
    if not InRange then
        Wait(5000)
    end
    end
end)

-- destroy plant
function DestroyPlant()
    local plant = GetClosestPlant()
    local hasDone = false

    for k, v in pairs(HarvestedPlants) do
        if v == plant.id then
            hasDone = true
        end
    end

    if not hasDone then
        table.insert(HarvestedPlants, plant.id)
        local ped = PlayerPedId()
        isDoingAction = true
        TriggerServerEvent('rsg_indiantobacco:server:plantHasBeenHarvested', plant.id)
		TaskStartScenarioInPlace(ped, `WORLD_HUMAN_CROUCH_INSPECT`, 0, true)
		Wait(5000)
		ClearPedTasks(ped)
		SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
		TriggerServerEvent('rsg_indiantobacco:server:destroyPlant', plant.id)
		isDoingAction = false
		canHarvest = true
    else
		exports['qbr-core']:Notify(9, 'error', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end

-- havest plants
function HarvestPlant()
    local plant = GetClosestPlant()
    local hasDone = false

    for k, v in pairs(HarvestedPlants) do
        if v == plant.id then
            hasDone = true
        end
    end

    if not hasDone then
        table.insert(HarvestedPlants, plant.id)
        local ped = PlayerPedId()
        isDoingAction = true
        TriggerServerEvent('rsg_indiantobacco:server:plantHasBeenHarvested', plant.id)
		TaskStartScenarioInPlace(ped, `WORLD_HUMAN_CROUCH_INSPECT`, 0, true)
		Wait(10000)
		ClearPedTasks(ped)
		SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
		TriggerServerEvent('rsg_indiantobacco:server:harvestPlant', plant.id)
		isDoingAction = false
		canHarvest = true
    else
		exports['qbr-core']:Notify(9, 'error', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end

function RemovePlantFromTable(plantId)
    for k, v in pairs(Config.Plants) do
        if v.id == plantId then
            table.remove(Config.Plants, k)
        end
    end
end

-- trigger actions
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local InRange = false
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)

		for k, v in pairs(Config.Plants) do
			if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z, true) < 1.3 and not isDoingAction and not v.beingHarvested and not IsPedInAnyVehicle(PlayerPedId(), false) then
				if PlayerJob.name == 'lawman' then
					local plant = GetClosestPlant()
					DrawText3D(v.x, v.y, v.z, 'Thirst: ' .. v.thirst .. '% - Hunger: ' .. v.hunger .. '% - Growth: ' ..  v.growth .. '% -  Quality: ' .. v.quality)
					DrawText3D(v.x, v.y, v.z - 0.18, '~b~G~w~ - Destroy Plant')
					if IsControlJustPressed(0, 0x760A9C6F) then -- [G]
						if v.id == plant.id then
							DestroyPlant()
						end
					end
				else
					if v.growth < 100 then
						local plant = GetClosestPlant()
						DrawText3D(v.x, v.y, v.z, 'Thirst: ' .. v.thirst .. '% - Hunger: ' .. v.hunger .. '% - Growth: ' ..  v.growth .. '% -  Quality: ' .. v.quality)
						DrawText3D(v.x, v.y, v.z - 0.18, '[G] - Water : [J] - Feed')
						if IsControlJustPressed(0, 0x760A9C6F) then -- [G]
							if v.id == plant.id then
								TriggerEvent('rsg_indiantobacco:client:waterPlant')
							end
						elseif IsControlJustPressed(0, 0xF3830D8E) then -- [J]
							if v.id == plant.id then
								TriggerEvent('rsg_indiantobacco:client:feedPlant')
							end
						end
					else
						DrawText3D(v.x, v.y, v.z, '[Quality: ' .. v.quality .. ']')
						DrawText3D(v.x, v.y, v.z - 0.18, '[E] - Harvest')
						if IsControlJustReleased(0, 0xCEFD9220) and canHarvest then
							local plant = GetClosestPlant()
							local calllaw = math.random(1,100)
							if v.id == plant.id then
								HarvestPlant()
								if calllaw > 95 then
									local lawcoords = GetEntityCoords(PlayerPedId())
									TriggerEvent('rsg_alerts:client:calllawman', lawcoords, 'suspicious activity spotted')
								end
							end
						end
					end
				end
			end
		end
    end
end)

-- search for seed
local IsSearching = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local InRange = false

		for k, v in pairs(Config.SeedLocations) do
			if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, v.x, v.y, v.z) < 1.5 then
				InRange = true
			end
		end

		if InRange and not IsSearching and not IsPedInAnyVehicle(PlayerPedId(), false) then
			DrawText3D(pos.x, pos.y, pos.z, '~y~G~w~ - Search')
			if IsControlJustReleased(0, 0x760A9C6F) then -- [G]
				IsSearching = true
				TaskStartScenarioInPlace(ped, `WORLD_HUMAN_CROUCH_INSPECT`, 0, true)
				Wait(10000)
				ClearPedTasks(ped)
				SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
				if math.random(1, 10) == 7 then
					TriggerServerEvent('rsg_indiantobacco:server:giveSeed')
				end
			end
		else
			Wait(3000)
		end
    end
end)

function GetClosestPlant()
    local dist = 1000
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local plant = {}

    for i = 1, #Config.Plants do
        local xd = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z, true)
        if xd < dist then
            dist = xd
            plant = Config.Plants[i]
        end
    end

    return plant
end

RegisterNetEvent('rsg_indiantobacco:client:removePlantObject')
AddEventHandler('rsg_indiantobacco:client:removePlantObject', function(plant)
    for i = 1, #SpawnedPlants do
        local o = SpawnedPlants[i]
        if o.id == plant then
            SetEntityAsMissionEntity(o.obj, false)
            FreezeEntityPosition(o.obj, false)
            DeleteObject(o.obj)
        end
    end
end)

-- water plants
RegisterNetEvent('rsg_indiantobacco:client:waterPlant')
AddEventHandler('rsg_indiantobacco:client:waterPlant', function()
    local entity = nil
    local plant = GetClosestPlant()
    local ped = PlayerPedId()
    isDoingAction = true

    for k, v in pairs(SpawnedPlants) do
        if v.id == plant.id then
            entity = v.obj
        end
    end
	
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			Citizen.InvokeNative(0x5AD23D40115353AC, ped, entity, -1)
			TaskStartScenarioInPlace(ped, `WORLD_HUMAN_BUCKET_POUR_LOW`, 0, true)
			Wait(10000)
			ClearPedTasks(ped)
			SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
			TriggerServerEvent('rsg_indiantobacco:server:waterPlant', plant.id)
			isDoingAction = false
		else
			exports['qbr-core']:Notify(9, 'You don\'t have any water!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
			Wait(5000)
			isDoingAction = false
		end
	end, { ['water'] = 1 })
end)

-- feed plants
RegisterNetEvent('rsg_indiantobacco:client:feedPlant')
AddEventHandler('rsg_indiantobacco:client:feedPlant', function()
    local entity = nil
    local plant = GetClosestPlant()
    local ped = PlayerPedId()
    isDoingAction = true

    for k, v in pairs(SpawnedPlants) do
        if v.id == plant.id then
            entity = v.obj
        end
    end
	
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			Citizen.InvokeNative(0x5AD23D40115353AC, ped, entity, -1)
			TaskStartScenarioInPlace(ped, `WORLD_HUMAN_FEED_PIGS`, 0, true)
			Wait(14000)
			ClearPedTasks(ped)
			SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
			TriggerServerEvent('rsg_indiantobacco:server:feedPlant', plant.id)
			isDoingAction = false
		else
			exports['qbr-core']:Notify(9, 'You don\'t have any fertilizer!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
			Wait(5000)
			isDoingAction = false
		end
	end, { ['plant_nutrition'] = 1 })
end)

RegisterNetEvent('rsg_indiantobacco:client:updatePlantData')
AddEventHandler('rsg_indiantobacco:client:updatePlantData', function(data)
    Config.Plants = data
end)

RegisterNetEvent('rsg_indiantobacco:client:plantNewSeed')
AddEventHandler('rsg_indiantobacco:client:plantNewSeed', function(type)
    local pos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.0, 0.0)
	local ped = PlayerPedId()
    if CanPlantSeedHere(pos) and not IsPedInAnyVehicle(PlayerPedId(), false) then
		TaskStartScenarioInPlace(ped, `WORLD_HUMAN_FARMER_RAKE`, 0, true)
		Wait(10000)
		ClearPedTasks(ped)
		SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
		TaskStartScenarioInPlace(ped, `WORLD_HUMAN_FARMER_WEEDING`, 0, true)
		Wait(20000)
		ClearPedTasks(ped)
		SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
		TriggerServerEvent('rsg_indiantobacco:server:plantNewSeed', type, pos)
    else
		exports['qbr-core']:Notify(9, 'too close to another plant', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(9)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end

function CanPlantSeedHere(pos)
    local canPlant = true

    for i = 1, #Config.Plants do
        if GetDistanceBetweenCoords(pos.x, pos.y, pos.z, Config.Plants[i].x, Config.Plants[i].y, Config.Plants[i].z, true) < 1.3 then
            canPlant = false
        end
    end

    return canPlant
end

----------------------------------------------------------------------------------------------
-- pipe smoking and drug effect / original resource : oneprop https://discord.com/channels/648268213859254309/648268616214511655/935886853310119936
RegisterNetEvent("rsg_drugs:client:indianboost")
AddEventHandler("rsg_drugs:client:indianboost", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			FPrompt("Put Away", 0x3B24C470, false)
			LMPrompt("Use", 0x07B8BEAF, false)
			EPrompt("Pose", 0xD51B784F, false)
			ExecuteCommand('close')
			local player = PlayerPedId()
			local male = IsPedMale(player)
			local x,y,z = table.unpack(GetEntityCoords(player, true))
			local syn = CreateObject(GetHashKey('P_PIPE01X'), x, y, z + 0.2, true, true, true)
			local righthand = GetEntityBoneIndexByName(player, "SKEL_R_Finger13")
			AttachEntityToEntity(syn, player, righthand, 0.005, -0.045, 0.0, -170.0, 10.0, -15.0, true, true, false, true, 1, true)
			Anim(player,"amb_wander@code_human_smoking_wander@male_b@trans","nopipe_trans_pipe",-1,30)
			Wait(9000)
			Anim(player,"amb_rest@world_human_smoking@male_b@base","base",-1,31)
			TriggerServerEvent('QBCore:Server:RemoveItem', 'indtobacco', 1)
			TriggerEvent('inventory:client:ItemBox', sharedItems['indtobacco'], 'remove')
			while not IsEntityPlayingAnim(player,"amb_rest@world_human_smoking@male_b@base","base", 3) do
				Wait(100)
			end

			if proppromptdisplayed == false then
				PromptSetEnabled(PropPrompt, true)
				PromptSetVisible(PropPrompt, true)
				PromptSetEnabled(UsePrompt, true)
				PromptSetVisible(UsePrompt, true)
				PromptSetEnabled(ChangeStance, true)
				PromptSetVisible(ChangeStance, true)
				proppromptdisplayed = true
			end

			while IsEntityPlayingAnim(player, "amb_rest@world_human_smoking@male_b@base","base", 3) do

				Wait(5)
				if IsControlJustReleased(0, 0x3B24C470) then
					PromptSetEnabled(PropPrompt, false)
					PromptSetVisible(PropPrompt, false)
					PromptSetEnabled(UsePrompt, false)
					PromptSetVisible(UsePrompt, false)
					PromptSetEnabled(ChangeStance, false)
					PromptSetVisible(ChangeStance, false)
					proppromptdisplayed = false

					Anim(player, "amb_wander@code_human_smoking_wander@male_b@trans", "pipe_trans_nopipe", -1, 30)
					Wait(6066)
					DeleteEntity(syn)
					ClearPedSecondaryTask(player)
					ClearPedTasks(player)
					Wait(10)
				end
				
				if IsControlJustReleased(0, 0xD51B784F) then
					Anim(player, "amb_rest@world_human_smoking@pipe@proper@male_d@wip_base", "wip_base", -1, 30)
					Wait(5000)
					Anim(player, "amb_rest@world_human_smoking@male_b@base","base", -1, 31)
					Wait(100)
				end

				if IsControlJustReleased(0, 0x07B8BEAF) then
					-- fill up cores
					Citizen.InvokeNative(0xC6258F41D86676E0, player, 0, 100) -- SetAttributeCoreValue
					Citizen.InvokeNative(0xC6258F41D86676E0, player, 1, 100) -- SetAttributeCoreValue
					Citizen.InvokeNative(0xC6258F41D86676E0, player, 2, 100) -- SetAttributeCoreValue
					EnableAttributeOverpower(player, 0, 5000.0)
					EnableAttributeOverpower(player, 1, 5000.0)
					EnableAttributeOverpower(player, 2, 5000.0)
					Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 0, 5000.0)
					Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 1, 5000.0)
					Citizen.InvokeNative(0xF6A7C08DF2E28B28, player, 2, 5000.0)
					-- play core fillup sound
					PlaySoundFrontend("Core_Fill_Up", "Consumption_Sounds", true, 0)
					-- do drug effect
					drugeffect()
					Wait(500)
					if IsControlPressed(0, 0x07B8BEAF) then
						Anim(player, "amb_rest@world_human_smoking@male_b@idle_b","idle_d", -1, 30, 0)
						Wait(15599)
						Anim(player, "amb_rest@world_human_smoking@male_b@base","base", -1, 31, 0)
						Wait(100)
					else
						Anim(player, "amb_rest@world_human_smoking@male_b@idle_a","idle_a", -1, 30, 0)
						Wait(22600)
						Anim(player, "amb_rest@world_human_smoking@male_b@base","base", -1, 31, 0)
						Wait(100)
					end
				end
			end

			PromptSetEnabled(PropPrompt, false)
			PromptSetVisible(PropPrompt, false)
			PromptSetEnabled(UsePrompt, false)
			PromptSetVisible(UsePrompt, false)
			PromptSetEnabled(ChangeStance, false)
			PromptSetVisible(ChangeStance, false)
			proppromptdisplayed = false

			DetachEntity(syn, true, true)
			ClearPedSecondaryTask(player)
			RemoveAnimDict("amb_wander@code_human_smoking_wander@male_b@trans")
			RemoveAnimDict("amb_rest@world_human_smoking@male_b@base")
			RemoveAnimDict("amb_rest@world_human_smoking@pipe@proper@male_d@wip_base")
			RemoveAnimDict("amb_rest@world_human_smoking@male_b@idle_a")
			RemoveAnimDict("amb_rest@world_human_smoking@male_b@idle_b")
			Wait(100)
			ClearPedTasks(player)
		else
			exports['qbr-core']:Notify(9, 'You don\'t have a pipe!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['indtobacco'] = 1 })
end)

-- functions

function drugeffect()
Citizen.CreateThread(function()
		AnimpostfxPlay("MP_MoonshineToxic") -- start screen effect
		Wait(Config.DrugEffect) -- drug effect time
		AnimpostfxStop("MP_MoonshineToxic") -- stop screen effect
    end)
end

function Anim(actor, dict, body, duration, flags, introtiming, exittiming)
Citizen.CreateThread(function()
    RequestAnimDict(dict)
    local dur = duration or -1
    local flag = flags or 1
    local intro = tonumber(introtiming) or 1.0
    local exit = tonumber(exittiming) or 1.0
	timeout = 5
    while (not HasAnimDictLoaded(dict) and timeout>0) do
		timeout = timeout-1
        if timeout == 0 then 
            print("Animation Failed to Load")
		end
		Citizen.Wait(300)
    end
    TaskPlayAnim(actor, dict, body, intro, exit, dur, flag --[[1 for repeat--]], 1, false, false, false, 0, true)
    end)
end

function StopAnim(dict, body)
Citizen.CreateThread(function()
    StopAnimTask(PlayerPedId(), dict, body, 1.0)
    end)
end

function FPrompt(text, button, hold)
    Citizen.CreateThread(function()
        proppromptdisplayed=false
        PropPrompt=nil
        local str = text or "Put Away"
        local buttonhash = button or 0x3B24C470
        local holdbutton = hold or false
        PropPrompt = PromptRegisterBegin()
        PromptSetControlAction(PropPrompt, buttonhash)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(PropPrompt, str)
        PromptSetEnabled(PropPrompt, false)
        PromptSetVisible(PropPrompt, false)
        PromptSetHoldMode(PropPrompt, holdbutton)
        PromptRegisterEnd(PropPrompt)
    end)
end

function LMPrompt(text, button, hold)
    Citizen.CreateThread(function()
        UsePrompt=nil
        local str = text or "Use"
        local buttonhash = button or 0x07B8BEAF
        local holdbutton = hold or false
        UsePrompt = PromptRegisterBegin()
        PromptSetControlAction(UsePrompt, buttonhash)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(UsePrompt, str)
        PromptSetEnabled(UsePrompt, false)
        PromptSetVisible(UsePrompt, false)
        PromptSetHoldMode(UsePrompt, holdbutton)
        PromptRegisterEnd(UsePrompt)
    end)
end

function EPrompt(text, button, hold)
    Citizen.CreateThread(function()
        ChangeStance=nil
        local str = text or "Use"
        local buttonhash = button or 0xD51B784F
        local holdbutton = hold or false
        ChangeStance = PromptRegisterBegin()
        PromptSetControlAction(ChangeStance, buttonhash)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(ChangeStance, str)
        PromptSetEnabled(ChangeStance, false)
        PromptSetVisible(ChangeStance, false)
        PromptSetHoldMode(ChangeStance, holdbutton)
        PromptRegisterEnd(ChangeStance)
    end)
end