local sharedItems = exports['qbr-core']:GetItems()
local smallfishsell = 1
local mediumfishsell = 3
local largefishsell = 5

-- sell small fish
RegisterServerEvent('rsg_fishvendor:server:sellsmallfish')
AddEventHandler('rsg_fishvendor:server:sellsmallfish', function()
    local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local price = 0
	local hassmallfish = false
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if Player.PlayerData.items[k].name == "smallfish" then 
                    price = price + (smallfishsell * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("smallfish", Player.PlayerData.items[k].amount, k)
					hassmallfish = true
                end
            end
        end
		if hassmallfish == true then
			Player.Functions.AddMoney("cash", price, "fish-sold")
			TriggerClientEvent('inventory:client:ItemBox', src, sharedItems["smallfish"], "remove")
			Player.Functions.AddItem('fishmeat', 1)
			TriggerClientEvent('inventory:client:ItemBox', src, sharedItems["fishmeat"], "add")
			TriggerClientEvent('QBCore:Notify', src, 8, 'Fish Sold', 5000, 'you have sold your fish for $'..price, 'inventory_items_mp', 'generic_bundle_fishing', 'COLOR_WHITE')
			hassmallfish = false
		else
			TriggerClientEvent('QBCore:Notify', src, 9, 'you don\'t have any fish to sell!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end
end)

-- sell medium fish
RegisterServerEvent('rsg_fishvendor:server:sellmediumfish')
AddEventHandler('rsg_fishvendor:server:sellmediumfish', function()
    local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local price = 0
	local hasmediumfish = false
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if Player.PlayerData.items[k].name == "mediumfish" then 
                    price = price + (mediumfishsell * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("mediumfish", Player.PlayerData.items[k].amount, k)
					hasmediumfish = true
                end
            end
        end
		if hasmediumfish == true then
			Player.Functions.AddMoney("cash", price, "fish-sold")
			TriggerClientEvent('inventory:client:ItemBox', src, sharedItems["mediumfish"], "remove")
			Player.Functions.AddItem('fishmeat', 2)
			TriggerClientEvent('inventory:client:ItemBox', src, sharedItems["fishmeat"], "add")
			TriggerClientEvent('QBCore:Notify', src, 8, 'Fish Sold', 5000, 'you have sold your fish for $'..price, 'inventory_items_mp', 'generic_bundle_fishing', 'COLOR_WHITE')
			hasmediumfish = false
		else
			TriggerClientEvent('QBCore:Notify', src, 9, 'you don\'t have any fish to sell!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end
end)

-- sell large fish
RegisterServerEvent('rsg_fishvendor:server:selllargefish')
AddEventHandler('rsg_fishvendor:server:selllargefish', function()
    local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local price = 0
	local haslargefish = false
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then 
                if Player.PlayerData.items[k].name == "largefish" then 
                    price = price + (largefishsell * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("largefish", Player.PlayerData.items[k].amount, k)
					haslargefish = true
                end
            end
        end
		if haslargefish == true then
			Player.Functions.AddMoney("cash", price, "fish-sold")
			TriggerClientEvent('inventory:client:ItemBox', src, sharedItems["largefish"], "remove")
			Player.Functions.AddItem('fishmeat', 3)
			TriggerClientEvent('inventory:client:ItemBox', src, sharedItems["fishmeat"], "add")
			TriggerClientEvent('QBCore:Notify', src, 8, 'Fish Sold', 5000, 'you have sold your fish for $'..price, 'inventory_items_mp', 'generic_bundle_fishing', 'COLOR_WHITE')
			haslargefish = false
		else
			TriggerClientEvent('QBCore:Notify', src, 9, 'you don\'t have any fish to sell!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	end
end)