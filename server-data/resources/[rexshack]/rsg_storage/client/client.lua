
-- valentine --

Citizen.CreateThread(function()
	exports['qbr-core']:createPrompt('valentine-storage-1', vector3(-179.3819, 648.2138, 113.58127), 0xF3830D8E, 'Open Valentine Storage', {
		type = 'client',
		event = 'rsg_storage:client:valstorage',
		args = { false, true, false },
	})
	local StorageBlip = N_0x554d9d53f696d002(1664425300, vector3(-179.3819, 648.2138, 113.58127))
	SetBlipSprite(StorageBlip, -426139257, 52)
	SetBlipScale(StorageBlip, 0.2)
	Citizen.InvokeNative(0x9CB1A1623062F402, StorageBlip, 'Storage')
end)

RegisterNetEvent('rsg_storage:client:valstorage', function()
	exports['qbr-core']:GetPlayerData(function(PlayerData)
	local cid = PlayerData.citizenid
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'valstore'..cid, {
        maxweight = Config.MaxWeight,
        slots = Config.MaxSlots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", 'valstore'..cid)
	end)
end)

-- blackwater --

Citizen.CreateThread(function()
	exports['qbr-core']:createPrompt('blackwater-storage-1', vector3(-733.6947, -1253.501, 44.734077), 0xF3830D8E, 'Open Blackwater Storage', {
		type = 'client',
		event = 'rsg_storage:client:blkstorage',
		args = { false, true, false },
	})
	local StorageBlip = N_0x554d9d53f696d002(1664425300, vector3(-734.923, -1254.389, 44.734107))
	SetBlipSprite(StorageBlip, -426139257, 52)
	SetBlipScale(StorageBlip, 0.2)
	Citizen.InvokeNative(0x9CB1A1623062F402, StorageBlip, 'Storage')
end)

RegisterNetEvent('rsg_storage:client:blkstorage', function()
	exports['qbr-core']:GetPlayerData(function(PlayerData)
	local cid = PlayerData.citizenid
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'blkstore'..cid, {
        maxweight = Config.MaxWeight,
        slots = Config.MaxSlots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", 'blkstore'..cid)
	end)
end)

-- stdenis --
Citizen.CreateThread(function()
	exports['qbr-core']:createPrompt('stdenis-storage-1', vector3(2669.6577, -1500.203, 45.968963), 0xF3830D8E, 'Open StDenis Storage', {
		type = 'client',
		event = 'rsg_storage:client:denstorage',
		args = { false, true, false },
	})
	local StorageBlip = N_0x554d9d53f696d002(1664425300, vector3(2669.6577, -1500.203, 45.968963))
	SetBlipSprite(StorageBlip, -426139257, 52)
	SetBlipScale(StorageBlip, 0.2)
	Citizen.InvokeNative(0x9CB1A1623062F402, StorageBlip, 'Storage')
end)

RegisterNetEvent('rsg_storage:client:denstorage', function()
	exports['qbr-core']:GetPlayerData(function(PlayerData)
	local cid = PlayerData.citizenid
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'denstore'..cid, {
        maxweight = Config.MaxWeight,
        slots = Config.MaxSlots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", 'denstore'..cid)
	end)
end)

-- rhodes --
Citizen.CreateThread(function()
	exports['qbr-core']:createPrompt('rhodes-storage-1', vector3(1231.0391, -1277.829, 76.021591), 0xF3830D8E, 'Open Rhodes Storage', {
		type = 'client',
		event = 'rsg_storage:client:rhostorage',
		args = { false, true, false },
	})
	local StorageBlip = N_0x554d9d53f696d002(1664425300, vector3(1231.0391, -1277.829, 76.021591))
	SetBlipSprite(StorageBlip, -426139257, 52)
	SetBlipScale(StorageBlip, 0.2)
	Citizen.InvokeNative(0x9CB1A1623062F402, StorageBlip, 'Storage')
end)

RegisterNetEvent('rsg_storage:client:rhostorage', function()
	exports['qbr-core']:GetPlayerData(function(PlayerData)
	local cid = PlayerData.citizenid
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'rhostore'..cid, {
        maxweight = Config.MaxWeight,
        slots = Config.MaxSlots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", 'rhostore'..cid)
	end)
end)

-- annesburg --
Citizen.CreateThread(function()
	exports['qbr-core']:createPrompt('annesburg-storage-1', vector3(2934.8232, 1306.6634, 44.47974), 0xF3830D8E, 'Open Annesburg Storage', {
		type = 'client',
		event = 'rsg_storage:client:annstorage',
		args = { false, true, false },
	})
	local StorageBlip = N_0x554d9d53f696d002(1664425300, vector3(2934.8232, 1306.6634, 44.47974))
	SetBlipSprite(StorageBlip, -426139257, 52)
	SetBlipScale(StorageBlip, 0.2)
	Citizen.InvokeNative(0x9CB1A1623062F402, StorageBlip, 'Storage')
end)

RegisterNetEvent('rsg_storage:client:annstorage', function()
	exports['qbr-core']:GetPlayerData(function(PlayerData)
	local cid = PlayerData.citizenid
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'annstore'..cid, {
        maxweight = Config.MaxWeight,
        slots = Config.MaxSlots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", 'annstore'..cid)
	end)
end)

-- strawberry --
Citizen.CreateThread(function()
	exports['qbr-core']:createPrompt('strawberry-storage-1', vector3(-1752.021, -386.3956, 156.49397), 0xF3830D8E, 'Open Strawberry Storage', {
		type = 'client',
		event = 'rsg_storage:client:strstorage',
		args = { false, true, false },
	})
	local StorageBlip = N_0x554d9d53f696d002(1664425300, vector3(-1752.021, -386.3956, 156.49397))
	SetBlipSprite(StorageBlip, -426139257, 52)
	SetBlipScale(StorageBlip, 0.2)
	Citizen.InvokeNative(0x9CB1A1623062F402, StorageBlip, 'Storage')
end)

RegisterNetEvent('rsg_storage:client:strstorage', function()
	exports['qbr-core']:GetPlayerData(function(PlayerData)
	local cid = PlayerData.citizenid
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'strstore'..cid, {
        maxweight = Config.MaxWeight,
        slots = Config.MaxSlots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", 'strstore'..cid)
	end)
end)

-- tumbleweed --
Citizen.CreateThread(function()
	exports['qbr-core']:createPrompt('tumbleweed-storage-1', vector3(-5494.741, -2959.111, -0.69497), 0xF3830D8E, 'Open Tumbleweed Storage', {
		type = 'client',
		event = 'rsg_storage:client:tumstorage',
		args = { false, true, false },
	})
	local StorageBlip = N_0x554d9d53f696d002(1664425300, vector3(-5494.741, -2959.111, -0.69497))
	SetBlipSprite(StorageBlip, -426139257, 52)
	SetBlipScale(StorageBlip, 0.2)
	Citizen.InvokeNative(0x9CB1A1623062F402, StorageBlip, 'Storage')
end)

RegisterNetEvent('rsg_storage:client:tumstorage', function()
	exports['qbr-core']:GetPlayerData(function(PlayerData)
	local cid = PlayerData.citizenid
    TriggerServerEvent("inventory:server:OpenInventory", "stash", 'tumstore'..cid, {
        maxweight = Config.MaxWeight,
        slots = Config.MaxSlots,
    })
    TriggerEvent("inventory:client:SetCurrentStash", 'tumstore'..cid)
	end)
end)