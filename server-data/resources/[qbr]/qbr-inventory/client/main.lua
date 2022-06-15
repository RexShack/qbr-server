-- Variables
local PlayerData = exports['qbr-core']:GetPlayerData()
local sharedItems = exports['qbr-core']:GetItems()
local inInventory = false
local currentWeapon = nil
local CurrentWeaponData = {}
local currentOtherInventory = nil
local Drops = {}
local CurrentDrop = nil
local DropsNear = {}
local CurrentVehicle = nil
local CurrentGlovebox = nil
local CurrentStash = nil
local isCrafting = false
local isHotbar = false
local itemInfos = {}
local weaponsOut = {}

-- Functions

local function GetClosestVending()
    local ped = PlayerPedId()
    local pos = GetEntityCoords(ped)
    local object = nil
    for _, machine in pairs(Config.VendingObjects) do
        local ClosestObject = GetClosestObjectOfType(pos.x, pos.y, pos.z, 0.75, GetHashKey(machine), 0, 0, 0)
        if ClosestObject ~= 0 then
            if object == nil then
                object = ClosestObject
            end
        end
    end
    return object
end

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)

    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end

local function FormatWeaponAttachments(itemdata)
    local attachments = {}
    itemdata.name = itemdata.name:upper()
    if itemdata.info.attachments ~= nil and next(itemdata.info.attachments) ~= nil then
        for k, v in pairs(itemdata.info.attachments) do
            if WeaponAttachments[itemdata.name] ~= nil then
                for key, value in pairs(WeaponAttachments[itemdata.name]) do
                    if value.component == v.component then
                        attachments[#attachments+1] = {
                            attachment = key,
                            label = value.label
                        }
                    end
                end
            end
        end
    end
    return attachments
end


local function IsBackEngine(vehModel)
    if BackEngineVehicles[vehModel] then return true end
    return false
end

local function OpenTrunk()
    local vehicle = exports['qbr-core']:GetClosestVehicle()
    while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do
        RequestAnimDict("amb@prop_human_bum_bin@idle_b")
        Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "idle_d", 4.0, 4.0, -1, 50, 0, false, false, false)
    if (IsBackEngine(GetEntityModel(vehicle))) then
        SetVehicleDoorOpen(vehicle, 4, false, false)
    else
        SetVehicleDoorOpen(vehicle, 5, false, false)
    end
end

local function CloseTrunk()
    local vehicle = exports['qbr-core']:GetClosestVehicle()
    while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do
        RequestAnimDict("amb@prop_human_bum_bin@idle_b")
        Wait(100)
    end
    TaskPlayAnim(PlayerPedId(), "amb@prop_human_bum_bin@idle_b", "exit", 4.0, 4.0, -1, 50, 0, false, false, false)
    if (IsBackEngine(GetEntityModel(vehicle))) then
        SetVehicleDoorShut(vehicle, 4, false)
    else
        SetVehicleDoorShut(vehicle, 5, false)
    end
end

local function closeInventory()
    SendNUIMessage({
        action = "close",
    })
end

local function ToggleHotbar(toggle)
    local HotbarItems = {
        [1] = PlayerData.items[1],
        [2] = PlayerData.items[2],
        [3] = PlayerData.items[3],
        [4] = PlayerData.items[4],
        [5] = PlayerData.items[5],
        [41] = PlayerData.items[41],
    }

    if toggle then
        SendNUIMessage({
            action = "toggleHotbar",
            open = true,
            items = HotbarItems
        })
    else
        SendNUIMessage({
            action = "toggleHotbar",
            open = false,
        })
    end
end

local function LoadAnimDict(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(0)
    end
end

local function openAnim()
    LoadAnimDict('pickup_object')
    TaskPlayAnim(PlayerPedId(),'pickup_object', 'putdown_low', 5.0, 1.5, 1.0, 48, 0.0, 0, 0, 0)
end

local function ItemsToItemInfo()
	itemInfos = {
		[1] = {costs = sharedItems["metalscrap"]["label"] .. ": 20x, " ..sharedItems["plastic"]["label"] .. ": 20x."},
		[2] = {costs = sharedItems["coffeeseeds"]["label"] .. ": 20x, " ..sharedItems["water_bottle"]["label"] .. ": 20x."},
	}

	local items = {}
	for k, item in pairs(Config.CraftingItems) do
		local itemInfo = sharedItems[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = itemInfos[item.slot],
			label = itemInfo["label"],
			description = itemInfo["description"] or "",
			weight = itemInfo["weight"],
			type = itemInfo["type"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = itemInfo["image"],
			slot = item.slot,
			costs = item.costs,
			threshold = item.threshold,
			points = item.points,
		}
	end
	Config.CraftingItems = items
end

local function SetupAttachmentItemsInfo()
	itemInfos = {
		[1] = {costs = sharedItems["metalscrap"]["label"] .. ": 140x, " },
	}

	local items = {}
	for k, item in pairs(Config.AttachmentCrafting["items"]) do
		local itemInfo = sharedItems[item.name:lower()]
		items[item.slot] = {
			name = itemInfo["name"],
			amount = tonumber(item.amount),
			info = itemInfos[item.slot],
			label = itemInfo["label"],
			description = itemInfo["description"] or "",
			weight = itemInfo["weight"],
			unique = itemInfo["unique"],
			useable = itemInfo["useable"],
			image = itemInfo["image"],
			slot = item.slot,
			costs = item.costs,
			threshold = item.threshold,
			points = item.points,
		}
	end
	Config.AttachmentCrafting["items"] = items
end

local function GetThresholdItems()
	ItemsToItemInfo()
	local items = {}
	for k, item in pairs(Config.CraftingItems) do
		if PlayerData.metadata["craftingrep"] >= Config.CraftingItems[k].threshold then
			items[k] = Config.CraftingItems[k]
		end
	end
	return items
end

local function GetAttachmentThresholdItems()
	SetupAttachmentItemsInfo()
	local items = {}
	for k, item in pairs(Config.AttachmentCrafting["items"]) do
		if PlayerData.metadata["attachmentcraftingrep"] >= Config.AttachmentCrafting["items"][k].threshold then
			items[k] = Config.AttachmentCrafting["items"][k]
		end
	end
	return items
end

local function modelrequest( model )
    CreateThread(function()
        RequestModel( model )
    end)
end

-- Events

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    LocalPlayer.state:set("inv_busy", false, true)
    PlayerData = exports['qbr-core']:GetPlayerData()
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    LocalPlayer.state:set("inv_busy", true, true)
    PlayerData = {}
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    PlayerData = val
end)

RegisterNetEvent('inventory:client:CheckOpenState', function(type, id, label)
    local name = exports['qbr-core']:SplitStr(label, "-")[2]
    if type == "stash" then
        if name ~= CurrentStash or CurrentStash == nil then
            TriggerServerEvent('inventory:server:SetIsOpenState', false, type, id)
        end
    elseif type == "trunk" then
        if name ~= CurrentVehicle or CurrentVehicle == nil then
            TriggerServerEvent('inventory:server:SetIsOpenState', false, type, id)
        end
    elseif type == "glovebox" then
        if name ~= CurrentGlovebox or CurrentGlovebox == nil then
            TriggerServerEvent('inventory:server:SetIsOpenState', false, type, id)
        end
    elseif type == "drop" then
        if name ~= CurrentDrop or CurrentDrop == nil then
            TriggerServerEvent('inventory:server:SetIsOpenState', false, type, id)
        end
    end
end)

RegisterNetEvent('weapons:client:SetCurrentWeapon', function(data, bool)
    CurrentWeaponData = data or {}
end)

RegisterNetEvent('inventory:client:ItemBox', function(itemData, type)
    SendNUIMessage({
        action = "itemBox",
        item = itemData,
        type = type
    })
end)

RegisterNetEvent('inventory:client:requiredItems', function(items, bool)
    local itemTable = {}
    if bool then
        for k, v in pairs(items) do
            itemTable[#itemTable+1] = {
                item = items[k].name,
                label = sharedItems[items[k].name]["label"],
                image = items[k].image,
            }
        end
    end

    SendNUIMessage({
        action = "requiredItem",
        items = itemTable,
        toggle = bool
    })
end)

RegisterNetEvent('inventory:server:RobPlayer', function(TargetId)
    SendNUIMessage({
        action = "RobMoney",
        TargetId = TargetId,
    })
end)

RegisterNetEvent('inventory:client:OpenInventory', function(PlayerAmmo, inventory, other)
    if not IsEntityDead(PlayerPedId()) then
        ToggleHotbar(false)
        SetNuiFocus(true, true)
        if other then
            currentOtherInventory = other.name
        end
        SendNUIMessage({
            action = "open",
            inventory = inventory,
            slots = MaxInventorySlots,
            other = other,
            maxweight = exports['qbr-core']:GetConfig().Player.MaxWeight,
            Ammo = PlayerAmmo,
            maxammo = Config.MaximumAmmoValues,
        })
        inInventory = true
    end
end)

RegisterNetEvent('inventory:client:UpdatePlayerInventory', function(isError)
    SendNUIMessage({
        action = "update",
        inventory = PlayerData.items,
        maxweight = exports['qbr-core']:GetConfig().Player.MaxWeight,
        slots = MaxInventorySlots,
        error = isError,
    })
end)

RegisterNetEvent('inventory:client:CraftItems', function(itemName, itemCosts, amount, toSlot, points)
    local ped = PlayerPedId()
    SendNUIMessage({
        action = "close",
    })
    isCrafting = true
    exports['qbr-core']:Progressbar("repair_vehicle", Lang:t("info.crafting_progress"), (math.random(2000, 5000) * amount), false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(ped, "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("inventory:server:CraftItems", itemName, itemCosts, amount, toSlot, points)
        TriggerEvent('inventory:client:ItemBox', sharedItems[itemName], 'add')
        isCrafting = false
	end, function() -- Cancel
		StopAnimTask(ped, "mini@repair", "fixing_a_player", 1.0)
        exports['qbr-core']:Notify(9, Lang:t("error.failed"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        isCrafting = false
	end)
end)

RegisterNetEvent('inventory:client:CraftAttachment', function(itemName, itemCosts, amount, toSlot, points)
    local ped = PlayerPedId()
    SendNUIMessage({
        action = "close",
    })
    isCrafting = true
    exports['qbr-core']:Progressbar("repair_vehicle", Lang:t("info.crafting_progress"), (math.random(2000, 5000) * amount), false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "mini@repair",
		anim = "fixing_a_player",
		flags = 16,
	}, {}, {}, function() -- Done
		StopAnimTask(ped, "mini@repair", "fixing_a_player", 1.0)
        TriggerServerEvent("inventory:server:CraftAttachment", itemName, itemCosts, amount, toSlot, points)
        TriggerEvent('inventory:client:ItemBox', sharedItems[itemName], 'add')
        isCrafting = false
	end, function() -- Cancel
		StopAnimTask(ped, "mini@repair", "fixing_a_player", 1.0)
        exports['qbr-core']:Notify(9, Lang:t("error.failed"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        isCrafting = false
	end)
end)

RegisterNetEvent("inventory:client:UseWeapon", function(weaponData, shootbool)
    local ply = PlayerPedId()
    local weaponName = tostring(weaponData.name)
    local weaponHash = GetHashKey(weaponData.name)
    Citizen.InvokeNative(0xB282DC6EBD803C75, ply, weaponHash, 500, true, 0)
    if (weaponsOut[weapon]) then
        if (weaponsOut[weapon].equipped) then
            SetCurrentPedWeapon(PlayerPedId(), weapon, true, weaponData.attachPoint, false, false)
            SetCurrentPedWeapon(PlayerPedId(), 0xA2719263, true, 0, false, false)
            weaponsOut[weapon].equipped = false
        else
            SetCurrentPedWeapon(PlayerPedId(), weapon, true, 0, false, false)
            weaponsOut[weapon].equipped = true
        end
    end
end)

RegisterNetEvent('inventory:client:CheckWeapon', function(weaponName)
    local ped = PlayerPedId()
    if currentWeapon == weaponName then
        TriggerEvent('weapons:ResetHolster')
        Citizen.InvokeNative(0xADF692B254977C0C, ped, `WEAPON_UNARMED`, true)
        Citizen.InvokeNative(0xADF692B254977C0C, ped, true)
        currentWeapon = nil
    end
end)

RegisterNetEvent("inventory:client:AddDropItem", function(dropId, player, coords)
    local forward = GetEntityForwardVector(GetPlayerPed(GetPlayerFromServerId(player)))
	local x, y, z = table.unpack(coords + forward * 0.5)
    local ped     = PlayerPedId()
    local forward = GetEntityForwardVector(ped)
    local x, y, z = table.unpack(coords + forward * 1.6)
    while not HasModelLoaded(`p_cs_lootsack02x` ) do
        Wait(500)
        modelrequest(`p_cs_lootsack02x`)
    end
    local obj = CreateObject("p_cs_lootsack02x", x, y, z, true, true, true)
    PlaceObjectOnGroundProperly(obj)
    SetEntityAsMissionEntity(obj, true, true)
    FreezeEntityPosition(obj , true)
	local _coords = GetEntityCoords(obj)
    PlaySoundFrontend("show_info", "Study_Sounds", true, 0)
    SetModelAsNoLongerNeeded(`p_cs_lootsack02x`)
    Drops[dropId] = {
        id = dropId,
        coords = {
            x = x,
            y = y,
            z = z - 0.3,
        },
    }
end)

RegisterNetEvent('inventory:client:RemoveDropItem', function(dropId)
    Drops[dropId] = nil
    DropsNear[dropId] = nil
end)

RegisterNetEvent('inventory:client:DropItemAnim', function()
    SendNUIMessage({
        action = "",
    })
    local dict = "amb_camp@world_camp_jack_throw_rocks_casual@male_a@idle_a"
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
    TaskPlayAnim(PlayerPedId(), dict, "idle_a", 1.0, 8.0, -1, 1, 0, false, false, false)
    Wait(1200)
    PlaySoundFrontend("CHECKPOINT_PERFECT", "HUD_MINI_GAME_SOUNDSET", true, 1)
    Wait(1000)
    ClearPedTasks(PlayerPedId())
end)

RegisterNetEvent('inventory:client:SetCurrentStash', function(stash)
    CurrentStash = stash
end)

-- Commands

RegisterCommand('closeinv', function()
    closeInventory()
end, false)

-- RegisterCommand('inventory', function()
    -- if not isCrafting and not inInventory then
        -- if not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and not PlayerData.metadata["ishandcuffed"] and not IsPauseMenuActive() then
            -- local ped = PlayerPedId()
            -- local curVeh = nil
            -- local VendingMachine = GetClosestVending()

            -- if IsPedInAnyVehicle(ped) then -- Is Player In Vehicle
                -- local vehicle = GetVehiclePedIsIn(ped, false)
                -- CurrentGlovebox = exports['qbr-core']:GetPlate(vehicle)
                -- curVeh = vehicle
                -- CurrentVehicle = nil
            -- else
                -- local vehicle = exports['qbr-core']:GetClosestVehicle()
                -- if vehicle ~= 0 and vehicle ~= nil then
                    -- local pos = GetEntityCoords(ped)
                    -- local trunkpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
                    -- if (IsBackEngine(GetEntityModel(vehicle))) then
                        -- trunkpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
                    -- end
                    -- if #(pos - trunkpos) < 2.0 and not IsPedInAnyVehicle(ped) then
                        -- if GetVehicleDoorLockStatus(vehicle) < 2 then
                            -- CurrentVehicle = exports['qbr-core']:GetPlate(vehicle)
                            -- curVeh = vehicle
                            -- CurrentGlovebox = nil
                        -- else
                            -- exports['qbr-core']:Notify(9, "Vehicle Locked", 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
                            -- return
                        -- end
                    -- else
                        -- CurrentVehicle = nil
                    -- end
                -- else
                    -- CurrentVehicle = nil
                -- end
            -- end

            -- if CurrentVehicle then -- Trunk
                -- local vehicleClass = GetVehicleClass(curVeh)
                -- local maxweight = 0
                -- local slots = 0
                -- if vehicleClass == 0 then
                    -- maxweight = 38000
                    -- slots = 30
                -- elseif vehicleClass == 1 then
                    -- maxweight = 50000
                    -- slots = 40
                -- elseif vehicleClass == 2 then
                    -- maxweight = 75000
                    -- slots = 50
                -- elseif vehicleClass == 3 then
                    -- maxweight = 42000
                    -- slots = 35
                -- elseif vehicleClass == 4 then
                    -- maxweight = 38000
                    -- slots = 30
                -- elseif vehicleClass == 5 then
                    -- maxweight = 30000
                    -- slots = 25
                -- elseif vehicleClass == 6 then
                    -- maxweight = 30000
                    -- slots = 25
                -- elseif vehicleClass == 7 then
                    -- maxweight = 30000
                    -- slots = 25
                -- elseif vehicleClass == 8 then
                    -- maxweight = 15000
                    -- slots = 15
                -- elseif vehicleClass == 9 then
                    -- maxweight = 60000
                    -- slots = 35
                -- elseif vehicleClass == 12 then
                    -- maxweight = 120000
                    -- slots = 35
                -- elseif vehicleClass == 13 then
                    -- maxweight = 0
                    -- slots = 0
                -- elseif vehicleClass == 14 then
                    -- maxweight = 120000
                    -- slots = 50
                -- elseif vehicleClass == 15 then
                    -- maxweight = 120000
                    -- slots = 50
                -- elseif vehicleClass == 16 then
                    -- maxweight = 120000
                    -- slots = 50
                -- else
                    -- maxweight = 60000
                    -- slots = 35
                -- end
                -- local other = {
                    -- maxweight = maxweight,
                    -- slots = slots,
                -- }
                -- TriggerServerEvent("inventory:server:OpenInventory", "trunk", CurrentVehicle, other)
                -- OpenTrunk()
            -- elseif CurrentGlovebox then
                -- TriggerServerEvent("inventory:server:OpenInventory", "glovebox", CurrentGlovebox)
            -- elseif CurrentDrop then
                -- TriggerServerEvent("inventory:server:OpenInventory", "drop", CurrentDrop)
            -- elseif VendingMachine then
                -- local ShopItems = {}
                -- ShopItems.label = "Vending Machine"
                -- ShopItems.items = Config.VendingItem
                -- ShopItems.slots = #Config.VendingItem
                -- TriggerServerEvent("inventory:server:OpenInventory", "shop", "Vendingshop_"..math.random(1, 99), ShopItems)
            -- else
                -- openAnim()
                -- TriggerServerEvent("inventory:server:OpenInventory")
            -- end
        -- end
    -- end
-- end)

-- RegisterKeyMapping('inventory', 'Open Inventory', 'keyboard', 'TAB')

-- RegisterCommand('hotbar', function()
    -- isHotbar = not isHotbar
    -- if not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and not PlayerData.metadata["ishandcuffed"] and not IsPauseMenuActive() then
        -- ToggleHotbar(isHotbar)
    -- end
-- end)

-- RegisterKeyMapping('hotbar', 'Toggles keybind slots', 'keyboard', 'z')

-- for i = 1, 6 do
    -- RegisterCommand('slot' .. i,function()
        -- if not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and not PlayerData.metadata["ishandcuffed"] and not IsPauseMenuActive() then
            -- if i == 6 then
                -- i = MaxInventorySlots
            -- end
            -- TriggerServerEvent("inventory:server:UseItemSlot", i)
        -- end
    -- end)
    -- RegisterKeyMapping('slot' .. i, 'Uses the item in slot ' .. i, 'keyboard', i)
-- end

CreateThread(function()
    while true do
        Wait(0)
        if IsControlJustReleased(0, 0xC1989F95) and IsInputDisabled(0) then -- key open inventory I
            if not isCrafting then
				if not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and not PlayerData.metadata["ishandcuffed"] and not IsPauseMenuActive() then
					local ped = PlayerPedId()
					local curVeh = nil
					local VendingMachine = GetClosestVending()

					-- Is Player In Vehicle

					if IsPedInAnyVehicle(ped) then
						local vehicle = GetVehiclePedIsIn(ped, false)
						CurrentGlovebox = exports['qbr-core']:GetPlate(vehicle)
						curVeh = vehicle
						CurrentVehicle = nil
					else
						local vehicle = exports['qbr-core']:GetClosestVehicle()
						if vehicle ~= 0 and vehicle ~= nil then
							local pos = GetEntityCoords(ped)
							local trunkpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, -2.5, 0)
							-- if (IsBackEngine(GetEntityModel(vehicle))) then
							--     trunkpos = GetOffsetFromEntityInWorldCoords(vehicle, 0, 2.5, 0)
							-- end
							if #(pos - trunkpos) < 2.0 and not IsPedInAnyVehicle(ped) then
								if GetVehicleDoorLockStatus(vehicle) < 2 then
									CurrentVehicle = exports['qbr-core']:GetPlate(vehicle)
									curVeh = vehicle
									CurrentGlovebox = nil
								else
									exports['qbr-core']:Notify(9, Lang:t("error.veh_locked"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
									return
								end
							else
								CurrentVehicle = nil
							end
						else
							CurrentVehicle = nil
						end
					end

					-- Trunk

					if CurrentVehicle ~= nil then
						local maxweight = 0
						local slots = 0
						if GetVehicleClass(curVeh) == 0 then
							maxweight = 38000
							slots = 30
						elseif GetVehicleClass(curVeh) == 1 then
							maxweight = 50000
							slots = 40
						elseif GetVehicleClass(curVeh) == 2 then
							maxweight = 75000
							slots = 50
						elseif GetVehicleClass(curVeh) == 3 then
							maxweight = 42000
							slots = 35
						elseif GetVehicleClass(curVeh) == 4 then
							maxweight = 38000
							slots = 30
						elseif GetVehicleClass(curVeh) == 5 then
							maxweight = 30000
							slots = 25
						elseif GetVehicleClass(curVeh) == 6 then
							maxweight = 30000
							slots = 25
						elseif GetVehicleClass(curVeh) == 7 then
							maxweight = 30000
							slots = 25
						elseif GetVehicleClass(curVeh) == 8 then
							maxweight = 15000
							slots = 15
						elseif GetVehicleClass(curVeh) == 9 then
							maxweight = 60000
							slots = 35
						elseif GetVehicleClass(curVeh) == 12 then
							maxweight = 120000
							slots = 35
						else
							maxweight = 60000
							slots = 35
						end
						local other = {
							maxweight = maxweight,
							slots = slots,
						}
						TriggerServerEvent("inventory:server:OpenInventory", "trunk", CurrentVehicle, other)
						OpenTrunk()
					elseif CurrentGlovebox ~= nil then
						TriggerServerEvent("inventory:server:OpenInventory", "glovebox", CurrentGlovebox)
					elseif CurrentDrop ~= 0 then
						TriggerServerEvent("inventory:server:OpenInventory", "drop", CurrentDrop)
					elseif VendingMachine ~= nil then
						local ShopItems = {}
						ShopItems.label = "Vending Machine"
						ShopItems.items = Config.VendingItem
						ShopItems.slots = #Config.VendingItem
						TriggerServerEvent("inventory:server:OpenInventory", "shop", "Vendingshop_"..math.random(1, 99), ShopItems)
					else
						TriggerServerEvent("inventory:server:OpenInventory")
					end
				end
            end
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        DisableControlAction(0, 0xE6F612E4)
        DisableControlAction(0, 0x1CE6D9EB)
        DisableControlAction(0, 0x1CE6D9EB)
        DisableControlAction(0, 0x8F9F9E58)
        DisableControlAction(0, 0xAB62E997)
        DisableControlAction(0, 0x26E9DC00)
        if IsDisabledControlPressed(0, 0xE6F612E4) and IsInputDisabled(0) then  -- 1  slot
			if not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and not PlayerData.metadata["ishandcuffed"] then
				TriggerServerEvent("inventory:server:UseItemSlot", 1)
			end
        end

        if IsDisabledControlPressed(0, 0x1CE6D9EB) and IsInputDisabled(0) then  -- 2 slot
			if not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and not PlayerData.metadata["ishandcuffed"] then
				TriggerServerEvent("inventory:server:UseItemSlot", 2)
			end
        end

        if IsDisabledControlPressed(0, 0x4F49CC4C) and IsInputDisabled(0) then -- 3 slot
			if not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and not PlayerData.metadata["ishandcuffed"] then
				TriggerServerEvent("inventory:server:UseItemSlot", 3)
			end
        end

        if IsDisabledControlPressed(0, 0x8F9F9E58) and IsInputDisabled(0) then  -- 4 slot
			if not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and not PlayerData.metadata["ishandcuffed"] then
				TriggerServerEvent("inventory:server:UseItemSlot", 4)
			end
        end

        if IsDisabledControlPressed(0, 0xAB62E997) and IsInputDisabled(0) then -- 5 slot
			if not PlayerData.metadata["isdead"] and not PlayerData.metadata["inlaststand"] and not PlayerData.metadata["ishandcuffed"] then
				TriggerServerEvent("inventory:server:UseItemSlot", 5)
			end
        end

        if IsDisabledControlJustPressed(0, 0x26E9DC00) and IsInputDisabled(0) then -- z  Hotbar
            isHotbar = not isHotbar
            ToggleHotbar(isHotbar)
        end

    end
end)

RegisterNetEvent('qbr-inventory:client:giveAnim', function()
    LoadAnimDict('mp_common')
	TaskPlayAnim(PlayerPedId(), 'mp_common', 'givetake1_b', 8.0, 1.0, -1, 16, 0, 0, 0, 0)
end)

-- NUI

RegisterNUICallback('RobMoney', function(data)
    TriggerServerEvent("police:server:RobPlayer", data.TargetId)
end)

RegisterNUICallback('Notify', function(data)
    exports['qbr-core']:Notify(9, data.message, data.type)
end)

RegisterNUICallback('GetWeaponData', function(data, cb)
    local data = {
        WeaponData = sharedItems[data.weapon],
        AttachmentData = FormatWeaponAttachments(data.ItemData)
    }
    cb(data)
end)

RegisterNUICallback('RemoveAttachment', function(data, cb)
    local ped = PlayerPedId()
    local WeaponData = sharedItems[data.WeaponData.name]
    local Attachment = WeaponAttachments[WeaponData.name:upper()][data.AttachmentData.attachment]

    exports['qbr-core']:TriggerCallback('weapons:server:RemoveAttachment', function(NewAttachments)
        if NewAttachments ~= false then
            local Attachies = {}
            RemoveWeaponComponentFromPed(ped, GetHashKey(data.WeaponData.name), GetHashKey(Attachment.component))
            for k, v in pairs(NewAttachments) do
                for wep, pew in pairs(WeaponAttachments[WeaponData.name:upper()]) do
                    if v.component == pew.component then
                        Attachies[#Attachies+1] = {
                            attachment = pew.item,
                            label = pew.label,
                        }
                    end
                end
            end
            local DJATA = {
                Attachments = Attachies,
                WeaponData = WeaponData,
            }
            cb(DJATA)
        else
            RemoveWeaponComponentFromPed(ped, GetHashKey(data.WeaponData.name), GetHashKey(Attachment.component))
            cb({})
        end
    end, data.AttachmentData, data.WeaponData)
end)

RegisterNUICallback('getCombineItem', function(data, cb)
    cb(sharedItems[data.item])
end)

RegisterNUICallback("CloseInventory", function()
    if currentOtherInventory == "none-inv" then
        CurrentDrop = nil
        CurrentVehicle = nil
        CurrentGlovebox = nil
        CurrentStash = nil
        SetNuiFocus(false, false)
        inInventory = false
        ClearPedTasks(PlayerPedId())
        return
    end
    if CurrentVehicle ~= nil then
        CloseTrunk()
        TriggerServerEvent("inventory:server:SaveInventory", "trunk", CurrentVehicle)
        CurrentVehicle = nil
    elseif CurrentGlovebox ~= nil then
        TriggerServerEvent("inventory:server:SaveInventory", "glovebox", CurrentGlovebox)
        CurrentGlovebox = nil
    elseif CurrentStash ~= nil then
        TriggerServerEvent("inventory:server:SaveInventory", "stash", CurrentStash)
        CurrentStash = nil
    else
        TriggerServerEvent("inventory:server:SaveInventory", "drop", CurrentDrop)
        CurrentDrop = nil
    end
    SetNuiFocus(false, false)
    inInventory = false
end)

RegisterNUICallback("UseItem", function(data)
    TriggerServerEvent("inventory:server:UseItem", data.inventory, data.item)
end)

RegisterNUICallback("combineItem", function(data)
    Wait(150)
    TriggerServerEvent('inventory:server:combineItem', data.reward, data.fromItem, data.toItem)
end)

RegisterNUICallback('combineWithAnim', function(data)
    local ped = PlayerPedId()
    local combineData = data.combineData
    local aDict = combineData.anim.dict
    local aLib = combineData.anim.lib
    local animText = combineData.anim.text
    local animTimeout = combineData.anim.timeOut

    exports['qbr-core']:Progressbar("combine_anim", animText, animTimeout, false, true, {
        disableMovement = false,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    }, {
        animDict = aDict,
        anim = aLib,
        flags = 16,
    }, {}, {}, function() -- Done
        StopAnimTask(ped, aDict, aLib, 1.0)
        TriggerServerEvent('inventory:server:combineItem', combineData.reward, data.requiredItem, data.usedItem)
    end, function() -- Cancel
        StopAnimTask(ped, aDict, aLib, 1.0)
        exports['qbr-core']:Notify(9, Lang:t("error.failed"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end)
end)

RegisterNUICallback("SetInventoryData", function(data)
    TriggerServerEvent("inventory:server:SetInventoryData", data.fromInventory, data.toInventory, data.fromSlot, data.toSlot, data.fromAmount, data.toAmount)
end)

-- RegisterNUICallback("PlayDropSound", function()
    -- PlaySound(-1, "CLICK_BACK", "WEB_NAVIGATION_SOUNDS_PHONE", 0, 0, 1)
-- end)

RegisterNUICallback("PlayDropFail", function()
    PlaySound(-1, "Place_Prop_Fail", "DLC_Dmod_Prop_Editor_Sounds", 0, 0, 1)
end)

RegisterNUICallback("GiveItem", function(data)
    local player, distance = exports['qbr-core']:GetClosestPlayer(GetEntityCoords(PlayerPedId()))
    if player ~= -1 and distance < 3 then
        if (data.inventory == 'player') then
            local playerId = GetPlayerServerId(player)
            SetCurrentPedWeapon(PlayerPedId(),'WEAPON_UNARMED',true)
            TriggerServerEvent("inventory:server:GiveItem", playerId, data.inventory, data.item, data.amount)
        else
            exports['qbr-core']:Notify(9, Lang:t("error.not_owned"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    else
        exports['qbr-core']:Notify(9, Lang:t("error.no_near"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

RegisterNUICallback('UseWeaponItem', function(data)
    local fromInventory = data.inventory
    local itemData = data.item
    local ply = PlayerPedId()
    local weaponHash = GetHashKey(itemData.name)
    local ammo = GetAmmoInPedWeapon(PlayerPedId(), weaponHash)
    Citizen.InvokeNative(0xB282DC6EBD803C75, ply, weaponHash, ammo, true, 0)
    if weaponsOut[weaponHash] then
        local ammo = GetAmmoInPedWeapon(PlayerPedId(), weaponHash)
        local total = tonumber(ammo)
        if (total ~= 0) then
            Citizen.InvokeNative(0xF4823C813CB8277D, PlayerPedId(), weaponHash, total, 0xAD5377D4)
        end
        RemoveWeaponFromPed(PlayerPedId(), weaponHash, true, 0xAD5377D4)
        weaponsOut[weaponHash] = nil
    else
        weaponsOut[weaponHash] = {
            itemData = itemData,
            equipped = false
        }
        exports['qbr-core']:TriggerCallback("weapon:server:GetWeaponAmmo", function(result)
            local ammo = tonumber(result)
            Citizen.InvokeNative(0x5E3BDDBCB83F3D84, PlayerPedId(), weapon, ammo, false, true, 0, false, 0, 0, 0xCA3454E6, false, 0, false)
            TriggerEvent('weapons:client:SetCurrentWeapon', itemData, true)
        end, itemData)
    end
end)

-- Threads

CreateThread(function()
    while true do
        local sleep = 1000
        if DropsNear then
            for k, v in pairs(DropsNear) do
                if DropsNear[k] then
                    sleep = 0
                    Citizen.InvokeNative(0x2A32FAA57B937173, 0x6903B113, v.coords.x, v.coords.y, v.coords.z, - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.9, 255, 255, 0, 155, 0, 0, 2, 0, 0, 0, 0)
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        if Drops and next(Drops) then
            local pos = GetEntityCoords(PlayerPedId(), true)
            for k, v in pairs(Drops) do
                if Drops[k] then
                    local dist = #(pos - vector3(v.coords.x, v.coords.y, v.coords.z))
                    if dist < 7.5 then
                        DropsNear[k] = v
                        if dist < 2 then
                            CurrentDrop = k
                        else
                            CurrentDrop = nil
                        end
                    else
                        DropsNear[k] = nil
                    end
                end
            end
        else
            DropsNear = {}
        end
        Wait(500)
    end
end)

CreateThread(function()
    while true do
        local sleep = 1000
        if LocalPlayer.state['isLoggedIn'] then
            local pos = GetEntityCoords(PlayerPedId())
            local craftObject = GetClosestObjectOfType(pos, 2.0, -1718655749 , false, false, false)
            if craftObject ~= 0 then
                local objectPos = GetEntityCoords(craftObject)
                if #(pos - objectPos) < 1.5 then
                    sleep = 0
                    DrawText3Ds(objectPos.x, objectPos.y, objectPos.z + 1.0, "~d~E~s~ - "..Lang:t("info.craft"))
                    if IsControlJustReleased(0, 0xCEFD9220) then
                        local crafting = {}
                        crafting.label = Lang:t("info.craft_label")
                        crafting.items = GetThresholdItems()
                        TriggerServerEvent("inventory:server:OpenInventory", "crafting", math.random(1, 99), crafting)
                        sleep = 100
                    end
                end
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
	while true do
		local pos = GetEntityCoords(PlayerPedId())
		local inRange = false
		local distance = #(pos - vector3(Config.AttachmentCraftingLocation.x, Config.AttachmentCraftingLocation.y, Config.AttachmentCraftingLocation.z))

		if distance < 10 then
			inRange = true
			if distance < 1.5 then
				DrawText3Ds(Config.AttachmentCraftingLocation.x, Config.AttachmentCraftingLocation.y, Config.AttachmentCraftingLocation.z, "~d~E~s~ - "..Lang:t("info.craft"))
				if IsControlJustPressed(0, 0xCEFD9220) then
					local crafting = {}
					crafting.label = Lang:t("info.attatch_label")
					crafting.items = GetAttachmentThresholdItems()
					TriggerServerEvent("inventory:server:OpenInventory", "attachment_crafting", math.random(1, 99), crafting)
				end
			end
		end

		if not inRange then
			Wait(1000)
		end

		Wait(3)
	end
end)
