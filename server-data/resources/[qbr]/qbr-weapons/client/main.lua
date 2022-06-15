-- Variables
local sharedWeapons = exports['qbr-core']:GetWeapons()
local PlayerData, CurrentWeaponData, CanShoot, MultiplierAmount = {}, {}, true, 0
local allowList = {
    `weapon_lasso`,
    `weapon_lasso_reinforced`,
    `weapon_melee_knife`,
    `weapon_melee_knife_jawbone`,
    `weapon_melee_hammer`,
    `weapon_melee_cleaver`,
    `weapon_melee_lantern`,
    `weapon_melee_davy_lantern`,
    `weapon_melee_torch`,
    `weapon_melee_hatchet`,
    `weapon_melee_machete`,
}

-- Handlers

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerData = exports['qbr-core']:GetPlayerData()
    exports['qbr-core']:TriggerCallback("weapons:server:GetConfig", function(RepairPoints)
        for k, data in pairs(RepairPoints) do
            Config.WeaponRepairPoints[k].IsRepairing = data.IsRepairing
            Config.WeaponRepairPoints[k].RepairingData = data.RepairingData
        end
    end)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    for k, v in pairs(Config.WeaponRepairPoints) do
        Config.WeaponRepairPoints[k].IsRepairing = false
        Config.WeaponRepairPoints[k].RepairingData = {}
    end
end)

-- Functions

local function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end

-- Events

RegisterNetEvent("weapons:client:SyncRepairShops", function(NewData, key)
    Config.WeaponRepairPoints[key].IsRepairing = NewData.IsRepairing
    Config.WeaponRepairPoints[key].RepairingData = NewData.RepairingData
end)

RegisterNetEvent("addAttachment", function(component)
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    local WeaponData = sharedWeapons[weapon]
    GiveWeaponComponentToPed(ped, GetHashKey(WeaponData.name), GetHashKey(component))
end)

RegisterNetEvent('weapons:client:EquipTint', function(tint)
    local player = PlayerPedId()
    local weapon = GetSelectedPedWeapon(player)
    SetPedWeaponTintIndex(player, weapon, tint)
end)

RegisterNetEvent('weapons:client:SetCurrentWeapon', function(data, bool)
    if data ~= false then
        CurrentWeaponData = data
    else
        CurrentWeaponData = {}
    end
    CanShoot = bool
end)

RegisterNetEvent('weapons:client:SetWeaponQuality', function(amount)
    if CurrentWeaponData and next(CurrentWeaponData) then
        TriggerServerEvent("weapons:server:SetWeaponQuality", CurrentWeaponData, amount)
    end
end)

RegisterNetEvent('weapon:client:AddAmmo', function(type, amount, itemData)
    local ped = PlayerPedId()
    local weapon = Citizen.InvokeNative(0x8425C5F057012DAB,ped)
    local sharedItems = exports['qbr-core']:GetItems()
    if CurrentWeaponData then
        if sharedWeapons[weapon]["name"] ~= "weapon_unarmed" and sharedWeapons[weapon]["name"] ~= "weapon_bow" and sharedWeapons[weapon]["name"] ~= "weapon_bow_improved" and sharedWeapons[weapon]["ammotype"] == type:upper() then
            local total = Citizen.InvokeNative(0x015A522136D7F951, PlayerPedId(), weapon, Citizen.ResultAsInteger())
            if total + (amount/2) < 200 then
                exports['qbr-core']:Progressbar("taking_bullets", Lang:t('info.loading_bullets'), math.random(4000, 6000), false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    if sharedWeapons[weapon] then
                        Citizen.InvokeNative(0xB190BCA3F4042F95, ped, weapon, amount, 0xCA3454E6)
                        TaskReloadWeapon(ped)
                        TriggerServerEvent("weapons:server:AddWeaponAmmo", CurrentWeaponData, total + amount)
                        TriggerServerEvent('QBCore:Server:RemoveItem', itemData.name, 1, itemData.slot)
                        TriggerEvent('inventory:client:ItemBox', sharedItems[itemData.name], "remove")
                        TriggerEvent('QBCore:Notify', Lang:t('success.reloaded'), 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
                    end
                end, function()
                    exports['qbr-core']:Notify(9, Lang:t('error.canceled'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
                end)
            else
                exports['qbr-core']:Notify(9, Lang:t('error.max_ammo'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
            end
        elseif sharedWeapons[weapon]["name"] == "weapon_bow" or sharedWeapons[weapon]["name"] == "weapon_bow_improved" and sharedWeapons[weapon]["ammotype"] == type:upper() then
            local total = Citizen.InvokeNative(0x015A522136D7F951, PlayerPedId(), weapon, Citizen.ResultAsInteger())
            if total + (amount/2) < 40 then
                exports['qbr-core']:Progressbar("taking_bullets", Lang:t('info.loading_bullets'), math.random(4000, 6000), false, true, {
                    disableMovement = false,
                    disableCarMovement = false,
                    disableMouse = false,
                    disableCombat = true,
                }, {}, {}, {}, function() -- Done
                    if sharedWeapons[weapon] then
                        Citizen.InvokeNative(0xB190BCA3F4042F95, ped, weapon, amount, 0xCA3454E6)
                        TaskReloadWeapon(ped)
                        TriggerServerEvent("weapons:server:AddWeaponAmmo", CurrentWeaponData, total + amount)
                        TriggerServerEvent('QBCore:Server:RemoveItem', itemData.name, 1, itemData.slot)
                        TriggerEvent('inventory:client:ItemBox', sharedItems[itemData.name], "remove")
                        TriggerEvent('QBCore:Notify', Lang:t('success.reloaded'), 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
                    end
                end, function()
                    exports['qbr-core']:Notify(9, Lang:t('error.canceled'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
                end)
            else
                exports['qbr-core']:Notify(9, Lang:t('error.max_ammo'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
            end
        else
            exports['qbr-core']:Notify(9, Lang:t('error.no_weapon'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    else
        exports['qbr-core']:Notify(9, Lang:t('error.no_weapon'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

RegisterNetEvent("weapons:client:EquipAttachment", function(ItemData, attachment)
    local ped = PlayerPedId()
    local weapon = GetSelectedPedWeapon(ped)
    local WeaponData = sharedWeapons[weapon]
    if weapon ~= `WEAPON_UNARMED` then
        WeaponData.name = WeaponData.name:upper()
        if WeaponAttachments[WeaponData.name] then
            if WeaponAttachments[WeaponData.name][attachment]['item'] == ItemData.name then
                TriggerServerEvent("weapons:server:EquipAttachment", ItemData, CurrentWeaponData, WeaponAttachments[WeaponData.name][attachment])
            else
                exports['qbr-core']:Notify(9, Lang:t('error.no_support_attachment'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
            end
        end
    else
        exports['qbr-core']:Notify(9, Lang:t('error.no_weapon_in_hand'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

-- Threads

CreateThread(function()
    SetWeaponsNoAutoswap(true)
end)

CreateThread(function()
    while true do
        local ped = PlayerPedId()
		if Citizen.InvokeNative(0xADF692B254977C0C, ped, 7) == 1 and IsControlJustReleased(0, 0x07CE1E61) or IsControlJustReleased(0, 0xF84FA74F) then
            local weapon = GetCurrentPedWeapon(ped)
            local ammo = GetAmmoInPedWeapon(ped, weapon)
            for k,v in pairs(allowList) do
                if (v == weapon) then
                    return
                end
            end
            if allowList[GetHashKey(weapon)] then return end
            TriggerServerEvent("weapons:server:UpdateWeaponAmmo", CurrentWeaponData, tonumber(ammo))
            if MultiplierAmount > 0 then
                TriggerServerEvent("weapons:server:UpdateWeaponQuality", CurrentWeaponData, MultiplierAmount)
                MultiplierAmount = 0
            end
        end
        Wait(1)
    end
end)

CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            local ped = PlayerPedId()
            if CurrentWeaponData and next(CurrentWeaponData) then
                if IsPedShooting(ped) or IsControlJustPressed(0, 24) then
                    local weapon = GetSelectedPedWeapon(ped)
                    if CanShoot then
                        if weapon and weapon ~= 0 and sharedWeapons[weapon] then
                            local ammo = GetAmmoInPedWeapon(ped, weapon)
                            if sharedWeapons[weapon]["name"] == "weapon_snowball" then
                                TriggerServerEvent('QBCore:Server:RemoveItem', "snowball", 1)
                            -- elseif sharedWeapons[weapon]["name"] == "weapon_pipebomb" then
                                -- TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_pipebomb", 1)
                            -- elseif sharedWeapons[weapon]["name"] == "weapon_molotov" then
                                -- TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_molotov", 1)
                            -- elseif sharedWeapons[weapon]["name"] == "weapon_stickybomb" then
                                -- TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_stickybomb", 1)
                            -- elseif sharedWeapons[weapon]["name"] == "weapon_grenade" then
                                -- TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_grenade", 1)
                            -- elseif sharedWeapons[weapon]["name"] == "weapon_bzgas" then
                                -- TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_bzgas", 1)
                            -- elseif sharedWeapons[weapon]["name"] == "weapon_proxmine" then
                                -- TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_proxmine", 1)
                            -- elseif sharedWeapons[weapon]["name"] == "weapon_ball" then
                                -- TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_ball", 1)
                            -- elseif sharedWeapons[weapon]["name"] == "weapon_smokegrenade" then
                                -- TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_smokegrenade", 1)
                            -- elseif sharedWeapons[weapon]["name"] == "weapon_flare" then
                                -- TriggerServerEvent('QBCore:Server:RemoveItem', "weapon_flare", 1)
                            else
                                if ammo > 0 then
                                    MultiplierAmount = MultiplierAmount + 1
                                end
                            end
                        end
                    else
                        if weapon ~= -1569615261 then
                            TriggerEvent('inventory:client:CheckWeapon', sharedWeapons[weapon]["name"])
                            exports['qbr-core']:Notify(9, Lang:t('error.weapon_broken'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
                            MultiplierAmount = 0
                        end
                    end
                end
            end
        end
        Wait(1)
    end
end)

CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            local inRange = false
            local ped = PlayerPedId()
            local pos = GetEntityCoords(ped)
            for k, data in pairs(Config.WeaponRepairPoints) do
                local distance = #(pos - data.coords)
                if distance < 10 then
                    inRange = true
                    if distance < 1 then
                        if data.IsRepairing then
                            if data.RepairingData.CitizenId ~= PlayerData.citizenid then
                                DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, Lang:t('info.repairshop_not_usable'))
                            else
                                if not data.RepairingData.Ready then
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, Lang:t('info.weapon_will_repair'))
                                else
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, Lang:t('info.take_weapon_back'))
                                end
                            end
                        else
                            if CurrentWeaponData and next(CurrentWeaponData) then
                                if not data.RepairingData.Ready then
                                    local WeaponData = sharedWeapons[GetHashKey(CurrentWeaponData.name)]
                                    local WeaponClass = (exports['qbr-core']:SplitStr(WeaponData.ammotype, "_")[2]):lower()
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, Lang:t('info.repair_weapon_price', { value = Config.WeaponRepairCosts[WeaponClass] }))
                                    if IsControlJustReleased(0, 0xCEFD9220) then
                                        exports['qbr-core']:TriggerCallback('weapons:server:RepairWeapon', function(HasMoney)
                                            if HasMoney then
                                                CurrentWeaponData = {}
                                            end
                                        end, k, CurrentWeaponData)
                                    end
                                else
                                    if data.RepairingData.CitizenId ~= PlayerData.citizenid then
                                        DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, Lang:t('info.repairshop_not_usable'))
                                    else
                                        DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, Lang:t('info.take_weapon_back'))
                                        if IsControlJustReleased(0, 0xCEFD9220) then
                                            TriggerServerEvent('weapons:server:TakeBackWeapon', k, data)
                                        end
                                    end
                                end
                            else
                                if data.RepairingData.CitizenId == nil then
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, Lang:t('error.no_weapon_in_hand'))
                                elseif data.RepairingData.CitizenId == PlayerData.citizenid then
                                    DrawText3Ds(data.coords.x, data.coords.y, data.coords.z, Lang:t('info.take_weapon_back'))
                                    if IsControlJustReleased(0, 0xCEFD9220) then
                                        TriggerServerEvent('weapons:server:TakeBackWeapon', k, data)
                                    end
                                end
                            end
                        end
                    end
                end
            end
            if not inRange then
                Wait(1000)
            end
        end
        Wait(3)
    end
end)
