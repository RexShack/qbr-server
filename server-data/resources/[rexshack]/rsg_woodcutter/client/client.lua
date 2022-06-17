local sharedItems = exports['qbr-core']:GetItems()
local trees
local choppingactive = false

Citizen.CreateThread(function()
    for trees, v in pairs(Config.TreeLocations) do
        exports['qbr-core']:createPrompt(v.treeType, v.coords, Config.ChoppingKey, 'Start Choping ' .. v.name, {
            type = 'client',
            event = 'rsg_woodcutter:clent:dowoodcutting',
            args = {},
        })
        if v.showblip == true then
            local TreeBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(TreeBlip, 1904459580, 1)
            SetBlipScale(TreeBlip, 0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, TreeBlip, v.name)
        end
    end
end)

-- do woodcutting need axe
RegisterNetEvent('rsg_woodcutter:clent:dowoodcutting')
AddEventHandler('rsg_woodcutter:clent:dowoodcutting', function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem) 
		if choppingactive == false then
			if hasItem then
				choppingactive = true
				local player = PlayerPedId()
				TaskStartScenarioInPlace(player, GetHashKey('EA_WORLD_HUMAN_TREE_CHOP_NEW'), Config.ChoppingTime, true, false, false, false)
				Wait(Config.ChoppingTime)
				ClearPedTasks(player)
				SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
				choppingactive = false
				randomNumber = math.random(1,100)
				if randomNumber > 95 then
					TriggerServerEvent('QBCore:Server:RemoveItem', "axe", 1)
					TriggerEvent("inventory:client:ItemBox", sharedItems["axe"], "remove")
					exports['qbr-core']:Notify(9, 'your axe is broken', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
				else
					TriggerServerEvent('rsg_woodcutter:server:giveWoodcuttingReward')
				end
			else
				exports['qbr-core']:Notify(9, 'you don\'t have a axe!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
			end
		else
			exports['qbr-core']:Notify(9, 'you are a bit busy right now!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end, { ['axe'] = 1 })
end)

RegisterNetEvent('rsg_woodcutter:client:alert')	
AddEventHandler('rsg_woodcutter:client:alert', function(txt)
    SetTextScale(0.5, 0.5)
    local str = Citizen.InvokeNative(0xFA925AC00EB830B9, 10, "LITERAL_STRING", txt, Citizen.ResultAsLong())
    Citizen.InvokeNative(0xFA233F8FE190514C, str)
    Citizen.InvokeNative(0xE9990552DEC71600)
end)