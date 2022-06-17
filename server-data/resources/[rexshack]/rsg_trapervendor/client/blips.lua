local blips = {

	-- adds trapper blips to map
	{ name = 'Trapper Vendor', sprite = 2888093246, x = -334.2203, y = 773.16943, z = 116.24839 }, --Valentine
	{ name = 'Trapper Vendor', sprite = 2888093246, x = 2832.2661, y = -1223.746, z = 194.07852 }, --StDenis
	{ name = 'Trapper Vendor', sprite = 2888093246, x = -1006.938, y = -549.3896, z = 99.393592 }, --RiggsStation
	{ name = 'Trapper Vendor', sprite = 2888093246, x = -2843.525, y = 142.12048, z = 184.59883 }, --WestElizabeth
	{ name = 'Trapper Vendor', sprite = 2888093246, x = -1746.238, y = -388.9359, z = 101.29882 }, --Stawberry
	
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