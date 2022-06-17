-- Trapper-Vendor-Valentine
Citizen.CreateThread(function()
	exports['qbr-core']:createPrompt('Trapper-Vendor-Valentine', vector3(-336.6282, 772.65386, 116.2103), 0xF3830D8E, 'Valentine Trapper Vendor', {
		type = 'client',
		event = 'rsg_trappervendor:client:menu',
		args = { },
	})
end)

-- Trapper-Vendor-StDenis
Citizen.CreateThread(function()
	exports['qbr-core']:createPrompt('Trapper-Vendor-StDenis', vector3(2832.3007, -1225.554, 47.657634), 0xF3830D8E, 'Saint Denis Trapper Vendor', {
		type = 'client',
		event = 'rsg_trappervendor:client:menu',
		args = { },
	})
end)

-- Trapper-Vendor-RiggsStation
Citizen.CreateThread(function()
	exports['qbr-core']:createPrompt('Trapper-Vendor-RiggsStation', vector3(-1006.938, -549.3896, 99.393592), 0xF3830D8E, 'Riggs Station Trapper Vendor', {
		type = 'client',
		event = 'rsg_trappervendor:client:menu',
		args = { },
	})
end)

-- Trapper-Vendor-WestElizabeth
Citizen.CreateThread(function()
	exports['qbr-core']:createPrompt('Trapper-Vendor-WestElizabeth', vector3(-2843.525, 142.12048, 184.59883), 0xF3830D8E, 'West Elizabeth Trapper Vendor', {
		type = 'client',
		event = 'rsg_trappervendor:client:menu',
		args = { },
	})
end)

-- Trapper-Vendor-Stawberry
Citizen.CreateThread(function()
	exports['qbr-core']:createPrompt('Trapper-Vendor-Stawberry', vector3(-1746.238, -388.9359, 156.57376), 0xF3830D8E, 'Stawberry Trapper Vendor', {
		type = 'client',
		event = 'rsg_trappervendor:client:menu',
		args = { },
	})
end)

-- trapper vendor menu
RegisterNetEvent('rsg_trappervendor:client:menu', function(data)
    exports['qbr-menu']:openMenu({
        {
            header = "| Trapper Vendor |",
            isMenuHeader = true,
        },
        {
            header = "Sell Pelts to Trapper",
            txt = "will sell all your pelts in your inventory",
            params = {
                event = 'rsg_trappervendor:server:sell',
				isServer = true,
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