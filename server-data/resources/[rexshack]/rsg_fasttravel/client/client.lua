Citizen.CreateThread(function()
    for fasttravel, v in pairs(Config.FastTravelLocations) do
        exports['qbr-core']:createPrompt(v.location, v.coords, 0xF3830D8E, 'Open ' .. v.name, {
            type = 'client',
            event = 'rsg_fasttravel:client:menu',
            args = {},
        })
        if v.showblip == true then
            local FastTravelBlip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, v.coords)
            SetBlipSprite(FastTravelBlip, 784218150, 1)
            SetBlipScale(FastTravelBlip, 0.2)
			Citizen.InvokeNative(0x9CB1A1623062F402, FastTravelBlip, v.name)
        end
    end
end)

MenuData = {}

TriggerEvent("rsg_menubase:getData",function(call)
    MenuData = call
end)

RegisterNetEvent('rsg_fasttravel:client:menu', function(data)
    MenuData.CloseAll()
        local elements = {
			{label = "Annesburg - $"..Config.TicketPrice, 				value = 'annesburg', 				desc = "FastTravel to Annesburg"},
			{label = "Armadillo - $"..Config.TicketPrice, 				value = 'armadillo', 				desc = "FastTravel to Armadillo"},
			{label = "Bacchus Station - $"..Config.TicketPrice, 		value = 'bacchusstation', 			desc = "FastTravel to Bacchus Station"},
			{label = "Benedict Point - $"..Config.TicketPrice, 			value = 'benedictpoint', 			desc = "FastTravel to Benedict Point"},
			{label = "Blackwater - $"..Config.TicketPrice, 				value = 'blackwater', 				desc = "FastTravel to Blackwater"},
			{label = "Braithwaite Manor - $"..Config.TicketPrice, 		value = 'braithwaitemanor', 		desc = "FastTravel to Braithwaite Manor"},
			{label = "Butcher Creek - $"..Config.TicketPrice, 			value = 'butchercreek', 			desc = "FastTravel to Butcher Creek"},
			{label = "Caliga Hall - $"..Config.TicketPrice, 			value = 'caligahall', 				desc = "FastTravel to Caliga Hall"},
			{label = "Colter - $"..Config.TicketPrice, 					value = 'colter', 					desc = "FastTravel to Colter"},
			{label = "Cornwall Kerosene - $"..Config.TicketPrice, 		value = 'cornwallkerosene', 		desc = "FastTravel to Cornwall Kerosene"},
			{label = "Emerald Ranch - $"..Config.TicketPrice, 			value = 'emeraldranch', 			desc = "FastTravel to Emerald Ranch"},
			{label = "Gaptooth Ridge - $"..Config.TicketPrice, 			value = 'gaptoothridge', 			desc = "FastTravel to Gaptooth Ridge"},
			{label = "Lagras - $"..Config.TicketPrice, 					value = 'lagras', 					desc = "FastTravel to Lagras"},
			{label = "Macfarlanes Ranch - $"..Config.TicketPrice, 		value = 'macfarlanesranch', 		desc = "FastTravel to Macfarlanes Ranch"},
			{label = "Manzanita Trading Post - $"..Config.TicketPrice,	value = 'manzanitatradingpost', 	desc = "FastTravel to Manzanita Trading Post"},
			{label = "Pronghorn Ranch - $"..Config.TicketPrice,			value = 'pronghornranch', 			desc = "FastTravel to Pronghorn Ranch"},
			{label = "Rhodes - $"..Config.TicketPrice, 					value = 'rhodes', 					desc = "FastTravel to Rhodes"},
			{label = "Riggs Station - $"..Config.TicketPrice, 			value = 'riggsstation', 			desc = "FastTravel to Riggs Station"},
			{label = "Strawberry - $"..Config.TicketPrice, 				value = 'strawberry', 				desc = "FastTravel to Strawberry"},
			{label = "St. Denis - $"..Config.TicketPrice, 				value = 'stdenis', 					desc = "FastTravel to St. Denis"},
			{label = "Thieves Landing - $"..Config.TicketPrice, 		value = 'thieveslanding', 			desc = "FastTravel to Thieves Landing"},
			{label = "Tumbleweed - $"..Config.TicketPrice, 				value = 'tumbleweed', 				desc = "FastTravel to Tumbleweed"},
			{label = "Valentine - $"..Config.TicketPrice, 				value = 'valentine', 				desc = "FastTravel to Valentine"},
			{label = "Van Horn Trading Post - $"..Config.TicketPrice, 	value = 'vanhorntradingpost', 		desc = "FastTravel to Van Horn Trading Post"},
			{label = "Wallace Station - $"..Config.TicketPrice, 		value = 'wallacestation', 			desc = "FastTravel to Wallace Station"},
			{label = "Indian Reservation  - $"..Config.TicketPrice, 	value = 'wapiti', 					desc = "FastTravel to Wapiti Indian Reservation"},
        }
	MenuData.Open(
		'default', GetCurrentResourceName(), 'fasttravel',
		{
			title		= 'FastTravel',
			subtext		= 'choose a destination',
			align		= 'top-left',
			elements 	= elements,
		},
		function(data, menu)
			if(data.current.value == 'valentine') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(-170.64,628.58,113.00 -1), Config.TicketPrice)
			elseif(data.current.value == 'stdenis') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(2688.77,-1459.11,46.0 -1), Config.TicketPrice)
			elseif(data.current.value == 'emeraldranch') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(1525.4,432.59,90.0 -1), Config.TicketPrice)
			elseif(data.current.value == 'annesburg') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(2945.21,1272.35,44.0 -1), Config.TicketPrice)
			elseif(data.current.value == 'macfarlanesranch') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(-2493.89,-2434.62,60.6 -1), Config.TicketPrice)
			elseif(data.current.value == 'riggsstation') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(-1104.26,-572.26,82.0 -1), Config.TicketPrice)
			elseif(data.current.value == 'rhodes') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(1218.83,-1298.03,76.0 -1), Config.TicketPrice)
			elseif(data.current.value == 'bacchusstation') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(582.8,1685.29,187.67 -1), Config.TicketPrice)
			elseif(data.current.value == 'gaptoothridge') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(-6033.22,-3264.7,-20.0 -1), Config.TicketPrice)
			elseif(data.current.value == 'tumbleweed') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(-5501.2,-2954.32,-1.73 -1), Config.TicketPrice)
			elseif(data.current.value == 'benedictpoint') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(-5230.16,-3468.16,-20.51 -1), Config.TicketPrice)
			elseif(data.current.value == 'armadillo') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(-3729.09,-2603.55,-12.94 -1), Config.TicketPrice)
			elseif(data.current.value == 'thieveslanding') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(-1407.96,-2297.31,43.52 -1), Config.TicketPrice)
			elseif(data.current.value == 'manzanitatradingpost') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(-1977.67,-1618.53,117.22 -1), Config.TicketPrice)
			elseif(data.current.value == 'blackwater') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(-830.92,-1343.15,43.67 -1), Config.TicketPrice)
			elseif(data.current.value == 'strawberry') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(-1827.5,-437.65,159.78 -1), Config.TicketPrice)
			elseif(data.current.value == 'pronghornranch') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(-2207.55,701.79,121.96 -1), Config.TicketPrice)
			elseif(data.current.value == 'colter') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(-1361.92,2393.97,306.66 -1), Config.TicketPrice)
			elseif(data.current.value == 'wapiti') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(465.0,2216.62,246.45 -1), Config.TicketPrice)
			elseif(data.current.value == 'butchercreek') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(2528.53,805.07,74.91 -1), Config.TicketPrice)
			elseif(data.current.value == 'vanhorntradingpost') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(2891.5263, 619.09191, 57.721347 -1), Config.TicketPrice)
			elseif(data.current.value == 'lagras') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(2117.9,-613.17,41.64 -1), Config.TicketPrice)
			elseif(data.current.value == 'caligahall') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(1798.68,-1352.74,43.84 -1), Config.TicketPrice)
			elseif(data.current.value == 'braithwaitemanor') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(1011.71,-1732.42,46.82 -1), Config.TicketPrice)
			elseif(data.current.value == 'cornwallkerosene') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(480.86,662.67,117.43 -1), Config.TicketPrice)
			elseif(data.current.value == 'wallacestation') then
				TriggerServerEvent('rsg_fasttravel:server:buyTicket', vector3(-1297.04,404.96,94.38 -1), Config.TicketPrice)
			end
		end,
		function(data, menu)
		menu.close()
	end)
end)

RegisterNetEvent('rsg_fasttravel:client:doTravel')
AddEventHandler('rsg_fasttravel:client:doTravel', function(travel)
	MenuData.CloseAll()
	PlaySoundFrontend("Gain_Point", "HUD_MP_PITP", true, 1)	
	local travelto = travel
	local ped = PlayerPedId()
	Citizen.InvokeNative(0x1E5B70E53DB661E5, 0, 0, 0, 'FastTravel', '', '')
	Wait(Config.TravelTime)
	Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), travelto)
	Citizen.InvokeNative(0x74E2261D2A66849A, 0)
	Citizen.InvokeNative(0xA657EC9DBC6CC900, -1868977180)
	Citizen.InvokeNative(0xE8770EE02AEE45C2, 0)
	ShutdownLoadingScreen()
	DoScreenFadeIn(1000)
	Wait(1000)
	SetCinematicModeActive(false)
end)

RegisterNetEvent('rsg_fasttravel:client:closemenu')
AddEventHandler('rsg_fasttravel:client:closemenu', function()
	MenuData.CloseAll()
end)