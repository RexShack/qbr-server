local sharedItems = exports['qbr-core']:GetItems()

Citizen.CreateThread(function()
	exports['qbr-core']:createPrompt('Tobacco-Factory-1', vector3(1833.4796, -1274.331, 43.351779), 0xF3830D8E, 'Tobacco Factory', {
		type = 'client',
		event = 'rsg_tobaccofactory:client:menu',
		args = { },
	})  
end)

-- menu
RegisterNetEvent('rsg_tobaccofactory:client:menu', function(data)
    exports['qbr-menu']:openMenu({
        {
            header = "| Tobacco Factory |",
            isMenuHeader = true,
        },
        {
            header = "Dry Tobacco Leaves",
            txt = "1 x Tobacco makes 1 x Dry Tabacco Leaf",
            params = {
                event = 'rsg_tobaccofactory:server:drytobaccoleaves',
				isServer = true,
            }
        },
        {
            header = "Make a Cigar",
            txt = "1 x Dry Tobacco Leaves makes 1 x Cigar",
            params = {
                event = "rsg_tobaccofactory:server:makecigar",
				isServer = true,
            }
        },
        {
            header = "Craft Box of Cigars",
            txt = "10 x Cigars makes 1 x Cigar Box",
            params = {
                event = "rsg_tobaccofactory:server:makecigarbox",
				isServer = true,
            }
        },
        {
            header = "Close Menu",
            txt = '',
            params = {
                event = 'qbr-menu:closeMenu',
            }
        },
    })
end)

RegisterNetEvent('rsg_tobaccofactory:client:dryleaves')
AddEventHandler('rsg_tobaccofactory:client:dryleaves', function(amount)
	if amount ~= nil then
		local ticker = (amount * 5000)
		exports['qbr-core']:Progressbar("dry_tobacco", "Dry Tobacco..", ticker, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
			TriggerServerEvent('QBCore:Server:RemoveItem', "tobacco", amount)
			TriggerServerEvent('QBCore:Server:AddItem', "tobaccodry", amount)
			TriggerEvent("inventory:client:ItemBox", sharedItems["tobaccodry"], "add")
			exports['rsg_notify']:DisplayNotification('you dried '..amount..' tobacco leaves', 5000)
        end)
	else
		exports['rsg_notify']:DisplayNotification('you don\'t have any tobacco leaves to dry!', 5000)
	end
end)

RegisterNetEvent('rsg_tobaccofactory:client:makecigar')
AddEventHandler('rsg_tobaccofactory:client:makecigar', function(amount)
	if amount ~= nil then
		local ticker = (amount * 5000)
		exports['qbr-core']:Progressbar("make_cigar", "Making Cigars..", ticker, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
			TriggerServerEvent('QBCore:Server:RemoveItem', "tobaccodry", amount)
			TriggerServerEvent('QBCore:Server:AddItem', "cigar", amount)
			TriggerEvent("inventory:client:ItemBox", sharedItems["cigar"], "add")
			exports['rsg_notify']:DisplayNotification('you made '..amount..' cigars', 5000)
		end)
	else
		exports['rsg_notify']:DisplayNotification('you don\'t have any dry tobacco leaves!', 5000)
	end
end)

RegisterNetEvent('rsg_tobaccofactory:client:makecigarbox')
AddEventHandler('rsg_tobaccofactory:client:makecigarbox', function(amount)
	if amount ~= nil then
		local ticker = (amount * 60000)
		exports['qbr-core']:Progressbar("make_cigarbox", "Packing Box of Cigars..", ticker, false, true, {
            disableMovement = true,
            disableCarMovement = false,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
			TriggerServerEvent('QBCore:Server:RemoveItem', "cigar", 10)
			TriggerServerEvent('QBCore:Server:AddItem', "cigarbox", 1)
			TriggerEvent("inventory:client:ItemBox", sharedItems["cigarbox"], "add")
			exports['rsg_notify']:DisplayNotification('you packed a box of cigars', 5000)
		end)
	else
		exports['rsg_notify']:DisplayNotification('you don\'t have any cigars to pack!', 5000)
	end
end)