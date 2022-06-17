Config = {}

Config.TimeToGrow = 1800 -- 1800 = 30 mins / testing 60 = 60 seconds

-- farm shop
Config.FarmShop = {
		[1] = {	name = "carrotseed",		price = 0.10,	amount = 500,	info = {},	type = "item",	slot = 1, },
        [2] = {	name = "cornseed",			price = 0.10,	amount = 500,	info = {},	type = "item",	slot = 2, },
		[3] = {	name = "sugarseed",			price = 0.10,	amount = 500,	info = {},	type = "item",	slot = 3, },
		[4] = {	name = "tobaccoseed",		price = 0.10,	amount = 500,	info = {},	type = "item",	slot = 4, },
		[5] = {	name = "tomatoseed",		price = 0.10,	amount = 500,	info = {},	type = "item",	slot = 5, },
		[6] = {	name = "wateringcan",		price = 10,		amount = 50,	info = {},	type = "item",	slot = 6, },
		[7] = {	name = "plant_nutrition",	price = 0.10,	amount = 5000,	info = {},	type = "item",	slot = 7, },
}

-- farm shop locations
Config.FarmShopLocations = {
	{name = 'Farm Shop', coords = vector3(-260.8685, 657.85388, 113.35163), showblip = true},
}

-- farm shop npc
Config.FarmNpc = {
	[1] = { ["Model"] = "A_M_M_ValFarmer_01", ["Pos"] = vector3(-260.8764, 657.46795, 113.35352 -1), ["Heading"] = 88.162658 }, -- farmer market valentine
}

Config.FarmZone = {
    [1] = {
        zones = { -- farmzone1
			vector2(-866.50738525391, 379.50839233398),
			vector2(-895.23333740234, 316.94226074219),
			vector2(-785.49139404297, 309.60153198242),
			vector2(-783.16119384766, 376.96636962891)
        },
		name = "farmzone1",
		minZ = 94.61107635498,
		maxZ = 96.225868225098
    },
    [2] = {
        zones = { -- farmzone2
			vector2(-416.44311523438, 877.68499755859),
			vector2(-340.73004150391, 882.06268310547),
			vector2(-327.01953125, 949.17590332031),
			vector2(-419.45263671875, 948.95648193359)
        },
		name = "farmzone2",
		minZ = 115.60678100586,
		maxZ = 125.75849914551
    },
    [3] = {
        zones = { -- farmzone3
			vector2(867.71990966797, 830.55853271484),
			vector2(827.24829101562, 978.51281738281),
			vector2(776.88360595703, 942.62603759766),
			vector2(722.10461425781, 843.55340576172),
			vector2(762.76971435547, 831.14996337891)
        },
		name = "farmzone3",
		minZ = 116.7624130249,
		maxZ = 121.97254180908
    },
    [4] = {
        zones = { -- farmzone4
			vector2(1057.3891601562, -1813.7116699219),
			vector2(1037.1082763672, -1936.9809570312),
			vector2(993.06481933594, -1935.6380615234),
			vector2(993.91253662109, -1889.6791992188),
			vector2(938.37463378906, -1889.8885498047),
			vector2(948.02667236328, -1807.7596435547)
        },
		name = "farmzone4",
		minZ = 44.672874450684,
		maxZ = 48.551219940186
    },
    [5] = {
        zones = { -- farmzone5 (gang house 2)
			vector2(-636.91583251953, -8.6817226409912),
			vector2(-642.67010498047, -87.87540435791),
			vector2(-562.67651367188, -59.754615783691),
			vector2(-607.54565429688, 14.365551948547)
        },
		name = "farmzone5",
		minZ = 80.278839111328,
		maxZ = 87.275184631348
    },
    [6] = {
        zones = { -- farmzone6 (braithwaite manore1)
			vector2(1110.6455078125, -1526.8820800781),
			vector2(1115.7180175781, -1485.7622070312),
			vector2(1035.0233154297, -1485.4185791016),
			vector2(1035.2568359375, -1525.4301757812)
        },
		name = "farmzone6",
		minZ = 49.336120605469,
		maxZ = 54.163547515869
    },
    [7] = {
        zones = { -- farmzone7 (braithwaite manore2)
			vector2(984.42602539062, -1528.4190673828),
			vector2(987.48181152344, -1391.3273925781),
			vector2(893.71978759766, -1391.5571289062),
			vector2(890.68676757812, -1444.1700439453),
			vector2(876.08648681641, -1455.8475341797),
			vector2(877.49755859375, -1531.7303466797)
        },
		name = "farmzone7",
		minZ = 48.134201049805,
		maxZ = 58.746471405029
    },
}