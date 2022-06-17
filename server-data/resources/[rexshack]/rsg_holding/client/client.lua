Citizen.CreateThread(function()
	while true do
    Wait(1000)
    local entity = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
    local model = GetEntityModel(entity)
    local carriedEntityHash = Citizen.InvokeNative(0x31FEF6A20F00B963, entity)
    local entType = GetEntityType(entity)
	local src = source
		if entType == 3 then -- Fur/Skin/Pelt
			-- bear
			if carriedEntityHash == 957520252 then
				item = 'poor_bear_fur'
				name = 'Poor Bear Fur'
				exports['qbr-core']:Notify(8, 'Bear Fur', 5000, name, 'satchel_textures', 'provision_bear_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 143941906 then
				item = 'good_bear_fur'
				name = 'Good Bear Fur'
				exports['qbr-core']:Notify(8, 'Bear Fur', 5000, name, 'satchel_textures', 'provision_bear_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 1292673537 then
				item = 'perfect_bear_fur'
				name = 'Perfect Bear Fur'
				exports['qbr-core']:Notify(8, 'Bear Fur', 5000, name, 'satchel_textures', 'provision_bear_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- big horn ram
			elseif carriedEntityHash == 1796037447 then
				item = 'poor_bighornram_hide'
				name = 'Poor Big Horn Ram Hide'
				exports['qbr-core']:Notify(8, 'Big Horn Ram Hide', 5000, name, 'satchel_textures', 'provision_ram_hide', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -476045512 then
				item = 'good_bighornram_hide'
				name = 'Good Big Horn Ram Hide'
				exports['qbr-core']:Notify(8, 'Big Horn Ram Hide', 5000, name, 'satchel_textures', 'provision_ram_hide', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 1795984405 then
				item = 'perfect_bighornram_hide'
				name = 'Perfect Big Horn Ram Hide'
				exports['qbr-core']:Notify(8, 'Big Horn Ram Hide', 5000, name, 'satchel_textures', 'provision_ram_hide', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- boar
			elseif carriedEntityHash == 1248540072 then
				item = 'poor_boar_skin'
				name = 'Poor Boar Skin'
				exports['qbr-core']:Notify(8, 'Boar Skin', 5000, name, 'satchel_textures', 'provision_boar_skin', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -1858513856 then
				item = 'perfect_boar_skin'
				name = 'Perfect Boar Skin'
				exports['qbr-core']:Notify(8, 'Boar Skin', 5000, name, 'satchel_textures', 'provision_boar_skin', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- buck
			elseif carriedEntityHash == 1603936352 then
				item = 'poor_buck_fur'
				name = 'Poor Buck Fur'
				exports['qbr-core']:Notify(8, 'Buck Fur', 5000, name, 'satchel_textures', 'provision_buck_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -868657362 then
				item = 'good_buck_fur'
				name = 'Good Buck Fur'
				exports['qbr-core']:Notify(8, 'Buck Fur', 5000, name, 'satchel_textures', 'provision_buck_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -702790226 then
				item = 'perfect_buck_fur'
				name = 'Perfect Buck Fur'
				exports['qbr-core']:Notify(8, 'Buck Fur', 5000, name, 'satchel_textures', 'provision_buck_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- bison
			elseif carriedEntityHash == -1730060063 then
				item = 'poor_bison_hide'
				name = 'Poor Bison Hide'
				exports['qbr-core']:Notify(8, 'you stored a '..name, 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -591117838 then
				item = 'good_bison_hide'
				name = 'Good Bison Hide'
				exports['qbr-core']:Notify(8, 'you stored a '..name, 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -237756948 then
				item = 'perfect_bison_hide'
				name = 'Perfect Bison Hide'
				exports['qbr-core']:Notify(8, 'you stored a '..name, 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- bull
			elseif carriedEntityHash == 9293261 then
				item = 'poor_bull_hide'
				name = 'Poor Bull Hide'
				exports['qbr-core']:Notify(8, 'Bull Hide', 5000, name, 'satchel_textures', 'provision_bull_hide', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -336086818 then
				item = 'good_bull_hide'
				name = 'Good Bull Hide'
				exports['qbr-core']:Notify(8, 'Bull Hide', 5000, name, 'satchel_textures', 'provision_bull_hide', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -53270317 then
				item = 'perfect_bull_hide'
				name = 'Perfect Bull Hide'
				exports['qbr-core']:Notify(8, 'Bull Hide', 5000, name, 'satchel_textures', 'provision_bull_hide', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- deer
			elseif carriedEntityHash == -662178186 then
				item = 'poor_deer_hide'
				name = 'Poor Deer Hide'
				exports['qbr-core']:Notify(8, 'Deer Hide', 5000, name, 'satchel_textures', 'provision_deer_hide', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -1827027577 then
				item = 'good_deer_hide'
				name = 'Good Deer Hide'
				exports['qbr-core']:Notify(8, 'Deer Hide', 5000, name, 'satchel_textures', 'provision_deer_hide', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -1035515486 then
				item = 'perfect_deer_hide'
				name = 'Perfect Deer Hide'
				exports['qbr-core']:Notify(8, 'Deer Hide', 5000, name, 'satchel_textures', 'provision_deer_hide', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- elk
			elseif carriedEntityHash == 2053771712 then
				item = 'poor_elk_fur'
				name = 'Poor Elk Fur'
				exports['qbr-core']:Notify(8, 'Elk Fur', 5000, name, 'satchel_textures', 'provision_elk_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 1181652728 then
				item = 'good_elk_fur'
				name = 'Good Elk Fur'
				exports['qbr-core']:Notify(8, 'Elk Fur', 5000, name, 'satchel_textures', 'provision_elk_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -1332163079 then
				item = 'perfect_elk_fur'
				name = 'Perfect Elk Fur'
				exports['qbr-core']:Notify(8, 'Elk Fur', 5000, name, 'satchel_textures', 'provision_elk_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- American Red Fox
			elseif carriedEntityHash == 1647012424 then
				item = 'poor_redfox_fur'
				name = 'Poor Red Fox Fur'
				exports['qbr-core']:Notify(8, 'Red Fox Fur', 5000, name, 'satchel_textures', 'provision_fox_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 238733925 then
				item = 'good_redfox_fur'
				name = 'Good Red Fox Fur'
				exports['qbr-core']:Notify(8, 'Red Fox Fur', 5000, name, 'satchel_textures', 'provision_fox_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 500722008 then
				item = 'perfect_redfox_fur'
				name = 'Perfect Red Fox Fur'
				exports['qbr-core']:Notify(8, 'Red Fox Fur', 5000, name, 'satchel_textures', 'provision_fox_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- Grey Wolf
			elseif carriedEntityHash == 85441452 then
				item = 'poor_greywolf_fur'
				name = 'Poor Grey Wolf Fur'
				exports['qbr-core']:Notify(8, 'Grey Wolf Fur', 5000, name, 'satchel_textures', 'provision_wolf_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 1145777975 then
				item = 'good_greywolf_fur'
				name = 'Good Grey Wolf Fur'
				exports['qbr-core']:Notify(8, 'Grey Wolf Fur', 5000, name, 'satchel_textures', 'provision_wolf_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 653400939 then
				item = 'perfect_greywolf_fur'
				name = 'Perfect Grey Wolf Fur'
				exports['qbr-core']:Notify(8, 'Grey Wolf Fur', 5000, name, 'satchel_textures', 'provision_wolf_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- Merino Sheep
			elseif carriedEntityHash == 1729948479 then
				item = 'poor_merinosheep_wool'
				name = 'Poor Merino Sheep Wool'
				exports['qbr-core']:Notify(8, 'Merino Sheep Wool', 5000, name, 'satchel_textures', 'provision_sheep_wool', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -1317365569 then
				item = 'good_merinosheep_wool'
				name = 'Good Merino Sheep Wool'
				exports['qbr-core']:Notify(8, 'Merino Sheep Wool', 5000, name, 'satchel_textures', 'provision_sheep_wool', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 1466150167 then
				item = 'perfect_merinosheep_wool'
				name = 'Perfect Merino Sheep Wool'
				exports['qbr-core']:Notify(8, 'Merino Sheep Wool', 5000, name, 'satchel_textures', 'provision_sheep_wool', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- pronghorn
			elseif carriedEntityHash == -983605026 then
				item = 'poor_pronghorn_fur'
				name = 'Poor Pronghorn Fur'
				exports['qbr-core']:Notify(8, 'Pronghorn Fur', 5000, name, 'satchel_textures', 'provision_pronghorn_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 554578289 then
				item = 'good_pronghorn_fur'
				name = 'Good Pronghorn Fur'
				exports['qbr-core']:Notify(8, 'Pronghorn Fur', 5000, name, 'satchel_textures', 'provision_pronghorn_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -1544126829 then
				item = 'perfect_pronghorn_fur'
				name = 'Perfect Pronghorn Fur'
				exports['qbr-core']:Notify(8, 'Pronghorn Fur', 5000, name, 'satchel_textures', 'provision_pronghorn_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- Berkshire Pig
			elseif carriedEntityHash == -308965548 then
				item = 'poor_berkshirepig_skin'
				name = 'Poor Berkshire Pig Skin'
				exports['qbr-core']:Notify(8, 'Berkshire Pig Skin', 5000, name, 'satchel_textures', 'provision_pig_skin', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -57190831 then
				item = 'good_berkshirepig_skin'
				name = 'Good Berkshire Pig Skin'
				exports['qbr-core']:Notify(8, 'Berkshire Pig Skin', 5000, name, 'satchel_textures', 'provision_pig_skin', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -1102272634 then
				item = 'perfect_berkshirepig_skin'
				name = 'Perfect Berkshire Pig Skin'
				exports['qbr-core']:Notify(8, 'Berkshire Pig Skin', 5000, name, 'satchel_textures', 'provision_pig_skin', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- Panther
			elseif carriedEntityHash == 1584468323 then
				item = 'poor_panther_fur'
				name = 'Poor Panther Fur'
				exports['qbr-core']:Notify(8, 'Panther Fur', 5000, name, 'satchel_textures', 'provision_panther_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -395646254 then
				item = 'good_panther_fur'
				name = 'Good Panther Fur'
				exports['qbr-core']:Notify(8, 'Panther Fur', 5000, name, 'satchel_textures', 'provision_panther_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 1969175294 then
				item = 'perfect_panther_fur'
				name = 'Perfect Panther Fur'
				exports['qbr-core']:Notify(8, 'Panther Fur', 5000, name, 'satchel_textures', 'provision_panther_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- Cougar
			elseif carriedEntityHash == 1914602340 then
				item = 'poor_cougar_fur'
				name = 'Poor Cougar Fur'
				exports['qbr-core']:Notify(8, 'Cougar Fur', 5000, name, 'satchel_textures', 'provision_cougar_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 459744337 then
				item = 'good_cougar_fur'
				name = 'Good Cougar Fur'
				exports['qbr-core']:Notify(8, 'Cougar Fur', 5000, name, 'satchel_textures', 'provision_cougar_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -1791452194 then
				item = 'perfect_cougar_fur'
				name = 'Perfect Cougar Fur'
				exports['qbr-core']:Notify(8, 'Cougar Fur', 5000, name, 'satchel_textures', 'provision_cougar_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- Cracker Cow
			elseif carriedEntityHash == 334093551 then
				item = 'poor_crackercow_hide'
				name = 'Poor Cracker Cow Hide'
				exports['qbr-core']:Notify(8, 'Cracker Cow Hide', 5000, name, 'satchel_textures', 'provision_cow_hide', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 1150594075 then
				item = 'good_crackercow_hide'
				name = 'Good Cracker Cow Hide'
				exports['qbr-core']:Notify(8, 'Cracker Cow Hide', 5000, name, 'satchel_textures', 'provision_cow_hide', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -845037222 then
				item = 'perfect_crackercow_hide'
				name = 'Perfect Cracker Cow Hide'
				exports['qbr-core']:Notify(8, 'Cracker Cow Hide', 5000, name, 'satchel_textures', 'provision_cow_hide', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- Coyote
			elseif carriedEntityHash == -1558096473 then
				item = 'poor_coyote_fur'
				name = 'Poor Coyote Fur'
				exports['qbr-core']:Notify(8, 'Coyote Fur', 5000, name, 'satchel_textures', 'provision_coyote_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 1150939141 then
				item = 'good_coyote_fur'
				name = 'Good Coyote Fur'
				exports['qbr-core']:Notify(8, 'Coyote Fur', 5000, name, 'satchel_textures', 'provision_coyote_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -794277189 then
				item = 'perfect_coyote_fur'
				name = 'Perfect Coyote Fur'
				exports['qbr-core']:Notify(8, 'Coyote Fur', 5000, name, 'satchel_textures', 'provision_coyote_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- Alpine Goat
			elseif carriedEntityHash == 699990316 then
				item = 'poor_alpinegoat_hair'
				name = 'Poor Alpine Goat Hair'
				exports['qbr-core']:Notify(8, 'Alpine Goat Hair', 5000, name, 'satchel_textures', 'provision_goat_hair', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 1710714415 then
				item = 'good_alpinegoat_hair'
				name = 'Good Alpine Goat Hair'
				exports['qbr-core']:Notify(8, 'Alpine Goat Hair', 5000, name, 'satchel_textures', 'provision_goat_hair', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -1648383828 then
				item = 'perfect_alpinegoat_hair'
				name = 'Perfect Alpine Goat Hair'
				exports['qbr-core']:Notify(8, 'Alpine Goat Hair', 5000, name, 'satchel_textures', 'provision_goat_hair', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- Peccary Pig
			elseif carriedEntityHash == -99092070 then
				item = 'poor_peccarypig_skin'
				name = 'Poor Peccary Pig Skin'
				exports['qbr-core']:Notify(8, 'Peccary Pig Skin', 5000, name, 'satchel_textures', 'provision_pig_skin', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -1379330323 then
				item = 'good_peccarypig_skin'
				name = 'Good Peccary Pig Skin'
				exports['qbr-core']:Notify(8, 'Peccary Pig Skin', 5000, name, 'satchel_textures', 'provision_pig_skin', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 1963510418 then
				item = 'perfect_peccarypig_skin'
				name = 'Perfect Peccary Pig Skin'
				exports['qbr-core']:Notify(8, 'Peccary Pig Skin', 5000, name, 'satchel_textures', 'provision_pig_skin', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- Moose
			elseif carriedEntityHash == 1868576868 then
				item = 'poor_moose_fur'
				name = 'Poor Moose Fur'
				exports['qbr-core']:Notify(8, 'Moose Fur', 5000, name, 'satchel_textures', 'provision_moose_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 1636891382 then
				item = 'good_moose_fur'
				name = 'Good Moose Fur'
				exports['qbr-core']:Notify(8, 'Moose Fur', 5000, name, 'satchel_textures', 'provision_moose_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -217731719 then
				item = 'perfect_moose_fur'
				name = 'Perfect Moose Fur'
				exports['qbr-core']:Notify(8, 'Moose Fur', 5000, name, 'satchel_textures', 'provision_moose_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- Angus Ox
			elseif carriedEntityHash == 4623248928 then
				item = 'poor_angusox_hide'
				name = 'Poor Angus Ox Hide'
				exports['qbr-core']:Notify(8, 'Angus Ox Hide', 5000, name, 'satchel_textures', 'provision_oxen_hide', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 1208128650 then
				item = 'good_angusox_hide'
				name = 'Good Angus Ox Hide'
				exports['qbr-core']:Notify(8, 'Angus Ox Hide', 5000, name, 'satchel_textures', 'provision_oxen_hide', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 659601266 then
				item = 'perfect_angusox_hide'
				name = 'Perfect Angus Ox Hide'
				exports['qbr-core']:Notify(8, 'Angus Ox Hide', 5000, name, 'satchel_textures', 'provision_oxen_hide', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- Alligator
			elseif carriedEntityHash == 1806153689 then
				item = 'poor_alligator_skin'
				name = 'Poor Alligator Skin'
				exports['qbr-core']:Notify(8, 'Alligator Skin', 5000, name, 'satchel_textures', 'provision_alligator_skin', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -802026654 then
				item = 'good_alligator_skin'
				name = 'Good Alligator Skin'
				exports['qbr-core']:Notify(8, 'Alligator Skin', 5000, name, 'satchel_textures', 'provision_alligator_skin', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -1625078531 then
				item = 'perfect_alligator_skin'
				name = 'Perfect Alligator Skin'
				exports['qbr-core']:Notify(8, 'Alligator Skin', 5000, name, 'satchel_textures', 'provision_alligator_skin', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- American Beaver
			elseif carriedEntityHash == -1569450319 then
				item = 'poor_beaver_fur'
				name = 'Poor Beaver Fur'
				exports['qbr-core']:Notify(8, 'Beaver Fur', 5000, name, 'satchel_textures', 'provision_beaver_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == -2059726619 then
				item = 'good_beaver_fur'
				name = 'Good Beaver Fur'
				exports['qbr-core']:Notify(8, 'Beaver Fur', 5000, name, 'satchel_textures', 'provision_beaver_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 854596618 then
				item = 'perfect_beaver_fur'
				name = 'Perfect Beaver Fur'
				exports['qbr-core']:Notify(8, 'Beaver Fur', 5000, name, 'satchel_textures', 'provision_beaver_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
				
			-- American Black Bear
			elseif carriedEntityHash == 1083865179 then
				item = 'poor_blackbear_fur'
				name = 'Poor American Black Bear Fur'
				exports['qbr-core']:Notify(8, 'American Black Bear Fur', 5000, name, 'satchel_textures', 'provision_black_bear_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 1490032862 then
				item = 'good_blackbear_fur'
				name = 'Good American Black Bear Fur'
				exports['qbr-core']:Notify(8, 'American Black Bear Fur', 5000, name, 'satchel_textures', 'provision_black_bear_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			elseif carriedEntityHash == 663376218 then
				item = 'perfect_blackbear_fur'
				name = 'Perfect American Black Bear Fur'
				exports['qbr-core']:Notify(8, 'American Black Bear Fur', 5000, name, 'satchel_textures', 'provision_black_bear_fur', 'COLOR_WHITE')
				TriggerServerEvent("rsg_holding:server:storepelt", item)
				DeleteThis(entity)
			end
		end
	end
end)

function DeleteThis(entity)
    NetworkRequestControlOfEntity(entity)
    SetEntityAsMissionEntity(entity, true, true)
    Wait(2000)
    DeleteEntity(entity)
    Wait(1000)
    local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
    local holdingcheck = GetPedType(entitycheck)
    if holdingcheck == 0 then
        return true
    else
        return false
    end
end