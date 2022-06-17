local sharedItems = exports['qbr-core']:GetItems()
local campfire = 0

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(9)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end

-- setup campfire
RegisterNetEvent('rsg_cooking:client:cookinggrill')
AddEventHandler('rsg_cooking:client:cookinggrill', function(itemName)
    if campfire ~= 0 then
        SetEntityAsMissionEntity(campfire)
        DeleteObject(campfire)
        SetEntityAsMissionEntity(cookgrill)
        DeleteObject(cookgrill)
        campfire = 0
    else
		local playerPed = PlayerPedId()
		TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 10000, true, false, false, false)
		Citizen.Wait(10000)
		ClearPedTasksImmediately(PlayerPedId())
		local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.75, -1.55))
		local prop = CreateObject(GetHashKey("p_campfire05x"), x, y, z, true, false, true)
		local prop2 = CreateObject(GetHashKey("p_cookgrate01x"), x, y, z, true, false, true)
		SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
		SetEntityHeading(prop2, GetEntityHeading(PlayerPedId()))
		PlaceObjectOnGroundProperly(prop)
		PlaceObjectOnGroundProperly(prop2)
		campfire = prop
		cookgrill = prop2
	end
end, false)

-- p_campfire05x
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local pos, awayFromObject = GetEntityCoords(PlayerPedId()), true
		local cookObject = GetClosestObjectOfType(pos, 5.0, GetHashKey("p_campfire05x"), false, false, false)
		if cookObject ~= 0 then
			local objectPos = GetEntityCoords(cookObject)
			if #(pos - objectPos) < 3.0 then
				awayFromObject = false
				DrawText3Ds(objectPos.x, objectPos.y, objectPos.z + 1.0, "~g~J~w~ - Cook Menu")
				if IsControlJustReleased(0, 0xF3830D8E) then
					TriggerEvent('rsg_cooking:client:menu')
				end
			end
		end
		
		if awayFromObject then
			Wait(1000)
		end
	end
end)

-- p_campfirecombined01x
Citizen.CreateThread(function()
	while true do
		Wait(0)
		local pos, awayFromObject = GetEntityCoords(PlayerPedId()), true
		local cookObject1 = GetClosestObjectOfType(pos, 5.0, GetHashKey("p_campfirecombined01x"), false, false, false)
		if cookObject1 ~= 0 then
			local objectPos = GetEntityCoords(cookObject1)
			if #(pos - objectPos) < 3.0 then
				awayFromObject = false
				DrawText3Ds(objectPos.x, objectPos.y, objectPos.z + 1.0, "~g~J~w~ - Cook Menu")
				if IsControlJustReleased(0, 0xF3830D8E) then
					TriggerEvent('rsg_cooking:client:menu')
				end
			end
		end
		
		if awayFromObject then
			Wait(1000)
		end
	end
end)

-- p_campfirecombined02x
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos, awayFromObject = GetEntityCoords(PlayerPedId()), true
		local cookObject2 = GetClosestObjectOfType(pos, 5.0, GetHashKey("p_campfirecombined02x"), false, false, false)
		if cookObject2 ~= 0 then
			local objectPos = GetEntityCoords(cookObject2)
			if #(pos - objectPos) < 3.0 then
				awayFromObject = false
				DrawText3Ds(objectPos.x, objectPos.y, objectPos.z + 1.0, "~g~J~w~ - Cook Menu")
				if IsControlJustReleased(0, 0xF3830D8E) then
					TriggerEvent('rsg_cooking:client:menu')
				end
			end
		end
		if awayFromObject then
			Citizen.Wait(1000)
		end
	end
end)

-- p_campfirecombined03x
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos, awayFromObject = GetEntityCoords(PlayerPedId()), true
		local cookObject3 = GetClosestObjectOfType(pos, 5.0, GetHashKey("p_campfirecombined03x"), false, false, false)
		if cookObject3 ~= 0 then
			local objectPos = GetEntityCoords(cookObject3)
			if #(pos - objectPos) < 3.0 then
				awayFromObject = false
				DrawText3Ds(objectPos.x, objectPos.y, objectPos.z + 1.0, "~g~J~w~ - Cook Menu")
				if IsControlJustReleased(0, 0xF3830D8E) then
					TriggerEvent('rsg_cooking:client:menu')
				end
			end
		end
		if awayFromObject then
			Citizen.Wait(1000)
		end
	end
end)

-- p_campfirecombined04x
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos, awayFromObject = GetEntityCoords(PlayerPedId()), true
		local cookObject4 = GetClosestObjectOfType(pos, 5.0, GetHashKey("p_campfirecombined04x"), false, false, false)
		if cookObject4 ~= 0 then
			local objectPos = GetEntityCoords(cookObject4)
			if #(pos - objectPos) < 3.0 then
				awayFromObject = false
				DrawText3Ds(objectPos.x, objectPos.y, objectPos.z + 1.0, "~g~J~w~ - Cook Menu")
				if IsControlJustReleased(0, 0xF3830D8E) then
					TriggerEvent('rsg_cooking:client:menu')
				end
			end
		end
		if awayFromObject then
			Citizen.Wait(1000)
		end
	end
end)

-- s_cookfire01x
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos, awayFromObject = GetEntityCoords(PlayerPedId()), true
		local cookObject5 = GetClosestObjectOfType(pos, 5.0, GetHashKey("s_cookfire01x"), false, false, false)
		if cookObject5 ~= 0 then
			local objectPos = GetEntityCoords(cookObject5)
			if #(pos - objectPos) < 3.0 then
				awayFromObject = false
				DrawText3Ds(objectPos.x, objectPos.y, objectPos.z + 1.0, "~g~J~w~ - Cook Menu")
				if IsControlJustReleased(0, 0xF3830D8E) then
					TriggerEvent('rsg_cooking:client:menu')
				end
			end
		end
		if awayFromObject then
			Citizen.Wait(1000)
		end
	end
end)

-- p_stove06x
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos, awayFromObject = GetEntityCoords(PlayerPedId()), true
		local cookObject5 = GetClosestObjectOfType(pos, 5.0, GetHashKey("p_stove06x"), false, false, false)
		if cookObject5 ~= 0 then
			local objectPos = GetEntityCoords(cookObject5)
			if #(pos - objectPos) < 3.0 then
				awayFromObject = false
				DrawText3Ds(objectPos.x, objectPos.y, objectPos.z + 1.0, "~g~J~w~ - Cook Menu")
				if IsControlJustReleased(0, 0xF3830D8E) then
					TriggerEvent('rsg_cooking:client:menu')
				end
			end
		end
		if awayFromObject then
			Citizen.Wait(1000)
		end
	end
end)

-- p_stove07x
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos, awayFromObject = GetEntityCoords(PlayerPedId()), true
		local cookObject5 = GetClosestObjectOfType(pos, 5.0, GetHashKey("p_stove07x"), false, false, false)
		if cookObject5 ~= 0 then
			local objectPos = GetEntityCoords(cookObject5)
			if #(pos - objectPos) < 3.0 then
				awayFromObject = false
				DrawText3Ds(objectPos.x, objectPos.y, objectPos.z + 1.0, "~g~J~w~ - Cook Menu")
				if IsControlJustReleased(0, 0xF3830D8E) then
					TriggerEvent('rsg_cooking:client:menu')
				end
			end
		end
		if awayFromObject then
			Citizen.Wait(1000)
		end
	end
end)

-- cooking menu
RegisterNetEvent('rsg_cooking:client:menu', function(data)
    exports['qbr-menu']:openMenu({
        {
            header = "| Cook Menu |",
            isMenuHeader = true,
        },
        {
            header = "Meat Steak",
            txt = "1 x Raw Meat",
            params = {
                event = "rsg_cooking:clent:meatsteak"
            }
        },
        {
            header = "Fish Steak",
            txt = "1 x Fish Steak",
            params = {
                event = "rsg_cooking:clent:fishsteak"
            }
        },
        {
            header = "Close Menu",
            txt = '',
            params = {
                event = 'qbr-menu:closeMenu',
            }
        },
    })
end)

-- meal creation : meat steak
RegisterNetEvent("rsg_cooking:clent:meatsteak")
AddEventHandler("rsg_cooking:clent:meatsteak", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem) 
		if hasItem then
			exports['qbr-core']:Progressbar("cook_steak", "Cooking Meat Steak..", 30000, false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				TriggerServerEvent('QBCore:Server:RemoveItem', "raw_meat", 1)
				TriggerServerEvent('QBCore:Server:AddItem', "cooked_meat", 1)
				TriggerEvent("inventory:client:ItemBox", sharedItems["cooked_meat"], "add")
				exports['qbr-core']:Notify(9, 'You cooked a Meat Steak', 5000, 0, 'inventory_items', 'consumable_meat_prime_beef_cooked', 'COLOR_WHITE')
			end)
		else
			exports['qbr-core']:Notify(9, 'You don\'t have the ingredients to make this!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['raw_meat'] = 1 })
end)

-- meal creation : fish steak
RegisterNetEvent("rsg_cooking:clent:fishsteak")
AddEventHandler("rsg_cooking:clent:fishsteak", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem) 
		if hasItem then
			exports['qbr-core']:Progressbar("fish_steak", "Cooking Fish Steak..", 30000, false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				TriggerServerEvent('QBCore:Server:RemoveItem', "fishmeat", 1)
				TriggerServerEvent('QBCore:Server:AddItem', "cooked_fishmeat", 1)
				TriggerEvent("inventory:client:ItemBox", sharedItems["cooked_fishmeat"], "add")
				exports['qbr-core']:Notify(9, 'You cooked a Fish Steak', 5000, 0, 'inventory_items', 'consumable_meat_succulent_fish_cooked', 'COLOR_WHITE')
				
			end)
		else
			exports['qbr-core']:Notify(9, 'You don\'t have the ingredients to make this!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['fishmeat'] = 1 })
end)

-- process small fish for cooking
RegisterNetEvent("rsg_cooking:client:smallfish")
AddEventHandler("rsg_cooking:client:smallfish", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem) 
		if hasItem then
			exports['qbr-core']:Progressbar("process_small_fish", "Processing Fish..", 10000, false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				TriggerServerEvent('QBCore:Server:RemoveItem', "smallfish", 1)
				TriggerEvent("inventory:client:ItemBox", sharedItems["smallfish"], "remove")
				TriggerServerEvent('QBCore:Server:AddItem', "fishmeat", 1)
				TriggerEvent("inventory:client:ItemBox", sharedItems["fishmeat"], "add")
				exports['qbr-core']:Notify(9, 'fish ready for cooking', 5000, 0, 'inventory_items', 'provision_fish_meat', 'COLOR_WHITE')
			end)
		else
			exports['qbr-core']:Notify(9, 'You don\'t have the items to do this', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['smallfish'] = 1, ['weapon_melee_knife'] = 1 })
end)

-- process mediumfish fish for cooking
RegisterNetEvent("rsg_cooking:client:mediumfish")
AddEventHandler("rsg_cooking:client:mediumfish", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem) 
		if hasItem then
			exports['qbr-core']:Progressbar("process_medium_fish", "Processing Fish..", 20000, false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				TriggerServerEvent('QBCore:Server:RemoveItem', "mediumfish", 1)
				TriggerEvent("inventory:client:ItemBox", sharedItems["mediumfish"], "remove")
				TriggerServerEvent('QBCore:Server:AddItem', "fishmeat", 2)
				TriggerEvent("inventory:client:ItemBox", sharedItems["fishmeat"], "add")
				exports['qbr-core']:Notify(9, 'fish ready for cooking', 5000, 0, 'inventory_items', 'provision_fish_meat', 'COLOR_WHITE')
			end)
		else
			exports['qbr-core']:Notify(9, 'You don\'t have the items to do this', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['mediumfish'] = 1, ['weapon_melee_knife'] = 1 })
end)

-- process largefish fish for cooking
RegisterNetEvent("rsg_cooking:client:largefish")
AddEventHandler("rsg_cooking:client:largefish", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem) 
		if hasItem then
			exports['qbr-core']:Progressbar("process_large_fish", "Processing Fish..", 30000, false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				TriggerServerEvent('QBCore:Server:RemoveItem', "largefish", 1)
				TriggerEvent("inventory:client:ItemBox", sharedItems["largefish"], "remove")
				TriggerServerEvent('QBCore:Server:AddItem', "fishmeat", 3)
				TriggerEvent("inventory:client:ItemBox", sharedItems["fishmeat"], "add")
				exports['qbr-core']:Notify(9, 'fish ready for cooking', 5000, 0, 'inventory_items', 'provision_fish_meat', 'COLOR_WHITE')
			end)
		else
			exports['qbr-core']:Notify(9, 'You don\'t have the items to do this', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['largefish'] = 1, ['weapon_melee_knife'] = 1 })
end)