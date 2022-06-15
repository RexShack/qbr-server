RegisterNetEvent("hidemenu")
AddEventHandler("hidemenu", function()
    InBank = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        status = "closebank"
    })
end)

RegisterNUICallback("NUIFocusOff", function(data, cb)
    InBank = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        status = "closebank"
    })

    TriggerEvent("debug", 'Banking: Close UI', 2000, 0, 'hud_textures', 'check')
end)

RegisterNetEvent('qbr-banking:client:newCardSuccess')
AddEventHandler('qbr-banking:client:newCardSuccess', function(cardno, ctype)
    SendNUIMessage({
        status = "updateCard",
        number = cardno,
        cardtype = ctype
    })

    TriggerEvent("debug", 'Banking: New ' .. ctype .. ' Card (' .. cardno .. ')', 2000, 0, 'hud_textures', 'check')
end)

RegisterNUICallback("createSavingsAccount", function(data, cb)
    TriggerServerEvent('qbr-banking:createSavingsAccount')
    TriggerEvent("debug", 'Banking: Create Savings Account', 2000, 0, 'hud_textures', 'check')
end)

RegisterNUICallback("doDeposit", function(data, cb)
    if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
        TriggerEvent("debug", 'Banking: Deposit $' .. data.amount, 2000, 0, 'hud_textures', 'check')
        TriggerServerEvent('qbr-banking:doQuickDeposit', data.amount)
        openAccountScreen()
    end
end)

RegisterNUICallback("doWithdraw", function(data, cb)
    if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
        TriggerEvent("debug", 'Banking: Withdraw $' .. data.amount, 2000, 0, 'hud_textures', 'check')
        TriggerServerEvent('qbr-banking:doQuickWithdraw', data.amount, true)
        openAccountScreen()
    end
end)

RegisterNUICallback("doATMWithdraw", function(data, cb)
    if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
        TriggerEvent("debug", 'ATM: Withdraw $' .. data.amount, 2000, 0, 'hud_textures', 'check')
        TriggerServerEvent('qbr-banking:doQuickWithdraw', data.amount, false)
        openAccountScreen()
    end
end)

RegisterNUICallback("savingsDeposit", function(data, cb)
    if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
        TriggerEvent("debug", 'Banking: Savings Deposit ($' .. data.amount .. ')', 2000, 0, 'hud_textures', 'check')
        TriggerServerEvent('qbr-banking:savingsDeposit', data.amount)
        openAccountScreen()
    end
end)

RegisterNUICallback("requestNewCard", function(data, cb)
    TriggerServerEvent('qbr-banking:createNewCard')
end)

RegisterNUICallback("savingsWithdraw", function(data, cb)
    if tonumber(data.amount) ~= nil and tonumber(data.amount) > 0 then
        TriggerEvent("debug", 'Banking: Savings Withdraw ($' .. data.amount .. ')', 2000, 0, 'hud_textures', 'check')
        TriggerServerEvent('qbr-banking:savingsWithdraw', data.amount)
        openAccountScreen()
    end
end)

RegisterNUICallback("doTransfer", function(data, cb)
    if data ~= nil then
        TriggerServerEvent('qbr-banking:initiateTransfer', data)
    end
end)

RegisterNUICallback("createDebitCard", function(data, cb)
    if data.pin ~= nil then
        TriggerServerEvent('qbr-banking:createBankCard', data.pin)
    end
end)

RegisterNUICallback("lockCard", function(data, cb)
    TriggerServerEvent('qbr-banking:toggleCard', true)
end)

RegisterNUICallback("unLockCard", function(data, cb)
    TriggerServerEvent('qbr-banking:toggleCard', false)
end)

RegisterNUICallback("updatePin", function(data, cb)
    if data.pin ~= nil then
        TriggerServerEvent('qbr-banking:updatePin', data.pin)
        TriggerEvent("debug", 'Banking: Update Pin (' .. data.pin .. ')', 2000, 0, 'hud_textures', 'check')
    end
end)
