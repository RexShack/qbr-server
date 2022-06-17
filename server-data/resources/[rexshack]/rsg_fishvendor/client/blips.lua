local blips = {

	-- fish vendors
	{ name = 'Fish Vendor', sprite = 3442726182, x = -335.7091, y = 762.49615, z = 116.55075 }, -- Valentine
	{ name = 'Fish Vendor', sprite = 3442726182, x = 2662.2517, y = -1505.653, z = 45.968982 }, -- StDenis
	{ name = 'Fish Vendor', sprite = 3442726182, x = 2991.6115, y = 558.83947, z = 44.355224 }, -- VanHorn
	{ name = 'Fish Vendor', sprite = 3442726182, x = 3017.9001, y = 1352.2457, z = 42.735687 }, -- Anusburg
	{ name = 'Fish Vendor', sprite = 3442726182, x = 1292.9488, y = -1274.879, z = 75.814758 }, -- Rhodes
	{ name = 'Fish Vendor', sprite = 3442726182, x = -724.5062, y = -1253.603, z = 44.734111 }, -- Blackwater
	{ name = 'Fish Vendor', sprite = 3442726182, x = -5515.16, y = -2948.124, z = -1.891277 }, -- Tumbleweed
	
}

-- do not change the code below
Citizen.CreateThread(function()
	for _, info in pairs(blips) do
        local blip = N_0x554d9d53f696d002(1664425300, info.x, info.y, info.z)
        SetBlipSprite(blip, info.sprite, 1)
		SetBlipScale(blip, 0.2)
		Citizen.InvokeNative(0x9CB1A1623062F402, blip, info.name)
    end  
end)