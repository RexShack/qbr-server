local sharedItems = exports['qbr-core']:GetItems()
local petout = false

Citizen.CreateThread(function()
    for pets, v in pairs(Config.PetShopLocations) do
        exports['qbr-core']:createPrompt(v.name, v.coords, 0xF3830D8E, 'Open ' .. v.name, {
            type = 'client',
            event = 'rsg_pets:client:OpenPetShop',
        })
        if v.showblip == true then
            local StoreBlip = N_0x554d9d53f696d002(1664425300, v.coords)
            SetBlipSprite(StoreBlip, 1475879922, 1)
            SetBlipScale(StoreBlip, 0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, StoreBlip, v.name)
        end
    end
end)

RegisterNetEvent('rsg_pets:client:OpenPetShop')
AddEventHandler('rsg_pets:client:OpenPetShop', function()
    local ShopItems = {}
    ShopItems.label = "Pet Shop"
    ShopItems.items = Config.PetShop
    ShopItems.slots = #Config.PetShop
    TriggerServerEvent("inventory:server:OpenInventory", "shop", "PetShop_"..math.random(1, 99), ShopItems)
end)

-- call foxhound
RegisterNetEvent("rsg_pets:client:callfoxhound")
AddEventHandler("rsg_pets:client:callfoxhound", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			if petout == false then
				local model = "A_C_DogAmericanFoxhound_01"
				local name = "foxhound"
				doggo = newDoggo(model, name)
				petout = true
				doggo.whistle()
				Wait(Config.whistle_wait)
			else
				doggo.delete()
				petout = false
				exports['qbr-core']:Notify(9, 'sent your dog to the kennel', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			end
		else
			exports['qbr-core']:Notify(9, 'you don\'t have this pet', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['foxhound'] = 1 })
end)

-- call sheperd
RegisterNetEvent("rsg_pets:client:callsheperd")
AddEventHandler("rsg_pets:client:callsheperd", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			if petout == false then
				local model = "A_C_DogAustralianSheperd_01"
				local name = "sheperd"
				doggo = newDoggo(model, name)
				petout = true
				doggo.whistle()
				Wait(Config.whistle_wait)
			else
				doggo.delete()
				petout = false
				exports['qbr-core']:Notify(9, 'sent your dog to the kennel', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			end
		else
			exports['qbr-core']:Notify(9, 'you don\'t have this pet', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['sheperd'] = 1 })
end)

-- call coonhound
RegisterNetEvent("rsg_pets:client:callcoonhound")
AddEventHandler("rsg_pets:client:callcoonhound", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			if petout == false then
				local model = "A_C_DogBluetickCoonhound_01"
				local name = "coonhound"
				doggo = newDoggo(model, name)
				petout = true
				doggo.whistle()
				Wait(Config.whistle_wait)
			else
				doggo.delete()
				petout = false
				exports['qbr-core']:Notify(9, 'sent your dog to the kennel', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			end
		else
			exports['qbr-core']:Notify(9, 'you don\'t have this pet', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['coonhound'] = 1 })
end)

-- call catahoulacur
RegisterNetEvent("rsg_pets:client:callcatahoulacur")
AddEventHandler("rsg_pets:client:callcatahoulacur", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			if petout == false then
				local model = "A_C_DogCatahoulaCur_01"
				local name = "catahoulacur"
				doggo = newDoggo(model, name)
				petout = true
				doggo.whistle()
				Wait(Config.whistle_wait)
			else
				doggo.delete()
				petout = false
				exports['qbr-core']:Notify(9, 'sent your dog to the kennel', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			end
		else
			exports['qbr-core']:Notify(9, 'you don\'t have this pet', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['catahoulacur'] = 1 })
end)

-- call bayretriever
RegisterNetEvent("rsg_pets:client:callbayretriever")
AddEventHandler("rsg_pets:client:callbayretriever", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			if petout == false then
				local model = "A_C_DogChesBayRetriever_01"
				local name = "bayretriever"
				doggo = newDoggo(model, name)
				petout = true
				doggo.whistle()
				Wait(Config.whistle_wait)
			else
				doggo.delete()
				petout = false
				exports['qbr-core']:Notify(9, 'sent your dog to the kennel', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			end
		else
			exports['qbr-core']:Notify(9, 'you don\'t have this pet', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['bayretriever'] = 1 })
end)

-- call collie
RegisterNetEvent("rsg_pets:client:callcollie")
AddEventHandler("rsg_pets:client:callcollie", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			if petout == false then
				local model = "A_C_DogCollie_01"
				local name = "collie"
				doggo = newDoggo(model, name)
				petout = true
				doggo.whistle()
				Wait(Config.whistle_wait)
			else
				doggo.delete()
				petout = false
				exports['qbr-core']:Notify(9, 'sent your dog to the kennel', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			end
		else
			exports['qbr-core']:Notify(9, 'you don\'t have this pet', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['collie'] = 1 })
end)

-- call hound
RegisterNetEvent("rsg_pets:client:callhound")
AddEventHandler("rsg_pets:client:callhound", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			if petout == false then
				local model = "A_C_DogHound_01"
				local name = "hound"
				doggo = newDoggo(model, name)
				petout = true
				doggo.whistle()
				Wait(Config.whistle_wait)
			else
				doggo.delete()
				petout = false
				exports['qbr-core']:Notify(9, 'sent your dog to the kennel', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			end
		else
			exports['qbr-core']:Notify(9, 'you don\'t have this pet', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['hound'] = 1 })
end)

-- call husky
RegisterNetEvent("rsg_pets:client:callhusky")
AddEventHandler("rsg_pets:client:callhusky", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			if petout == false then
				local model = "A_C_DogHusky_01"
				local name = "husky"
				doggo = newDoggo(model, name)
				petout = true
				doggo.whistle()
				Wait(Config.whistle_wait)
			else
				doggo.delete()
				petout = false
				exports['qbr-core']:Notify(9, 'sent your dog to the kennel', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			end
		else
			exports['qbr-core']:Notify(9, 'you don\'t have this pet', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['husky'] = 1 })
end)

-- call lab
RegisterNetEvent("rsg_pets:client:calllab")
AddEventHandler("rsg_pets:client:calllab", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			if petout == false then
				local model = "A_C_DogLab_01"
				local name = "lab"
				doggo = newDoggo(model, name)
				petout = true
				doggo.whistle()
				Wait(Config.whistle_wait)
			else
				doggo.delete()
				petout = false
				exports['qbr-core']:Notify(9, 'sent your dog to the kennel', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			end
		else
			exports['qbr-core']:Notify(9, 'you don\'t have this pet', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['lab'] = 1 })
end)

-- call poodle
RegisterNetEvent("rsg_pets:client:callpoodle")
AddEventHandler("rsg_pets:client:callpoodle", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			if petout == false then
				local model = "A_C_DogPoodle_01"
				local name = "poodle"
				doggo = newDoggo(model, name)
				petout = true
				doggo.whistle()
				Wait(Config.whistle_wait)
			else
				doggo.delete()
				petout = false
				exports['qbr-core']:Notify(9, 'sent your dog to the kennel', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			end
		else
			exports['qbr-core']:Notify(9, 'you don\'t have this pet', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['poodle'] = 1 })
end)

-- call street
RegisterNetEvent("rsg_pets:client:callstreet")
AddEventHandler("rsg_pets:client:callstreet", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
		if hasItem then
			if petout == false then
				local model = "A_C_DogStreet_01"
				local name = "street"
				doggo = newDoggo(model, name)
				petout = true
				doggo.whistle()
				Wait(Config.whistle_wait)
			else
				doggo.delete()
				petout = false
				exports['qbr-core']:Notify(9, 'sent your dog to the kennel', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			end
		else
			exports['qbr-core']:Notify(9, 'you don\'t have this pet', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['street'] = 1 })
end)