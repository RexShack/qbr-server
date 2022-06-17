local sharedItems = exports['qbr-core']:GetItems()

-- start invension shop
Citizen.CreateThread(function()
    for bpos, v in pairs(Config.InvensionShopLocations) do
        exports['qbr-core']:createPrompt(v.name, v.coords, 0xF3830D8E, 'Open ' .. v.name, {
            type = 'client',
            event = 'rsg_crafting:client:OpenInvensionShop',
        })
        if v.showblip == true then
            local StoreBlip = N_0x554d9d53f696d002(1664425300, v.coords)
            SetBlipSprite(StoreBlip, 1475879922, 1)
            SetBlipScale(StoreBlip, 0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, StoreBlip, v.name)
        end
    end
end)

RegisterNetEvent('rsg_crafting:client:OpenInvensionShop')
AddEventHandler('rsg_crafting:client:OpenInvensionShop', function()
    local ShopItems = {}
    ShopItems.label = "Invension Shop"
    ShopItems.items = Config.InvensionShop
    ShopItems.slots = #Config.InvensionShop
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "InvensionShop_"..math.random(1, 99), ShopItems)
end)
-- end invension shop

--------------------------------------------------------------------------

-- shovel crafting
RegisterNetEvent('rsg_crafting:client:shovel')
AddEventHandler('rsg_crafting:client:shovel', function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			exports['qbr-core']:Progressbar("crafting-shovel", "Crafting a Shovel..", 30000, false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				TriggerServerEvent('QBCore:Server:RemoveItem', "steel", 3)
				TriggerServerEvent('QBCore:Server:RemoveItem', "wood", 1)
				TriggerServerEvent('QBCore:Server:RemoveItem', "bpcshovel", 1)
				TriggerEvent("inventory:client:ItemBox", sharedItems["bpcshovel"], "remove")
				TriggerServerEvent('QBCore:Server:AddItem', "shovel", 1)
				TriggerEvent("inventory:client:ItemBox", sharedItems["shovel"], "add")
				TriggerServerEvent("QBCore:Server:SetMetaData", "craftingrep", exports['qbr-core']:GetPlayerData().metadata["craftingrep"] + 1)
				exports['qbr-core']:Notify(9, 'Shovel Crafted', 5000, 0, 'inventory_items_mp', 'generic_bundle_crafting', 'COLOR_WHITE')
				Wait(5000)
				exports['qbr-core']:Notify(9, 'Crafting Reputation +1', 5000, 0, 'inventory_items_mp', 'generic_bundle_crafting', 'COLOR_WHITE')
			end)
		else
			exports['qbr-core']:Notify(9, 'need more crafting items', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['bpcshovel'] = 1, ['steel'] = 3, ['wood'] = 1 })
end)

--------------------------------------------------------------------------

-- pickaxe crafting
RegisterNetEvent('rsg_crafting:client:pickaxe')
AddEventHandler('rsg_crafting:client:pickaxe', function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			exports['qbr-core']:Progressbar("crafting-pickaxe", "Crafting a Pickaxe..", 30000, false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				TriggerServerEvent('QBCore:Server:RemoveItem', "steel", 3)
				TriggerServerEvent('QBCore:Server:RemoveItem', "wood", 1)
				TriggerServerEvent('QBCore:Server:RemoveItem', "bpcpickaxe", 1)
				TriggerEvent("inventory:client:ItemBox", sharedItems["bpcpickaxe"], "remove")
				TriggerServerEvent('QBCore:Server:AddItem', "pickaxe", 1)
				TriggerEvent("inventory:client:ItemBox", sharedItems["pickaxe"], "add")
				TriggerServerEvent("QBCore:Server:SetMetaData", "craftingrep", exports['qbr-core']:GetPlayerData().metadata["craftingrep"] + 1)
				exports['qbr-core']:Notify(9, 'Pickaxe Crafted', 5000, 0, 'inventory_items_mp', 'generic_bundle_crafting', 'COLOR_WHITE')
				Wait(5000)
				exports['qbr-core']:Notify(9, 'Crafting Reputation +1', 5000, 0, 'inventory_items_mp', 'generic_bundle_crafting', 'COLOR_WHITE')
			end)
		else
			exports['qbr-core']:Notify(9, 'need more crafting items', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['bpcpickaxe'] = 1, ['steel'] = 3, ['wood'] = 1 })
end)

--------------------------------------------------------------------------

-- axe crafting
RegisterNetEvent('rsg_crafting:client:axe')
AddEventHandler('rsg_crafting:client:axe', function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			exports['qbr-core']:Progressbar("crafting-axe", "Crafting an Axe..", 30000, false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				TriggerServerEvent('QBCore:Server:RemoveItem', "steel", 3)
				TriggerServerEvent('QBCore:Server:RemoveItem', "wood", 1)
				TriggerServerEvent('QBCore:Server:RemoveItem', "bpcaxe", 1)
				TriggerEvent("inventory:client:ItemBox", sharedItems["bpcaxe"], "remove")
				TriggerServerEvent('QBCore:Server:AddItem', "axe", 1)
				TriggerEvent("inventory:client:ItemBox", sharedItems["axe"], "add")
				TriggerServerEvent("QBCore:Server:SetMetaData", "craftingrep", exports['qbr-core']:GetPlayerData().metadata["craftingrep"] + 1)
				exports['qbr-core']:Notify(9, 'Axe Crafted', 5000, 0, 'inventory_items_mp', 'generic_bundle_crafting', 'COLOR_WHITE')
				Wait(5000)
				exports['qbr-core']:Notify(9, 'Crafting Reputation +1', 5000, 0, 'inventory_items_mp', 'generic_bundle_crafting', 'COLOR_WHITE')
			end)
		else
			exports['qbr-core']:Notify(9, 'need more crafting items', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['bpcaxe'] = 1, ['steel'] = 3, ['wood'] = 1 })
end)

--------------------------------------------------------------------------

-- knife (weapon) crafting
RegisterNetEvent('rsg_crafting:client:knife')
AddEventHandler('rsg_crafting:client:knife', function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			exports['qbr-core']:Progressbar("crafting-knife", "Crafting a Knife..", 30000, false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				TriggerServerEvent('QBCore:Server:RemoveItem', "steel", 2)
				TriggerServerEvent('QBCore:Server:RemoveItem', "wood", 1)
				TriggerServerEvent('QBCore:Server:RemoveItem', "bpcknife", 1)
				TriggerEvent("inventory:client:ItemBox", sharedItems["bpcknife"], "remove")
				TriggerServerEvent('QBCore:Server:AddItem', "weapon_melee_knife", 1)
				TriggerEvent("inventory:client:ItemBox", sharedItems["weapon_melee_knife"], "add")
				TriggerServerEvent("QBCore:Server:SetMetaData", "craftingrep", exports['qbr-core']:GetPlayerData().metadata["craftingrep"] + 1)
				exports['qbr-core']:Notify(9, 'Knife Crafted', 5000, 0, 'inventory_items_mp', 'generic_bundle_crafting', 'COLOR_WHITE')
				Wait(5000)
				exports['qbr-core']:Notify(9, 'Crafting Reputation +1', 5000, 0, 'inventory_items_mp', 'generic_bundle_crafting', 'COLOR_WHITE')
			end)
		else
			exports['qbr-core']:Notify(9, 'need more crafting items', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['bpcknife'] = 1, ['steel'] = 2, ['wood'] = 1 })
end)

--------------------------------------------------------------------------

-- moonshinekit crafting
RegisterNetEvent('rsg_crafting:client:moonshinekit')
AddEventHandler('rsg_crafting:client:moonshinekit', function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			exports['qbr-core']:Progressbar("crafting-moonshinekit", "Crafting a MoonshineKit..", 30000, false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				TriggerServerEvent('QBCore:Server:RemoveItem', "copper", 10)
				TriggerServerEvent('QBCore:Server:RemoveItem', "wood", 5)
				TriggerServerEvent('QBCore:Server:RemoveItem', "water", 5)
				TriggerServerEvent('QBCore:Server:RemoveItem', "steel", 3)
				TriggerServerEvent('QBCore:Server:RemoveItem', "bpcmoonshinekit", 1)
				TriggerEvent("inventory:client:ItemBox", sharedItems["bpcmoonshinekit"], "remove")
				TriggerServerEvent('QBCore:Server:AddItem', "moonshinekit", 1)
				TriggerEvent("inventory:client:ItemBox", sharedItems["moonshinekit"], "add")
				TriggerServerEvent("QBCore:Server:SetMetaData", "craftingrep", exports['qbr-core']:GetPlayerData().metadata["craftingrep"] + 1)
				exports['qbr-core']:Notify(9, 'MoonshineKit Crafted', 5000, 0, 'inventory_items_mp', 'generic_bundle_crafting', 'COLOR_WHITE')
				Wait(5000)
				exports['qbr-core']:Notify(9, 'Crafting Reputation +1', 5000, 0, 'inventory_items_mp', 'generic_bundle_crafting', 'COLOR_WHITE')
			end)
		else
			exports['qbr-core']:Notify(9, 'need more crafting items', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['bpcmoonshinekit'] = 1, ['copper'] = 10, ['wood'] = 5, ['water'] = 5, ['steel'] = 3 })
end)

--------------------------------------------------------------------------

-- make copy from blueprint original
RegisterNetEvent('rsg_crafting:client:makecopy')
AddEventHandler('rsg_crafting:client:makecopy', function(bpo, bpc, name, copycost)
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			exports['qbr-core']:Progressbar('copy-'..name, 'Making a copy of '..name..'..', Config.BPOCopyTime, false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {}, {}, {}, function() -- Done
				TriggerServerEvent('QBCore:Server:AddItem', bpc, 1)
				TriggerEvent("inventory:client:ItemBox", sharedItems[bpc], "add")
				exports['qbr-core']:Notify(9, name..' copied', 5000, 0, 'inventory_items_mp', 'document_catalogue', 'COLOR_WHITE')
			end)
		else
			exports['qbr-core']:Notify(9, 'you don\'t have this blueprint original', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { [bpo] = 1 })
end)

--------------------------------------------------------------------------