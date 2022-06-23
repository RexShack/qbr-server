-- GLOBAL CLIENT VARIABLES
NewPlayer = false
Camera = -1
BeforePosition = nil

SkinData = {}
ClothesData = {}
PreviousSkinData = {}
PreviousClothesData = {}
PreviewSkinData = {}
PreviewClothesData = {}

Skins = {}
Skins.Male = {}
Skins.Female = {}
Clothes = {}
Clothes.Male = {}
Clothes.Female = {}

Citizen.CreateThread(function()
    while true do
        local sleep = 1000
        if NewPlayer then
            sleep = 0
            DrawLightWithRange(-558.71 - 5.0, -3781.6 - 5.0, 238.6 + 1.0, 255, 255, 204, 50.5, 50.0)
        end

        Citizen.Wait(sleep)
    end
end)

-- clothing shops prompts and blips
Citizen.CreateThread(function()
    for clothing, v in pairs(Config.Stores) do
        exports['qbr-core']:createPrompt(v.location..'-clothing', v.coords, 0xF3830D8E, 'Open ' .. v.name, { -- [J]
			type = 'client',
			event = 'qbr-clothing:client:openMenu',
			args = {false, 'clothingMenu'}
        })
		exports['qbr-core']:createPrompt(v.location..'-outfits', v.coords, 0xC7B5340A, 'Open Outfits', { -- ["ENTER"]
            type = 'client',
            event = 'qbr-clothing:client:openMenu',
            args = {false, 'outfitMenu'},
        })
        if v.showblip == true then
			local ClothingBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(ClothingBlip, 1195729388, 1)
            SetBlipScale(ClothingBlip, 0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, ClothingBlip, v.name)
        end
    end
end)

Citizen.CreateThread(function()
    for _, v in pairs(cloth_hash_names) do
        if v.category_hashname == 'heads'
            or v.category_hashname == 'eyes'
            or v.category_hashname == 'teeth'
            or v.category_hashname == 'BODIES_UPPER'
            or v.category_hashname == 'BODIES_LOWER'
            or v.category_hashname == 'beard'
            or v.category_hashname == 'hair' then
            if v.ped_type == 'male' and v.hashname ~= '' and v.is_multiplayer then
                if not Skins.Male[v.category_hashname] then
                    Skins.Male[v.category_hashname] = {}
                end
                Skins.Male[v.category_hashname][#Skins.Male[v.category_hashname] + 1] = v.hash
            elseif v.ped_type == 'female' and v.hashname ~= '' and v.is_multiplayer then
                if not Skins.Female[v.category_hashname] then
                    Skins.Female[v.category_hashname] = {}
                end
                Skins.Female[v.category_hashname][#Skins.Female[v.category_hashname] + 1] = v.hash
            end
        else
            if v.ped_type == 'male' and v.hashname ~= '' and v.is_multiplayer then
                if not Clothes.Male[v.category_hashname] then
                    Clothes.Male[v.category_hashname] = {}
                end
                Clothes.Male[v.category_hashname][#Clothes.Male[v.category_hashname] + 1] = v.hash
            elseif v.ped_type == 'female' and v.hashname ~= '' and v.is_multiplayer then
                if not Clothes.Female[v.category_hashname] then
                    Clothes.Female[v.category_hashname] = {}
                end
                Clothes.Female[v.category_hashname][#Clothes.Female[v.category_hashname] + 1] = v.hash
            end
        end
    end
end)

AddEventHandler('onResourceStart', function(resource)
    if GetCurrentResourceName() == resource then
        DisableCamera()
        DestroyAllCams(true)
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    if NetworkIsInTutorialSession() then
        NetworkEndTutorialSession()
        print('removing from session')
    end
end)

RegisterNetEvent('qbr-clothing:client:newPlayer', function()
    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, true)
    SetEntityHeading(playerPed, 105.68)
    NewPlayer = true
    OpenMenu(true, 'all')
end)

RegisterNetEvent('qbr-clothing:client:openMenu', function(newPlayer, menuType)
    OpenMenu(newPlayer, menuType)
end)

RegisterNUICallback('rotateCamera', function(data)
    local rotation = data.direction
    local playerPed = PlayerPedId()
    local playerCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0, 2.0, 0)

    if rotation == 'left' then
        SetEntityHeading(playerPed, GetEntityHeading(playerPed) - 10)
    -- SetCamCoord(Camera, playerCoords.x, playerCoords.y, playerCoords.z + 0.5)
    -- SetCamRot(Camera, 0.0, 0.0, GetEntityHeading(playerPed) + 180)
    elseif rotation == 'right' then
        SetEntityHeading(playerPed, GetEntityHeading(playerPed) + 10)
    -- SetCamCoord(Camera, playerCoords.x, playerCoords.y, playerCoords.z + 0.5)
    -- SetCamRot(Camera, 0.0, 0.0, GetEntityHeading(playerPed) + 180)
    end
end)

RegisterNUICallback('setCamera', function(data)
    local rotation = data.direction
    local playerPed = PlayerPedId()

    if rotation == 1 then
        local playerCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0, 0.75, 0)
        SetCamCoord(Camera, playerCoords.x, playerCoords.y, playerCoords.z + 0.65)
        SetCamRot(Camera, 0.0, 0.0, GetEntityHeading(playerPed) + 180)
    elseif rotation == 2 then
        local playerCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0, 1.0, 0)
        SetCamCoord(Camera, playerCoords.x, playerCoords.y, playerCoords.z + 0.2)
        SetCamRot(Camera, 0.0, 0.0, GetEntityHeading(playerPed) + 180)
    elseif rotation == 3 then
        local playerCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0, 2.0, 0)
        SetCamCoord(Camera, playerCoords.x, playerCoords.y, playerCoords.z + -0.5)
        SetCamRot(Camera, 0.0, 0.0, GetEntityHeading(playerPed) + 180)
    else
        local playerCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0, 2.0, 0)
        SetCamCoord(Camera, playerCoords.x, playerCoords.y, playerCoords.z + 0.5)
        SetCamRot(Camera, 0.0, 0.0, GetEntityHeading(playerPed) + 180)
    end
end)

RegisterNUICallback('closeMenu', function()
    local playerPed = PlayerPedId()
    LoadSkin(playerPed, SkinData)
    LoadClothes(playerPed, ClothesData, false)
    SetNuiFocus(false, false)
    RenderScriptCams(false, true, 250, 1, 0)
    DestroyCam(Camera, false)
    ClothingRoomTransition(BeforePosition, false)
    FreezeEntityPosition(playerPed, false)
end)

RegisterNUICallback('closeMenu2', function()
    local citizenid = exports['qbr-core']:GetPlayerData().citizenid
    exports['qbr-core']:TriggerCallback('qbr-multicharacter:server:getSkin', function(data)
        local playerPed = PlayerPedId()
        LoadSkin(playerPed, data.skin)
        LoadClothes(playerPed, data.clothes, false)
        SetNuiFocus(false, false)
        RenderScriptCams(false, true, 250, 1, 0)
        DestroyCam(Camera, false)
        ClothingRoomTransition(BeforePosition, false)
        FreezeEntityPosition(playerPed, false)
    end, citizenid)
end)

RegisterNUICallback('save', function()
    local playerPed = PlayerPedId()
    local model = GetEntityModel(playerPed)
    local skins = json.encode(SkinData)
    local clothes = json.encode(ClothesData)
    TriggerServerEvent('qbr-clothing:server:saveSkin', model, skins, clothes)
    if NewPlayer then
        newPlayer = false
        DoScreenFadeOut(150)
        --exports['qbr-weathersync']:enableSync()
        Citizen.Wait(500)
        TriggerServerEvent('QBCore:Server:OnPlayerLoaded')
        TriggerEvent('QBCore:Client:OnPlayerLoaded')
        --SetEntityCoords(playerPed, 1359.57, -1301.45, 77.76) -- not sure why this was put here.
        DisableCamera()
        if NetworkIsInTutorialSession() then
            NetworkEndTutorialSession()
            print('ending tutorial session')
        end

        Citizen.Wait(1000)
        DoScreenFadeIn(150)
    end

    DisableCamera()
end)

RegisterNUICallback('saveOutfit', function(data)
    local playerPed = PlayerPedId()
    local model = GetEntityModel(playerPed)
    local clothes = json.encode(ClothesData)
    TriggerServerEvent('qbr-clothing:server:saveOutfit', data.outfitName, model, clothes)
    DisableCamera()
end)

RegisterNUICallback('applySkin', function(data)
    local skins = {}
    for k, v in pairs(data.values) do
        if not skins[v.name] then
            skins[v.name] = tonumber(v.currentValue)
        end
    end

    if next(skins) then
        if NewPlayer then
            LoadSkin(PlayerPedId(), skins)
        else
            ChangeNotUpdate(PlayerPedId(), skins)
        end
    end
end)

RegisterNUICallback('applyClothes', function(data)
    local clothes = {}
    for k, v in pairs(data.values) do
        if not clothes[v.name] then
            clothes[v.name] = tonumber(v.currentValue)
        end
    end

    if next(clothes) then
        if NewPlayer then
            LoadClothes(PlayerPedId(), clothes, false)
        else
            LoadClothes(PlayerPedId(), clothes, false)
        end
    end
end)

RegisterNUICallback('useOutfit', function(data)
    LoadSkin(PlayerPedId(), SkinData)
    LoadClothes(PlayerPedId(), data.skin, false)
	local playerPed = PlayerPedId()
	local model = GetEntityModel(playerPed)
    local skins = json.encode(SkinData)
    local clothes = json.encode(data.skin)
    TriggerServerEvent('qbr-clothing:server:saveSkin', model, skins, clothes)
end)

OpenMenu = function(newPlayer, menuType)
    if newPlayer then
		ClothingRoomTransition(Config.StaticClothingRoom, true)
        local skins = GetSkinMaxValues()
        local clothes = GetClothesMaxValues()
        SendNUIMessage({
            type = 'newPlayer',
            skins = skins,
            clothes = clothes
        })
    elseif menuType == 'outfitMenu' then
        ClothingRoomTransition(Config.StaticClothingRoom, true)
        exports['qbr-core']:TriggerCallback('qbr-clothing:server:getOutfits', function(outfits)
            SendNUIMessage({
                type = 'outfitMenu',
                outfits = outfits
            })
        end)
    elseif menuType == 'skinMenu' then
        ClothingRoomTransition(Config.StaticClothingRoom, true)
        local skins = GetSkinMaxValues()
        SendNUIMessage({
            type = 'skinMenu',
            skins = skins
        })
    elseif menuType == 'clothingMenu' then
        ClothingRoomTransition(Config.StaticClothingRoom, true)
        local clothes = GetClothesMaxValues()
        SendNUIMessage({
            type = 'clothingMenu',
            clothes = clothes
        })
    elseif menuType == 'allMenu' then
        ClothingRoomTransition(Config.StaticClothingRoom, true)
        exports['qbr-core']:TriggerCallback('qbr-clothing:server:getOutfits', function(outfits)
            local skins = GetSkinMaxValues()
            local clothes = GetClothesMaxValues()
            SendNUIMessage({
                type = 'allMenu',
                outfits = outfits,
                clothes = clothes,
                skins = skins
            })
        end)
    end

    SetNuiFocus(true, true)
    FreezeEntityPosition(PlayerPedId(), true)
    EnableCamera()
end

ClothingRoomTransition = function(coords, makeInvisible)
    if makeInvisible then
        if not NetworkIsInTutorialSession() then
            NetworkStartSoloTutorialSession()
            print('adding to session')
        end
    else
        if NetworkIsInTutorialSession() then
            NetworkEndTutorialSession()
            print('removing from session')
        end
    end

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local playerHeading = GetEntityHeading(playerPed)
    BeforePosition = vector4(playerCoords.x, playerCoords.y, playerCoords.z, playerHeading)

    DoScreenFadeOut(1000)
    while IsScreenFadingOut() do
        Citizen.Wait(10)
    end

    if not coords then
        local playerCoords = GetEntityCoords(playerPed)
        local playerHeading = GetEntityHeading(playerPed)
        coords = vector4(playerCoords.x, playerCoords.y, playerCoords.z, playerHeading)
    end

    SetEntityCoords(playerPed, coords.x, coords.y, coords.z - 1.0)
    SetEntityHeading(playerPed, coords.w or 0.0)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)
    while IsScreenFadingIn() do
        Citizen.Wait(10)
    end
end

EnableCamera = function()
    local playerPed = PlayerPedId()
    local playerCoords = GetOffsetFromEntityInWorldCoords(playerPed, 0, 2.0, 0)
    RenderScriptCams(false, false, 0, 1, 0)
    DestroyCam(Camera, false)
    if not DoesCamExist(Camera) then
        Camera = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
        SetCamActive(Camera, true)
        RenderScriptCams(true, false, 0, true, true)
        SetCamCoord(Camera, playerCoords.x, playerCoords.y, playerCoords.z + 0.5)
        SetCamRot(Camera, 0.0, 0.0, GetEntityHeading(playerPed) + 180)
    end
end

DisableCamera = function()
    RenderScriptCams(false, true, 250, 1, 0)
    DestroyCam(Camera, false)
    SetNuiFocus(false, false)
    FreezeEntityPosition(PlayerPedId(), false)
end

RequestAndSetModel = function(model)
    local requestedModel = GetHashKey(model)
    RequestModel(requestedModel)
    while not HasModelLoaded(requestedModel) do
        Citizen.Wait(0)
    end
    Citizen.Wait(200)
    Citizen.InvokeNative(0xED40380076A31506, PlayerId(), requestedModel, false)
    Citizen.InvokeNative(0x77FF8D35EEC6BBC4, PlayerPedId(), 0, 0)
    Citizen.Wait(200)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x1D4C528A, 0)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0x3F1F01E5, 0)
    Citizen.InvokeNative(0xD710A5007C2AC539, PlayerPedId(), 0xDA0E2C55, 0)
end

exports('RequestAndSetModel', RequestAndSetModel)

GetSkinMaxValues = function()
    local sex = IsPedMale(PlayerPedId()) and 'Male' or 'Female'
    local skins = {}
    -- skins.overlay = {}
    for k, v in pairs(Skins[sex]) do
        if (k ~= 'BODIES_UPPER' and k ~= 'BODIES_LOWER') then
            if SkinData[k] then
                skins[#skins + 1] = {name = k or 'unnamed', minValue = 0, maxValue = #v, currentValue = SkinData[k]}
            else
                skins[#skins + 1] = {name = k or 'unnamed', minValue = 0, maxValue = #v, currentValue = 0}
            end
        end
    end

    if SkinData.skin then
        skins[#skins + 1] = {name = 'skin', minValue = 0, maxValue = 6, currentValue = SkinData.skin}
    else
        skins[#skins + 1] = {name = 'skin', minValue = 0, maxValue = 6, currentValue = 0}
    end

    for k, v in pairs(Config.Features) do
        if SkinData[k] then
            skins[#skins + 1] = {name = k or 'unnamed', minValue = -100, maxValue = 100, currentValue = SkinData[k]}
        else
            skins[#skins + 1] = {name = k or 'unnamed', minValue = -100, maxValue = 100, currentValue = 0}
        end
    end

    if #skins > 0 then
        return skins
    end

    return false
end

GetClothesMaxValues = function()
    local sex = IsPedMale(PlayerPedId()) and 'Male' or 'Female'
    local clothes = {}
    for k, v in pairs(Clothes[sex]) do
        if ClothesData[k] then
            clothes[#clothes + 1] = {name = k or 'unnamed', minValue = 0, maxValue = #v, currentValue = ClothesData[k]}
        else
            clothes[#clothes + 1] = {name = k or 'unnamed', minValue = 0, maxValue = #v, currentValue = 0}
        end
    end

    if #clothes > 0 then
        return clothes
    end

    return false
end

LoadClothes = function(ped, data, preview)
    if data and next(data) then
        while not Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, ped) do
            Citizen.Wait(1)
        end

        local sex = IsPedMale(PlayerPedId()) and 'Male' or 'Female'
        for k, v in pairs(data) do
            for i, j in pairs(Clothes[sex]) do
                if k == i then
                    if v > 0 then
                        Citizen.InvokeNative(0xD710A5007C2AC539, ped, GetHashKey(k), 0)
                        if k == 'shirts_full' then
                            Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(TorsoComponent), false, true, true)
                        elseif k == 'boots' or k == 'pants' then
                            Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(TorsoComponent), false, true, true)
                        end

                        local hash = Clothes[sex][k][v]
                        Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(hash), false, true, true)
                    else
                        Citizen.InvokeNative(0xD710A5007C2AC539, ped, GetHashKey(k), 0)
                    end
                end
            end
        end

        Citizen.InvokeNative(0x704C908E9C405136, ped)
        Citizen.InvokeNative(0xAAB86462966168CE, ped, 1)
        Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, 0)
        if not preview then
            ClothesData = data
        else
            PreviewClothesData = data
        end
    else
        if not preview then
            ClothesData = {}
        else
            PreviewClothesData = {}
        end
    end
end

exports('loadClothes', LoadClothes)

RegisterCommand('clothingmenu', function()
    OpenMenu(false, 'allMenu')
end)

RegisterCommand('loadcharacter', function()
    local citizenid = exports['qbr-core']:GetPlayerData().citizenid
    exports['qbr-core']:TriggerCallback('qbr-multicharacter:server:getSkin', function(data)
        local playerPed = PlayerPedId()
        LoadSkin(playerPed, data.skin)
        LoadClothes(playerPed, data.clothes, false)
    end, citizenid)
end)
