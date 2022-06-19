Config = {}

Config.VaultDoors = {
	1634148892, -- gate locked (no access)
	2058564250, -- corridor door (use lockpick)
	3483244267, -- vault door (use dynamite)
}

Config.HeistNpcs = {
	[1] = { ["Model"] = "RE_POLICECHASE_MALES_01", ["Pos"] = vector3(1298.1922, -1298.921, 77.028564 -1), ["Heading"] = 323.39672 },
	[2] = { ["Model"] = "RE_POLICECHASE_MALES_01", ["Pos"] = vector3(1291.1708, -1293.379, 76.439674 -1), ["Heading"] = 306.5007 },
	[3] = { ["Model"] = "RE_POLICECHASE_MALES_01", ["Pos"] = vector3(1278.746, -1311.409, 76.929656 -1), ["Heading"] = 141.41909 },
	[4] = { ["Model"] = "RE_POLICECHASE_MALES_01", ["Pos"] = vector3(1290.0343, -1304.887, 81.971908 -1), ["Heading"] = 140.40957 },
	[5] = { ["Model"] = "RE_POLICECHASE_MALES_01", ["Pos"] = vector3(1297.2199, -1304.808, 77.041122 -1), ["Heading"] = 65.686851 },
}

-- -1 DOORSTATE_INVALID,
-- 0 DOORSTATE_UNLOCKED,
-- 1 DOORSTATE_LOCKED_UNBREAKABLE,
-- 2 DOORSTATE_LOCKED_BREAKABLE,
-- 3 DOORSTATE_HOLD_OPEN_POSITIVE,
-- 4 DOORSTATE_HOLD_OPEN_NEGATIVE