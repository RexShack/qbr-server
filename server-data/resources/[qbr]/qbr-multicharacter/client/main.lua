local charPed = nil
local choosingCharacter = false
local currentSkin = nil
local currentClothes = nil
local selectingChar = true
local cams = {
    {
        type = "customization",
        x = -561.8157,
        y = -3780.966,
        z = 239.0805,
        rx = -4.2146,
        ry = -0.0007,
        rz = -87.8802,
        fov = 30.0
    },
    {
        type = "selection",
        x = -562.8157,
        y = -3776.266,
        z = 239.0805,
        rx = -4.2146,
        ry = -0.0007,
        rz = -87.8802,
        fov = 30.0
    }
}

-- Handlers

AddEventHandler('onResourceStop', function(resource)
    if (GetCurrentResourceName() == resource) then
        DeleteEntity(charPed)
        SetModelAsNoLongerNeeded(charPed)
    end
end)

-- Functions

local function baseModel(sex)
    if (sex == 'mp_male') then
        Citizen.InvokeNative(0xD3A7B003ED343FD9, charPed, 0x158cb7f2, true, true, true); --head
        Citizen.InvokeNative(0xD3A7B003ED343FD9, charPed, 361562633, true, true, true); --hair
        Citizen.InvokeNative(0xD3A7B003ED343FD9, charPed, 62321923, true, true, true); --hand
        Citizen.InvokeNative(0xD3A7B003ED343FD9, charPed, 3550965899, true, true, true); --legs
        Citizen.InvokeNative(0xD3A7B003ED343FD9, charPed, 612262189, true, true, true); --Eye
        Citizen.InvokeNative(0xD3A7B003ED343FD9, charPed, 319152566, true, true, true); --
        Citizen.InvokeNative(0xD3A7B003ED343FD9, charPed, 0x2CD2CB71, true, true, true); -- shirt
        Citizen.InvokeNative(0xD3A7B003ED343FD9, charPed, 0x151EAB71, true, true, true); -- bots
        Citizen.InvokeNative(0xD3A7B003ED343FD9, charPed, 0x1A6D27DD, true, true, true); -- pants
    else
        Citizen.InvokeNative(0xD3A7B003ED343FD9, charPed, 0x1E6FDDFB, true, true, true); -- head
        Citizen.InvokeNative(0xD3A7B003ED343FD9, charPed, 272798698, true, true, true); -- hair
        Citizen.InvokeNative(0xD3A7B003ED343FD9, charPed, 869083847, true, true, true); -- Eye
        Citizen.InvokeNative(0xD3A7B003ED343FD9, charPed, 736263364, true, true, true); -- hand
        Citizen.InvokeNative(0xD3A7B003ED343FD9, charPed, 0x193FCEC4, true, true, true); -- shirt
        Citizen.InvokeNative(0xD3A7B003ED343FD9, charPed, 0x285F3566, true, true, true); -- pants
        Citizen.InvokeNative(0xD3A7B003ED343FD9, charPed, 0x134D7E03, true, true, true); -- bots
    end
end

local function createCharacter(sex)
    if (sex == 0) then
        local model = 'mp_male'
        exports['qbr-clothing']:RequestAndSetModel(model)
        Wait(1000)
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0x158cb7f2, true, true, true); --head
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0x16e292a1, true, true, true); --torso
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0xa615e02, true, true, true); --legs
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0x105ddb4, true, true, true); --hair
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0x10404a83, true, true, true); --mustache
        -- Citizen.InvokeNative(0x77FF8D35EEC6BBC4, PlayerPedId(), 0, 0) -- set outfit preset, unsure if needed
        SetModelAsNoLongerNeeded(model)
    else
        local model = 'mp_female'
        exports['qbr-clothing']:RequestAndSetModel(model)
        Wait(1000)
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0x11567c3, true, true, true); --head
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0x2c4fe0c5, true, true, true); --torso
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0xaa25eca7, true, true, true); --legs
        Citizen.InvokeNative(0xD3A7B003ED343FD9, PlayerPedId(), 0x104293ea, true, true, true); --hair
        -- Citizen.InvokeNative(0x77FF8D35EEC6BBC4, PlayerPedId(), 0, 0) -- set outfit preset, unsure if needed
        SetModelAsNoLongerNeeded(model)
    end
    selectingChar = false
end

local function skyCam(bool)
    if bool then
        DoScreenFadeIn(1000)
        SetTimecycleModifier('hud_def_blur')
        SetTimecycleModifierStrength(1.0)
        cam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
        SetCamCoord(cam, -555.925, -3778.709, 238.597)
        SetCamRot(cam, -20.0, 0.0, 83)
        SetCamActive(cam, true)
        RenderScriptCams(true, false, 1, true, true)
        fixedCam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
        SetCamCoord(fixedCam, -561.206, -3776.224, 239.597)
        SetCamRot(fixedCam, -20.0, 0, 270.0)
        SetCamActive(fixedCam, true)
        SetCamActiveWithInterp(fixedCam, cam, 3900, true, true)
        Wait(3900)
        DestroyCam(groundCam)
        InterP = true
    else
        SetTimecycleModifier('default')
        SetCamActive(cam, false)
        DestroyCam(cam, true)
        RenderScriptCams(false, false, 1, true, true)
        FreezeEntityPosition(PlayerPedId(), false)
    end
end

local function openCharMenu(bool)
    exports['qbr-core']:TriggerCallback("qb-multicharacter:server:GetNumberOfCharacters", function(result)
        SetNuiFocus(bool, bool)
        SendNUIMessage({
            action = "ui",
            toggle = bool,
            nChar = result,
        })
        choosingCharacter = bool
        Wait(100)
        skyCam(bool)
    end)
end

-- Events

-- RegisterNetEvent('qb-multicharacter:client:closeNUIdefault', function() -- This event is only for no starting apartments
--     DeleteEntity(charPed)
--     SetNuiFocus(false, false)
--     DoScreenFadeOut(500)
--     Wait(2000)
--     SetEntityCoords(PlayerPedId(), Config.DefaultSpawn.x, Config.DefaultSpawn.y, Config.DefaultSpawn.z)
--     TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
--     TriggerEvent('QBCore:Client:OnPlayerLoaded')
--     TriggerServerEvent('qb-houses:server:SetInsideMeta', 0, false)
--     TriggerServerEvent('qb-apartments:server:SetInsideMeta', 0, 0, false)
--     Wait(500)
--     openCharMenu()
--     SetEntityVisible(PlayerPedId(), true)
--     Wait(500)
--     DoScreenFadeIn(250)
--     TriggerEvent('qb-weathersync:client:EnableSync')
--     TriggerEvent('qb-clothes:client:CreateFirstCharacter')
-- end)

RegisterNetEvent('qbr-multicharacter:client:closeNUI', function()
    DeleteEntity(charPed)
    SetNuiFocus(false, false)
end)

RegisterNetEvent('qbr-multicharacter:client:chooseChar', function()
    SetEntityVisible(PlayerPedId(), false, false)
    SetNuiFocus(false, false)
    DoScreenFadeOut(10)
    Wait(1000)
    GetInteriorAtCoords(-558.9098, -3775.616, 238.59, 137.98)
    FreezeEntityPosition(PlayerPedId(), true)
    SetEntityCoords(PlayerPedId(), -562.91,-3776.25,237.63)
    Wait(1500)
    ShutdownLoadingScreen()
    ShutdownLoadingScreenNui()
    Wait(10)
    openCharMenu(true)
    while selectingChar do
        Wait(1)
        local coords = GetEntityCoords(PlayerPedId())
        DrawLightWithRange(coords.x, coords.y , coords.z + 1.0 , 255, 255, 255, 5.5, 50.0)
    end
end)

-- NUI

RegisterNUICallback('closeUI', function()
    openCharMenu(false)
end)

RegisterNUICallback('disconnectButton', function()
    SetEntityAsMissionEntity(charPed, true, true)
    DeleteEntity(charPed)
    TriggerServerEvent('qb-multicharacter:server:disconnect')
end)

RegisterNUICallback('cDataPed', function(data) -- Visually seeing the char
    local cData = data.cData
    SetEntityAsMissionEntity(charPed, true, true)
    DeleteEntity(charPed)

    if cData ~= nil then
        exports['qbr-core']:TriggerCallback('qbr-multicharacter:server:getSkin', function(data)
            model = data.model and tonumber(data.model) or false
            currentSkin = data.skin or {}
            currentClothes = data.clothes or {}
            if model ~= nil then
                CreateThread(function()
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Wait(0)
                    end
                    charPed = CreatePed(model, -558.91, -3776.25, 237.63, 90.0, false, false)
                    FreezeEntityPosition(charPed, false)
                    SetEntityInvincible(charPed, true)
                    SetBlockingOfNonTemporaryEvents(charPed, true)
                    while not Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, charPed) do
                        Wait(1)
                    end
                    exports['qbr-clothing']:loadSkin(charPed, currentSkin, false)
                    exports['qbr-clothing']:loadClothes(charPed, currentClothes, false)
                end)
            else
                CreateThread(function()
                    local randommodels = {
                        "mp_male",
                        "mp_female",
                    }
                    local randomModel = randommodels[math.random(1, #randommodels)]
                    local model = GetHashKey(randomModel)
                    RequestModel(model)
                    while not HasModelLoaded(model) do
                        Wait(0)
                    end
                    Wait(100)
                    baseModel(randomModel)
                    charPed = CreatePed(model, -558.91, -3776.25, 237.63, 90.0, false, false)
                    FreezeEntityPosition(charPed, false)
                    SetEntityInvincible(charPed, true)
                    SetBlockingOfNonTemporaryEvents(charPed, true)
                end)
            end
        end, cData.citizenid)
    else
        CreateThread(function()
            local randommodels = {
                "mp_male",
                "mp_female",
            }
            local randomModel = randommodels[math.random(1, #randommodels)]
            local model = GetHashKey(randomModel)
            RequestModel(model)
            while not HasModelLoaded(model) do
                Wait(0)
            end
            charPed = CreatePed(model, -558.91, -3776.25, 237.63, 90.0, false, false)
            Wait(100)
            baseModel(randomModel)
            FreezeEntityPosition(charPed, false)
            SetEntityInvincible(charPed, true)
            NetworkSetEntityInvisibleToNetwork(charPed, true)
            SetBlockingOfNonTemporaryEvents(charPed, true)
        end)
    end
end)

RegisterNUICallback('selectCharacter', function(data) -- When a char is selected and confirmed to use
    CreateThread(function()
        selectingChar = false
        local cData = data.cData
        DoScreenFadeOut(10)
        TriggerServerEvent('qbr-multicharacter:server:loadUserData', cData)
        openCharMenu(false)
        local model = IsPedMale(charPed) and 'mp_male' or 'mp_female'
        SetEntityAsMissionEntity(charPed, true, true)
        DeleteEntity(charPed)
        Wait(5000)
        exports['qbr-clothing']:RequestAndSetModel(model)
        Wait(200)
        exports['qbr-clothing']:loadSkin(PlayerPedId(), currentSkin, true)
        Wait(500)
        exports['qbr-clothing']:loadClothes(PlayerPedId(), currentClothes, false)
        SetModelAsNoLongerNeeded(model)
    end)
end)

RegisterNUICallback('setupCharacters', function() -- Present char info
    exports['qbr-core']:TriggerCallback("qb-multicharacter:server:setupCharacters", function(result)
        SendNUIMessage({
            action = "setupCharacters",
            characters = result
        })
    end)
end)

RegisterNUICallback('removeBlur', function()
    SetTimecycleModifier('default')
end)

RegisterNUICallback('createNewCharacter', function(data) -- Creating a char
    DoScreenFadeOut(150)
    Wait(200)
    DestroyAllCams(true)

    if data.gender == "Male" then
        data.gender = 0
    elseif data.gender == "Female" then
        data.gender = 1
    end
    createCharacter(data.gender)
    DeleteEntity(charPed)
    SetModelAsNoLongerNeeded(charPed)
    TriggerServerEvent('qbr-multicharacter:server:createCharacter', data)
    Wait(1000)
    DoScreenFadeIn(1000)
end)

RegisterNUICallback('removeCharacter', function(data) -- Removing a char
    TriggerServerEvent('qbr-multicharacter:server:deleteCharacter', data.citizenid)
    TriggerEvent('qbr-multicharacter:client:chooseChar')
end)

-- Threads

CreateThread(function()
    RequestImap(-1699673416)
    RequestImap(1679934574)
    RequestImap(183712523)
    while true do
        Wait(0)
        if NetworkIsSessionStarted() then
            TriggerEvent('qbr-multicharacter:client:chooseChar')
            return
        end
    end
end)