local sharedItems = exports['qbr-core']:GetItems()
local initialCooldownSeconds = 3600 -- cooldown time in seconds
local cooldownSecondsRemaining = 0 -- done to zero cooldown on restart
local lockpicked = false
local dynamiteused = false
local vault1 = false
local vault2 = false

-- lock vault doors
Citizen.CreateThread(function()
    for k,v in pairs(Config.VaultDoors) do
        Citizen.InvokeNative(0xD99229FE93B46286,v,1,1,0,0,0,0)
        Citizen.InvokeNative(0x6BAB9442830C7F53,v,1)
    end
end)

------------------------------------------------------------------------------------------------------------------------

-- lockpick door
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos, awayFromObject = GetEntityCoords(PlayerPedId()), true
		local object = Citizen.InvokeNative(0xF7424890E4A094C0, 2058564250, 0)
		if object ~= 0 and cooldownSecondsRemaining == 0 and lockpicked == false then
			local objectPos = GetEntityCoords(object)
			if #(pos - objectPos) < 3.0 then
				awayFromObject = false
				DrawText3Ds(objectPos.x, objectPos.y, objectPos.z + 1.0, "~g~J~w~ - Lockpick")
				if IsControlJustReleased(0, 0xF3830D8E) then -- [J]
					exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
						if hasItem then
							TriggerServerEvent('QBCore:Server:RemoveItem', 'lockpick', 1)
							TriggerEvent("inventory:client:ItemBox", sharedItems['lockpick'], 'remove')
							TriggerEvent('qbr-lockpick:client:openLockpick', lockpickFinish)
						else
							exports['qbr-core']:Notify(9, 'you need a lockpick', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
						end
					end, { ['lockpick'] = 1 })
				end
			end
		end
		if awayFromObject then
			Citizen.Wait(1000)
		end
	end
end)

function lockpickFinish(success)
    if success then
		exports['qbr-core']:Notify(9, 'lockpick successful', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
		Citizen.InvokeNative(0x6BAB9442830C7F53, 2058564250, 0)
		lockpicked = true
    else
        exports['qbr-core']:Notify(9, 'lockpick unsuccessful', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end

------------------------------------------------------------------------------------------------------------------------

-- vault prompt
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos, awayFromObject = GetEntityCoords(PlayerPedId()), true
		local object = Citizen.InvokeNative(0xF7424890E4A094C0, 3483244267, 0)
		if object ~= 0 and cooldownSecondsRemaining == 0 and dynamiteused == false then
			local objectPos = GetEntityCoords(object)
			if #(pos - objectPos) < 3.0 then
				awayFromObject = false
				DrawText3Ds(objectPos.x, objectPos.y, objectPos.z + 1.0, "~g~J~w~ - Place Dynamite")
				if IsControlJustReleased(0, 0xF3830D8E) then -- [J]
					TriggerEvent('rsg_rhodesbankheist:client:boom')
					dynamiteused = true
				end
			end
		end
		if awayFromObject then
			Citizen.Wait(1000)
		end
	end
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
		exports['qbr-core']:Progressbar("search_vault", "Stealing Gold", 10000, false, true, {
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
		exports['qbr-core']:Progressbar("search_vault", "Stealing Gold", 10000, false, true, {
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
	local npc = CreatePed(GetHashKey(Config.HeistNpcs[z]["Model"]), Config.HeistNpcs[z]["Pos"].x, Config.HeistNpcs[z]["Pos"].y, Config.HeistNpcs[z]["Pos"].z, Config.HeistNpcs[z]["Heading"], true, false, 0, 0)
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

------------------------------------------------------------------------------------------------------------------------

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(9)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end