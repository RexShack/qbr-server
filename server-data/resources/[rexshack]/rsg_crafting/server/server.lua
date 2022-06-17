--------------------------------------------------------------------------

-- get crafting rep
exports['qbr-core']:AddCommand('craftingrep', 'get your crafting reputation', {}, false, function(source)
    local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
    local craftingRep = Player.PlayerData.metadata['craftingrep']
	TriggerClientEvent('QBCore:Notify', src, 9, 'Your Crafting Rep is: '..craftingRep, 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
end)

--------------------------------------------------------------------------

-- use bpcshovel
exports['qbr-core']:CreateUseableItem('bpcshovel', function(source, item)
    local src = source
	local repneeded = Config.ShovelRepRequired
	local Player = exports['qbr-core']:GetPlayer(src)
	local craftingRep = Player.PlayerData.metadata['craftingrep']
	if craftingRep >= repneeded then
		TriggerClientEvent('rsg_crafting:client:shovel', src, item.name)
	else
		TriggerClientEvent('QBCore:Notify', src, 9, 'not enough reputation '..repneeded..' required!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)

-- bpo shovel copy
exports['qbr-core']:CreateUseableItem('bposhovel', function(source, item)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	------------------------
	local bpo = 'bposhovel'
	local bpc = 'bpcshovel'
	local name = 'Shovel'
	local repneeded = Config.ShovelRepRequired
	local copycost = Config.ShovelCopyCost
	------------------------
	local cashBalance = Player.PlayerData.money["cash"]
	local craftingRep = Player.PlayerData.metadata['craftingrep']
	if craftingRep >= repneeded then
		if cashBalance >= copycost then
			Player.Functions.RemoveMoney("cash", copycost, "copy-bpo")
			TriggerClientEvent('rsg_crafting:client:makecopy', src, bpo, bpc, name, copycost)
			TriggerClientEvent('QBCore:Notify', src, 9, '$'..copycost..' taken for the copy', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
		else 
			TriggerClientEvent('QBCore:Notify', src, 9, 'you don\'t have enough cash to do that!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	else
		TriggerClientEvent('QBCore:Notify', src, 9, 'not enough reputation '..repneeded..' required!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)

--------------------------------------------------------------------------

-- use bpcpickaxe
exports['qbr-core']:CreateUseableItem('bpcpickaxe', function(source, item)
    local src = source
	local repneeded = Config.PickaxeRepRequired
	local Player = exports['qbr-core']:GetPlayer(src)
	local craftingRep = Player.PlayerData.metadata['craftingrep']
	if craftingRep >= repneeded then
		TriggerClientEvent('rsg_crafting:client:pickaxe', src, item.name)
	else
		TriggerClientEvent('QBCore:Notify', src, 9, 'not enough reputation '..repneeded..' required!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)

-- bpo pickaxe copy
exports['qbr-core']:CreateUseableItem('bpopickaxe', function(source, item)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	------------------------
	local bpo = 'bpopickaxe'
	local bpc = 'bpcpickaxe'
	local name = 'Pickaxe'
	local repneeded = Config.PickaxeRepRequired
	local copycost = Config.PickaxeCopyCost
	------------------------
	local cashBalance = Player.PlayerData.money["cash"]
	local craftingRep = Player.PlayerData.metadata['craftingrep']
	if craftingRep >= repneeded then
		if cashBalance >= copycost then
			Player.Functions.RemoveMoney("cash", copycost, "copy-bpo")
			TriggerClientEvent('rsg_crafting:client:makecopy', src, bpo, bpc, name, copycost)
			TriggerClientEvent('QBCore:Notify', src, 9, '$'..copycost..' taken for the copy', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
		else 
			TriggerClientEvent('QBCore:Notify', src, 9, 'you don\'t have enough cash to do that!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	else
		TriggerClientEvent('QBCore:Notify', src, 9, 'not enough reputation '..repneeded..' required!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)

--------------------------------------------------------------------------

-- use bpcaxe
exports['qbr-core']:CreateUseableItem('bpcaxe', function(source, item)
    local src = source
	local repneeded = Config.AxeRepRequired
	local Player = exports['qbr-core']:GetPlayer(src)
	local craftingRep = Player.PlayerData.metadata['craftingrep']
	if craftingRep >= repneeded then
		TriggerClientEvent('rsg_crafting:client:axe', src, item.name)
	else
		TriggerClientEvent('QBCore:Notify', src, 9, 'not enough reputation '..repneeded..' required!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)

-- bpoaxe copy
exports['qbr-core']:CreateUseableItem('bpoaxe', function(source, item)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	------------------------
	local bpo = 'bpoaxe'
	local bpc = 'bpcaxe'
	local name = 'Axe'
	local repneeded = Config.AxeRepRequired
	local copycost = Config.AxeCopyCost
	------------------------
	local cashBalance = Player.PlayerData.money["cash"]
	local craftingRep = Player.PlayerData.metadata['craftingrep']
	if craftingRep >= repneeded then
		if cashBalance >= copycost then
			Player.Functions.RemoveMoney("cash", copycost, "copy-bpo")
			TriggerClientEvent('rsg_crafting:client:makecopy', src, bpo, bpc, name, copycost)
			TriggerClientEvent('QBCore:Notify', src, 9, '$'..copycost..' taken for the copy', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
		else 
			TriggerClientEvent('QBCore:Notify', src, 9, 'you don\'t have enough cash to do that!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	else
		TriggerClientEvent('QBCore:Notify', src, 9, 'not enough reputation '..repneeded..' required!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)

--------------------------------------------------------------------------

-- use bpcknife
exports['qbr-core']:CreateUseableItem('bpcknife', function(source, item)
    local src = source
	local repneeded = Config.KnifeRepRequired
	local Player = exports['qbr-core']:GetPlayer(src)
	local craftingRep = Player.PlayerData.metadata['craftingrep']
	if craftingRep >= repneeded then
		TriggerClientEvent('rsg_crafting:client:knife', src, item.name)
	else
		TriggerClientEvent('QBCore:Notify', src, 9, 'not enough reputation '..repneeded..' required!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)

-- bpo weapon knife copy
exports['qbr-core']:CreateUseableItem('bpoknife', function(source, item)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	------------------------
	local bpo = 'bpoknife'
	local bpc = 'bpcknife'
	local name = 'Knife'
	local repneeded = Config.KnifeRepRequired
	local copycost = Config.KnifeCopyCost
	------------------------
	local cashBalance = Player.PlayerData.money["cash"]
	local craftingRep = Player.PlayerData.metadata['craftingrep']
	if craftingRep >= repneeded then
		if cashBalance >= copycost then
			Player.Functions.RemoveMoney("cash", copycost, "copy-bpo")
			TriggerClientEvent('rsg_crafting:client:makecopy', src, bpo, bpc, name, copycost)
			TriggerClientEvent('QBCore:Notify', src, 9, '$'..copycost..' taken for the copy', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
		else 
			TriggerClientEvent('QBCore:Notify', src, 9, 'you don\'t have enough cash to do that!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	else
		TriggerClientEvent('QBCore:Notify', src, 9, 'not enough reputation '..repneeded..' required!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)

--------------------------------------------------------------------------

-- use bpc moonshinekit
exports['qbr-core']:CreateUseableItem('bpcmoonshinekit', function(source, item)
    local src = source
	local repneeded = Config.KnifeRepRequired
	local Player = exports['qbr-core']:GetPlayer(src)
	local craftingRep = Player.PlayerData.metadata['craftingrep']
	if craftingRep >= repneeded then
		TriggerClientEvent('rsg_crafting:client:moonshinekit', src, item.name)
	else
		TriggerClientEvent('QBCore:Notify', src, 9, 'not enough reputation '..repneeded..' required!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)

-- bpo moonshinekit copy
exports['qbr-core']:CreateUseableItem('bpomoonshinekit', function(source, item)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	------------------------
	local bpo = 'bpomoonshinekit'
	local bpc = 'bpcmoonshinekit'
	local name = 'MoonshineKit'
	local repneeded = Config.MoonshineKitRepRequired
	local copycost = Config.MoonshineKitCopyCost
	------------------------
	local cashBalance = Player.PlayerData.money["cash"]
	local craftingRep = Player.PlayerData.metadata['craftingrep']
	if craftingRep >= repneeded then
		if cashBalance >= copycost then
			Player.Functions.RemoveMoney("cash", copycost, "copy-bpo")
			TriggerClientEvent('rsg_crafting:client:makecopy', src, bpo, bpc, name, copycost)
			TriggerClientEvent('QBCore:Notify', src, 9, '$'..copycost..' taken for the copy', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
		else 
			TriggerClientEvent('QBCore:Notify', src, 9, 'you don\'t have enough cash to do that!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	else
		TriggerClientEvent('QBCore:Notify', src, 9, 'not enough reputation '..repneeded..' required!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)

--------------------------------------------------------------------------