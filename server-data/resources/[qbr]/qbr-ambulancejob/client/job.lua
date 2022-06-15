isHealingPerson = false
healAnimDict = "mini_games@story@mob4@heal_jules@bandage@arthur"
healAnim = "bandage_fast"

local statusCheckPed = nil
local PlayerJob = {}
local onDuty = false
local currentGarage = 1

-- Functions
local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

local function GetClosestPlayer()
    local closestPlayers = exports['qbr-core']:GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(PlayerPedId())

    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = #(pos - coords)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end
	return closestPlayer, closestDistance
end

local function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)

    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end

function TakeOutVehicle(vehicleInfo)
    local coords = Config.Locations["vehicle"][currentGarage]
    exports['qbr-core']:SpawnVehicle(vehicleInfo, function(veh)
        SetEntityHeading(veh, coords.w)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
	Citizen.InvokeNative(0x400F9556,veh, Lang:t('info.amb_plate')..tostring(math.random(1000, 9999)))
        -- if Config.VehicleSettings[vehicleInfo] ~= nil then
        --     QBCore.Shared.SetDefaultVehicleExtras(veh, Config.VehicleSettings[vehicleInfo].extras)
        -- end
        --TriggerEvent("vehiclekeys:client:SetOwner", exports['qbr-core']:GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end

function MenuGarage()
    local vehicleMenu = {
        {
            header = Lang:t('menu.amb_vehicles'),
            isMenuHeader = true
        }
    }

    local authorizedVehicles = Config.AuthorizedVehicles[exports['qbr-core']:GetPlayerData().job.grade.level]
    for veh, label in pairs(authorizedVehicles) do
        vehicleMenu[#vehicleMenu+1] = {
            header = label,
            txt = "",
            params = {
                event = "ambulance:client:TakeOutVehicle",
                args = {
                    vehicle = veh
                }
            }
        }
    end
    vehicleMenu[#vehicleMenu+1] = {
        header = Lang:t('menu.close'),
        txt = "",
        params = {
            event = "qbr-menu:client:closeMenu"
        }

    }
    exports['qbr-menu']:openMenu(vehicleMenu)
end

function createAmbuPrompts()
    for k, v in pairs(Config.Locations["armory"]) do
        exports['qbr-core']:createPrompt("ambulance:armory:"..k, vector3(v.x, v.y, v.z), Config.PromptKey, 'Armory', {
            type = 'client',
            event = 'ambulance:client:promptArmory',
        })
    end
    for k, v in pairs(Config.Locations["duty"]) do
        exports['qbr-core']:createPrompt("ambulance:duty:"..k, vector3(v.x, v.y, v.z), Config.PromptKey, 'On/Off Duty', {
            type = 'client',
            event = 'ambulance:client:promptDuty',
        })
    end
    for k, v in pairs(Config.Locations["vehicle"]) do
        exports['qbr-core']:createPrompt("ambulance:vehicle:"..k, vector3(v.x, v.y, v.z), Config.PromptKey, 'Jobgarage', {
            type = 'client',
            event = 'ambulance:client:promptVehicle',
            args = {k},
        })
    end
    for k, v in pairs(Config.Locations["stash"]) do
        exports['qbr-core']:createPrompt("ambulance:stash:"..k, vector3(v.x, v.y, v.z), Config.PromptKey, 'Personal Stash', {
            type = 'client',
            event = 'ambulance:client:promptStash',
        })
    end
    for k, v in pairs(Config.Locations["checking"]) do
        exports['qbr-core']:createPrompt("ambulance:checkin:"..k, vector3(v.x, v.y, v.z), Config.PromptKey, 'Check-in', {
            type = 'client',
            event = 'ambulance:client:promptCheckin',
        })
    end
    for k, v in pairs(Config.Locations["beds"]) do
        exports['qbr-core']:createPrompt("ambulance:bed:"..k, vector3(Config.Locations["beds"][k].coords.x, Config.Locations["beds"][k].coords.y, Config.Locations["beds"][k].coords.z), Config.PromptKey, Lang:t('text.lie_bed', {cost = Config.BillCost}), {
            type = 'client',
            event = 'ambulance:client:promptBed',
        })
    end
end

-- Events
RegisterNetEvent('ambulance:client:promptArmory', function()
    exports['qbr-core']:GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        onDuty = PlayerData.job.onduty
        if PlayerJob.name == "ambulance"  then
            TriggerServerEvent("inventory:server:OpenInventory", "shop", "hospital", Config.Items)
        else
            exports['qbr-core']:Notify(9, Lang:t('error.not_ems'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    end)
end)

RegisterNetEvent('ambulance:client:promptDuty', function()
    exports['qbr-core']:GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        onDuty = PlayerData.job.onduty
        if PlayerJob.name == "ambulance"  then
            onDuty = not onDuty
            TriggerServerEvent("QBCore:ToggleDuty")
        else
            exports['qbr-core']:Notify(9, Lang:t('error.not_ems'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    end)
end)

RegisterNetEvent('ambulance:client:promptVehicle', function(k)
    exports['qbr-core']:GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        onDuty = PlayerData.job.onduty
        local ped = PlayerPedId()

        if PlayerJob.name == "ambulance"  then
            if IsPedInAnyVehicle(ped, false) then
                exports['qbr-core']:DeleteVehicle(GetVehiclePedIsIn(ped))
            else
                MenuGarage()
                currentGarage = k
            end
        else
            exports['qbr-core']:Notify(9, Lang:t('error.not_ems'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    end)
end)

RegisterNetEvent('ambulance:client:promptStash', function(k)
    exports['qbr-core']:GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
        onDuty = PlayerData.job.onduty
        if PlayerJob.name == "ambulance"  then
            TriggerServerEvent("inventory:server:OpenInventory", "stash", "ambulancestash_"..exports['qbr-core']:GetPlayerData().citizenid)
            TriggerEvent("inventory:client:SetCurrentStash", "ambulancestash_"..exports['qbr-core']:GetPlayerData().citizenid)
        else
            exports['qbr-core']:Notify(9, Lang:t('error.not_ems'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    end)
end)

RegisterNetEvent('ambulance:client:TakeOutVehicle', function(data)
    local vehicle = data.vehicle
    TakeOutVehicle(vehicle)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
    TriggerServerEvent("hospital:server:SetDoctor")
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    exports.spawnmanager:setAutoSpawn(false)
    local ped = PlayerPedId()
    local player = PlayerId()
    TriggerServerEvent("hospital:server:SetDoctor")
    CreateThread(function()
        Wait(5000)
        SetEntityMaxHealth(ped, 200)
        SetEntityHealth(ped, 200)
        SetPlayerHealthRechargeMultiplier(player, 0.0)
    end)
    CreateThread(function()
        Wait(1000)
        exports['qbr-core']:GetPlayerData(function(PlayerData)
            PlayerJob = PlayerData.job
            onDuty = PlayerData.job.onduty
            if (not PlayerData.metadata["inlaststand"] and PlayerData.metadata["isdead"]) then
                deathTime = Laststand.ReviveInterval
                OnDeath()
                DeathTimer()
            elseif (PlayerData.metadata["inlaststand"] and not PlayerData.metadata["isdead"]) then
                SetLaststand(true, true)
            else
                TriggerServerEvent("hospital:server:SetDeathStatus", false)
                TriggerServerEvent("hospital:server:SetLaststandStatus", false)
            end
            createAmbuPrompts()
        end)
    end)
end)

RegisterNetEvent('QBCore:Client:SetDuty', function(duty)
    onDuty = duty
    TriggerServerEvent("hospital:server:SetDoctor")
end)

RegisterNetEvent('hospital:client:CheckStatus', function()
    local player, distance = GetClosestPlayer()
    if player ~= -1 and distance < 5.0 then
        local playerId = GetPlayerServerId(player)
        statusCheckPed = GetPlayerPed(player)
        exports['qbr-core']:TriggerCallback('hospital:GetPlayerStatus', function(result)
            if result then
                for k, v in pairs(result) do
                    if k ~= "BLEED" and k ~= "WEAPONWOUNDS" then
                        statusChecks[#statusChecks+1] = {bone = Config.BoneIndexes[k], label = v.label .." (".. Config.WoundStates[v.severity] ..")"}
                    elseif result["WEAPONWOUNDS"] then
                        for k, v in pairs(result["WEAPONWOUNDS"]) do
                            exports['qbr-core']:Notify(9, Lang:t('info.status')..': '..WeaponDamageList[v], 2000, 0, 'mp_lobby_textures', 'cross')
                        end
                    elseif result["BLEED"] > 0 then
                        exports['qbr-core']:Notify(9, Lang:t('info.status')..': '..Lang:t('info.is_status', {status = Config.BleedingStates[v].label}), 2000, 0, 'mp_lobby_textures', 'cross')
                    else
                        exports['qbr-core']:Notify(9, Lang:t('success.healthy_player'), 2000, 0, 'hud_textures', 'check')
                    end
                end
                isStatusChecking = true
                statusCheckTime = Config.CheckTime
            end
        end, playerId)
    else
        exports['qbr-core']:Notify(9, Lang:t('error.no_player'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('hospital:client:RevivePlayer', function()
    exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
        if hasItem then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                isHealingPerson = true
                exports['qbr-core']:Progressbar("hospital_revive", Lang:t('progress.revive'), 5000, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = healAnimDict,
                    anim = healAnim,
                    flags = 1,
                }, {}, {}, function() -- Done
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, healAnim, 1.0)
                    exports['qbr-core']:Notify(9, Lang:t('success.revived'), 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
                    TriggerServerEvent("hospital:server:RevivePlayer", playerId)
                end, function() -- Cancel
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, healAnim, 1.0)
                    exports['qbr-core']:Notify(9, Lang:t('error.cancled'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
                end)
            else
                exports['qbr-core']:Notify(9, Lang:t('error.no_player'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
            end
        else
            exports['qbr-core']:Notify(9, Lang:t('error.no_firstaid'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    end, 'firstaid')
end)

RegisterNetEvent('hospital:client:TreatWounds', function()
    exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
        if hasItem then
            local player, distance = GetClosestPlayer()
            if player ~= -1 and distance < 5.0 then
                local playerId = GetPlayerServerId(player)
                isHealingPerson = true
                exports['qbr-core']:Progressbar("hospital_healwounds", Lang:t('progress.healing'), 5000, false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    animDict = healAnimDict,
                    anim = healAnim,
                    flags = 1,
                }, {}, {}, function() -- Done
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, healAnim, 1.0)
                    exports['qbr-core']:Notify(9, Lang:t('success.helped_player'), 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
                    TriggerServerEvent("hospital:server:TreatWounds", playerId)
                end, function() -- Cancel
                    isHealingPerson = false
                    StopAnimTask(PlayerPedId(), healAnimDict, "exit", 1.0)
                    exports['qbr-core']:Notify(9, Lang:t('error.canceled'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
                end)
            else
                exports['qbr-core']:Notify(9, Lang:t('error.no_player'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
            end
        else
            exports['qbr-core']:Notify(9, Lang:t('error.no_bandage'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    end, 'bandage')
end)

-- Threads
CreateThread(function()
    while true do
        Wait(10)
        if isStatusChecking then
            for k, v in pairs(statusChecks) do
                local x,y,z = table.unpack(GetPedBoneCoords(statusCheckPed, v.bone))
                DrawText3D(x, y, z, v.label)
            end
        end
        if isHealingPerson then
            local ped = PlayerPedId()
            if not IsEntityPlayingAnim(ped, healAnimDict, healAnim, 1) then
                loadAnimDict(healAnimDict)
                TaskPlayAnim(ped, healAnimDict, healAnim, 3.0, 3.0, -1, 49, 0, 0, 0, 0)
            end
        end
    end
end)
