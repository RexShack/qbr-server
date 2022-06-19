local sharedItems = exports['qbr-core']:GetItems()
local initialCooldownSeconds = 3600 -- cooldown time in seconds
local cooldownSecondsRemaining = 0 -- done to zero cooldown on restart
local vault1 = false
local vault2 = false

-- lock vault doors
Citizen.CreateThread(function()
    for k,v in pairs(Config.VaultDoors) do
        Citizen.InvokeNative(0xD99229FE93B46286,v,1,1,0,0,0,0)
        Citizen.InvokeNative(0x6BAB9442830C7F53,v,1)
    end
end)

Citizen.CreateThread(function()
	exports['qbr-core']:createPrompt('trigger-1', vector3(1282.2947, -1308.442, 77.03968), 0xF3830D8E, 'Place Dynamite', {
		type = 'client',
		event = 'rsg_rhodesbankheist:client:boom',
		args = {},
	})
end)

-- blow vault doors
RegisterNetEvent('rsg_rhodesbankheist:client:boom')
AddEventHandler('rsg_rhodesbankheist:client:boom', function()
	if cooldownSecondsRemaining == 0 then
		exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
			if hasItem then
				TriggerServerEvent('QBCore:Server:RemoveItem', 'dynamite', 1)
				TriggerEvent('inventory:client:ItemBox', sharedItems['dynamite'], 'remove')
				local playerPed = PlayerPedId()
				TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 5000, true, false, false, false)
				Citizen.Wait(5000)
				ClearPedTasksImmediately(PlayerPedId())
				local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.5, 0.0))
				local prop = CreateObject(GetHashKey("p_dynamite01x"), x, y, z, true, false, true)
				SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
				PlaceObjectOnGroundProperly(prop)
				FreezeEntityPosition(prop,true)
				exports['qbr-core']:Notify(8, 'Bank Robbery', 10000, 'explosives set, stand well back', 'toast_log_blips', 'blip_robbery_bank', 'COLOR_WHITE')
				Wait(10000)
				AddExplosion(1282.2947, -1308.442, 77.03968, 25 , 5000.0 ,true , false , 27)
				DeleteObject(prop)
				Citizen.InvokeNative(0x6BAB9442830C7F53, 3483244267, 0)
				TriggerEvent('rsg_rhodesbankheist:client:policenpc')
				local alertcoords = GetEntityCoords(PlayerPedId())
				local blipname = 'bank robbery'
				local alertmsg = 'bank robbery in progress'
				TriggerEvent('rsg_alerts:client:lawmanalert', alertcoords, blipname, alertmsg)
				handleCooldown()
			else
				exports['qbr-core']:Notify(9, 'you need dynamite to do that', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
			end
		end, { ['dynamite'] = 1 })
	else
		exports['qbr-core']:Notify(9, 'you can\'t do that right now', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)

------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	exports['qbr-core']:createPrompt('vault1', vector3(1288.6381, -1313.991, 77.039779), 0xF3830D8E, 'Loot Vault', {
		type = 'client',
		event = 'rsg_rhodesbankheist:client:checkvault1',
		args = {},
	})
end)

-- loot vault1
RegisterNetEvent('rsg_rhodesbankheist:client:checkvault1', function()
	local player = PlayerPedId()
	SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
	if vault1 == false then
		exports['qbr-core']:Progressbar("search_vault", "Stealing Cash", 10000, false, true, {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		}, {
			animDict = "script_ca@cachr@ig@ig4_vaultloot",
			anim = "ig13_14_grab_money_front01_player_zero",
			flags = 1,
		}, {}, {}, function() -- Done
			ClearPedTasks(player)
			SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
			TriggerServerEvent('rsg_rhodesbankheist:server:reward')
			vault1 = true
		end)
	else
		exports['qbr-core']:Notify(9, 'already looted this vault', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)

------------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	exports['qbr-core']:createPrompt('vault2', vector3(1286.2711, -1315.305, 77.039764), 0xF3830D8E, 'Loot Vault', {
		type = 'client',
		event = 'rsg_rhodesbankheist:client:checkvault2',
		args = {},
	})
end)

-- loot vault2
RegisterNetEvent('rsg_rhodesbankheist:client:checkvault2', function()
	local player = PlayerPedId()
	SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
	if vault2 == false then
		exports['qbr-core']:Progressbar("search_vault", "Stealing Cash", 10000, false, true, {
			disableMovement = false,
			disableCarMovement = false,
			disableMouse = false,
			disableCombat = true,
		}, {
			animDict = "script_ca@cachr@ig@ig4_vaultloot",
			anim = "ig13_14_grab_money_front01_player_zero",
			flags = 1,
		}, {}, {}, function() -- Done
			ClearPedTasks(player)
			SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
			TriggerServerEvent('rsg_rhodesbankheist:server:reward')
			vault2 = true
		end)
	else
		exports['qbr-core']:Notify(9, 'already looted this vault', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)

------------------------------------------------------------------------------------------------------------------------

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

-- start mission npcs
RegisterNetEvent('rsg_rhodesbankheist:client:policenpc')
AddEventHandler('rsg_rhodesbankheist:client:policenpc', function()
	for z, x in pairs(Config.HeistNpcs) do
	while not HasModelLoaded( GetHashKey(Config.HeistNpcs[z]["Model"]) ) do
		Wait(500)
		modelrequest( GetHashKey(Config.HeistNpcs[z]["Model"]) )
	end
	local npc = CreatePed(GetHashKey(Config.HeistNpcs[z]["Model"]), Config.HeistNpcs[z]["Pos"].x, Config.HeistNpcs[z]["Pos"].y, Config.HeistNpcs[z]["Pos"].z, Config.HeistNpcs[z]["Heading"], false, false, 0, 0)
	while not DoesEntityExist(npc) do
		Wait(300)
	end
	if not NetworkGetEntityIsNetworked(npc) then
		NetworkRegisterEntityAsNetworked(npc)
	end
	Citizen.InvokeNative(0x283978A15512B2FE, npc, true) -- SetRandomOutfitVariation
	GiveWeaponToPed_2(npc, 0x64356159, 500, true, 1, false, 0.0)
	TaskCombatPed(npc, PlayerPedId())
	end
end)

------------------------------------------------------------------------------------------------------------------------

-- cooldown
function handleCooldown()
    cooldownSecondsRemaining = initialCooldownSeconds
    Citizen.CreateThread(function()
        while cooldownSecondsRemaining > 0 do
            Citizen.Wait(1000)
            cooldownSecondsRemaining = cooldownSecondsRemaining - 1
        end
    end)
end