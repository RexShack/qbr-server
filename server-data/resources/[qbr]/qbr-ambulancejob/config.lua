Config = {}

Config.MinimalDoctors = 2
Config.WipeInventoryOnRespawn = false
Config.DispatchTimer = 180 --DispatchTimer*4
Config.PromptKey = 0xE30CD707 -- R
Config.BillCost = 10
Config.DeathTime = 300
Config.CheckTime = 10
Config.PainkillerInterval = 60

Config.Locations = {
    ["checking"] = {
	    [1] = vector3(-286.28, 804.77, 119.3), -- Valentine
    },
    ["duty"] = {
        [1] = vector3(-284.49, 807.49, 119.38), -- Valentine
        [2] = vector3(2385.24, -1374.19, 46.55), -- Saint Denis
        [3] = vector3(-3650.37, -2645.63, -13.45), -- Armadillo
    },
    ["vehicle"] = {
        [1] = vector4(-387.12, 775.3, 115.79, 189.93), -- Valentine Stable
        [2] = vector4(2396.21, -1350.28, 45.74, 118.78), -- Saint Denis
        [3] = vector4(-3666.87, -2643.86, -13.75, 280.63), -- Armadillo
    },
    ["armory"] = {
        [1] = vector3(-289.913, 816.26, 119.38), -- Valentine
        [2] = vector3(2382.31, -1372.55, 46.55), -- Saint Denis
        [3] = vector3(-3651.38, -2653.74, -13.45), -- Armadillo
    },
    ["stash"] = {
        [1] = vector3(-288.79, 808.83, 119.38), -- Valentine
        [2] = vector3(2378.21, -1370.32, 45.82), -- Saint Denis
        [3] = vector3(-3648.06, -2647.18, -13.46), -- Armadillo
    },
    ["beds"] = {
        [1] = {coords = vector4(-282.19, 814.46, 118.9, 96.10), taken = false, model = -2121768533}, -- Valentine 1
        [2] = {coords = vector4(-284.01, 813.39, 118.9, 5.67), taken = false, model = -2121768533}, -- Valentine 2
        [3] = {coords = vector4(2392.70, -1373.21, 45.45, 65.5), taken = false, model = 158978}, -- Saint Denis 1 /stream/SaintDenis.ymap
        [4] = {coords = vector4(2390.11, -1377.52, 45.45, 65.5), taken = false, model = 158978}, -- Saint Denis 2 /stream/SaintDenis.ymap
        [5] = {coords = vector4(-3655.04, -2645.26, -14.46, -94.0), taken = false, model = 247554}, -- Armadillo Custom Dotcors Office /stream/Armadillo.ymap
        [6] = {coords = vector4(-3654.89, -2650.54, -14.46, -94.0), taken = false, model = 247554}, -- Armadillo Custom Dotcors Office /stream/Armadillo.ymap
    },
    ["stations"] = {
        [1] = {label = Lang:t('info.v_hospital'), coords = vector4(-284.49, 807.49, 119.38, 104.89)}, -- Valentine
        [2] = {label = Lang:t('info.sd_hospital'), coords = vector4(2387.306, -1369.280, 46.541, 242.542)}, -- Saint Denis
        [3] = {label = Lang:t('info.a_hospital'), coords = vector4(-3651.82, -2649.4, -13.45, 99.22)}, -- Armadillo
    }
}

Config.AuthorizedVehicles = {
	-- Grade 0
	[0] = {
		["CHUCKWAGON000X"] = "Chuckwagon",
	},
	-- Grade 1
	[1] = {
		["CHUCKWAGON000X"] = "Chuckwagon",

	},
	-- Grade 2
	[2] = {
		["CHUCKWAGON000X"] = "Chuckwagon",
	},
	-- Grade 3
	[3] = {
		["CHUCKWAGON000X"] = "Chuckwagon",
	},
	-- Grade 4
	[4] = {
		["CHUCKWAGON000X"] = "Chuckwagon",
	}
}

Config.Items = {
    label = Lang:t('info.safe'),
    slots = 10,
    items = {
        [1] = {
            name = "bandage",
            price = 0,
            amount = 20,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "painkillers",
            price = 0,
            amount = 10,
            info = {},
            type = "item",
            slot = 2,
        },
        [3] = {
            name = "firstaid",
            price = 0,
            amount = 10,
            info = {},
            type = "item",
            slot = 3,
        },
    }
}

--[[
    GENERAL SETTINGS | THESE WILL AFFECT YOUR ENTIRE SERVER SO BE SURE TO SET THESE CORRECTLY
    MaxHp : Maximum HP Allowed, set to -1 if you want to disable mythic_hospital from setting this
        NOTE: Anything under 100 and you are dead
    RegenRate :
]]
Config.MaxHp = 200
Config.RegenRate = 0.0

--[[
    HealthDamage : How Much Damage To Direct HP Must Be Applied Before Checks For Damage Happens
    ArmorDamage : How Much Damage To Armor Must Be Applied Before Checks For Damage Happens | NOTE: This will in turn make stagger effect with armor happen only after that damage occurs
]]
Config.HealthDamage = 5
Config.ArmorDamage = 5

--[[
    MaxInjuryChanceMulti : How many times the HealthDamage value above can divide into damage taken before damage is forced to be applied
    ForceInjury : Maximum amount of damage a player can take before limb damage & effects are forced to occur
]]
Config.MaxInjuryChanceMulti = 3
Config.ForceInjury = 35
Config.AlwaysBleedChance = 70

--[[
    Message Timer : How long it will take to display limb/bleed message
]]
Config.MessageTimer = 12

--[[
    AIHealTimer : How long it will take to be healed after checking in, in seconds
]]
Config.AIHealTimer = 20

--[[
    BleedTickRate : How much time, in seconds, between bleed ticks
]]
Config.BleedTickRate = 30

--[[
    BleedMovementTick : How many seconds is taken away from the bleed tick rate if the player is walking, jogging, or sprinting
    BleedMovementAdvance : How Much Time Moving While Bleeding Adds (This Adds This Value To The Tick Count, Meaing The Above BleedTickRate Will Be Reached Faster)
]]
Config.BleedMovementTick = 10
Config.BleedMovementAdvance = 3

--[[
    The Base Damage That Is Multiplied By Bleed Level Every Time A Bleed Tick Occurs
]]
Config.BleedTickDamage = 8

--[[
    FadeOutTimer : How many bleed ticks occur before fadeout happens
    BlackoutTimer : How many bleed ticks occur before blacking out
    AdvanceBleedTimer : How many bleed ticks occur before bleed level increases
]]
Config.FadeOutTimer = 2
Config.BlackoutTimer = 10
Config.AdvanceBleedTimer = 10

--[[
    HeadInjuryTimer : How much time, in seconds, do head injury effects chance occur
    ArmInjuryTimer : How much time, in seconds, do arm injury effects chance occur
    LegInjuryTimer : How much time, in seconds, do leg injury effects chance occur
]]
Config.HeadInjuryTimer = 30
Config.ArmInjuryTimer = 30
Config.LegInjuryTimer = 15

--[[
    The Chance, In Percent, That Certain Injury Side-Effects Get Applied
]]
Config.HeadInjuryChance = 25
Config.ArmInjuryChance = 25
Config.LegInjuryChance = {
    Running = 50,
    Walking = 15
}

--[[
    MajorArmoredBleedChance : The % Chance Someone Gets A Bleed Effect Applied When Taking Major Damage With Armor
    MajorDoubleBleed : % Chance You Have To Receive Double Bleed Effect From Major Damage, This % is halved if the player has armor
]]
Config.MajorArmoredBleedChance = 45

--[[
    DamgeMinorToMajor : How much damage would have to be applied for a minor weapon to be considered a major damage event. Put this at 100 if you want to disable it
]]
Config.DamageMinorToMajor = 35

--[[
    AlertShowInfo :
]]
Config.AlertShowInfo = 2

--[[
    These following lists uses tables defined in definitions.lua, you can technically use the hardcoded values but for sake
    of ensuring future updates doesn't break it I'd highly suggest you check that file for the index you're wanting to use.

    MinorInjurWeapons : Damage From These Weapons Will Apply Only Minor Injuries
    MajorInjurWeapons : Damage From These Weapons Will Apply Only Major Injuries
    AlwaysBleedChanceWeapons : Weapons that're in the included weapon classes will roll for a chance to apply a bleed effect if the damage wasn't enough to trigger an injury chance
    CriticalAreas :
    StaggerAreas : These are the body areas that would cause a stagger is hit by firearms,
        Table Values: Armored = Can This Cause Stagger If Wearing Armor, Major = % Chance You Get Staggered By Major Damage, Minor = % Chance You Get Staggered By Minor Damage
]]

Config.WeaponClasses = {
    ['SMALL_CALIBER'] = 1,
    ['MEDIUM_CALIBER'] = 2,
    ['HIGH_CALIBER'] = 3,
    ['SHOTGUN'] = 4,
    ['CUTTING'] = 5,
    ['LIGHT_IMPACT'] = 6,
    ['HEAVY_IMPACT'] = 7,
    ['EXPLOSIVE'] = 8,
    ['FIRE'] = 9,
    ['SUFFOCATING'] = 10,
    ['OTHER'] = 11,
    ['WILDLIFE'] = 12,
    ['NOTHING'] = 13
}

Config.MinorInjurWeapons = {
    [Config.WeaponClasses['SMALL_CALIBER']] = true,
    [Config.WeaponClasses['MEDIUM_CALIBER']] = true,
    [Config.WeaponClasses['CUTTING']] = true,
    [Config.WeaponClasses['WILDLIFE']] = true,
    [Config.WeaponClasses['OTHER']] = true,
    [Config.WeaponClasses['LIGHT_IMPACT']] = true,
}

Config.MajorInjurWeapons = {
    [Config.WeaponClasses['HIGH_CALIBER']] = true,
    [Config.WeaponClasses['HEAVY_IMPACT']] = true,
    [Config.WeaponClasses['SHOTGUN']] = true,
    [Config.WeaponClasses['EXPLOSIVE']] = true,
}

Config.AlwaysBleedChanceWeapons = {
    [Config.WeaponClasses['SMALL_CALIBER']] = true,
    [Config.WeaponClasses['MEDIUM_CALIBER']] = true,
    [Config.WeaponClasses['CUTTING']] = true,
    [Config.WeaponClasses['WILDLIFE']] = false,
}

Config.ForceInjuryWeapons = {
    [Config.WeaponClasses['HIGH_CALIBER']] = true,
    [Config.WeaponClasses['HEAVY_IMPACT']] = true,
    [Config.WeaponClasses['EXPLOSIVE']] = true,
}

Config.CriticalAreas = {
    ['UPPER_BODY'] = { armored = false },
    ['LOWER_BODY'] = { armored = true },
    ['SPINE'] = { armored = true },
}

Config.StaggerAreas = {
    ['SPINE'] = { armored = true, major = 60, minor = 30 },
    ['UPPER_BODY'] = { armored = false, major = 60, minor = 30 },
    ['LLEG'] = { armored = true, major = 100, minor = 85 },
    ['RLEG'] = { armored = true, major = 100, minor = 85 },
    ['LFOOT'] = { armored = true, major = 100, minor = 100 },
    ['RFOOT'] = { armored = true, major = 100, minor = 100 },
}

Config.WoundStates = {
    Lang:t('states.irritated'),
    Lang:t('states.quite_painful'),
    Lang:t('states.painful'),
    Lang:t('states.really_painful'),
}

Config.BleedingStates = {
    [1] = {label = Lang:t('states.little_bleed'), damage = 10, chance = 50},
    [2] = {label = Lang:t('states.bleed'), damage = 15, chance = 65},
    [3] = {label = Lang:t('states.lot_bleed'), damage = 20, chance = 65},
    [4] = {label = Lang:t('states.big_bleed'), damage = 25, chance = 75},
}

Config.MovementRate = {
    0.98,
    0.96,
    0.94,
    0.92,
}

Config.Bones = {
    [0]     = 'NONE',
    -- HEAD
    [27981] = 'HEAD',
    [57278] = 'HEAD',
    [54890] = 'HEAD',
    [21030] = 'HEAD',
    -- NECK
    [24015] = 'NECK',
    [52596] = 'NECK',
    [32630] = 'NECK',
	[32631] = 'NECK',
	[32632] = 'NECK',
    [14283] = 'NECK',
	[14284] = 'NECK',
	[14285] = 'NECK',
    -- SPINE
    [14410] = 'SPINE',
    [14411] = 'SPINE',
	[14412] = 'SPINE',
	[14413] = 'SPINE',
	[14414] = 'SPINE',
    --UPPER_BODY
    [30226] = 'UPPER_BODY',
    -- LOWER_BODY
    [56200] = 'LOWER_BODY',
    -- LARM
    [43700] = 'LARM',
    [24238] = 'LARM',
    [55540] = 'LARM',
    [53562] = 'LARM',
    [53675] = 'LARM',
    -- LHAND
    [34606] = 'LHAND',
    -- LFINGER
    [41403] = 'LFINGER',
    [41404] = 'LFINGER',
    [41405] = 'LFINGER',
    [41323] = 'LFINGER',
    [41324] = 'LFINGER',
    [41325] = 'LFINGER',
    [41326] = 'LFINGER',
    [41307] = 'LFINGER',
    [41308] = 'LFINGER',
    [41309] = 'LFINGER',
    [41310] = 'LFINGER',
    [41355] = 'LFINGER',
    [41356] = 'LFINGER',
    [41357] = 'LFINGER',
    [41358] = 'LFINGER',
    [41339] = 'LFINGER',
    [41340] = 'LFINGER',
    [41341] = 'LFINGER',
    [41342] = 'LFINGER',
    [35940] = 'LFINGER',
	[43154] = 'LFINGER',
	[60440] = 'LFINGER',
	[35924] = 'LFINGER',
	[35908] = 'LFINGER',
	[35892] = 'LFINGER',
	[35876] = 'LFINGER',
	[55214] = 'LFINGER',
	[55198] = 'LFINGER',
	[55246] = 'LFINGER',
	[55230] = 'LFINGER',
    -- LLEG
    [40091] = 'LLEG',
    [52390] = 'LLEG',
	[65480] = 'LLEG',
	[21174] = 'LLEG',
	[49844] = 'LLEG',
	[38229] = 'LLEG',
	[51618] = 'LLEG',
	[17816] = 'LLEG',
    [21124] = 'LLEG',
	[12785] = 'LLEG',
	[881] = 'LLEG',
	[65034] = 'LLEG',
	[62433] = 'LLEG',
	[8936] = 'LLEG',
	[2474] = 'LLEG',
	[8980] = 'LLEG',
    [55253] = 'LLEG',
	[15681] = 'LLEG',
    [12865] = 'LLEG',
    [3003] = 'LLEG',
    [65478] = 'LLEG',
    [55120] = 'LLEG',
    -- LFOOT
    [45454] = 'LFOOT',
    -- RARM
    [54187] = 'RARM',
    [46065] = 'RARM',
    [46260] = 'RARM',
    [65198] = 'RARM',
    [31186] = 'RARM',
    -- RHAND
    [22798] = 'RHAND',
    -- RFINGER
    [16827] = 'RFINGER',
	[16828] = 'RFINGER',
	[16829] = 'RFINGER',
	[16747] = 'RFINGER',
	[16748] = 'RFINGER',
	[16749] = 'RFINGER',
	[16750] = 'RFINGER',
	[16731] = 'RFINGER',
	[16732] = 'RFINGER',
	[16733] = 'RFINGER',
	[16734] = 'RFINGER',
	[16779] = 'RFINGER',
	[16780] = 'RFINGER',
	[16781] = 'RFINGER',
	[16782] = 'RFINGER',
	[16763] = 'RFINGER',
	[16764] = 'RFINGER',
	[16765] = 'RFINGER',
	[16766] = 'RFINGER',
    [11364] = 'RFINGER',
	[41618] = 'RFINGER',
	[14992] = 'RFINGER',
	[11348] = 'RFINGER',
	[11332] = 'RFINGER',
	[11316] = 'RFINGER',
	[11300] = 'RFINGER',
	[61341] = 'RFINGER',
	[61325] = 'RFINGER',
	[61373] = 'RFINGER',
	[61357] = 'RFINGER',
	[36407] = 'RFINGER',
    -- RLEG
    [64298] = 'RLEG',
	[27814] = 'RLEG',
	[65384] = 'RLEG',
	[19638] = 'RLEG',
	[6170] = 'RLEG',
	[17720] = 'RLEG',
    [22660] = 'RLEG',
	[10571] = 'RLEG',
	[64874] = 'RLEG',
	[30131] = 'RLEG',
	[46712] = 'RLEG',
	[53296] = 'RLEG',
	[14866] = 'RLEG',
    [31046] = 'RLEG',
	[11991] = 'RLEG',
    [10651] = 'RLEG',
    [5217] = 'RLEG',
    [6884] = 'RLEG',
    -- RFOOT
    [33646] = 'RFOOT',
}

Config.BoneIndexes = {
    ['NONE'] = 0,
    ['HEAD'] = 21030, -- SKEL_HEAD
    ['NECK'] = 14284, -- SKEL_NECK1
    ['SPINE'] = 14413, -- SKEL_SPINE3
    ['UPPER_BODY'] = 30226, --SKEL_L_Clavicle
    ['LOWER_BODY'] = 56200, --SKEL_Pelvis
    ['LARM'] = 53675, --skel_l_forearm
    ['LHAND'] = 34606, --skel_l_hand
    ['LFINGER'] = 41339, --SKEL_L_Finger40
    ['LLEG'] = 55120, --SKEL_L_Calf
    ['LFOOT'] = 45454, --SKEL_L_Foot
    ['RARM'] = 54187, --skel_r_forearm
    ['RHAND'] = 22798, --skel_r_hand
    ['RFINGER'] = 16733, --SKEL_R_Finger22
    ['RLEG'] = 6884, --SKEL_R_Thigh
    ['RFOOT'] = 33646, --SKEL_R_Foot
}

Config.Weapons = {
    --[[ Small Caliber ]]--
    [`WEAPON_REVOLVER_CATTLEMAN`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_REVOLVER_CATTLEMAN_MEXICAN`] = Config.WeaponClasses['SMALL_CALIBER'],
    [`WEAPON_REVOLVER_DOUBLEACTION_GAMBLER`] = Config.WeaponClasses['SMALL_CALIBER'],
	[`WEAPON_REVOLVER_SCHOFIELD`] = Config.WeaponClasses['SMALL_CALIBER'],
	[`WEAPON_REVOLVER_LEMAT`] = Config.WeaponClasses['SMALL_CALIBER'],
	[`WEAPON_REVOLVER_NAVY`] = Config.WeaponClasses['SMALL_CALIBER'],
	[`WEAPON_PISTOL_VOLCANIC`] = Config.WeaponClasses['SMALL_CALIBER'],
	[`WEAPON_PISTOL_M1899`] = Config.WeaponClasses['SMALL_CALIBER'],
	[`WEAPON_PISTOL_MAUSER`] = Config.WeaponClasses['SMALL_CALIBER'],
	[`WEAPON_PISTOL_SEMIAUTO`] = Config.WeaponClasses['SMALL_CALIBER'],
    --[[ MEDIUM_CALIBER ]]--
    [`WEAPON_REPEATER_CARBINE`] = Config.WeaponClasses['MEDIUM_CALIBER'],
	[`WEAPON_REPEATER_WINCHESTER`] = Config.WeaponClasses['MEDIUM_CALIBER'],
	[`WEAPON_REPEATER_HENRY`] = Config.WeaponClasses['MEDIUM_CALIBER'],
	[`WEAPON_REPEATER_EVANS`] = Config.WeaponClasses['MEDIUM_CALIBER'],
	[`WEAPON_RIFLE_VARMINT`] = Config.WeaponClasses['MEDIUM_CALIBER'],
	[`WEAPON_RIFLE_SPRINGFIELD`] = Config.WeaponClasses['MEDIUM_CALIBER'],
	[`WEAPON_RIFLE_BOLTACTION`] = Config.WeaponClasses['MEDIUM_CALIBER'],
	[`WEAPON_RIFLE_ELEPHANT`] = Config.WeaponClasses['MEDIUM_CALIBER'],
    --[[ 'HIGH_CALIBER' ]]--
    [`WEAPON_SNIPERRIFLE_ROLLINGBLOCK`] = Config.WeaponClasses['HIGH_CALIBER'],
	[`WEAPON_SNIPERRIFLE_ROLLINGBLOCK_EXOTIC`] = Config.WeaponClasses['HIGH_CALIBER'],
	[`WEAPON_SNIPERRIFLE_CARCANO`] = Config.WeaponClasses['HIGH_CALIBER'],
    --[[ 'SHOTGUN' ]]--
    [`WEAPON_SHOTGUN_DOUBLEBARREL`] = Config.WeaponClasses['SHOTGUN'],
	[`WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC`] = Config.WeaponClasses['SHOTGUN'],
	[`WEAPON_SHOTGUN_SAWEDOFF`] = Config.WeaponClasses['SHOTGUN'],
	[`WEAPON_SHOTGUN_SEMIAUTO`] = Config.WeaponClasses['SHOTGUN'],
    --[[ 'CUTTING' ]]--
    [`WEAPON_BOW`] = Config.WeaponClasses['CUTTING'],
	[`WEAPON_BOW_IMPROVED`] = Config.WeaponClasses['CUTTING'],
	[`WEAPON_LASSO`] = Config.WeaponClasses['CUTTING'],
	[`WEAPON_LASSO_REINFORCED`] = Config.WeaponClasses['CUTTING'],
	[`WEAPON_MELEE_KNIFE`] = Config.WeaponClasses['CUTTING'],
	[`WEAPON_MELEE_KNIFE_JAWBONE`] = Config.WeaponClasses['CUTTING'],
	[`WEAPON_MELEE_HAMMER`] = Config.WeaponClasses['CUTTING'],
	[`WEAPON_THROWN_DYNAMITE`] = Config.WeaponClasses['CUTTING'],
	[`WEAPON_THROWN_MOLOTOV`] = Config.WeaponClasses['CUTTING'],
	[`WEAPON_THROWN_THROWING_KNIVES`] = Config.WeaponClasses['CUTTING'],
	[`WEAPON_THROWN_TOMAHAWK`] = Config.WeaponClasses['CUTTING'],
	[`WEAPON_THROWN_TOMAHAWK_ANCIENT`] = Config.WeaponClasses['CUTTING'],
	[`WEAPON_THROWN_BOLAS`] = Config.WeaponClasses['CUTTING'],
	[`WEAPON_MELEE_CLEAVER`] = Config.WeaponClasses['CUTTING'],
	[`WEAPON_MELEE_LANTERN`] = Config.WeaponClasses['CUTTING'],
	[`WEAPON_MELEE_DAVY_LANTERN`] = Config.WeaponClasses['CUTTING'],
	[`WEAPON_MELEE_TORCH`] = Config.WeaponClasses['CUTTING'],
	[`WEAPON_MELEE_HATCHET`] = Config.WeaponClasses['CUTTING'],
	[`WEAPON_MELEE_MACHETE`] = Config.WeaponClasses['CUTTING'],
    --[[ 'LIGHT_IMPACT' ]]--
    --[[ 'HEAVY_IMPACT' ]]--
    --[[ 'EXPLOSIVE' ]]--
    --[[ 'FIRE' ]]--
    --[[ 'SUFFOCATING' ]]--
    --[[ 'OTHER' ]]--
    --[[ 'WILDLIFE' ]]--
    --[[ 'NOTHING' ]]--
}

Config.VehicleSettings = {
    ["CHUCKWAGON000X"] = { -- Model name
        ["extras"] = {
            ["1"] = false, -- on/off
            ["2"] = false,
            ["3"] = false,
            ["4"] = false,
            ["5"] = false,
            ["6"] = false,
            ["7"] = false,
            ["8"] = false,
            ["9"] = false,
            ["10"] = false,
            ["11"] = false,
            ["12"] = false,
        }
    }
}
