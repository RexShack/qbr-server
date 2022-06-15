

exports['qbr-core']:CreateCallback('qbr-scoreboard:server:GetCurrentPlayers', function(source, cb)
    local TotalPlayers = 0
    for k, v in pairs(exports['qbr-core']:GetPlayers()) do
        TotalPlayers = TotalPlayers + 1
    end
    cb(TotalPlayers)
end)

exports['qbr-core']:CreateCallback('qbr-scoreboard:server:GetActivity', function(source, cb)
    local PoliceCount = 0
    local AmbulanceCount = 0

    for k, v in pairs(exports['qbr-core']:GetPlayers()) do
        local Player = exports['qbr-core']:GetPlayer(v)
        if Player ~= nil then
            if (Player.PlayerData.job.name == "police" and Player.PlayerData.job.onduty) then
                PoliceCount = PoliceCount + 1
            end

            if ((Player.PlayerData.job.name == "ambulance" or Player.PlayerData.job.name == "doctor") and Player.PlayerData.job.onduty) then
                AmbulanceCount = AmbulanceCount + 1
            end
        end
    end

    cb(PoliceCount, AmbulanceCount)
end)

exports['qbr-core']:CreateCallback('qbr-scoreboard:server:GetConfig', function(source, cb)
    cb(Config.IllegalActions)
end)

exports['qbr-core']:CreateCallback('qbr-scoreboard:server:GetPlayersArrays', function(source, cb)
    local players = {}
    for k, v in pairs(exports['qbr-core']:GetPlayers()) do
        local Player = exports['qbr-core']:GetPlayer(v)
        if Player ~= nil then
            players[Player.PlayerData.source] = {}
            players[Player.PlayerData.source].permission = exports['qbr-core']:IsOptin(Player.PlayerData.source)
        end
    end
    cb(players)
end)

RegisterServerEvent('qbr-scoreboard:server:SetActivityBusy')
AddEventHandler('qbr-scoreboard:server:SetActivityBusy', function(activity, bool)
    Config.IllegalActions[activity].busy = bool
    TriggerClientEvent('qbr-scoreboard:client:SetActivityBusy', -1, activity, bool)
end)
