Config = {}

Config.BuyText = "Buy this House"
Config.BuyText2 = "Buy"
Config.BuyText3 = "for"
Config.BlipName = "Property for Sale"
Config.OwnedBlipName = "Owned House"

-- [U] to open door
Config.KeyPress = 0xD8F73058 

-- HouseStash
Config.StashWeight = 5000000
Config.StashSlots = 48

-- house price per class
Config.HouseClass1 = 1000
Config.HouseClass2 = 2000
Config.HouseClass3 = 3000
Config.HouseClass4 = 4000

Config.Houses = {

	{
		['number'] = "house1", 
		['name'] = "House1", 
		['pos'] = vector3(222.3369, 986.5397, 190.886), 
		['buy'] = vector3(215.0397, 987.553, 190.7944), 
		['menu'] = vector3(220.05, 984.86, 190.9), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house2", 
		['name'] = "House2", 
		['pos'] = vector3(-612.22, -27.18, 85.98), 
		['buy'] = vector3(-617.96, -28.84, 85.4), 
		['menu'] = vector3(-614.38, -37.4, 85.97), 
		['price'] = Config.HouseClass3, 
		['owned'] = false
	},
	{
		['number'] = "house3", 
		['name'] = "House3", 
		['pos'] = vector3(1888.22, 300.66, 77.06), 
		['buy'] = vector3(1887.66, 296.25, 76.83), 
		['menu'] = vector3(1887.16, 300.48, 77.07), 
		['price'] = Config.HouseClass1, 
		['owned'] = false
	},
	{
		['number'] = "house4", 
		['name'] = "House4", 
		['pos'] = vector3(1786.94, -85.86, 56.82), 
		['buy'] = vector3(1794.23, -83.64, 56.75), 
		['menu'] = vector3(1782.71, -86.67, 60.45), 
		['price'] = Config.HouseClass3, 
		['owned'] = false
	},
	{
		['number'] = "house5", 
		['name'] = "House5", 
		['pos'] = vector3(1267.77, -407.72, 97.59), 
		['buy'] = vector3(1264.84, -402.14, 97.61), 
		['menu'] = vector3(1263.01, -409.96, 97.6), 
		['price'] = Config.HouseClass1, 
		['owned'] = false
	},
	{
		['number'] = "house6", 
		['name'] = "House6", 
		['pos'] = vector3(1626.18, -363.34, 75.9), 
		['buy'] = vector3(1626.32, -368.52, 75.86), 
		['menu'] = vector3(1619.19, -363.79, 75.9), 
		['price'] = Config.HouseClass1, 
		['owned'] = false
	},
	{
		['number'] = "house7", 
		['name'] = "House7", 
		['pos'] = vector3(-2370.595, -2390.662, 62.168346), 
		['buy'] = vector3(-2370.595, -2390.662, 62.168346), 
		['menu'] = vector3(-2366.754, -2393.241, 62.278358), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house8", 
		['name'] = "House8", 
		['pos'] = vector3(1117.83, 490.4, 97.28), 
		['buy'] = vector3(1118.58, 484.51, 97.25), 
		['menu'] = vector3(1114.94, 494.99, 97.28), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house9", 
		['name'] = "House9", 
		['pos'] = vector3(-61.34, -392.34, 72.21), 
		['buy'] = vector3(-65.11, -394.67, 72.24), 
		['menu'] = vector3(-63.3, -390.63, 72.22), 
		['price'] = Config.HouseClass1, 
		['owned'] = false
	},
	{
		['number'] = "house10", 
		['name'] = "House10", 
		['pos'] = vector3(342.64, -665.5, 42.82), 
		['buy'] = vector3(348.98, -667.65, 42.78), 
		['menu'] = vector3(343.63, -670.14, 42.8), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house11", 
		['name'] = "House11", 
		['pos'] = vector3(1112.38, -1301.47, 66.41), 
		['buy'] = vector3(1114.64, -1307.13, 66.44), 
		['menu'] = vector3(1117.42, -1300.58, 66.38), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house12", 
		['name'] = "House12", 
		['pos'] = vector3(1371.13, -873.39, 70.13), 
		['buy'] = vector3(1377.86, -872.36, 70.11), 
		['menu'] = vector3(1372.37, -877.97, 70.14), 
		['price'] = Config.HouseClass3, 
		['owned'] = false
	},
	{
		['number'] = "house13", 
		['name'] = "House13", 
		['pos'] = vector3(2066.89, -851.34, 43.36), 
		['buy'] = vector3(2068.99, -857.52, 43.35), 
		['menu'] = vector3(2071.32, -854.65, 43.36), 
		['price'] = Config.HouseClass4, 
		['owned'] = false
	},
	{
		['number'] = "house14", 
		['name'] = "House14", 
		['pos'] = vector3(2254.69, -786.24, 44.2), 
		['buy'] = vector3(2252.84, -779.73, 44.14), 
		['menu'] = vector3(2250.09, -783.89, 44.17), 
		['price'] = Config.HouseClass4, 
		['owned'] = false
	},
	------------ 115 missing
	{
		['number'] = "house16", 
		['name'] = "House16", 
		['pos'] = vector3(2370.01, -860.3, 43.03), 
		['buy'] = vector3(2372.17, -866.56, 43.06), 
		['menu'] = vector3(2369.38, -859.62, 43.06), 
		['price'] = Config.HouseClass1, 
		['owned'] = false
	},
	{
		['number'] = "house17", 
		['name'] = "House17", 
		['pos'] = vector3(1706.75, -1005.97, 43.48), 
		['buy'] = vector3(1711.39, -1000.74, 43.43), 
		['menu'] = vector3(1707.62, -1007.67, 43.5), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	------------ 118 missing
	{
		['number'] = "house19", 
		['name'] = "House19", 
		['pos'] = vector3(2624.87, 1695.73, 115.69), 
		['buy'] = vector3(2630.19, 1693.39, 115.78), 
		['menu'] = vector3(2623.93, 1695.58, 115.7), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house20", 
		['name'] = "House20", 
		['pos'] = vector3(2990.73, 2189.84, 166.79), 
		['buy'] = vector3(2987.1, 2193.61, 166.75), 
		['menu'] = vector3(2984.41, 2184.76, 166.74), 
		['price'] = Config.HouseClass3, 
		['owned'] = false
	},
	{
		['number'] = "house21", 
		['name'] = "House21", 
		['pos'] = vector3(2475.03, 1998.71, 168.25), 
		['buy'] = vector3(2471.55, 2003.62, 168.14), 
		['menu'] = vector3(2475.22, 2000.75, 168.25), 
		['price'] = Config.HouseClass1, 
		['owned'] = false
	},
	--[[
	{
		['number'] = "house22", 
		['name'] = "House22", 
		['pos'] = vector3(2518.03, 2284.42, 177.35), 
		['buy'] = vector3(2513.38, 2277.17, 176.68), 
		['menu'] = vector3(2510.37, 2290.45, 177.35), 
		['price'] = Config.HouseClass4, 
		['owned'] = false
	},
	--]]
	------------ house23 missing
	{
		['number'] = "house24", 
		['name'] = "House24", 
		['pos'] = vector3(-423.35, 1736.39, 216.56), 
		['buy'] = vector3(-420.61, 1731.14, 216.32), 
		['menu'] = vector3(-426.61, 1736.05, 216.57), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house25", 
		['name'] = "House25", 
		['pos'] = vector3(899.7, 261.23, 116.01), 
		['buy'] = vector3(899.49, 267.14, 116.11), 
		['menu'] = vector3(897.26, 261.69, 116.01), 
		['price'] = Config.HouseClass3, 
		['owned'] = false
	},
	{
		['number'] = "house26", 
		['name'] = "House26", 
		['pos'] = vector3(-1351.03, 2439.35, 308.48), 
		['buy'] = vector3(-1346.46, 2435.12, 307.8), 
		['menu'] = vector3(-1353.22, 2436.3, 308.4), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house27", 
		['name'] = "House27", 
		['pos'] = vector3(-554.47, 2704.27, 320.42), 
		['buy'] = vector3(-558.36, 2696.98, 319.34), 
		['menu'] = vector3(-555.01, 2710.72, 320.41), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house28", 
		['name'] = "House28", 
		['pos'] = vector3(-1020.75, 1691.05, 244.31), 
		['buy'] = vector3(-1018.86, 1686.34, 244.2), 
		['menu'] = vector3(-1021.79, 1695.67, 244.31), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house29", 
		['name'] = "House29", 
		['pos'] = vector3(-1817.67, 657.86, 131.86), 
		['buy'] = vector3(-1814.2, 652.78, 131.38), 
		['menu'] = vector3(-1818.6, 661.78, 131.87), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house30", 
		['name'] = "House30", 
		['pos'] = vector3(-2176.89, 718.47, 122.62), 
		['buy'] = vector3(-2184.19, 714.96, 122.3), 
		['menu'] = vector3(-2176.76, 720.45, 126.2), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house31", 
		['name'] = "House31", 
		['pos'] = vector3(-2578.24, -1382.19, 149.25), 
		['buy'] = vector3(-2574.17, -1379.84, 149.28), 
		['menu'] = vector3(-2577.62, -1384.25, 149.25), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house32", 
		['name'] = "House32", 
		['pos'] = vector3(-2376.75, -1589.76, 154.28), 
		['buy'] = vector3(-2372.26, -1593.56, 153.97), 
		['menu'] = vector3(-2378.31, -1587.07, 154.3), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house33", 
		['name'] = "House33", 
		['pos'] = vector3(-1412.38, -2671.69, 42.26), 
		['buy'] = vector3(-1410.21, -2675.92, 42.13), 
		['menu'] = vector3(-1412.21, -2671.06, 42.23), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	------------ house34 missing
	{
		['number'] = "house35", 
		['name'] = "House35", 
		['pos'] = vector3(-3956.68, -2126.78, -4.29), 
		['buy'] = vector3(-3959.19, -2132.61, -4.69), 
		['menu'] = vector3(-3959.49, -2124.64, -4.08), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house36", 
		['name'] = "House36", 
		['pos'] = vector3(-4368.31, -2416.64, 20.4), 
		['buy'] = vector3(-4364.11, -2414.88, 20.4), 
		['menu'] = vector3(-4367.36, -2417.35, 20.4), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house37", 
		['name'] = "House37", 
		['pos'] = vector3(-5551.72, -2398.2, -8.74), 
		['buy'] = vector3(-5550.81, -2403.93, -8.92), 
		['menu'] = vector3(-5550.35, -2397.39, -8.75), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{	
		['number'] = "house38", 
		['name'] = "House38", 
		['pos'] = vector3(-3550.85, -3008.65, 11.88), 
		['buy'] = vector3(-3551.53, -3014.15, 11.83), 
		['menu'] = vector3(-3555.61, -3011.7, 11.85), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house39", 
		['name'] = "House39", 
		['pos'] = vector3(-1961.98, 2159.45, 327.55), 
		['buy'] = vector3(-1957.83, 2159.82, 327.0), 
		['menu'] = vector3(-1960.23, 2157.86, 327.58), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house40", 
		['name'] = "House40", 
		['pos'] = vector3(-1491.73, 1248.79, 314.49), 
		['buy'] = vector3(-1496.55, 1246.02, 314.21), 
		['menu'] = vector3(-1489.68, 1250.54, 314.57), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{	
		['number'] = "house41", 
		['name'] = "House41", 
		['pos'] = vector3(3027.04, 1778.16, 84.13), 
		['buy'] = vector3(3024.32, 1774.78, 84.18), 
		['menu'] = vector3(3030.43, 1776.15, 84.14), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house42", 
		['name'] = "House42", 
		['pos'] = vector3(1983.82, 1192.16, 171.4), 
		['buy'] = vector3(1979.75, 1195.76, 171.11), 
		['menu'] = vector3(1984.85, 1197.15, 171.4), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house43", 
		['name'] = "House43", 
		['pos'] = vector3(2717.63, 710.12, 79.55), 
		['buy'] = vector3(2717.4, 706.39, 79.07), 
		['menu'] = vector3(2717.57, 710.46, 79.55), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house44", 
		['name'] = "House44", 
		['pos'] = vector3(2822.25, 277.12, 51.08), 
		['buy'] = vector3(2819.19, 279.97, 50.69), 
		['menu'] = vector3(2822.55, 270.26, 48.1), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house45", 
		['name'] = "House45", 
		['pos'] = vector3(1389.32, -2084.4, 52.57), 
		['buy'] = vector3(1383.79, -2086.02, 52.02), 
		['menu'] = vector3(1388.05, -2087.22, 53.08), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house46", 
		['name'] = "House46", 
		['pos'] = vector3(1319.68, -2282.13, 50.54), 
		['buy'] = vector3(1324.79, -2278.29, 50.55), 
		['menu'] = vector3(1317.71, -2275.29, 50.51), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	------------ house47 missing
	{
		['number'] = "house48", 
		['name'] = "House48", 
		['pos'] = vector3(1700.1, 1511.05, 147.87), 
		['buy'] = vector3(1695.04, 1508.44, 147.8), 
		['menu'] = vector3(1699.75, 1509.19, 147.87), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house49", 
		['name'] = "House49", 
		['pos'] = vector3(-3400.89, -3304.84, -4.44), 
		['buy'] = vector3(-3400.57, -3301.26, -4.44), 
		['menu'] = vector3(-3398.69, -3305.49, -4.44), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house50", 
		['name'] = "House50", 
		['pos'] = vector3(-815.85, 353.63, 98.3), 
		['buy'] = vector3(-818.39, 349.82, 98.28), 
		['menu'] = vector3(-817.18, 357.43, 98.08), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{	
		['number'] = "house51", 
		['name'] = "House51", 
		['pos'] = vector3(2717.55, -1289.78, 60.34), 
		['buy'] = vector3(2711.09, -1293.78, 60.34), 
		['menu'] = vector3(2717.31, -1282.86, 60.34), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house52", 
		['name'] = "House52", 
		['pos'] = vector3(2633.33, -1224.85, 53.58), 
		['buy'] = vector3(2626.15, -1221.19, 53.46), 
		['menu'] = vector3(2639.94, -1224.73, 59.79),
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house53", 
		['name'] = "House53", 
		['pos'] = vector3(2802.7, -1165.93, 48.13), 
		['buy'] = vector3(2804.83, -1163.39, 47.99), 
		['menu'] = vector3(2799.83, -1170.06, 48.13), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
	{
		['number'] = "house54", 
		['name'] = "House54", 
		['pos'] = vector3(2592.56, -1009.0, 44.43), 
		['buy'] = vector3(2597.01, -1008.2, 44.33), 
		['menu'] = vector3(2583.09, -1009.16, 44.44), 
		['price'] = Config.HouseClass2, 
		['owned'] = false
	},
}

Config.DoorList = {

---------- HOUSE1 ----------------
	{
		houseid = { 'house1' },
		doorid = 3598523785,
		objCoords  = vector3(215.66, 987.43, 190.93),
		textCoords  = vector3(215.66, 987.43, 190.93),
		objYaw = -100.0,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house1' },
		doorid = 2031215067,
		objCoords  = vector3(223.48, 990.51, 190.93),
		textCoords  = vector3(223.48, 990.51, 190.93),
		objYaw = -10.0,
		locked = true,
		distance = 1.0
	},
	
---------- HOUSE2 ----------------
	{
		houseid = { 'house2' },
		doorid = 1189146288,
		objCoords  = vector3(-615.74, -27.7, 86.01),
		textCoords  = vector3(-615.74, -27.7, 86.01),
		objYaw = -70.0,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house2' },
		doorid = 906448125,
		objCoords  = vector3(-608.92, -25.96, 86.00),
		textCoords  = vector3(-608.92, -25.96, 86.00),
		objYaw = 110.0,
		locked = true,
		distance = 1.0
	},
	
---------- HOUSE3 ----------------
	
	{
		houseid = { 'house3' },
		doorid = 2821676992,
		objCoords  = vector3(1887.5, 297.93, 77.06),
		textCoords  = vector3(1887.5, 297.93, 77.06),
		objYaw = -180.00,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house3' },
		doorid = 1510914117,
		objCoords  = vector3(1891.11, 301.83, 77.08),
		textCoords  = vector3(1891.11, 301.83, 77.08),
		objYaw = -90.36,
		locked = true,
		distance = 1.0
	},

----------HOUSE4 ----------------
	
	{
		houseid = { 'house4' },
		doorid = 3549587335,
		objCoords  = vector3(1780.91, -89.8, 56.8),
		textCoords  = vector3(1780.91, -89.8, 56.8),
		objYaw = -92.93,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house4' },
		doorid = 3000692149,
		objCoords  = vector3(1781.28, -83.36, 56.8),
		textCoords  = vector3(1781.28, -83.36, 56.8),
		objYaw = -90.36,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house4' },
		doorid = 1928053488,
		objCoords  = vector3(1791.97, -83.9, 56.8),
		textCoords  = vector3(1791.97, -83.9, 56.8),
		objYaw = -93.36,
		locked = true,
		distance = 1.0
	},

----------HOUSE5 ----------------
	
	{
		houseid = { 'house5' },
		doorid = 772977516,
		objCoords  = vector3(1264.9, -404.04, 97.62),
		textCoords  = vector3(1264.9, -404.04, 97.62),
		objYaw = 4.59,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house5' },
		doorid = 527767089,
		objCoords  = vector3(1266.63, -411.98, 97.62),
		textCoords  = vector3(1266.63, -411.98, 97.62),
		objYaw = 90.36,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE6 ----------------
	
	{
		houseid = { 'house6' },
		doorid = 3468185317,
		objCoords  = vector3(1626.57, -366.35, 75.9),
		textCoords  = vector3(1626.57, -366.35, 75.9),
		objYaw = -180.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE7 ----------------
	
	{
		houseid = { 'house7' },
		doorid = 2779142555,
		objCoords  = vector3(-2368.842, -2390.407, 61.52021),
		textCoords  = vector3(-2368.851, -2390.904, 62.517932),
		objYaw = 259.999,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE8 ----------------
	
	{
		houseid = { 'house8' },
		doorid = 1239033969,
		objCoords  = vector3(1114.5, 493.21, 97.31),
		textCoords  = vector3(1114.5, 493.21, 97.31),
		objYaw = -49.89,
		locked = true,
		distance = 1.0
	},

	{
		houseid = { 'house8' },
		doorid = 1597362984,
		objCoords  = vector3(1116.91, 486.42, 97.31),
		textCoords  = vector3(1116.91, 486.42, 97.31),
		objYaw = 40.06,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE9 ----------------
	
	{
		houseid = { 'house9' },
		doorid = 1299456376,
		objCoords  = vector3(-64.02, -394.13, 72.25),
		textCoords  = vector3(-64.02, -394.13, 72.25),
		objYaw = -59.77,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE10 ----------------
	
	{
		houseid = { 'house10' },
		doorid = 2933656395,
		objCoords  = vector3(338.79, -670.41, 42.84),
		textCoords  = vector3(338.79, -670.41, 42.84),
		objYaw = -30.77,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house10' },
		doorid = 3238637478,
		objCoords  = vector3(346.91, -666.41, 42.84),
		textCoords  = vector3(346.91, -666.41, 42.84),
		objYaw = -120.77,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE11 ----------------
	
	{
		houseid = { 'house11' },
		doorid = 3544613794,
		objCoords  = vector3(1112.12, -1297.47, 66.41),
		textCoords  =  vector3(1112.12, -1297.47, 66.41),
		objYaw = 15.0,
		locked = true,
		distance = 1.0
	},

	{
		houseid = { 'house11' },
		doorid = 1485561723,
		objCoords  = vector3(1113.92, -1305.2, 66.44),
		textCoords  = vector3(1113.92, -1305.2, 66.44),
		objYaw = -165.77,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE12 ----------------
	
	{
		houseid = { 'house12' },
		doorid = 1511858696,
		objCoords  = vector3(1365.65, -873.54, 70.16),
		textCoords  =  vector3(1365.65, -873.54, 70.16),
		objYaw = -75.0,
		locked = true,
		distance = 1.0
	},

	{
		houseid = { 'house12' },
		doorid = 1282705079,
		objCoords  = vector3(1375.88, -872.58, 70.16),
		textCoords  = vector3(1375.88, -872.58, 70.16),
		objYaw = 105.00,
		locked = true,
		distance = 1.0
	},

----------HOUSE13 ----------------
	
	{
		houseid = { 'house13' },
		doorid = 2238665296,
		doorid2 = 2080980868,
		objCoords  = vector3(2068.94, -847.4, 43.38),
		textCoords  =  vector3(2068.94, -847.4, 43.38),
		objYaw = -180.0,
		objYaw2 = -180.0,
		locked = true,
		distance = 1.0
	},

	{
		houseid = { 'house13' },
		doorid = 2700347737,
		doorid2 = 2544301759,
		objCoords  = vector3(2065.13, -847.25, 43.38),
		textCoords  = vector3(2065.13, -847.25, 43.38),
		objYaw = -180.0,
		objYaw2 = -180.0,
		locked = true,
		distance = 1.0
	},

	{
		houseid = { 'house13' },
		doorid = 3720952508,
		doorid2 = 350169319,
		objCoords  = vector3(2069.05, -856.06, 43.38),
		textCoords  = vector3(2069.05, -856.06, 43.38),
		objYaw = 0.0,
		objYaw2 = 0.0,
		locked = true,
		distance = 1.0
	},

----------HOUSE14 ----------------
	
	{
		houseid = { 'house14' },
		doorid = 984852093,
		objCoords  = vector3(2253.18, -797.3, 44.2),
		textCoords  =  vector3(2253.18, -797.3, 44.2),
		objYaw = 185.0,
		locked = true,
		distance = 1.0
	},

	{
		houseid = { 'house14' },
		doorid = 3473362722,
		objCoords  = vector3(2257.35, -792.02, 44.2),
		textCoords  = vector3(2257.35, -792.02, 44.2),
		objYaw = 90.0,
		locked = true,
		distance = 1.0
	},

	{
		houseid = { 'house14' },
		doorid = 686097120,
		objCoords  = vector3(2258.08, -786.01, 44.2),
		textCoords  = vector3(2258.08, -786.01, 44.2),
		objYaw = 85.0,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house14' },
		doorid = 3107660458,
		doorid2 = 3419719645,
		objCoords  = vector3(2253.47, -781.55, 44.2),
		textCoords  = vector3(2253.47, -781.55, 44.2),
		objYaw = 179.0,
		objYaw2 = 180.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE16 ----------------
	
	{
		houseid = { 'house16' },
		doorid = 3945582303,
		objCoords  = vector3(2370.32, -857.7, 43.04),
		textCoords  =  vector3(2370.32, -857.7, 43.04),
		objYaw = -160.0,
		locked = true,
		distance = 1.0
	},

	{
		houseid = { 'house16' },
		doorid = 862008394,
		objCoords  = vector3(2371.45, -864.19, 43.04),
		textCoords  = vector3(2371.45, -864.19, 43.04),
		objYaw = 20.00,
		locked = true,
		distance = 1.0
	},

----------HOUSE17 ----------------
	
	{
		houseid = { 'house17' },
		doorid = 1661737397,
		objCoords  = vector3(1708.88, -1003.32, 43.48),
		textCoords  =  vector3(1708.88, -1003.32, 43.48),
		objYaw = 140.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE19 ----------------
	
	{
		houseid = { 'house19' },
		doorid = 1574473390,
		objCoords  = vector3(2627.97, 1693.69, 115.7),
		textCoords  =  vector3(2627.97, 1693.69, 115.7),
		objYaw = -105.0,
		locked = true,
		distance = 1.0
	},

----------HOUSE20 ----------------
	
	{
		houseid = { 'house20' },
		doorid = 3731688048,
		objCoords  = vector3(2993.58, 2189.13, 166.76),
		textCoords  =  vector3(2993.58, 2189.13, 166.76),
		objYaw = 70.0,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house20' },
		doorid = 344028824,
		objCoords  = vector3(2988.94, 2193.05, 166.76),
		textCoords  = vector3(2988.94, 2193.05, 166.76),
		objYaw = -110.0,
		locked = true,
		distance = 1.0
	},

----------HOUSE21 ----------------
	
	{
		houseid = { 'house21' },
		doorid = 2652873387,
		objCoords  = vector3(2473.42, 1996.92, 168.28),
		textCoords  =  vector3(2473.42, 1996.92, 168.28),
		objYaw = 135.0,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house21' },
		doorid = 2061942857,
		objCoords  = vector3(2473.04, 2002.19, 168.28),
		textCoords  = vector3(2473.04, 2002.19, 168.28),
		objYaw = 45.0,
		locked = true,
		distance = 1.0
	},	

----------HOUSE22 ----------------
	--[[
	{
		houseid = { 'house22' },
		doorid = 1416977006,
		doorid2 = 1731133409,
		objCoords  = vector3(2517.24, 2289.43, 177.35),
		textCoords  =  vector3(2517.24, 2289.43, 177.35),
		objYaw = -198.0,
		objYaw2 = -198.0,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house22' },
		doorid = 1446885586,
		doorid2 = 1208032345,
		objCoords  = vector3(2524.84, 2282.34, 177.35),
		textCoords  = vector3(2524.84, 2282.34, 177.35),
		objYaw = 73.0,
		objYaw2 = 73.0,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house22' },
		doorid = 3772438949,
		doorid2 = 4067196104,
		objCoords  = vector3(2514.34, 2280.85, 177.35),
		textCoords  = vector3(2514.34, 2280.85, 177.35),
		objYaw = -17.0,
		objYaw2 = -18.0,
		locked = true,
		distance = 1.0
	},
	--]]

----------HOUSE23 ----------------

	--[[{
		houseid = { '123' },
		object = 1981171235,
		objCoords  = vector3(1932.91, 1949.01, 266.13),
		textCoords = vector3(1932.91, 1949.01, 266.13),
		objYaw = -175.0,
		locked = true,
		distance = 1.0
	},--]]
	
----------HOUSE24 ----------------

	{
		houseid = { 'house24' },
		doorid = 3702071668,
		objCoords  = vector3(-421.98, 1733.76, 216.58),
		textCoords =  vector3(-421.98, 1733.76, 216.58),
		objYaw = 30.0,
		locked = true,
		distance = 1.0
	},

----------HOUSE25 ----------------
	{
		houseid = { 'house25' },
		doorid = 1934463007,
		objCoords  = vector3(899.66, 265.24, 116.05),
		textCoords =  vector3(899.66, 265.24, 116.05),
		objYaw = -180.0,
		locked = true,
		distance = 1.0
	},

----------HOUSE26 ----------------

	{
		houseid = { 'housse26' },
		doorid = 2183007198,
		objCoords  = vector3(-1347.74, 2435.87, 308.41),
		textCoords =  vector3(-1347.74, 2435.87, 308.41),
		objYaw = 75.0,
		locked = true,
		distance = 1.0
	},
						{
		houseid = { 'house26' },
		doorid = 4288310487,
		objCoords  = vector3(-1347.74, 2435.87, 308.41),
		textCoords =  vector3(-1348.94, 2447.32, 308.41),
		objYaw = 160.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE27 ----------------

	{
		houseid = { 'house27' },
		doorid = 872775928,
		objCoords  = vector3(-557.01, 2699.24, 320.48),
		textCoords = vector3(-557.01, 2699.24, 320.48),
		objYaw = 147.0,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house27' },
		doorid = 2385374047,
		objCoords  = vector3(-558.27, 2708.4, 320.42),
		textCoords = vector3(-558.27, 2708.4, 320.42),
		objYaw = -120.0,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house27' },
		doorid = 2051127971,
		objCoords  = vector3(-540.40,2675.38, 359.93),
		textCoords = vector3(-533.99, 2675.26, 319.24),
		objYaw = -180,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE28 ----------------
	
	{
		houseid = { 'house28' },
		doorid = 3167436574,
		objCoords  = vector3(-1019.73, 1688.1, 244.33),
		textCoords = vector3(-1019.73, 1688.1, 244.33),
		objYaw = -155.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE29 ----------------
	{
		houseid = { 'house29' },
		doorid = 1195519038,
		objCoords  = vector3(-1815.75, 654.61, 131.86),
		textCoords = vector3(-1815.75, 654.61, 131.86),
		objYaw = -150.0,
		locked = true,
		distance = 1.0
	},

----------HOUSE30 ----------------
	
	{
		houseid = { 'house30' },
		doorid = 2212914984,
		objCoords  = vector3(-2182.22, 715.85, 122.62),
		textCoords = vector3(-2182.22, 715.85, 122.62),
		objYaw = -65.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE31 ----------------

	{
		houseid = { 'house31' },
		doorid = 562830153,
		objCoords  = vector3(-2575.87, -1380.3, 149.25),
		textCoords = vector3(-2575.87, -1380.3, 149.25),
		objYaw = 90.0,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house31' },
		doorid = 663425326,
		objCoords  = vector3(-2579.7, -1385.28, 149.3),
		textCoords = vector3(-2579.7, -1385.28, 149.3),
		objYaw = 177.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE32 ----------------

	{
		houseid = { 'house32' },
		doorid = 1171581101,
		objCoords  = vector3(-2373.97, -1592.05, 154.3),
		textCoords = vector3(-2373.97, -1592.05, 154.3),
		objYaw = 52.0,
		locked = true,
		distance = 1.0
	},

----------HOUSE33 ----------------
	
	{
		houseid = { 'house33' },
		doorid = 52014802,
		objCoords  = vector3(-1411.18, -2674.49, 42.19),
		textCoords = vector3(-1411.18, -2674.49, 42.19),
		objYaw = -155.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE35 ----------------

	{
		houseid = { 'house35' },
		doorid = 4164042403,
		objCoords  = vector3(-3957.95, -2129.93, -4.23),
		textCoords = vector3(-3957.95, -2129.93, -4.23),
		objYaw = -45.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE36 ----------------
	
	{
		houseid = { 'house36' },
		doorid = 2047072501,
		objCoords  = vector3(-4366.35, -2415.68, 20.42),
		textCoords = vector3(-4366.35, -2415.68, 20.42),
		objYaw = 105.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE37 ----------------
	
	{
		houseid = { 'house37' },
		doorid = 2715667864,
		objCoords  = vector3(-5551.53, -2401.28, -8.71),
		textCoords = vector3(-5551.53, -2401.28, -8.71),
		objYaw = 20.0,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house37' },
		doorid = 1263476860,
		objCoords  = vector3(-5555.27, -2397.36, -9.72),
		textCoords = vector3(-5555.27, -2397.36, -9.72+1.0),
		objYaw = -160.1,
		locked = true,
		distance = 1.0
	},

----------HOUSE38 ----------------
	
	{
		houseid = { 'house38' },
		doorid = 1894337720,
		objCoords  = vector3(-3551.69, -3012.02, 11.88),
		textCoords =  vector3(-3551.69, -3012.02, 11.88),
		objYaw = 12.0,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house38' },
		doorid = 120764251,
		objCoords  = vector3(-3554.75, -3007.8, 11.88),
		textCoords =  vector3(-3554.75, -3007.8, 11.88),
		objYaw = 12.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE39 ----------------
	
	{
		houseid = { 'house39' },
		doorid = 943176298,
		objCoords  = vector3(-1959.11, 2159.51, 327.57),
		textCoords =  vector3(-1959.11, 2159.51, 327.57),
		objYaw = -90.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE40 ----------------
	
	{
		houseid = { 'house40' },
		doorid = 2971757040,
		objCoords  = vector3(-1494.57, 1247.48, 314.54),
		textCoords =  vector3(-1494.57, 1247.48, 314.54),
		objYaw = 110.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE41 ----------------
	
	{
		houseid = { 'house41' },
		doorid = 1973911195,
		objCoords  = vector3(3024.73, 1776.72, 84.18),
		textCoords = vector3(3024.73, 1776.72, 84.18),
		objYaw = -21.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE42 ----------------
	
	{
		houseid = { 'house42' },
		doorid = 784290387,
		objCoords  = vector3(1981.57, 1194.53, 171.4),
		textCoords = vector3(1981.57, 1194.53, 171.4),
		objYaw = -125.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE43 ----------------
	
	{
		houseid = { 'house43' },
		doorid = 843137708,
		objCoords  = vector3(2717.54, 708.19, 79.54),
		textCoords = vector3(2717.54, 708.19, 79.54),
		objYaw = 0.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE44 ----------------
	
	{
		houseid = { 'house44' },
		doorid = 4275653891,
		objCoords  = vector3(2824.95, 271.41, 48.12),
		textCoords = vector3(2824.95, 271.41, 48.12),
		objYaw = 45.0,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house44' },
		doorid = 1431398235,
		objCoords  = vector3(2820.11, 278.41, 51.09),
		textCoords = vector3(2820.11, 278.41, 51.09),
		objYaw = 225.0,
		locked = true,
		distance = 1.0
	},

----------HOUSE45 ----------------
	
	{
		houseid = { 'house45' },
		doorid = 896012811,
		objCoords  = vector3(1386.69, -2077.74, 52.58),
		textCoords = vector3(1386.69, -2077.74, 52.58),
		objYaw = -160.0,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house45' },
		doorid = 2813949612,
		objCoords  = vector3(1385.3, -2085.83, 52.58),
		textCoords = vector3(1385.3, -2085.83, 52.58),
		objYaw = -69.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE46 ----------------
	
	{
		houseid = { 'house46' },
		doorid = 3184160386,
		objCoords  = vector3(1322.83, -2279.99, 50.53),
		textCoords = vector3(1322.83, -2279.99, 50.53),
		objYaw = -55.0,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house46' },
		doorid = 3202958073,
		objCoords  = vector3(1316.19, -2284.32, 50.53),
		textCoords = vector3(1316.19, -2284.32, 50.53),
		objYaw = 125.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE48 ----------------
	
	{
		houseid = { 'house48' },
		doorid = 868379185,
		objCoords  = vector3(1697.3, 1508.92, 147.88),
		textCoords = vector3(1697.3, 1508.92, 147.88),
		objYaw = 99.0,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house48' },
		doorid = 640077562,
		objCoords  = vector3(1702.14, 1514.22, 147.88),
		textCoords = vector3(1702.14, 1514.22, 147.88),
		objYaw = -170.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE49 ----------------
	
	{
		houseid = { 'house49' },
		doorid = 3045682143,
		objCoords  = vector3(-3400.713, -3302.24, -4.4),
		textCoords = vector3(-3400.713, -3302.24, -4.4),
		objYaw = 179.0,
		locked = true,
		distance = 1.0
	},

----------HOUSE50 ----------------
	
	{
	houseid = { 'house50' },
		doorid = 1915887592,
		objCoords  = vector3(-818.07, 351.23, 98.0),
		textCoords = vector3(-818.07, 351.23, 98.3),
		objYaw = -10.0,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house50' },
		doorid = 3324299212,
		objCoords  = vector3(-819.79, 358.61, 98.0),
		textCoords = vector3(-819.79, 358.61, 98.3),
		objYaw = 170.0,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE51----------------
	
	{
		houseid = { 'house51' },
		doorid = 1180868565,
		objCoords  = vector3(2711.9, -1293.9, 60.46),
		textCoords = vector3(2711.9, -1293.9, 60.46),
		objYaw = -64.6,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE52----------------
	
	{
		houseid = { 'house52' },
		doorid = 3895438792,
		objCoords  = vector3(2627.74, -1221.86, 52.39),
		textCoords = vector3(2627.74, -1221.86, 52.69),
		objYaw = 45.05,
		locked = false,
		distance = 1.0
	},
	
	{
		houseid = { 'house52' },
		doorid = 804086151,
		objCoords  = vector3(2629.29, -1220.3, 52.39),
		textCoords = vector3(2629.29, -1220.3, 52.69),
		objYaw = 224.64,
		locked = false,
		distance = 1.0
	},
	
	{
		houseid = { 'house52' },
		doorid = 1555588463,
		objCoords  = vector3(2634.68, -1225.03, 58.59),
		textCoords = vector3(2634.68, -1225.03, 58.79),
		objYaw = 89.7,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE53----------------

	{
		houseid = { 'house53' },
		doorid = 2653589767,
		objCoords  = vector3(2793.11, -1173.75, 46.92),
		textCoords = vector3(2793.11, -1173.75, 48.5),
		objYaw = 329.25,
		locked = false,
		distance = 1.0
	},
	
	{
		houseid = { 'house53' },
		doorid = 2960930218,
		objCoords  = vector3(2794.29, -1174.44, 46.92),
		textCoords = vector3(2794.29, -1174.44, 48.5),
		objYaw = 150.0,
		locked = false,
		distance = 1.0
	},
	
	{
		houseid = { 'house53' },
		doorid = 4220752030,
		objCoords  = vector3(2803.27, -1163.53, 46.93),
		textCoords = vector3(2803.27, -1163.53, 48.5),
		objYaw = 329.69,
		locked = true,
		distance = 1.0
	},
	
----------HOUSE54----------------
						
	{
		houseid = { 'house54' },
		doorid = 3052936071,
		objCoords  = vector3(2595.18, -1007.49, 43.25),
		textCoords = vector3(2595.18, -1007.49, 44.25),
		objYaw = 280.26,
		locked = true,
		distance = 1.0
	},
	
	{
		houseid = { 'house54' },
		doorid = 404931123,
		objCoords  = vector3(2595.49, -1009.25, 43.25),
		textCoords = vector3(2595.49, -1009.25, 44.25),
		objYaw = 99.93,
		locked = true,
		distance = 1.0
	},
	
----------------------------------

}