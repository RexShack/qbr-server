-- Functions

local StarterItems = {
    ['apple'] = { amount = 1, item = 'apple' }
}


local function GiveStarterItems(source)
    local Player = exports['qbr-core']:GetPlayer(source)
    for k, v in pairs(StarterItems) do
        Player.Functions.AddItem(v.item, 1)
    end
end

local function loadHouseData()
    local HouseGarages = {}
    local Houses = {}
    local result = MySQL.Sync.fetchAll('SELECT * FROM houselocations')
    if result[1] ~= nil then
        for k, v in pairs(result) do
            local owned = false
            if tonumber(v.owned) == 1 then
                owned = true
            end
            local garage = v.garage ~= nil and json.decode(v.garage) or {}
            Houses[v.name] = {
                coords = json.decode(v.coords),
                owned = v.owned,
                price = v.price,
                locked = true,
                adress = v.label,
                tier = v.tier,
                garage = garage,
                decorations = {},
            }
            HouseGarages[v.name] = {
                label = v.label,
                takeVehicle = garage,
            }
        end
    end
    TriggerClientEvent("qbr-garages:client:houseGarageConfig", -1, HouseGarages)
    TriggerClientEvent("qbr-houses:client:setHouseConfig", -1, Houses)
end

RegisterNetEvent('qbr-multicharacter:server:disconnect', function(source)
    DropPlayer(source, "You have disconnected from QBCore RedM")
end)

RegisterNetEvent('qbr-multicharacter:server:loadUserData', function(cData)
    local src = source
    if exports['qbr-core']:Login(src, cData.citizenid) then
        print('^2[qbr-core]^7 '..GetPlayerName(src)..' (Citizen ID: '..cData.citizenid..') has succesfully loaded!')
        exports['qbr-core']:RefreshCommands(src)
        TriggerClientEvent("qbr-multicharacter:client:closeNUI", src)
        TriggerClientEvent('qbr-spawn:client:setupSpawnUI', src, cData, false)
        TriggerEvent("qbr-log:server:CreateLog", "joinleave", "Loaded", "green", "**".. GetPlayerName(src) .. "** ("..cData.citizenid.." | "..src..") loaded..")
	end
end)

RegisterNetEvent('qbr-multicharacter:server:createCharacter', function(data, enabledhouses)
    local newData = {}
    local src = source
    newData.cid = data.cid
    newData.charinfo = data
    if exports['qbr-core']:Login(src, false, newData) then
        exports['qbr-core']:ShowSuccess(GetCurrentResourceName(), GetPlayerName(src)..' has succesfully loaded!')
        exports['qbr-core']:RefreshCommands(src)
        --[[if enabledhouses then loadHouseData() end]] -- Enable once housing is ready
        TriggerClientEvent("qbr-multicharacter:client:closeNUI", src)
        TriggerClientEvent('qbr-spawn:client:setupSpawnUI', src, newData, true)
        GiveStarterItems(src)
	end
end)

RegisterNetEvent('qbr-multicharacter:server:deleteCharacter', function(citizenid)
    exports['qbr-core']:DeleteCharacter(source, citizenid)
end)

-- Callbacks

exports['qbr-core']:CreateCallback("qb-multicharacter:server:setupCharacters", function(source, cb)
    local license = exports['qbr-core']:GetIdentifier(source, 'license')
    local plyChars = {}
    MySQL.Async.fetchAll('SELECT * FROM players WHERE license = @license', {['@license'] = license}, function(result)
        for i = 1, (#result), 1 do
            result[i].charinfo = json.decode(result[i].charinfo)
            result[i].money = json.decode(result[i].money)
            result[i].job = json.decode(result[i].job)
            plyChars[#plyChars+1] = result[i]
        end
        cb(plyChars)
    end)
end)

exports['qbr-core']:CreateCallback("qb-multicharacter:server:GetNumberOfCharacters", function(source, cb)
    local license = exports['qbr-core']:GetIdentifier(source, 'license')
    local numOfChars = 0
    if next(Config.PlayersNumberOfCharacters) then
        for i, v in pairs(Config.PlayersNumberOfCharacters) do
            if v.license == license then
                numOfChars = v.numberOfChars
                break
            else
                numOfChars = Config.DefaultNumberOfCharacters
            end
        end
    else
        numOfChars = Config.DefaultNumberOfCharacters
    end
    cb(numOfChars)
end)

exports['qbr-core']:CreateCallback("qbr-multicharacter:server:getSkin", function(source, cb, cid)
    MySQL.Async.fetchAll('SELECT * FROM playerskins WHERE citizenid = ? AND active = ?', {cid, 1}, function(result)
        result[1].skin = json.decode(result[1].skin)
        result[1].clothes = json.decode(result[1].clothes)
        cb(result[1])
    end)
end)

-- Commands

exports['qbr-core']:AddCommand("logout", "Logout of Character (Admin Only)", {}, false, function(source)
    exports['qbr-core']:Logout(source)
    TriggerClientEvent('qbr-multicharacter:client:chooseChar', source)
end, 'admin')

exports['qbr-core']:AddCommand("closeNUI", "Close Multi NUI", {}, false, function(source)
    TriggerClientEvent('qb-multicharacter:client:closeNUI', source)
end, 'user')
