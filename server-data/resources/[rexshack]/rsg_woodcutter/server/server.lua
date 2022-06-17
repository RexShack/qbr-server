local sharedItems = exports['qbr-core']:GetItems()

-- give wood reward
RegisterServerEvent('rsg_woodcutter:server:giveWoodcuttingReward')
AddEventHandler('rsg_woodcutter:server:giveWoodcuttingReward', function()
    local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local randomNumber = math.random(1,4)
	if randomNumber == 1 then
		Player.Functions.AddItem('wood', 1)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['wood'], "add")
		TriggerClientEvent('QBCore:Notify', src, 9, 'you chopped one wood', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
	elseif randomNumber == 2 then
		Player.Functions.AddItem('wood', 2)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['wood'], "add")
		TriggerClientEvent('QBCore:Notify', src, 9, 'you chopped two wood', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
	elseif randomNumber == 3 then
		Player.Functions.AddItem('wood', 3)
		TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['wood'], "add")
		TriggerClientEvent('QBCore:Notify', src, 9, 'you chopped three wood', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
	else
		TriggerClientEvent('QBCore:Notify', src, 9, 'you\'re axe got stuck, no wood this time!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)