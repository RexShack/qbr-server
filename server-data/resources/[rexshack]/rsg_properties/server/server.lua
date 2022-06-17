data = {}
OwnedHouses = {}

-- check house
RegisterServerEvent('rsg_properties:server:checkhouses')
AddEventHandler('rsg_properties:server:checkhouses', function()
	local src = source
    MySQL.Async.fetchAll('SELECT * FROM houses;', {}, function(result)
        if result ~= nil then
            for k,v in pairs(result) do
                table.insert(OwnedHouses, v.id)
            end
		end
		TriggerClientEvent('rsg_properties:client:setblips', src, OwnedHouses)
    end)
end)

local function GetAmmoutOwned(pcitizenid, pcid)
    local HasRented = MySQL.Sync.fetchAll( "SELECT * FROM houses WHERE citizenid = @citizenid AND cid = @cid ", { ['citizenid'] = pcitizenid, ['cid'] = pcid} )
    if #HasRented > 0 then return true end
    return false
end

-- buy house
RegisterServerEvent('rsg_properties:server:buyhouse')
AddEventHandler('rsg_properties:server:buyhouse', function(price, id)
	local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local citizenid = Player.PlayerData.citizenid
	local cid = Player.PlayerData.cid
	local currentBank = Player.Functions.GetMoney('bank')
	local checkowned = GetAmmoutOwned(citizenid, cid)
	if checkowned == false then
		if currentBank > price then
			-- buy house and add to database
			Player.Functions.RemoveMoney('bank', tonumber(price), 'buy-house')
			TriggerClientEvent('rsg_properties:client:buyhouse', src, price, id)
			TriggerEvent("rsg_properties:server:addhousetodb", id, citizenid, cid, price)
			Player.Functions.SetMetaData("house", id)
			-- notify player
			TriggerClientEvent('QBCore:Notify', src, 8, 'House Purchased', 5000, 'you now own this house', 'satchel_textures', 'satchel_nav_sell', 'COLOR_WHITE')
			Wait(5000)
			TriggerClientEvent('QBCore:Notify', src, 8, 'Keys Dispatched', 5000, 'you should now have the keys', 'inventory_items', 'folder_kit_keychain', 'COLOR_WHITE')
		else
			TriggerClientEvent('QBCore:Notify', src, 9, 'you don\'t have enough money in your bank!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	else
		TriggerClientEvent('QBCore:Notify', src, 9, 'you already own a property!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)

-- add owner to database
AddEventHandler("rsg_properties:server:addhousetodb", function(id , citizenid, cid, price)
    MySQL.Async.execute('INSERT INTO houses (`citizenid`, `cid`, `id`, `time`, `price`) VALUES (@citizenid, @cid, @id, @time, @price);',
	{	citizenid = citizenid,
	    cid = cid,
		id = id,
		time = os.time(),
		price = price
	}, function(rowsChanged)
	end)
end)

-----------------------------------DOORS--------------------------------------------

local DoorInfo	= {}

RegisterServerEvent('rsg_properties:updatedoorsv')
AddEventHandler('rsg_properties:updatedoorsv', function(doorID, state, cb)
    local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local phouse = Player.PlayerData.metadata['house']
	if not IsAuthorized(Player.PlayerData.metadata['house'], Config.DoorList[doorID]) then
	TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("error.nokey"), 2000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		return
	else
		TriggerClientEvent('rsg_properties:changedoor', src, doorID, state)
	end
end)

RegisterServerEvent('rsg_properties:updateState')
AddEventHandler('rsg_properties:updateState', function(doorID, state, cb)
    local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	if type(doorID) ~= 'number' then
		return
	end
	if not IsAuthorized(Player.PlayerData.metadata['house'], Config.DoorList[doorID]) then
		return
	end
	DoorInfo[doorID] = {}
	TriggerClientEvent('rsg_properties:setState', -1, doorID, state)
end)

function IsAuthorized(playerHouse, doorID)
	for _,house in pairs(doorID.houseid) do
		if house == playerHouse then
			return true
		end
	end
	return false
end

-----------------------------------END DOORS----------------------------------------