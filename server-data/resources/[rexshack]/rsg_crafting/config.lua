Config = {}

Config.BPOCopyTime = 30000

------------------------------
Config.ShovelCopyCost = 1
Config.ShovelRepRequired = 0
------------------------------
Config.PickaxeCopyCost = 1
Config.PickaxeRepRequired = 0
------------------------------
Config.AxeCopyCost = 1
Config.AxeRepRequired = 0
------------------------------
Config.KnifeCopyCost = 1
Config.KnifeRepRequired = 30
------------------------------
Config.MoonshineKitCopyCost = 1
Config.MoonshineKitRepRequired = 100
------------------------------

-- blueprint original shop items
Config.InvensionShop = {
	[1] = 	{ name = "bposhovel",		price = 500, amount = 1, info = {}, type = "item", slot = 1, }, -- crafting level 0
	[2] = 	{ name = "bpopickaxe",		price = 500, amount = 1, info = {}, type = "item", slot = 2, }, -- crafting level 0
	[3] = 	{ name = "bpoaxe",			price = 500, amount = 1, info = {}, type = "item", slot = 3, }, -- crafting level 0
	[4] = 	{ name = "bpoknife",		price = 750, amount = 1, info = {}, type = "item", slot = 4, }, -- crafting level 30
	[5] = 	{ name = "bpomoonshinekit",	price = 1000, amount = 1, info = {}, type = "item", slot = 5, }, -- crafting level 100
}

-- blueprint original shope locations
Config.InvensionShopLocations = {
	{name = 'Invension Shop', coords = vector3(2516.7561, 2285.0756, 177.35156),	showblip = true},
}

-- blueprint original shop npc
Config.CraftingNpc = {
	[1] = { ["Model"] = "CS_crackpotRobot", ["Pos"] = vector3(2516.7561, 2285.0756, 177.35156 -1), ["Heading"] = 246.71557 }, -- robot
}