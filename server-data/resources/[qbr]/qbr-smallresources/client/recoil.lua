local recoils = {
	[34411519] = 0.7, --   weapon_pistol_volcanic
	[1252941818] = 0.7,-- `weapon_pistol_mauser_drunk
	[1534638301] = 0.7,-- weapon_pistol_m1899
	[1701864918] = 0.7,-- weapon_pistol_semiauto
	[2239809086] = 0.7,-- weapon_pistol_mauser
	---Repeater
	[1905553950] = 0.7,-- weapon_repeater_evans
	-- [2077870112] = 0.7,-- weapon_repeater_carbine_sadie
	[2511488402] = 0.7,-- weapon_repeater_henry
	[2823250668] = 0.7,-- weapon_repeater_winchester
	-- [3195419004] = 0.7,-- weapon_repeater_winchester_john
	[4111948705] = 0.7,-- weapon_repeater_carbine
	---revolver
	-- [13903789] = 0.7,-- weapon_revolver_doubleaction_micah_dualwield
	-- [36703333] = 0.7,-- weapon_revolver_doubleaction_micah
	-- [38266755] = 0.7,--weapon_revolver_schofield_calloway
	[127400949] = 0.7,-- weapon_revolver_doubleaction
	[379542007] = 0.7,-- weapon_revolver_cattleman
	[383145463] = 0.7,-- weapon_revolver_cattleman_mexican
	[1529685685] = 0.7,-- weapon_revolver_lemat
	[2075992054] = 0.7,-- weapon_revolver_schofield
	[2212320791] = 0.7,-- weapon_revolver_doubleaction_gambler
	--riflle
	[1676963302] = 0.7,-- weapon_rifle_springfield
	[1999408598] = 0.7,-- weapon_rifle_boltaction
	[3724000286] = 0.7,-- weapon_rifle_varmint
	--shoutgun
	[392538360] = 0.7,-- weapon_shotgun_sawedoff
	[575725904] = 0.7,-- weapon_shotgun_doublebarrel_exotic
	[834124286] = 0.7,-- weapon_shotgun_pump
	[1674213418] = 0.7,-- weapon_shotgun_repeating
	[1838922096] = 0.7,-- weapon_shotgun_semiauto
	[1845102363] = 0.7,-- weapon_shotgun_doublebarrel
	--sniperrifle
	[1402226560] = 0.7,-- weapon_sniperrifle_carcano
	[3788682007] = 0.7,-- weapon_sniperrifle_rollingblock

    -------------------------------------  Weapons from game version 1207.80 till 1311.12 ---------------------------------
    -- {`weapon_rifle_elephant`,`group_rifle`,},
    -- {`weapon_revolver_navy`,`group_revolver`,},

    -------------------------------------  Weapons from game version 1311.12 till 1355.18 ---------------------------------
   	--- {`weapon_revolver_navy_crossover`,`group_revolver`,},

}


Citizen.CreateThread(function()
	while true do
		local ped = PlayerPedId()
		if IsPedShooting(ped) then --and not IsPedDoingDriveby(ped) then
			local _,wep = GetCurrentPedWeapon(ped)
			if recoils[wep] and recoils[wep] ~= 0 then
				tv = 0
				-- if GetFollowPedCamViewMode() ~= 4 then
				-- 	repeat
				-- 		Wait(0)
				-- 		p = GetGameplayCamRelativePitch()
				-- 		SetGameplayCamRelativePitch(p+0.1, 0.2)
				-- 		tv = tv+0.1
				-- 	until tv >= recoils[wep]
				--else
					repeat
						Wait(0)
						p = GetGameplayCamRelativePitch()
						if recoils[wep] > 0.1 then
							SetGameplayCamRelativePitch(p+0.6, 1.2)
							tv = tv+0.6
						else
							SetGameplayCamRelativePitch(p+0.016, 0.333)
							tv = tv+0.1
						end
					until tv >= recoils[wep]
				--end
			end
		end

		Citizen.Wait(0)
	end
end)
