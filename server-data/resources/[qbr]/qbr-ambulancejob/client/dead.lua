local deadAnimDict = "ai_damage@dead@base"
local deadAnim = "dead_e"
deathTime = 0
local sharedWeapons = exports['qbr-core']:GetWeapons()
-- Functions
local function loadAnimDict(dict)
    while (not HasAnimDictLoaded(dict)) do
        RequestAnimDict(dict)
        Wait(5)
    end
end

function OnDeath()
    if not isDead then
        isDead = true
        TriggerServerEvent("hospital:server:SetDeathStatus", true)
        TriggerServerEvent("InteractSound_SV:PlayOnSource", "demo", 0.1)
        local player = PlayerPedId()

        while GetEntitySpeed(player) > 0.5 or IsPedRagdoll(player) do
            Wait(10)
        end

        if isDead then
            local pos = GetEntityCoords(player)
            local heading = GetEntityHeading(player)

            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped) then
                local veh = GetVehiclePedIsIn(ped)
                local vehseats = GetVehicleModelNumberOfSeats(GetHashKey(GetEntityModel(veh)))
                for i = -1, vehseats do
                    local occupant = GetPedInVehicleSeat(veh, i)
                    if occupant == ped then
                        NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z + 0.5, heading, true, false)
                        SetPedIntoVehicle(ped, veh, i)
                    end
                end
            else
                NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z + 0.5, heading, true, false)
            end

            SetEntityInvincible(player, true)
            SetEntityHealth(player, GetEntityMaxHealth(player))

            --TODO Animations
            if IsPedInAnyVehicle(player, false) then
                loadAnimDict("veh@low@front_ps@idle_duck")
                TaskPlayAnim(player, "veh@low@front_ps@idle_duck", "sit", 1.0, 1.0, -1, 1, 0, 0, 0, 0)
            else
                loadAnimDict(deadAnimDict)
                TaskPlayAnim(player, deadAnimDict, deadAnim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
            end
            TriggerServerEvent('hospital:server:ambulanceAlert', Lang:t('info.civ_died'))
        end
    end
end

function DeathTimer()
    sleep = 1000
    while isDead do
        Wait(sleep)
        deathTime = deathTime - 1
        if deathTime <= 0 then
            if IsControlPressed(0, 0xCEFD9220) and not isInHospitalBed then
                sleep= 10
                TriggerEvent("hospital:client:RespawnAtHospital")
                return
            end
        end
    end
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    DisplayText(str, x, y)
end

-- Threads

CreateThread(function()
	while true do
		Wait(10)
		local player = PlayerId()
		if NetworkIsPlayerActive(player) then
            local playerPed = PlayerPedId()
            if IsEntityDead(playerPed) and not InLaststand then
                SetLaststand(true)
            elseif IsEntityDead(playerPed) and InLaststand and not isDead then
                SetLaststand(false)
                local killer_2, killerWeapon = NetworkGetEntityKillerOfPlayer(player)
                local killer = GetPedSourceOfDeath(playerPed)

                if killer_2 ~= 0 and killer_2 ~= -1 then
                    killer = killer_2
                end

                local killerId = NetworkGetPlayerIndexFromPed(killer)
                local killerName = killerId ~= -1 and GetPlayerName(killerId) .. " " .. "("..GetPlayerServerId(killerId)..")" or Lang:t('info.self_death')
                local weaponLabel = Lang:t('info.wep_unknown')
                local weaponName = Lang:t('info.wep_unknown')
                local weaponItem = sharedWeapons[killerWeapon]
                if weaponItem then
                    weaponLabel = weaponItem.label
                    weaponName = weaponItem.name
                end
                TriggerServerEvent("qb-log:server:CreateLog", "death", Lang:t('logs.death_log_title', {playername = GetPlayerName(-1), playerid = GetPlayerServerId(player)}), "red", Lang:t('logs.death_log_message', {killername = killerName, playername = GetPlayerName(player), weaponlabel = weaponLabel, weaponname = weaponName}))
                deathTime = Config.DeathTime
                OnDeath()
                DeathTimer()
            end
		end
	end
end)

emsNotified = false

CreateThread(function()
	while true do
        sleep = 1000
		if isDead or InLaststand then
            sleep = 5
            local ped = PlayerPedId()
            DisableAllControlActions(0)
			EnableControlAction(0, 0x9720FCEE, true)   -- T
            EnableControlAction(0, 0xCEFD9220, true)    -- E
            EnableControlAction(0, 0x760A9C6F, true)    -- G

            if isDead then
                if not isInHospitalBed then
                    if deathTime > 0 then
                        DrawTxt(Lang:t('info.respawn_txt', {deathtime = math.ceil(deathTime)}), 0.50, 0.80, 0.5, 0.5, true, 255, 0, 0, 200, true)
                    else
                        DrawTxt(Lang:t('info.respawn_revive', {cost = Config.BillCost}), 0.50, 0.80, 0.5, 0.5, true, 255, 0, 0, 200, true)
                    end
                end

                if IsPedInAnyVehicle(ped, false) then
                    loadAnimDict("veh@low@front_ps@idle_duck")
                    if not IsEntityPlayingAnim(ped, "veh@low@front_ps@idle_duck", "sit", 3) then
                        TaskPlayAnim(ped, "veh@low@front_ps@idle_duck", "sit", 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                    end
                else
                    if isInHospitalBed then
                        if not IsEntityPlayingAnim(ped, inBedDict, inBedAnim, 3) then
                            loadAnimDict(inBedDict)
                            TaskPlayAnim(ped, inBedDict, inBedAnim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                        end
                    else
                        if not IsEntityPlayingAnim(ped, deadAnimDict, deadAnim, 3) then
                            loadAnimDict(deadAnimDict)
                            TaskPlayAnim(ped, deadAnimDict, deadAnim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                        end
                    end
                end

                SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
            elseif InLaststand then
                sleep = 5

                if LaststandTime > Laststand.MinimumRevive then
                    DrawTxt(Lang:t('info.bleed_out', {time = math.ceil(LaststandTime)}), 0.50, 0.80, 0.5, 0.5, true, 255, 255, 255, 200, true)
                else
                    DrawTxt(Lang:t('info.bleed_out_help', {time = math.ceil(LaststandTime)}), 0.50, 0.80, 0.5, 0.5, true, 255, 255, 255, 200, true)
                    if not emsNotified then
                        DrawTxt(Lang:t('info.request_help'), 0.50, 0.85, 0.5, 0.5, true, 255, 255, 255, 200, true)
                    else
                        DrawTxt(Lang:t('info.help_requested'), 0.50, 0.85, 0.5, 0.5, true, 255, 255, 255, 200, true)
                    end

                    if IsControlJustPressed(0, 0x760A9C6F) and not emsNotified then
                        TriggerServerEvent('hospital:server:ambulanceAlert', Lang:t('info.civ_down'))
                        emsNotified = true
                    end
                end

                if not isEscorted then
                    if IsPedInAnyVehicle(ped, false) then
                        loadAnimDict("veh@low@front_ps@idle_duck")
                        if not IsEntityPlayingAnim(ped, "veh@low@front_ps@idle_duck", "sit", 3) then
                            TaskPlayAnim(ped, "veh@low@front_ps@idle_duck", "sit", 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                        end
                    else
                        loadAnimDict(lastStandDict)
                        if not IsEntityPlayingAnim(ped, lastStandDict, lastStandAnim, 3) then
                            TaskPlayAnim(ped, lastStandDict, lastStandAnim, 1.0, 1.0, -1, 1, 0, 0, 0, 0)
                        end
                    end
                else
                    if IsPedInAnyVehicle(ped, false) then
                        loadAnimDict("veh@low@front_ps@idle_duck")
                        if IsEntityPlayingAnim(ped, "veh@low@front_ps@idle_duck", "sit", 3) then
                            StopAnimTask(ped, "veh@low@front_ps@idle_duck", "sit", 3)
                        end
                    else
                        loadAnimDict(lastStandDict)
                        if IsEntityPlayingAnim(ped, lastStandDict, lastStandAnim, 3) then
                            StopAnimTask(ped, lastStandDict, lastStandAnim, 3)
                        end
                    end
                end
            end
		end
        Wait(sleep)
	end
end)
