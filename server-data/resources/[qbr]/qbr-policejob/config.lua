Config = {}

Config.ShowBlips = true

Config.Objects = {
    ["cone"] = {model = `prop_roadcone02a`, freeze = false},
    ["barrier"] = {model = `prop_barrier_work06a`, freeze = true},
    ["roadsign"] = {model = `prop_snow_sign_road_06g`, freeze = true},
    ["tent"] = {model = `prop_gazebo_03`, freeze = true},
    ["light"] = {model = `prop_worklight_03b`, freeze = true},
}

Config.MaxSpikes = 5

Config.HandCuffItem = 'handcuffs'

Config.LicenseRank = 2

Config.Locations = {
    ["duty"] = {
        [1] = vector3(1362.05, -1301.83, 77.77),
        [2] = vector3(2507.53, -1301.41, 48.95),
        [3] = vector3(-768.03, -1266.37, 44.05),
        [4] = vector3(-1812.03, -354.09, 164.65),
        
    },
    ["stash"] = {
        [1] = vector3(1359.24, -1299.65, 77.76),
        [2] = vector3(2497.01, -1301.2, 48.96),
        [3] = vector3(-766.55, -1271.61, 44.05),
        [4] = vector3(-1812.43, -355.87, 164.65)
    },
    ["armory"] = {
        [1] = vector3(1361.16, -1305.7, 77.76),
        [2] = vector3(2494.53, -1304.32, 48.95),
        [3] = vector3(-764.86, -1272.4, 44.04),
        [4] = vector3(-1814.01, -354.93, 164.65),
    },
    ["evidence"] = {
        [1] = vector3(1361.39, -1303.77, 77.77),
        [2] = vector3(2494.44, -1313.39, 48.95),
        [3] = vector3(-761.98, -1272.62, 44.05),
        [4] = vector3(-1812.43, -355.87, 164.65)
    },
    ["stations"] = {
        [1] = {label = "Sheriff", coords = vector3(1360.88, -1301.53, 77.77)},
        [2] = {label = "Saint Denis Police Dept. HQ", coords = vector3(2501.83, -1309.04, 48.95)},
        [3] = {label = "Blackwater Police Dept.", coords = vector3(-760.47, -1269.14, 44.04)},
        [4] = {label = "Strawberry Sheriff", coords = vector3(-1810.57, -350.91, 164.66)}
    },
}

Config.WeaponHashes = {}

Config.ArmoryWhitelist = {}
Config.WhitelistedVehicles = {}

Config.Items = {
    label = "Police Armory",
    slots = 30,
    items = {
        {
            name = "weapon_revolver_cattleman",
            price = 0,
            amount = 1,
            info = {
                serie = "",
            },
            type = "weapon",
            slot = 1,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "weapon_repeater_winchester",
            price = 0,
            amount = 1,
            info = {
                serie = "",
            },
            type = "weapon",
            slot = 2,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "weapon_melee_lantern",
            price = 0,
            amount = 1,
            info = {},
            type = "weapon",
            slot = 3,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "weapon_lasso",
            price = 0,
            amount = 1,
            info = {},
            type = "item",
            slot = 4,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "ammo_revolver",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 5,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
        {
            name = "ammo_repeater",
            price = 0,
            amount = 5,
            info = {},
            type = "item",
            slot = 6,
            authorizedJobGrades = {0, 1, 2, 3, 4}
        },
    }
}
