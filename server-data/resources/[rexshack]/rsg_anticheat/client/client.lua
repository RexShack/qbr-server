local sharedWeapons = exports['qbr-core']:GetWeapons()

CreateThread(function()	-- Check if player has weapon in inventory --
    while true do
        Wait(5000)
		local player = PlayerPedId()
		local weapon = Citizen.InvokeNative(0x8425C5F057012DAB, player)
		local WeaponData = sharedWeapons[weapon]
		if WeaponData ~= nil and WeaponData["name"] ~= "weapon_unarmed" then
			exports['qbr-core']:GetPlayerData(function(PlayerData)
				firstname = PlayerData.charinfo.firstname
				lastname = PlayerData.charinfo.lastname
			end)
			exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem)
				if not hasItem then
					SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
					RemoveAllPedWeapons(player, true, true)
					TriggerServerEvent("qbr-log:server:CreateLog", "anticheat", "Weapon Removed!", "orange", "** @staff ** " ..firstname.. " " ..lastname.. " had a weapon on them that they did not have in his inventory : anticheat has removed the weapon")
				end
			end, WeaponData["name"])
		end
    end
end)