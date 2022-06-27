local Zones = {}
local zonename = NIL
local inHostileZone = false

CreateThread(function() 
    for k=1, #Config.HostileZones do
		Zones[k] = PolyZone:Create(Config.HostileZones[k].zones, {
			name = Config.HostileZones[k].name,
			minZ = 	Config.HostileZones[k].minz,
			maxZ = Config.HostileZones[k].maxz,
			debugPoly = false,
		})
		Zones[k]:onPlayerInOut(function(isPointInside)
			if isPointInside then
				inHostileZone = true
				zonename = Zones[k].name
				exports['qbr-core']:Notify(8, 'Outlaw Post', 5000, 'you have entered a hostle zone', 'pm_awards_mp', 'awards_set_h_006', 'COLOR_WHITE')
				local alertcoords = GetEntityCoords(PlayerPedId())
				local blipname = 'Outlaw Post'
				local alertmsg = 'outlaw post alarm triggered'
				TriggerEvent('rsg_alerts:client:lawmanalert', alertcoords, blipname, alertmsg)
				TriggerEvent('rsg_outlaws:client:hostilezone', name)
			else
				inHostileZone = false
			end
		end)
    end
end)

--------------------------------------------------------------------------------------------------------------------

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

-- start mission npcs
RegisterNetEvent('rsg_outlaws:client:hostilezone')
AddEventHandler('rsg_outlaws:client:hostilezone', function(name)
	if name == hostile1 then
		for z, x in pairs(Config.Mission1Npcs) do
		while not HasModelLoaded( GetHashKey(Config.Mission1Npcs[z]["Model"]) ) do
			Wait(500)
			modelrequest( GetHashKey(Config.Mission1Npcs[z]["Model"]) )
		end
		local npc = CreatePed(GetHashKey(Config.Mission1Npcs[z]["Model"]), Config.Mission1Npcs[z]["Pos"].x, Config.Mission1Npcs[z]["Pos"].y, Config.Mission1Npcs[z]["Pos"].z, Config.Mission1Npcs[z]["Heading"], false, false, 0, 0)
		while not DoesEntityExist(npc) do
			Wait(300)
		end
		Citizen.InvokeNative(0x283978A15512B2FE, npc, true) -- SetRandomOutfitVariation
		GiveWeaponToPed_2(npc, 0x64356159, 500, true, 1, false, 0.0)
		TaskCombatPed(npc, PlayerPedId())
		end
	end
end)

--------------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
    for outlaw, v in pairs(Config.OutlawLocations) do
        exports['qbr-core']:createPrompt(v.location, v.coords, 0xF3830D8E, 'Open ' .. v.name, {
            type = 'client',
            event = 'rsg_outlaws:cient:openMenu',
            args = {},
        })
        if v.showblip == true then
            local OutlawPostBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(OutlawPostBlip, 3865995214, 1)
            SetBlipScale(OutlawPostBlip, 0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, OutlawPostBlip, v.name)
        end
    end
end)

-- outlaw menu
RegisterNetEvent('rsg_outlaws:cient:openMenu', function(data)
    exports['qbr-menu']:openMenu({
        {
            header = "| Outlaw Menu |",
            isMenuHeader = true,
        },
        {
            header = "Blood Money Wash",
            txt = "wash the blood off your money",
            params = {
                event = 'rsg_outlaws:client:sellbloodmoney',
				isServer = false,
				args = {}
            }
        },
        {
            header = "Sell Gold Bars",
            txt = "sell your gold bars here",
            params = {
                event = 'rsg_outlaws:client:sellgoldbars',
				isServer = false,
				args = {}
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

-- wash blood money
RegisterNetEvent('rsg_outlaws:client:sellbloodmoney')
AddEventHandler('rsg_outlaws:client:sellbloodmoney', function()
    local moneywash = exports['qbr-input']:ShowInput({
        header = "Money Wash",
		inputs = {
            {
                text = "Amount to Wash ($)",
                input = "amount",
                type = "number",
                isRequired = true
            },
		}
    })
    if moneywash ~= nil then
        for k,v in pairs(moneywash) do
			TriggerServerEvent('rsg_outlaws:server:sellbloodmoney', v)
        end
    end
end)

--------------------------------------------------------------------------------------------------------------------

-- sell gold bars
RegisterNetEvent('rsg_outlaws:client:sellgoldbars')
AddEventHandler('rsg_outlaws:client:sellgoldbars', function()
    local goldbars = exports['qbr-input']:ShowInput({
        header = "Gold Bars",
		inputs = {
            {
                text = "Amount of Bars",
                input = "amount",
                type = "number",
                isRequired = true
            },
		}
    })
    if goldbars ~= nil then
        for k,v in pairs(goldbars) do
			TriggerServerEvent('rsg_outlaws:server:sellgoldbars', v)
        end
    end
end)
