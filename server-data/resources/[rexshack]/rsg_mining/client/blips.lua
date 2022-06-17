local blips = {

	-- add mining blips to map / uncomment if you want to show blips
	--{ name = 'Mine', sprite = -1289383059, x = -1404.681, y = 1157.0645, z = 226.1493 },
	--{ name = 'Mine', sprite = -1289383059, x = -1417.508, y = 1171.145, z = 226.57142 },
	--{ name = 'Mine', sprite = -1289383059,  x = 2763.174, y = 1406.2044, z = 68.444854 },
	--{ name = 'Mine', sprite = -1289383059, x = 2726.7871, y = 1384.9691, z = 68.878173 },
	--{ name = 'Mine', sprite = -1289383059, x = 2717.3491, y = 1314.0633, z = 69.75164 },
	--{ name = 'Mine', sprite = -1289383059, x = 835.76275, y = 1931.185, z = 259.84646 },
	--{ name = 'Mine', sprite = -1289383059, x = 835.62109, y = 1925.5421, z = 259.289 },
	--{ name = 'Mine', sprite = -1289383059, x = 831.66693, y = 1920.0919, z = 259.37493 },
	--{ name = 'Mine', sprite = -1289383059, x = 825.7395, y = 1922.6685, z = 259.20452 },
	
}

-- do not touch code below
Citizen.CreateThread(function()
	for _, info in pairs(blips) do
        local blip = Citizen.InvokeNative(0x554D9D53F696D002, 1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, info.sprite, 1)
		SetBlipScale(blip, 0.2)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, info.name)
    end  
end)