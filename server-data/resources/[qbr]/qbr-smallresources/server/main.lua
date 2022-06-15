exports['qbr-core']:AddCommand("id", "Check Your ID #", {}, false, function(source)
	TriggerClientEvent('QBCore:Notify', source, 9,  "ID: "..source, 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
end)

exports['qbr-core']:CreateCallback('smallresources:server:GetCurrentPlayers', function(source, cb)
    local TotalPlayers = 0
    for k, v in pairs(exports['qbr-core']:GetQBPlayers()) do
        TotalPlayers = TotalPlayers + 1
    end
    cb(TotalPlayers)
end)