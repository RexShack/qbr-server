-- Variables
local CurrentStatusList = {}
local Casings = {}
local CurrentCasing = nil
local Blooddrops = {}
local CurrentBlooddrop = nil
local Fingerprints = {}
local CurrentFingerprint = 0
local shotAmount = 0

local StatusList = {
    ['fight'] = Lang:t('evidence.red_hands'),
    ['widepupils'] = Lang:t('evidence.wide_pupils'),
    ['redeyes'] = Lang:t('evidence.red_eyes'),
    ['weedsmell'] = Lang:t('evidence.weed_smell'),
    ['gunpowder'] = Lang:t('evidence.gunpowder'),
    ['chemicals'] = Lang:t('evidence.chemicals'),
    ['heavybreath'] = Lang:t('evidence.heavy_breathing'),
    ['sweat'] = Lang:t('evidence.sweat'),
    ['handbleed'] = Lang:t('evidence.handbleed'),
    ['confused'] = Lang:t('evidence.confused'),
    ['alcohol'] = Lang:t('evidence.alcohol'),
    ["heavyalcohol"] = Lang:t('evidence.heavy_alcohol'),
    ["agitated"] = Lang:t('evidence.agitated')
}

local WhitelistedWeapons = {
    0xC715F939,
    0x126210c3,
    0xA00FC1E4,
    0xb5fd67cd,
    0x60b51da4,
    0x126210c3,
}

-- Functions
local function DrawText3D(x, y, z, text)
    coords = vector3(x, y, z)
	local onScreen, x, y = GetScreenCoordFromWorldCoord(coords.x, coords.y, coords.z)

	if (onScreen) then
		SetTextScale(0.35, 0.35)
		SetTextColor(255, 255, 255, 215)
		SetTextFontForCurrentCommand(4)
		SetTextDropshadow(0, 0, 0, 255)
		SetTextCentre(true)
		DisplayText(CreateVarString(10, 'LITERAL_STRING', text), x, y)
	end
end

local function WhitelistedWeapon(weapon)
    local weaponGroup = GetWeapontypeGroup(weapon)
    for i=1, #WhitelistedWeapons do
        if WhitelistedWeapons[i] == weaponGroup then
            return true
        end
    end
    return false
end

local function DropBulletCasing(weapon, ped)
    local randX = math.random() + math.random(-1, 1)
    local randY = math.random() + math.random(-1, 1)
    local coords = GetOffsetFromEntityInWorldCoords(ped, randX, randY, 0)
    TriggerServerEvent('evidence:server:CreateCasing', weapon, coords)
    Wait(300)
end

local function DnaHash(s)
    local h = string.gsub(s, '.', function(c)
        return string.format('%02x', string.byte(c))
    end)
    return h
end

-- Events
RegisterNetEvent('evidence:client:SetStatus', function(statusId, time)
    if time > 0 and StatusList[statusId] then
        if (CurrentStatusList == nil or CurrentStatusList[statusId] == nil) or
            (CurrentStatusList[statusId] and CurrentStatusList[statusId].time < 20) then
            CurrentStatusList[statusId] = {
                text = StatusList[statusId],
                time = time
            }
            exports['qbr-core']:Notify(9, CurrentStatusList[statusId].text, 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    elseif StatusList[statusId] then
        CurrentStatusList[statusId] = nil
    end
    TriggerServerEvent('evidence:server:UpdateStatus', CurrentStatusList)
end)

RegisterNetEvent('evidence:client:AddBlooddrop', function(bloodId, citizenid, bloodtype, coords)
    Blooddrops[bloodId] = {
        citizenid = citizenid,
        bloodtype = bloodtype,
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z - 0.9
        }
    }
end)

RegisterNetEvent('evidence:client:RemoveBlooddrop', function(bloodId)
    Blooddrops[bloodId] = nil
    CurrentBlooddrop = 0
end)

RegisterNetEvent('evidence:client:AddFingerPrint', function(fingerId, fingerprint, coords)
    Fingerprints[fingerId] = {
        fingerprint = fingerprint,
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z - 0.9
        }
    }
end)

RegisterNetEvent('evidence:client:RemoveFingerprint', function(fingerId)
    Fingerprints[fingerId] = nil
    CurrentFingerprint = 0
end)

RegisterNetEvent('evidence:client:ClearBlooddropsInArea', function()
    local pos = GetEntityCoords(PlayerPedId())
    local blooddropList = {}
    exports['qbr-core']:Progressbar('clear_blooddrops', Lang:t("progressbar.blood_clear"), 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true
    }, {}, {}, {}, function() -- Done
        if Blooddrops and next(Blooddrops) then
            for bloodId, v in pairs(Blooddrops) do
                if #(pos -
                    vector3(Blooddrops[bloodId].coords.x, Blooddrops[bloodId].coords.y, Blooddrops[bloodId].coords.z)) <
                    10.0 then
                    blooddropList[#blooddropList+1] = bloodId
                end
            end
            TriggerServerEvent('evidence:server:ClearBlooddrops', blooddropList)
            exports['qbr-core']:Notify(9, Lang:t("success.blood_clear"), 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
        end
    end, function() -- Cancel
        exports['qbr-core']:Notify(9, Lang:t("error.blood_not_cleared"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end)
end)

RegisterNetEvent('evidence:client:AddCasing', function(casingId, weapon, coords, serie)
    Casings[casingId] = {
        type = weapon,
        serie = serie and serie or Lang:t('evidence.serial_not_visible'),
        coords = {
            x = coords.x,
            y = coords.y,
            z = coords.z - 0.9
        }
    }
end)

RegisterNetEvent('evidence:client:RemoveCasing', function(casingId)
    Casings[casingId] = nil
    CurrentCasing = 0
end)

RegisterNetEvent('evidence:client:ClearCasingsInArea', function()
    local pos = GetEntityCoords(PlayerPedId())
    local casingList = {}
    exports['qbr-core']:Progressbar('clear_casings', Lang:t("progressbar.bullet_casing"), 5000, false, true, {
        disableMovement = false,
        disableCarMovement = false,
        disableMouse = false,
        disableCombat = true
    }, {}, {}, {}, function() -- Done
        if Casings and next(Casings) then
            for casingId, v in pairs(Casings) do
                if #(pos - vector3(Casings[casingId].coords.x, Casings[casingId].coords.y, Casings[casingId].coords.z)) <
                    10.0 then
                    casingList[#casingList+1] = casingId
                end
            end
            TriggerServerEvent('evidence:server:ClearCasings', casingList)
            exports['qbr-core']:Notify(9, Lang:t("success.bullet_casing_removed"), 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')

        end
    end, function() -- Cancel
        exports['qbr-core']:Notify(9, Lang:t("error.bullet_casing_not_removed"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end)
end)

-- Threads

CreateThread(function()
    while true do
        Wait(10000)
        if LocalPlayer.state.isLoggedIn then
            if CurrentStatusList and next(CurrentStatusList) then
                for k, v in pairs(CurrentStatusList) do
                    if CurrentStatusList[k].time > 0 then
                        CurrentStatusList[k].time = CurrentStatusList[k].time - 10
                    else
                        CurrentStatusList[k].time = 0
                    end
                end
                TriggerServerEvent('evidence:server:UpdateStatus', CurrentStatusList)
            end
            if shotAmount > 0 then
                shotAmount = 0
            end
        end
    end
end)

CreateThread(function() -- Gunpowder Status when shooting
    while true do
        Wait(1)
        local ped = PlayerPedId()
        if IsPedShooting(ped) then
            local weapon = Citizen.InvokeNative(0x8425C5F057012DAB, ped)
            if not WhitelistedWeapon(weapon) then
                shotAmount = shotAmount + 1
                if shotAmount > 5 and (CurrentStatusList == nil or CurrentStatusList['gunpowder'] == nil) then
                    if math.random(1, 10) <= 7 then
                        TriggerEvent('evidence:client:SetStatus', 'gunpowder', 200)
                    end
                end
                DropBulletCasing(weapon, ped)
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(1)
        if CurrentCasing and CurrentCasing ~= 0 then
            local pos = GetEntityCoords(PlayerPedId())
            if #(pos -vector3(Casings[CurrentCasing].coords.x, Casings[CurrentCasing].coords.y, Casings[CurrentCasing].coords.z)) < 1.5 then
                local weaponHash = Casings[CurrentCasing].type
                DrawText3D(Casings[CurrentCasing].coords.x, Casings[CurrentCasing].coords.y, Casings[CurrentCasing].coords.z, Lang:t('info.bullet_casing', {value = Config.WeaponHashes[Casings[CurrentCasing].type].weaponAmmoLabel}))
                if IsControlJustReleased(0, 0x5415BE48) then
                    local info = {
                        label = Lang:t('info.casing'),
                        type = 'casing',
                        ammolabel = Config.WeaponHashes[Casings[CurrentCasing].type].weaponAmmoLabel,
                        ammotype = Config.WeaponHashes[Casings[CurrentCasing].type].weaponAmmo,
                        serie = Casings[CurrentCasing].serie
                    }
                    TriggerServerEvent('evidence:server:AddCasingToInventory', CurrentCasing, info)
                end
            end
        end

        if CurrentBlooddrop and CurrentBlooddrop ~= 0 then
            local pos = GetEntityCoords(PlayerPedId())
            if #(pos - vector3(Blooddrops[CurrentBlooddrop].coords.x, Blooddrops[CurrentBlooddrop].coords.y,
                Blooddrops[CurrentBlooddrop].coords.z)) < 1.5 then
                DrawText3D(Blooddrops[CurrentBlooddrop].coords.x, Blooddrops[CurrentBlooddrop].coords.y, Blooddrops[CurrentBlooddrop].coords.z, Lang:t('blood_text', {value = DnaHash(Blooddrops[CurrentBlooddrop].citizenid)}))
                if IsControlJustReleased(0, 0x5415BE48) then
                    local info = {
                        label = Lang:t('info.blood'),
                        type = 'blood',
                        dnalabel = DnaHash(Blooddrops[CurrentBlooddrop].citizenid),
                        bloodtype = Blooddrops[CurrentBlooddrop].bloodtype
                    }
                    TriggerServerEvent('evidence:server:AddBlooddropToInventory', CurrentBlooddrop, info)
                end
            end
        end

        if CurrentFingerprint and CurrentFingerprint ~= 0 then
            local pos = GetEntityCoords(PlayerPedId())
            if #(pos - vector3(Fingerprints[CurrentFingerprint].coords.x, Fingerprints[CurrentFingerprint].coords.y,
                Fingerprints[CurrentFingerprint].coords.z)) < 1.5 then
                DrawText3D(Fingerprints[CurrentFingerprint].coords.x, Fingerprints[CurrentFingerprint].coords.y, Fingerprints[CurrentFingerprint].coords.z, Lang:t('info.fingerprint_text'))
                if IsControlJustReleased(0, 0x5415BE48) then
                    local info = {
                        label = Lang:t('info.fingerprint'),
                        type = 'fingerprint',
                        fingerprint = Fingerprints[CurrentFingerprint].fingerprint
                    }
                    TriggerServerEvent('evidence:server:AddFingerprintToInventory', CurrentFingerprint, info)
                end
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(10)
        if LocalPlayer.state.isLoggedIn then
            if PlayerJob.name == 'police' and onDuty then
                if Citizen.InvokeNative(0x8425C5F057012DAB, PlayerPedId()) == -164645981 then
                    if next(Casings) then
                        local pos = GetEntityCoords(PlayerPedId(), true)
                        for k, v in pairs(Casings) do
                            local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                            if dist < 1.5 then
                                CurrentCasing = k
                            end
                        end
                    end
                    if next(Blooddrops) then
                        local pos = GetEntityCoords(PlayerPedId(), true)
                        for k, v in pairs(Blooddrops) do
                            local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                            if dist < 1.5 then
                                CurrentBlooddrop = k
                            end
                        end
                    end
                    if next(Fingerprints) then
                        local pos = GetEntityCoords(PlayerPedId(), true)
                        for k, v in pairs(Fingerprints) do
                            local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                            if dist < 1.5 then
                                CurrentFingerprint = k
                            end
                        end
                    end
                else
                    Wait(1000)
                end
            else
                Wait(5000)
            end
        end
    end
end)