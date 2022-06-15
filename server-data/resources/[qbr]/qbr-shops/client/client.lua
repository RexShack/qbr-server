

Citizen.CreateThread(function()
    for store, v in pairs(Config.Locations) do
        exports['qbr-core']:createPrompt(v.name, v.coords, 0xF3830D8E, 'Open ' .. v.name, {
            type = 'client',
            event = 'qbr-shops:openshop',
            args = {v.products, v.name},
        })
        if v.showblip == true then
            local StoreBlip = N_0x554d9d53f696d002(1664425300, v.coords)
            if v.products == "normal" then
                SetBlipSprite(StoreBlip, 1475879922, 52)
                SetBlipScale(StoreBlip, 0.2)
            elseif v.products == "weapons" then
                SetBlipSprite(StoreBlip, -145868367, 1)
                SetBlipScale(StoreBlip, 0.2)
            elseif v.products == "saloon" then
                SetBlipSprite(StoreBlip, 1879260108, 1)
                SetBlipScale(StoreBlip, 0.2)
            elseif v.products == "casino" then
                SetBlipSprite(StoreBlip, 595820042, 1)
                SetBlipScale(StoreBlip, 0.2)
            end
        end
    end
end)

RegisterNetEvent('qbr-shops:openshop')
AddEventHandler('qbr-shops:openshop', function(shopType, shopName)
    local type = shopType
    local shop = shopName
    local ShopItems = {}
    ShopItems.items = {}
    exports['qbr-core']:TriggerCallback('qbr-shops:server:getLicenseStatus', function(result)
        ShopItems.label = shop
        if type == "weapon" then
            if result then
                ShopItems.items =  Config.Products[type]
            else
                for i = 1, #Config.Products[type] do
                    if not Config.Products[type][i].requiresLicense then
                        table.insert(ShopItems.items, Config.Products[type][i])
                    end
                end
            end
        else
            ShopItems.items = Config.Products[type]
        end
        ShopItems.slots = 30
        TriggerServerEvent("inventory:server:OpenInventory", "shop", "Itemshop_"..type, ShopItems) --Review later for visual correction
    end)
end)

RegisterNetEvent('qbr-shops:client:UpdateShop')
AddEventHandler('qbr-shops:client:UpdateShop', function(shopType, itemData, amount)
    TriggerServerEvent('qbr-shops:server:UpdateShopItems', shopType, itemData, amount)
end)

RegisterNetEvent('qbr-shops:client:SetShopItems')
AddEventHandler('qbr-shops:client:SetShopItems', function(shopType, shopProducts)
    Config.Products[shopType] = shopProducts
end)

RegisterNetEvent('qbr-shops:client:RestockShopItems')
AddEventHandler('qbr-shops:client:RestockShopItems', function(shopType, amount)
    print('RESTOCK FUNCTION')
    print(shopType)
    print(amount)
    if Config.Products[shopType] ~= nil then
        for k, v in pairs(Config.Products[shopType]) do
            Config.Products[shopType][k].amount = Config.Products[shopType][k].amount + amount
        end
    end
end)
