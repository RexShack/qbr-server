

RegisterNetEvent('qbr-afkkick:server:KickForAFK', function()
    local src = source
	DropPlayer(src, 'You Have Been Kicked For Being AFK')
end)

exports['qbr-core']:CreateCallback('qbr-afkkick:server:GetPermissions', function(source, cb)
    local src = source
    local group = exports['qbr-core']:GetPermissions(src)
    cb(group)
end)
