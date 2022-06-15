-- AFK Kick Time Limit (in seconds)
local group = 'user'
local secondsUntilKick = 1800

local prevPos, time = nil, nil

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    exports['qbr-core']:TriggerCallback('qbr-afkkick:server:GetPermissions', function(UserGroup)
        group = UserGroup
    end)
end)

RegisterNetEvent('QBCore:Client:OnPermissionUpdate', function(UserGroup)
    group = UserGroup
end)

CreateThread(function()
    while true do
        Wait(1000)
        local playerPed = PlayerPedId()
        if LocalPlayer.state.isLoggedIn then
            if group == 'user' then
                currentPos = GetEntityCoords(playerPed, true)
                if prevPos ~= nil then
                    if currentPos == prevPos then
                        if time ~= nil then
                            if time > 0 then
                                if time == (900) then
                                    exports['qbr-core']:Notify(9, 'You are AFK and will be kicked in ' .. math.ceil(time / 60) .. ' minutes!', 'error', 10000)
                                elseif time == (600) then
                                    exports['qbr-core']:Notify(9, 'You are AFK and will be kicked in ' .. math.ceil(time / 60) .. ' minutes!', 'error', 10000)
                                elseif time == (300) then
                                    exports['qbr-core']:Notify(9, 'You are AFK and will be kicked in ' .. math.ceil(time / 60) .. ' minutes!', 'error', 10000)
                                elseif time == (150) then
                                    exports['qbr-core']:Notify(9, 'You are AFK and will be kicked in ' .. math.ceil(time / 60) .. ' minutes!', 'error', 10000)
                                elseif time == (60) then
                                    exports['qbr-core']:Notify(9, 'You are AFK and will be kicked in ' .. math.ceil(time / 60) .. ' minute!', 'error', 10000)
                                elseif time == (30) then
                                    exports['qbr-core']:Notify(9, 'You are AFK and will be kicked in ' .. time .. ' seconds!', 'error', 10000)
                                elseif time == (20) then
                                    exports['qbr-core']:Notify(9, 'You are AFK and will be kicked in ' .. time .. ' seconds!', 'error', 10000)
                                elseif time == (10) then
                                    exports['qbr-core']:Notify(9, 'You are AFK and will be kicked in ' .. time .. ' seconds!', 'error', 10000)
                                end
                                time = time - 1
                            else
                                TriggerServerEvent('qbr-afkkick:server:KickForAFK')
                            end
                        else
                            time = secondsUntilKick
                        end
                    else
                        time = secondsUntilKick
                    end
                end
                prevPos = currentPos
            end
        end
    end
end)
