Config = {}

Config.Products = {
    ["normal"] = {
        [1] = { name = "water_bottle", 					price = 2, 	amount = 50, info = {}, type = "item", slot = 1, },
        [2] = { name = "bread", 						price = 2, 	amount = 50, info = {}, type = "item", slot = 2, },
        [3] = { name = "apple", 						price = 1, 	amount = 50, info = {}, type = "item", slot = 3, },
        [4] = { name = "chocolate", 					price = 2, 	amount = 50, info = {}, type = "item", slot = 4, },
		[5] = { name = "shovel", 						price = 10, amount = 50, info = {}, type = "item", slot = 5, },
		[6] = { name = "weapon_kit_metal_detector", 	price = 50, amount = 50, info = {}, type = "item", slot = 6, },
    },
    ["saloon"] = {
        [1] = { name = "beer",		price = 7, 	amount = 50, 	info = {}, type = "item", slot = 1, },
        [2] = { name = "whiskey",	price = 10, amount = 50, 	info = {}, type = "item", slot = 2, },
        [3] = { name = "vodka",		price = 12, amount = 50, 	info = {}, type = "item", slot = 3, },
        [4] = { name = "coffee",	price = 5, 	amount = 500, 	info = {}, type = "item", slot = 4, },
    },
    ["weapons"] = {
        [1] = { name = "weapon_revolver_cattleman", price = 250, 	amount = 250, info = {}, type = "item", slot = 1, },
        [2] = { name = "ammo_revolver", 			price = 15, 	amount = 250, info = {}, type = "item", slot = 2, }, 
	},
}

Config.Locations = {
    --Example--
    -- {name = 'unique name', products = "product mix", coords = vector3, showblip = T/F}
    {name = 'Rhodes General Store',         products = "normal",    coords = vector3(1328.99, -1293.28, 77.02),     showblip = true},
    {name = 'Valentine General Store',      products = "normal",    coords = vector3(-322.433, 803.797, 117.882),   showblip = true},
    {name = 'Strawberry General Store',     products = "normal",    coords = vector3(-1791.49, -386.87, 160.33),    showblip = true},
    {name = 'Annesburg General Store',      products = "normal",    coords = vector3(2931.35, 1365.94, 45.19),      showblip = true},
    {name = 'Saint Denis General Store',    products = "normal",    coords = vector3(2859.81, -1200.37, 49.59),     showblip = true},
    {name = 'Tumbleweed General Store',     products = "normal",    coords = vector3(-5487.613, -2938.54, -0.38),   showblip = true},
    {name = 'Armadillo General Store',      products = "normal",    coords = vector3(-3685.56, -2622.59, -13.43),   showblip = true},
    {name = 'Blackwater General Store',     products = "normal",    coords = vector3(-785.18, -1323.83, 43.88),     showblip = true},
    {name = 'Van Horn General Store',       products = "normal",    coords = vector3(3027.03, 561.00, 44.72),       showblip = true},
    {name = 'Valentine Gunsmith',           products = "weapons",   coords = vector3(-281.97, 781.09,119.52),       showblip = true},
    {name = 'Tumbleweed Gunsmith',          products = "weapons",   coords = vector3(-5508.14, -2964.33,-0.628),    showblip = true},
    {name = 'Saint Denis Gunsmith',         products = "weapons",   coords = vector3(2716.42, -1285.42,49.63),      showblip = true},
    {name = 'Rhodes Gunsmith',              products = "weapons",   coords = vector3(1322.67, -1323.16,77.88),      showblip = true},
    {name = 'Annesburg Gunsmith',           products = "weapons",   coords = vector3(2946.50, 1319.53,44.82),       showblip = true},
    {name = 'Valentine Saloon',             products = "saloon",    coords = vector3(-313.26, 805.22, 118.98),      showblip = true},
    {name = 'Tumbleweed Saloon',            products = "saloon",    coords = vector3(-5518.35, -2906.43, -1.75),    showblip = true},
    {name = 'Armadillo Saloon',             products = "saloon",    coords = vector3(-3699.74, -2594.51, -13.31),   showblip = true},
    {name = 'Blackwater Saloon ',           products = "saloon",    coords = vector3(-817.66, -1319.43, 43.67),     showblip = true},
    {name = 'Rhodes Saloon',                products = "saloon",    coords = vector3(1340.14, -1374.99, 80.48),     showblip = true},
    {name = 'Saint Denis Saloon',           products = "saloon",    coords = vector3(2792.55, -1168.14, 47.93),     showblip = true},
    {name = 'Van Horn Saloon',              products = "saloon",    coords = vector3(2947.58, 528.07, 45.33),       showblip = true},
}
