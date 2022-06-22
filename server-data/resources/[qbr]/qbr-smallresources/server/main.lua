exports['qbr-core']:AddCommand("id", "Check Your ID #", {}, false, function(source)
	TriggerClientEvent('QBCore:Notify', source, 9,  "ID: "..source, 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
end)

exports['qbr-core']:AddCommand("cid", "Check Your Citizen ID #", {}, false, function(source)
    local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local Playercid = Player.PlayerData.citizenid
	TriggerClientEvent('QBCore:Notify', source, 9,  "Citizen ID: "..Playercid, 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
end)

exports['qbr-core']:CreateCallback('smallresources:server:GetCurrentPlayers', function(source, cb)
    local TotalPlayers = 0
    for k, v in pairs(exports['qbr-core']:GetQBPlayers()) do
        TotalPlayers = TotalPlayers + 1
    end
    cb(TotalPlayers)
end)