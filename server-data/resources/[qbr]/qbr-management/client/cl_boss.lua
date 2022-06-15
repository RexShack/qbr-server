local sharedJobs = exports['qbr-core']:GetJobs()
local PlayerJob = {}
local shownBossMenu = false

-- UTIL
local function CloseMenuFull()
    exports['qbr-menu']:closeMenu()
    shownBossMenu = false
end

local function DrawText3D(v, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(v.x,v.y,v.z)

    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end

local function comma_value(amount)
    local formatted = amount
    while true do
        formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')
        if (k == 0) then
            break
        end
    end
    return formatted
end

AddEventHandler('onResourceStart', function(resource)--if you restart the resource
    if resource == GetCurrentResourceName() then
        Wait(200)
        PlayerJob = exports['qbr-core']:GetPlayerData().job
    end
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = exports['qbr-core']:GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

RegisterNetEvent('qbr-bossmenu:client:OpenMenu', function()
    shownBossMenu = true
    local bossMenu = {
        {
            header = "Boss Menu - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
        },
        {
            header = "📋 Manage Employees",
            txt = "Check your Employees List",
            params = {
                event = "qbr-bossmenu:client:employeelist",
            }
        },
        {
            header = "💛 Hire Employees",
            txt = "Hire Nearby Civilians",
            params = {
                event = "qbr-bossmenu:client:HireMenu",
            }
        },
        {
            header = "🗄️ Storage Access",
            txt = "Open Storage",
            params = {
                event = "qbr-bossmenu:client:Stash",
            }
        },
        {
            header = "🚪 Outfits",
            txt = "See Saved Outfits",
            params = {
                event = "qbr-bossmenu:client:Wardrobe",
            }
        },
        {
            header = "💰 Money Management",
            txt = "Check your Company Balance",
            params = {
                event = "qbr-bossmenu:client:SocietyMenu",
            }
        },
        {
            header = "Exit",
            params = {
                event = "qbr-menu:closeMenu",
            }
        },
    }
    exports['qbr-menu']:openMenu(bossMenu)
end)

RegisterNetEvent('qbr-bossmenu:client:employeelist', function()
    local EmployeesMenu = {
        {
            header = "Manage Employees - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
        },
    }
    exports['qbr-core']:TriggerCallback('qbr-bossmenu:server:GetEmployees', function(cb)
        for _, v in pairs(cb) do
            EmployeesMenu[#EmployeesMenu + 1] = {
                header = v.name,
                txt = v.grade.name,
                params = {
                    event = "qbr-bossmenu:client:ManageEmployee",
                    args = {
                        player = v,
                        work = PlayerJob
                    }
                }
            }
        end
        EmployeesMenu[#EmployeesMenu + 1] = {
            header = "< Return",
            params = {
                event = "qbr-bossmenu:client:OpenMenu",
            }
        }
        exports['qbr-menu']:openMenu(EmployeesMenu)
    end, PlayerJob.name)
end)

RegisterNetEvent('qbr-bossmenu:client:ManageEmployee', function(data)
    local EmployeeMenu = {
        {
            header = "Manage " .. data.player.name .. " - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
        },
    }
    for k, v in pairs(sharedJobs[data.work.name].grades) do
        EmployeeMenu[#EmployeeMenu + 1] = {
            header = v.name,
            txt = "Grade: " .. k,
            params = {
                isServer = true,
                event = "qbr-bossmenu:server:GradeUpdate",
                args = {
                    cid = data.player.empSource,
                    grado = tonumber(k),
                    nomegrado = v.name
                }
            }
        }
    end
    EmployeeMenu[#EmployeeMenu + 1] = {
        header = "Fire Employee",
        params = {
            isServer = true,
            event = "qbr-bossmenu:server:FireEmployee",
            args = data.player.empSource
        }
    }
    EmployeeMenu[#EmployeeMenu + 1] = {
        header = "< Return",
        params = {
            event = "qbr-bossmenu:client:OpenMenu",
        }
    }
    exports['qbr-menu']:openMenu(EmployeeMenu)
end)

RegisterNetEvent('qbr-bossmenu:client:Stash', function()
    TriggerServerEvent("inventory:server:OpenInventory", "stash", "boss_" .. PlayerJob.name, {
        maxweight = 4000000,
        slots = 25,
    })
    TriggerEvent("inventory:client:SetCurrentStash", "boss_" .. PlayerJob.name)
end)

RegisterNetEvent('qbr-bossmenu:client:Wardrobe', function()
    TriggerEvent('qbr-clothing:client:openOutfitMenu')
end)

RegisterNetEvent('qbr-bossmenu:client:HireMenu', function()
    local HireMenu = {
        {
            header = "Hire Employees - " .. string.upper(PlayerJob.label),
            isMenuHeader = true,
        },
    }
    exports['qbr-core']:TriggerCallback('qbr-bossmenu:getplayers', function(players)
        for _, v in pairs(players) do
            if v and v ~= PlayerId() then
                HireMenu[#HireMenu + 1] = {
                    header = v.name,
                    txt = "Citizen ID: " .. v.citizenid .. " - ID: " .. v.sourceplayer,
                    params = {
                        isServer = true,
                        event = "qbr-bossmenu:server:HireEmployee",
                        args = v.sourceplayer
                    }
                }
            end
        end
        HireMenu[#HireMenu + 1] = {
            header = "< Return",
            params = {
                event = "qbr-bossmenu:client:OpenMenu",
            }
        }
        exports['qbr-menu']:openMenu(HireMenu)
    end)
end)

RegisterNetEvent('qbr-bossmenu:client:SocietyMenu', function()
    exports['qbr-core']:TriggerCallback('qbr-bossmenu:server:GetAccount', function(cb)
        local SocietyMenu = {
            {
                header = "Balance: $" .. comma_value(cb) .. " - " .. string.upper(PlayerJob.label),
                isMenuHeader = true,
            },
            {
                header = "💸 Deposit",
                txt = "Deposit Money into account",
                params = {
                    event = "qbr-bossmenu:client:SocetyDeposit",
                    args = comma_value(cb)
                }
            },
            {
                header = "💸 Withdraw",
                txt = "Withdraw Money from account",
                params = {
                    event = "qbr-bossmenu:client:SocetyWithDraw",
                    args = comma_value(cb)
                }
            },
            {
                header = "< Return",
                params = {
                    event = "qbr-bossmenu:client:OpenMenu",
                }
            },
        }
        exports['qbr-menu']:openMenu(SocietyMenu)
    end, PlayerJob.name)
end)

RegisterNetEvent('qbr-bossmenu:client:SocetyDeposit', function(money)
    local deposit = exports['qbr-input']:ShowInput({
        header = "Deposit Money <br> Available Balance: $" .. money,
        submitText = "Confirm",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = 'Amount'
            }
        }
    })
    if deposit then
        if not deposit.amount then return end
        TriggerServerEvent("qbr-bossmenu:server:depositMoney", tonumber(deposit.amount))
    end
end)

RegisterNetEvent('qbr-bossmenu:client:SocetyWithDraw', function(money)
    local withdraw = exports['qbr-input']:ShowInput({
        header = "Withdraw Money <br> Available Balance: $" .. money,
        submitText = "Confirm",
        inputs = {
            {
                type = 'number',
                isRequired = true,
                name = 'amount',
                text = 'Amount'
            }
        }
    })
    if withdraw then
        if not withdraw.amount then return end
        TriggerServerEvent("qbr-bossmenu:server:withdrawMoney", tonumber(withdraw.amount))
    end
end)

-- MAIN THREAD
CreateThread(function()
    while true do
        local pos = GetEntityCoords(PlayerPedId())
        local inRangeBoss = false
        local nearBossmenu = false
        for k, v in pairs(Config.Jobs) do
            if k == PlayerJob.name and PlayerJob.isboss then
                print('1')
                print(#(pos-v))
                if #(pos - v) < 5.0 then
                    inRangeBoss = true
                    if #(pos - v) <= 3.0 then
                        if not shownBossMenu then DrawText3D(v, "~b~E~w~ - Open Job Management") end
                        nearBossmenu = true
                        if IsControlJustReleased(0, Config.Key) then
                            TriggerEvent("qbr-bossmenu:client:OpenMenu")
                        end
                    end

                    if not nearBossmenu and shownBossMenu then
                        CloseMenuFull()
                        shownBossMenu = false
                    end
                end
            end
        end
        if not inRangeBoss then
            Wait(1500)
            if shownBossMenu then
                CloseMenuFull()
                shownBossMenu = false
            end
        end
        Wait(3)
    end
end)
