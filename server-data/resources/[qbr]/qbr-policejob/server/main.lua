-- Variables
local Plates = {}
local PlayerStatus = {}
local Casings = {}
local BloodDrops = {}
local FingerDrops = {}
local Objects = {}
local sharedItems = exports['qbr-core']:GetItems()

-- Functions
local function UpdateBlips()
    local dutyPlayers = {}
    local players = exports['qbr-core']:GetQBPlayers()
    for k, v in pairs(players) do
        if (v.PlayerData.job.name == "police" or v.PlayerData.job.name == "ambulance") and v.PlayerData.job.onduty then
            local coords = GetEntityCoords(GetPlayerPed(v.PlayerData.source))
            local heading = GetEntityHeading(GetPlayerPed(v.PlayerData.source))
            dutyPlayers[#dutyPlayers+1] = {
                source = v.PlayerData.source,
                label = v.PlayerData.metadata["callsign"],
                job = v.PlayerData.job.name,
                location = {
                    x = coords.x,
                    y = coords.y,
                    z = coords.z,
                    w = heading
                }
            }
        end
    end
    TriggerClientEvent("police:client:UpdateBlips", -1, dutyPlayers)
end

local function CreateBloodId()
    if BloodDrops then
        local bloodId = math.random(10000, 99999)
        while BloodDrops[bloodId] do
            bloodId = math.random(10000, 99999)
        end
        return bloodId
    else
        local bloodId = math.random(10000, 99999)
        return bloodId
    end
end

local function CreateFingerId()
    if FingerDrops then
        local fingerId = math.random(10000, 99999)
        while FingerDrops[fingerId] do
            fingerId = math.random(10000, 99999)
        end
        return fingerId
    else
        local fingerId = math.random(10000, 99999)
        return fingerId
    end
end

local function CreateCasingId()
    if Casings then
        local caseId = math.random(10000, 99999)
        while Casings[caseId] do
            caseId = math.random(10000, 99999)
        end
        return caseId
    else
        local caseId = math.random(10000, 99999)
        return caseId
    end
end

local function CreateObjectId()
    if Objects then
        local objectId = math.random(10000, 99999)
        while Objects[objectId] do
            objectId = math.random(10000, 99999)
        end
        return objectId
    else
        local objectId = math.random(10000, 99999)
        return objectId
    end
end

local function IsVehicleOwned(plate)
    local result = MySQL.Sync.fetchScalar('SELECT plate FROM player_vehicles WHERE plate = ?', {plate})
    return result
end

local function GetCurrentCops()
    local amount = 0
    local players = exports['qbr-core']:GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    return amount
end

local function DnaHash(s)
    local h = string.gsub(s, ".", function(c)
        return string.format("%02x", string.byte(c))
    end)
    return h
end

-- Commands
exports['qbr-core']:AddCommand("pobject", Lang:t("commands.place_object"), {{name = "type",help = Lang:t("info.poobject_object")}}, true, function(source, args)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    local type = args[1]:lower()
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        if type == "cone" then
            TriggerClientEvent("police:client:spawnCone", src)
        elseif type == "barrier" then
            TriggerClientEvent("police:client:spawnBarrier", src)
        elseif type == "roadsign" then
            TriggerClientEvent("police:client:spawnRoadSign", src)
        elseif type == "tent" then
            TriggerClientEvent("police:client:spawnTent", src)
        elseif type == "light" then
            TriggerClientEvent("police:client:spawnLight", src)
        elseif type == "delete" then
            TriggerClientEvent("police:client:deleteObject", src)
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("error.on_duty_police_only"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

exports['qbr-core']:AddCommand("cuff", Lang:t("commands.cuff_player"), {}, false, function(source, args)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:CuffPlayer", src)
    else
        TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("error.on_duty_police_only"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

exports['qbr-core']:AddCommand("escort", Lang:t("commands.escort"), {}, false, function(source, args)
    local src = source
    TriggerClientEvent("police:client:EscortPlayer", src)
end)

exports['qbr-core']:AddCommand("callsign", Lang:t("commands.callsign"), {{name = "name", help = Lang:t('info.callsign_name')}}, false, function(source, args)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    Player.Functions.SetMetaData("callsign", table.concat(args, " "))
end)

exports['qbr-core']:AddCommand("clearcasings", Lang:t("commands.clear_casign"), {}, false, function(source)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("evidence:client:ClearCasingsInArea", src)
    else
        TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("error.on_duty_police_only"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

exports['qbr-core']:AddCommand("jail", Lang:t("commands.jail_player"), {{name = "id", help = Lang:t('info.player_id')}, {name = "time", help = Lang:t('info.jail_time')}}, true, function(source, args)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        local playerId = tonumber(args[1])
        local time = tonumber(args[2])
        if time > 0 then
            TriggerClientEvent("police:client:JailCommand", src, playerId, time)
        else
            TriggerClientEvent('QBCore:Notify', src, 9, Lang:t('info.jail_time_no'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("error.on_duty_police_only"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

exports['qbr-core']:AddCommand("unjail", Lang:t("commands.unjail_player"), {{name = "id", help = Lang:t('info.player_id')}}, true, function(source, args)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        local playerId = tonumber(args[1])
        TriggerClientEvent("prison:client:UnjailPerson", playerId)
    else
        TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("error.on_duty_police_only"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

exports['qbr-core']:AddCommand("clearblood", Lang:t("commands.clearblood"), {}, false, function(source)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("evidence:client:ClearBlooddropsInArea", src)
    else
        TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("error.on_duty_police_only"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

exports['qbr-core']:AddCommand("seizecash", Lang:t("commands.seizecash"), {}, false, function(source)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:SeizeCash", src)
    else
        TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("error.on_duty_police_only"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

exports['qbr-core']:AddCommand("sc", Lang:t("commands.softcuff"), {}, false, function(source)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    if Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty then
        TriggerClientEvent("police:client:CuffPlayerSoft", src)
    else
        TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("error.on_duty_police_only"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

exports['qbr-core']:AddCommand("takedna", Lang:t("commands.takedna"), {{name = "id", help = Lang:t('info.player_id')}}, true, function(source, args)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    local OtherPlayer = exports['qbr-core']:GetPlayer(tonumber(args[1]))
    if ((Player.PlayerData.job.name == "police") and Player.PlayerData.job.onduty) and OtherPlayer then
        if Player.Functions.RemoveItem("satchel", 1) then
            local info = {
                label = Lang:t('info.dna_sample'),
                type = "dna",
                dnalabel = DnaHash(OtherPlayer.PlayerData.citizenid)
            }
            if Player.Functions.AddItem("evidence_satchel", 1, false, info) then
                TriggerClientEvent("inventory:client:ItemBox", src, sharedItems["evidence_satchel"], "add")
            end
        else
            TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("error.have_evidence_bag"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    end
end)

-- Items
exports['qbr-core']:CreateUseableItem("handcuffs", function(source, item)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) then
        TriggerClientEvent("police:client:CuffPlayerSoft", src)
    end
end)

exports['qbr-core']:CreateUseableItem("moneybag", function(source, item)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) then
        if item.info and item.info ~= "" then
            if Player.PlayerData.job.name ~= "police" then
                if Player.Functions.RemoveItem("moneybag", 1, item.slot) then
                    Player.Functions.AddMoney("cash", tonumber(item.info.cash), "used-moneybag")
                end
            end
        end
    end
end)

exports['qbr-core']:CreateUseableItem("evidence_satchel", function(source, item)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    if Player.Functions.GetItemByName(item.name) then
        if item.info and item.info ~= "" then
            if item.info.type == 'dna' then
                TriggerClientEvent('chat:addMessage', src, item.info.label .. ' | ' .. item.info.dnalabel)
            elseif item.info.type == 'casing' then
                TriggerClientEvent('chat:addMessage', src, item.info.label .. ' | ' .. item.info.serie .. ' - ' .. item.info.ammolabel)
            elseif item.info.type == 'blood' then
                TriggerClientEvent('chat:addMessage', src, item.info.label .. ' | ' .. item.info.dnalabel .. ' (' .. item.info.bloodtype .. ')')
            elseif item.info.type == 'fingerprint' then
                TriggerClientEvent('chat:addMessage', src, item.info.label .. ' | ' .. item.info.fingerprint)
            end
            print(json.encode(item.info))
        end
    end
end)

-- Callbacks
exports['qbr-core']:CreateCallback('police:server:isPlayerDead', function(source, cb, playerId)
    local Player = exports['qbr-core']:GetPlayer(playerId)
    cb(Player.PlayerData.metadata["isdead"])
end)

exports['qbr-core']:CreateCallback('police:GetPlayerStatus', function(source, cb, playerId)
    local Player = exports['qbr-core']:GetPlayer(playerId)
    local statList = {}
    if Player then
        if PlayerStatus[Player.PlayerData.source] and next(PlayerStatus[Player.PlayerData.source]) then
            for k, v in pairs(PlayerStatus[Player.PlayerData.source]) do
                statList[#statList+1] = PlayerStatus[Player.PlayerData.source][k].text
            end
        end
    end
    cb(statList)
end)

exports['qbr-core']:CreateCallback('police:GetDutyPlayers', function(source, cb)
    local dutyPlayers = {}
    local players = exports['qbr-core']:GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            dutyPlayers[#dutyPlayers+1] = {
                source = Player.PlayerData.source,
                label = Player.PlayerData.metadata["callsign"],
                job = Player.PlayerData.job.name
            }
        end
    end
    cb(dutyPlayers)
end)

exports['qbr-core']:CreateCallback('police:GetCops', function(source, cb)
    local amount = 0
    local players = exports['qbr-core']:GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    cb(amount)
end)

exports['qbr-core']:CreateCallback('police:server:IsPoliceForcePresent', function(source, cb)
    local retval = false
    local players = exports['qbr-core']:GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.grade.level >= 2 then
            retval = true
            break
        end
    end
    cb(retval)
end)

-- Events
AddEventHandler('onResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        CreateThread(function()
            MySQL.Async.execute("DELETE FROM stashitems WHERE stash='policetrash'")
        end)
    end
end)

RegisterNetEvent('police:server:policeAlert', function(text)
    local src = source
    local ped = GetPlayerPed(src)
    local coords = GetEntityCoords(ped)
    local players = exports['qbr-core']:GetQBPlayers()
    for k,v in pairs(players) do
        if v.PlayerData.job.name == 'police' and v.PlayerData.job.onduty then
            local alertData = {title = Lang:t('info.new_call'), coords = {coords.x, coords.y, coords.z}, description = text}
            TriggerClientEvent("qb-phone:client:addPoliceAlert", v.PlayerData.source, alertData)
            TriggerClientEvent('police:client:policeAlert', v.PlayerData.source, coords, text)
        end
    end
end)

RegisterNetEvent('police:server:CuffPlayer', function(playerId, isSoftcuff)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    local CuffedPlayer = exports['qbr-core']:GetPlayer(playerId)
    if CuffedPlayer then
        if Player.Functions.GetItemByName("handcuffs") or Player.PlayerData.job.name == "police" then
            TriggerClientEvent("police:client:GetCuffed", CuffedPlayer.PlayerData.source, Player.PlayerData.source, isSoftcuff)
        end
    end
end)

RegisterNetEvent('police:server:EscortPlayer', function(playerId)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(source)
    local EscortPlayer = exports['qbr-core']:GetPlayer(playerId)
    if EscortPlayer then
        if (Player.PlayerData.job.name == "police" or Player.PlayerData.job.name == "ambulance") or (EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or EscortPlayer.PlayerData.metadata["inlaststand"]) then
            TriggerClientEvent("police:client:GetEscorted", EscortPlayer.PlayerData.source, Player.PlayerData.source)
        else
            TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("error.not_cuffed_dead"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    end
end)

RegisterNetEvent('police:server:KidnapPlayer', function(playerId)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(source)
    local EscortPlayer = exports['qbr-core']:GetPlayer(playerId)
    if EscortPlayer then
        if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] or
            EscortPlayer.PlayerData.metadata["inlaststand"] then
            TriggerClientEvent("police:client:GetKidnappedTarget", EscortPlayer.PlayerData.source, Player.PlayerData.source)
            TriggerClientEvent("police:client:GetKidnappedDragger", Player.PlayerData.source, EscortPlayer.PlayerData.source)
        else
            TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("error.not_cuffed_dead"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    end
end)

RegisterNetEvent('police:server:SetPlayerOutVehicle', function(playerId)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(source)
    local EscortPlayer = exports['qbr-core']:GetPlayer(playerId)
    if EscortPlayer then
        if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] then
            TriggerClientEvent("police:client:SetOutVehicle", EscortPlayer.PlayerData.source)
        else
            TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("error.not_cuffed_dead"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    end
end)

RegisterNetEvent('police:server:PutPlayerInVehicle', function(playerId)
    local src = source
    local EscortPlayer = exports['qbr-core']:GetPlayer(playerId)
    if EscortPlayer then
        if EscortPlayer.PlayerData.metadata["ishandcuffed"] or EscortPlayer.PlayerData.metadata["isdead"] then
            TriggerClientEvent("police:client:PutInVehicle", EscortPlayer.PlayerData.source)
        else
            TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("error.not_cuffed_dead"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end
    end
end)

RegisterNetEvent('police:server:BillPlayer', function(playerId, price)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    local OtherPlayer = exports['qbr-core']:GetPlayer(playerId)
    if Player.PlayerData.job.name == "police" then
        if OtherPlayer then
            OtherPlayer.Functions.RemoveMoney("bank", price, "paid-bills")
            TriggerEvent('qb-bossmenu:server:addAccountMoney', "police", price)
            TriggerClientEvent('QBCore:Notify', OtherPlayer.PlayerData.source, Lang:t("info.fine_received", {fine = price}), 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
        end
    end
end)

RegisterNetEvent('police:server:JailPlayer', function(playerId, time)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    local OtherPlayer = exports['qbr-core']:GetPlayer(playerId)
    local currentDate = os.date("*t")
    if currentDate.day == 31 then
        currentDate.day = 30
    end

    if Player.PlayerData.job.name == "police" then
        if OtherPlayer then
            OtherPlayer.Functions.SetMetaData("injail", time)
            OtherPlayer.Functions.SetMetaData("criminalrecord", {
                ["hasRecord"] = true,
                ["date"] = currentDate
            })
            TriggerClientEvent("police:client:SendToJail", OtherPlayer.PlayerData.source, time)
            TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("info.sent_jail_for", {time = time}), 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
        end
    end
end)

RegisterNetEvent('police:server:SetHandcuffStatus', function(isHandcuffed)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    if Player then
        Player.Functions.SetMetaData("ishandcuffed", isHandcuffed)
    end
end)

RegisterNetEvent('police:server:SearchPlayer', function(playerId)
    local src = source
    local SearchedPlayer = exports['qbr-core']:GetPlayer(playerId)
    if SearchedPlayer then
        TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("info.cash_found", {cash = SearchedPlayer.PlayerData.money["cash"]}), 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
        TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, Lang:t("info.being_searched"), 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('police:server:SeizeCash', function(playerId)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    local SearchedPlayer = exports['qbr-core']:GetPlayer(playerId)
    if SearchedPlayer then
        local moneyAmount = SearchedPlayer.PlayerData.money["cash"]
        local info = { cash = moneyAmount }
        SearchedPlayer.Functions.RemoveMoney("cash", moneyAmount, "police-cash-seized")
        Player.Functions.AddItem("moneybag", 1, false, info)
        TriggerClientEvent('inventory:client:ItemBox', src, sharedItems["moneybag"], "add")
        TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, Lang:t("info.cash_confiscated"), 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('police:server:RobPlayer', function(playerId)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    local SearchedPlayer = exports['qbr-core']:GetPlayer(playerId)
    if SearchedPlayer then
        local money = SearchedPlayer.PlayerData.money["cash"]
        Player.Functions.AddMoney("cash", money, "police-player-robbed")
        SearchedPlayer.Functions.RemoveMoney("cash", money, "police-player-robbed")
        TriggerClientEvent('QBCore:Notify', SearchedPlayer.PlayerData.source, Lang:t("info.cash_robbed", {money = money}), 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
        TriggerClientEvent('QBCore:Notify', Player.PlayerData.source, Lang:t("info.stolen_money", {stolen = money}), 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('police:server:UpdateBlips', function()
    -- KEEP FOR REF BUT NOT NEEDED ANYMORE.
end)

RegisterNetEvent('police:server:spawnObject', function(type)
    local src = source
    local objectId = CreateObjectId()
    Objects[objectId] = type
    TriggerClientEvent("police:client:spawnObject", src, objectId, type, src)
end)

RegisterNetEvent('police:server:deleteObject', function(objectId)
    TriggerClientEvent('police:client:removeObject', -1, objectId)
end)

RegisterNetEvent('evidence:server:UpdateStatus', function(data)
    local src = source
    PlayerStatus[src] = data
end)

RegisterNetEvent('evidence:server:CreateBloodDrop', function(citizenid, bloodtype, coords)
    local bloodId = CreateBloodId()
    BloodDrops[bloodId] = {
        dna = citizenid,
        bloodtype = bloodtype
    }
    TriggerClientEvent("evidence:client:AddBlooddrop", -1, bloodId, citizenid, bloodtype, coords)
end)

RegisterNetEvent('evidence:server:CreateFingerDrop', function(coords)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    local fingerId = CreateFingerId()
    FingerDrops[fingerId] = Player.PlayerData.metadata["fingerprint"]
    TriggerClientEvent("evidence:client:AddFingerPrint", -1, fingerId, Player.PlayerData.metadata["fingerprint"], coords)
end)

RegisterNetEvent('evidence:server:ClearBlooddrops', function(blooddropList)
    if blooddropList and next(blooddropList) then
        for k, v in pairs(blooddropList) do
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, v)
            BloodDrops[v] = nil
        end
    end
end)

RegisterNetEvent('evidence:server:AddBlooddropToInventory', function(bloodId, bloodInfo)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    if Player.Functions.RemoveItem("satchel", 1) then
        if Player.Functions.AddItem("evidence_satchel", 1, false, bloodInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, sharedItems["evidence_satchel"], "add")
            TriggerClientEvent("evidence:client:RemoveBlooddrop", -1, bloodId)
            BloodDrops[bloodId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("error.have_evidence_bag"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('evidence:server:AddFingerprintToInventory', function(fingerId, fingerInfo)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    if Player.Functions.RemoveItem("satchel", 1) then
        if Player.Functions.AddItem("evidence_satchel", 1, false, fingerInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, sharedItems["evidence_satchel"], "add")
            TriggerClientEvent("evidence:client:RemoveFingerprint", -1, fingerId)
            FingerDrops[fingerId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("error.have_evidence_bag"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('evidence:server:CreateCasing', function(weapon, coords)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    local casingId = CreateCasingId()
    local sharedWeapons = exports['qbr-core']:GetWeapons()
    local weaponInfo = sharedWeapons[weapon]
    local serieNumber = nil
    if weaponInfo then
        local weaponItem = Player.Functions.GetItemByName(weaponInfo["name"])
        if weaponItem then
            if weaponItem.info and weaponItem.info ~= "" then
                serieNumber = weaponItem.info.serie
            end
        end
    end
    TriggerClientEvent("evidence:client:AddCasing", -1, casingId, weapon, coords, serieNumber)
end)

RegisterNetEvent('police:server:UpdateCurrentCops', function()
    local amount = 0
    local players = exports['qbr-core']:GetQBPlayers()
    for k, v in pairs(players) do
        if v.PlayerData.job.name == "police" and v.PlayerData.job.onduty then
            amount = amount + 1
        end
    end
    TriggerClientEvent("police:SetCopCount", -1, amount)
end)

RegisterNetEvent('evidence:server:ClearCasings', function(casingList)
    if casingList and next(casingList) then
        for k, v in pairs(casingList) do
            TriggerClientEvent("evidence:client:RemoveCasing", -1, v)
            Casings[v] = nil
        end
    end
end)

RegisterNetEvent('evidence:server:AddCasingToInventory', function(casingId, casingInfo)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    if Player.Functions.RemoveItem("satchel", 1) then
        if Player.Functions.AddItem("evidence_satchel", 1, false, casingInfo) then
            TriggerClientEvent("inventory:client:ItemBox", src, sharedItems["evidence_satchel"], "add")
            TriggerClientEvent("evidence:client:RemoveCasing", -1, casingId)
            Casings[casingId] = nil
        end
    else
        TriggerClientEvent('QBCore:Notify', src, 9, Lang:t("error.have_evidence_bag"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('police:server:showFingerprint', function(playerId)
    local src = source
    TriggerClientEvent('police:client:showFingerprint', playerId, src)
    TriggerClientEvent('police:client:showFingerprint', src, playerId)
end)

RegisterNetEvent('police:server:showFingerprintId', function(sessionId)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    local fid = Player.PlayerData.metadata["fingerprint"]
    TriggerClientEvent('police:client:showFingerprintId', sessionId, fid)
    TriggerClientEvent('police:client:showFingerprintId', src, fid)
end)

-- Threads
CreateThread(function()
    while true do
        Wait(1000 * 60 * 10)
        local curCops = GetCurrentCops()
        TriggerClientEvent("police:SetCopCount", -1, curCops)
    end
end)

CreateThread(function()
    while true do
        Wait(5000)
        UpdateBlips()
    end
end)
