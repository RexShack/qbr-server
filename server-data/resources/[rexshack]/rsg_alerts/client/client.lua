-- lawman alert
RegisterNetEvent('rsg_alerts:client:lawmanalert')
AddEventHandler('rsg_alerts:client:lawmanalert', function(coords, blipname, alert)
	local job = exports['qbr-core']:GetPlayerData().job.name
	if job == Config.LawmanJob then
		exports['qbr-core']:Notify(8, 'Law Alert!', 5000, alert, 'inventory_items', 'provision_sheriff_star', 'COLOR_WHITE')
		local lawblip = Citizen.InvokeNative(0x554D9D53F696D002,1664425300, coords.x, coords.y, coords.z)
		SetBlipSprite(lawblip, Config.LawBlipHash, true)
		SetBlipScale(lawblip, 0.2)
		Citizen.InvokeNative(0x9CB1A1623062F402, lawblip, blipname) -- blip name
		Citizen.InvokeNative(0x662D364ABF16DE2F, lawblip, 0x6F85C3CE) -- red color blip
		Wait(Config.LawAlertTime) -- blips will dispears after time expires
		RemoveBlip(blip)
	end
end)

-- medic alert
RegisterNetEvent('rsg_alerts:client:medicalert')
AddEventHandler('rsg_alerts:client:medicalert', function(coords, blipname, alert)
	local job = exports['qbr-core']:GetPlayerData().job.name
	if job == Config.MedicJob then
		exports['qbr-core']:Notify(8, 'Medic Alert!', 5000, alert, 'blips', 'blip_supplies_health', 'COLOR_WHITE')
		local medicblip = Citizen.InvokeNative(0x554D9D53F696D002,1664425300, coords.x, coords.y, coords.z)
		SetBlipSprite(medicblip, Config.MedicBlipHash, true)
		SetBlipScale(medicblip, 0.2)
		Citizen.InvokeNative(0x9CB1A1623062F402, medicblip, blipname) -- blip name
		Citizen.InvokeNative(0x662D364ABF16DE2F, medicblip, 0x6F85C3CE) -- red color blip
		Wait(Config.MedicAlertTime) -- blips will dispears after time expires
		RemoveBlip(blip)
	end
end)