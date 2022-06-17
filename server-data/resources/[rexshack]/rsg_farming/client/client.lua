local sharedItems = exports['qbr-core']:GetItems()
local myPlants = {}
local myPlants2 = {}
local myPlants3 = {}
local isPlanting = false
local Zones = {}
local zonename = NIL
local inFarmZone = false

-- start farm shop
Citizen.CreateThread(function()
    for bpos, v in pairs(Config.FarmShopLocations) do
        exports['qbr-core']:createPrompt(v.name, v.coords, 0xF3830D8E, 'Open ' .. v.name, {
            type = 'client',
            event = 'rsg_farming:client:OpenFarmShop',
        })
        if v.showblip == true then
            local StoreBlip = N_0x554d9d53f696d002(1664425300, v.coords)
            SetBlipSprite(StoreBlip, 1475879922, 1)
            SetBlipScale(StoreBlip, 0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, StoreBlip, v.name)
        end
    end
end)

RegisterNetEvent('rsg_farming:client:OpenFarmShop')
AddEventHandler('rsg_farming:client:OpenFarmShop', function()
    local ShopItems = {}
    ShopItems.label = "Farm Shop"
    ShopItems.items = Config.FarmShop
    ShopItems.slots = #Config.FarmShop
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "FarmShop_"..math.random(1, 99), ShopItems)
end)
-- end farm shop

CreateThread(function() 
    for k=1, #Config.FarmZone do
		Zones[k] = PolyZone:Create(Config.FarmZone[k].zones, {
			name = Config.FarmZone[k].name,
			minZ = 	Config.FarmZone[k].minz,
			maxZ = Config.FarmZone[k].maxz,
			debugPoly = false,
		})
		Zones[k]:onPlayerInOut(function(isPointInside)
			if isPointInside then
				inFarmZone = true
				zonename = Zones[k].name
				exports['qbr-core']:Notify(8, 'Farming Zone', 5000, 'you have entered a farm zone', 'inventory_items', 'consumable_corn', 'COLOR_WHITE')
			else
				inFarmZone = false
			end
		end)
    end
end)

-- planting (must be in farming zone)
RegisterNetEvent('rsg_farming:client:planting')
AddEventHandler('rsg_farming:client:planting', function(itemn, hash1, hash2, hash3)
	if inFarmZone == true then
		local xPlayer = PlayerPedId()
		local itemname = tostring(itemn)
		local plant1 = hash1
		if not HasModelLoaded(plant1) then
			RequestModel(plant1)
		end
		while not HasModelLoaded(plant1) do
			Citizen.Wait(100)
		end
		if isPlanting == false then
			isPlanting = true
			TaskStartScenarioInPlace(xPlayer, `WORLD_HUMAN_FARMER_RAKE`, 10000, true, false, false, false)
			Wait(10000)
			ClearPedTasks(xPlayer)
			SetCurrentPedWeapon(xPlayer, `WEAPON_UNARMED`, true)		
			Wait(1000)
			TaskStartScenarioInPlace(xPlayer, `WORLD_HUMAN_FARMER_WEEDING`, 20000, true, false, false, false)
			Wait(20000)
			ClearPedTasks(xPlayer)
			SetCurrentPedWeapon(xPlayer, `WEAPON_UNARMED`, true)
			local pPos = GetEntityCoords(xPlayer, true)
			local object = CreateObject(plant1, pPos.x, pPos.y, pPos.z, true, true, false)
			local plantCount = #myPlants+1
			myPlants[plantCount] = {["object"] = object, ['x'] = pPos.x, ['y'] = pPos.y, ['z'] = pPos.z, ['stage'] = 1, ['hash'] = hash1, ['hash2'] = hash2, ['hash3'] = hash3,}
			PlaceObjectOnGroundProperly(myPlants[plantCount].object)
			SetEntityAsMissionEntity(myPlants[plantCount].object, true)
			SetModelAsNoLongerNeeded(plant1)
			TriggerServerEvent('QBCore:Server:RemoveItem', itemn, 1)
			TriggerEvent("inventory:client:ItemBox", sharedItems[itemn], "remove")
			exports['qbr-core']:Notify(9, 'planting finished', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			isPlanting = false
		else
			exports['qbr-core']:Notify(9, 'you need to fishing planting first!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	else
		exports['qbr-core']:Notify(9, 'you are not in a farming zone!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)


RegisterNetEvent('rsg_farming:client:waterplant')
AddEventHandler('rsg_farming:client:waterplant', function(source)
    if isPlanting == false then
        local pos = GetEntityCoords(PlayerPedId(), true)
        local object = nil
        local key = nil
        local hash1, hash2, hash3 = nil, nil, nil
        local planta = GetEntityCoords(object, true)
        local x, y, z = nil, nil, nil
        
        for k, v in ipairs(myPlants) do
            if v.stage == 1 then
                if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 2.0 then
                    object = v.object
                    key = k
                    x, y, z = v.x, v.y, v.z
                    hash1, hash2, hash3 = v.hash, v.hash2, v.hash3
                    break
                end
            end
        end
        
        local plant2 = hash2
        
        if DoesEntityExist(object) then
            isPlanting = true
            dowaterplant()

            RequestModel(plant2)

            while not HasModelLoaded(plant2) do
                Citizen.Wait(1)
            end

            DeleteObject(object)
            table.remove(myPlants, key)
            Wait(800)
            local object = CreateObject(plant2, x, y, z, true, true, false)
            local plantCount = #myPlants2+1
            myPlants2[plantCount] = {["object"] = object, ['x'] = x, ['y'] = y, ['z'] = z, ['stage'] = 2, ['timer'] = Config.TimeToGrow, ['hash'] = hash1, ['hash2'] = hash2, ['hash3'] = hash3}
            PlaceObjectOnGroundProperly(myPlants2[plantCount].object)
            SetEntityAsMissionEntity(myPlants2[plantCount].object, true)
            SetModelAsNoLongerNeeded(plant2)
            isPlanting = false
        end
    else
		exports['qbr-core']:Notify(9, 'finish first what you started!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('rsg_farming:client:fin2')
AddEventHandler('rsg_farming:client:fin2', function(object2, x, y, z, key, hash1, hash2, hash3)
    local planta2 = GetEntityCoords(object2, true)
    
	exports['qbr-core']:Notify(9, 'your plant has grown', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
    
    local plant3 = hash3
    
    RequestModel(plant3)

    while not HasModelLoaded(plant3) do
        Citizen.Wait(1)
    end
    
    DeleteObject(object2)
    Wait(800)
    local object3 = CreateObject(plant3, x, y, z, true, true, false)
    PlaceObjectOnGroundProperly(object3)
    local plantCount = #myPlants3+1
    myPlants3[plantCount] = {["object"] = object3, ['x'] = x, ['y'] = y, ['z'] = z, ['stage'] = 3, ['prompt'] = false, ['hash'] = hash1, ['hash2'] = hash2, ['hash3'] = hash3,}
    PlaceObjectOnGroundProperly(myPlants3[plantCount].object)
    SetEntityAsMissionEntity(myPlants3[plantCount].object, true)
    SetModelAsNoLongerNeeded(plant3)
end)


function harvestPlant(key)
    if isPlanting == false then
        isPlanting = true
        local xPlayer = PlayerPedId()
        if IsPedMale(xPlayer) then
            TaskStartScenarioInPlace(xPlayer, `WORLD_HUMAN_FARMER_WEEDING`, 10000, true, false, false, false)
        else
            RequestAnimDict("amb_work@world_human_farmer_weeding@male_a@idle_a")
            while ( not HasAnimDictLoaded( "amb_work@world_human_farmer_weeding@male_a@idle_a" ) ) do
                    Citizen.Wait( 100 )
            end
            TaskPlayAnim(xPlayer, "amb_work@world_human_farmer_weeding@male_a@idle_a", "idle_a", 8.0, -8.0, 10000, 1, 0, true, 0, false, 0, false)
        end
		Wait(10000)
		isPlanting = false
		ClearPedTasks(xPlayer)
		SetCurrentPedWeapon(xPlayer, `WEAPON_UNARMED`, true)
		DeleteObject(myPlants3[key].object)
		table.remove(myPlants3, key)
    else
		exports['qbr-core']:Notify(9, 'finish first what you started!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        local pos = GetEntityCoords(PlayerPedId(), true)
		if myPlants2 ~= nil then
			for k, v in ipairs(myPlants2) do
				if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 15.0 then
					if v.stage == 2 then
						v.timer = v.timer-1
						if v.timer == 0 then
							v.stage = 3
							local key = k
							TriggerEvent('rsg_farming:client:fin2', v.object, v.x, v.y, v.z, key, v.hash, v.hash2, v.hash3)
						end
					end    
				end
			end
		end
		if myPlants3 ~= nil then
			for k, v in ipairs(myPlants3) do
				if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 15.0 then
					if v.stage == 3 and GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) <= 2.0 then
						if not v.prompt then
							v.prompt = true
						end
					end   
					if v.stage == 3 and GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) > 2.1 then
						if v.prompt then
							v.prompt = false
						end
					end
				end
			end
		end
    end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
        local pos = GetEntityCoords(PlayerPedId(), true)
		if myPlants ~= nil  then
			for k, v in ipairs(myPlants) do
				if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 1.0 then
					if v.stage == 1 then
                        DrawText3D(v.x, v.y, v.z, 'needs water!')
					end
				end
			end
        end
        if myPlants2 ~= nil then
            for k, v in ipairs(myPlants2) do
				if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 1.0 then
					if v.stage == 2 then
                        DrawText3D(v.x, v.y, v.z, 'until harvest: ' .. v.timer)
					end
				end
			end
        end
        if myPlants3 ~= nil then
            for k, v in ipairs(myPlants3) do
				if GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true) < 1.0 then
					if v.stage == 3 then
                        DrawText3D(v.x, v.y, v.z, 'Harvest [J]')
					end
					if v.prompt then
                        if isPlanting == false then
                            if Citizen.InvokeNative(0x91AEF906BCA88877, 0, 0xF3830D8E) then -- [J]
                                local key = k
                                harvestPlant(key)
                                TriggerServerEvent("rsg_farming:server:giveitem", v.hash3)
                            end
                        end
					end
				end
			end
        end
	end
end)

function dowaterplant()
    local xPlayer = PlayerPedId()
	TaskStartScenarioInPlace(xPlayer, `WORLD_HUMAN_BUCKET_POUR_LOW`, 10000, true, false, false, false)
	Wait(10000)
	isPlanting = false
	ClearPedTasks(xPlayer)
	SetCurrentPedWeapon(xPlayer, `WEAPON_UNARMED`, true)
end

function DrawTxt(str, x, y, w, h, enableShadow, col1, col2, col3, a, centre)
    local str = CreateVarString(10, "LITERAL_STRING", str)
    SetTextScale(w, h)
    SetTextColor(math.floor(col1), math.floor(col2), math.floor(col3), math.floor(a))
    SetTextCentre(centre)
    if enableShadow then SetTextDropshadow(1, 0, 0, 0, 255) end
    Citizen.InvokeNative(0xADA9255D, 1);
    DisplayText(str, x, y)
end

function CreateVarString(p0, p1, variadic)
    return Citizen.InvokeNative(0xFA925AC00EB830B9, p0, p1, variadic, Citizen.ResultAsLong())
end

function DrawText3D(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    local px,py,pz=table.unpack(GetGameplayCamCoord())
    
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
    local factor = (string.len(text)) / 150
    DrawSprite("generic_textures", "hud_menu_4a", _x, _y+0.0125,0.015+ factor, 0.03, 0.1, 52, 52, 52, 190, 0)
end

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in ipairs(myPlants) do
			DeleteObject(v.object)
			table.remove(myPlants, k)
		end
        for k, v in ipairs(myPlants2) do
			DeleteObject(v.object)
			table.remove(myPlants2, k)
		end
        for k, v in ipairs(myPlants3) do
			DeleteObject(v.object)
			table.remove(myPlants3, k)
		end
	end
end)