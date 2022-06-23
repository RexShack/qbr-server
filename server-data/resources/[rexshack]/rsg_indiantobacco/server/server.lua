local sharedItems = exports['qbr-core']:GetItems()
local PlantsLoaded = false

-- use seed
exports['qbr-core']:CreateUseableItem("indtobaccoseed", function(source, item)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    TriggerClientEvent('rsg_indiantobacco:client:plantNewSeed', src, 'indtobacco')
    Player.Functions.RemoveItem('indtobaccoseed', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['indtobaccoseed'], "remove")
end)

-- use pipe
exports['qbr-core']:CreateUseableItem("pipe", function(source, item)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
	TriggerClientEvent('rsg_drugs:client:indianboost', src)
end)

Citizen.CreateThread(function()
    while true do
        Wait(5000)
        if PlantsLoaded then
            TriggerClientEvent('rsg_indiantobacco:client:updatePlantData', -1, Config.Plants)
        end
    end
end)

Citizen.CreateThread(function()
    TriggerEvent('rsg_indiantobacco:server:getPlants')
    PlantsLoaded = true
end)

RegisterServerEvent('rsg_indiantobacco:server:savePlant')
AddEventHandler('rsg_indiantobacco:server:savePlant', function(data, plantId)
    local data = json.encode(data)

    MySQL.Async.execute('INSERT INTO indian_plants (properties, plantid) VALUES (@properties, @plantid)', {
        ['@properties'] = data,
        ['@plantid'] = plantId
    })
end)

-- give seed
RegisterServerEvent('rsg_indiantobacco:server:giveSeed')
AddEventHandler('rsg_indiantobacco:server:giveSeed', function()
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    Player.Functions.AddItem('indtobaccoseed', math.random(1, 2))
    TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['indtobaccoseed'], "add")
end)

-- plant seed
RegisterServerEvent('rsg_indiantobacco:server:plantNewSeed')
AddEventHandler('rsg_indiantobacco:server:plantNewSeed', function(type, location)
    local src = source
    local plantId = math.random(111111, 999999)
    local Player = exports['qbr-core']:GetPlayer(src)
    local SeedData = {
        id = plantId, 
        type = type, 
        x = location.x, 
        y = location.y, 
        z = location.z, 
        hunger = Config.StartingHunger, 
        thirst = Config.StartingThirst, 
        growth = 0.0, 
        quality = 100.0, 
        grace = true, 
        beingHarvested = false, 
        planter = Player.PlayerData.citizenid
    }

    local PlantCount = 0

    for k, v in pairs(Config.Plants) do
        if v.planter == Player.PlayerData.citizenid then
            PlantCount = PlantCount + 1
        end
    end

    if PlantCount >= Config.MaxPlantCount then
		TriggerClientEvent('QBCore:Notify', src, 9, 'You already have ' .. Config.MaxPlantCount .. ' plants down', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    else
        table.insert(Config.Plants, SeedData)
        TriggerEvent('rsg_indiantobacco:server:savePlant', SeedData, plantId)
        TriggerEvent('rsg_indiantobacco:server:updatePlants')
    end
end)

RegisterServerEvent('rsg_indiantobacco:server:plantHasBeenHarvested')
AddEventHandler('rsg_indiantobacco:server:plantHasBeenHarvested', function(plantId)
    for k, v in pairs(Config.Plants) do
        if v.id == plantId then
            v.beingHarvested = true
        end
    end
    TriggerEvent('rsg_indiantobacco:server:updatePlants')
end)

RegisterServerEvent('rsg_indiantobacco:server:destroyPlant')
AddEventHandler('rsg_indiantobacco:server:destroyPlant', function(plantId)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)

    for k, v in pairs(Config.Plants) do
        if v.id == plantId then
            table.remove(Config.Plants, k)
        end
    end
	TriggerClientEvent('rsg_indiantobacco:client:removePlantObject', src, plantId)
	TriggerEvent('rsg_indiantobacco:server:PlantRemoved', plantId)
	TriggerEvent('rsg_indiantobacco:server:updatePlants')
	TriggerClientEvent('QBCore:Notify', src, 9, 'you distroyed the plant', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
end)

-- harvest plant
RegisterServerEvent('rsg_indiantobacco:server:harvestPlant')
AddEventHandler('rsg_indiantobacco:server:harvestPlant', function(plantId)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)
    local amount
    local label
    local item
	local poorQuality = false
    local goodQuality = false
	local exellentQuality = false
    local hasFound = false

    for k, v in pairs(Config.Plants) do
        if v.id == plantId then
            for y = 1, #Config.YieldRewards do
                if v.type == Config.YieldRewards[y].type then
                    label = Config.YieldRewards[y].label
                    item = Config.YieldRewards[y].item
                    amount = math.random(Config.YieldRewards[y].rewardMin, Config.YieldRewards[y].rewardMax)
                    local quality = math.ceil(v.quality)
                    hasFound = true
                    table.remove(Config.Plants, k)
					if quality > 0 and quality <= 25 then -- poor
                        poorQuality = true
					elseif quality >= 25 and quality <= 75 then -- good
						goodQuality = true
					elseif quality >= 75 then -- excellent
						exellentQuality = true
                    end
                end
            end
        end
    end
	-- give rewards
    if hasFound then		
        if poorQuality then
			local pooramount = math.random(1,3)
			Player.Functions.AddItem('indtobacco', pooramount)
			TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['indtobacco'], "add")
			TriggerClientEvent('QBCore:Notify', src, 9, 'You harvest '.. pooramount ..' Indian Tobacco', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
        elseif goodQuality then
			local goodamount = math.random(3,6)
			Player.Functions.AddItem('indtobacco', goodamount)
			TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['indtobacco'], "add")
			TriggerClientEvent('QBCore:Notify', src, 9, 'You harvest '.. goodamount ..' Indian Tobacco', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
		elseif exellentQuality then
			local exellentamount = math.random(6,12)
			Player.Functions.AddItem('indtobacco', exellentamount)
			TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['indtobacco'], "add")
			Player.Functions.AddItem('indtobaccoseed', 1)
			TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['indtobaccoseed'], "add")
			TriggerClientEvent('QBCore:Notify', src, 9, 'You harvest '.. exellentamount ..' Indian Tobacco', 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
		else
			print("something went wrong!")
        end
		TriggerClientEvent('rsg_indiantobacco:client:removePlantObject', src, plantId)
        TriggerEvent('rsg_indiantobacco:server:PlantRemoved', plantId)
        TriggerEvent('rsg_indiantobacco:server:updatePlants')
    end
end)

RegisterServerEvent('rsg_indiantobacco:server:updatePlants')
AddEventHandler('rsg_indiantobacco:server:updatePlants', function()
	local src = source
    TriggerClientEvent('rsg_indiantobacco:client:updatePlantData', src, Config.Plants)
end)

-- water plant
RegisterServerEvent('rsg_indiantobacco:server:waterPlant')
AddEventHandler('rsg_indiantobacco:server:waterPlant', function(plantId)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)

    for k, v in pairs(Config.Plants) do
        if v.id == plantId then
            Config.Plants[k].thirst = Config.Plants[k].thirst + Config.ThirstIncrease
            if Config.Plants[k].thirst > 100.0 then
                Config.Plants[k].thirst = 100.0
            end
        end
    end

    Player.Functions.RemoveItem('water', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['water'], "remove")
    TriggerEvent('rsg_indiantobacco:server:updatePlants')
end)

-- feed plant
RegisterServerEvent('rsg_indiantobacco:server:feedPlant')
AddEventHandler('rsg_indiantobacco:server:feedPlant', function(plantId)
    local src = source
    local Player = exports['qbr-core']:GetPlayer(src)

    for k, v in pairs(Config.Plants) do
        if v.id == plantId then
            Config.Plants[k].hunger = Config.Plants[k].hunger + Config.HungerIncrease
            if Config.Plants[k].hunger > 100.0 then
                Config.Plants[k].hunger = 100.0
            end
        end
    end

    Player.Functions.RemoveItem('plant_nutrition', 1)
    TriggerClientEvent('inventory:client:ItemBox', src, sharedItems['plant_nutrition'], "remove")
    TriggerEvent('rsg_indiantobacco:server:updatePlants')
end)

-- update plant
RegisterServerEvent('rsg_indiantobacco:server:updateIndianPlants')
AddEventHandler('rsg_indiantobacco:server:updateIndianPlants', function(id, data)
    local result = MySQL.query.await('SELECT * FROM indian_plants WHERE plantid = @plantid', {
        ['@plantid'] = id
    })

    if result[1] then
        local newData = json.encode(data)
        MySQL.Async.execute('UPDATE indian_plants SET properties = @properties WHERE plantid = @id', {
            ['@properties'] = newData,
            ['@id'] = id
        })
    end
end)

-- remove plant
RegisterServerEvent('rsg_indiantobacco:server:PlantRemoved')
AddEventHandler('rsg_indiantobacco:server:PlantRemoved', function(plantId)
    local result = MySQL.query.await('SELECT * FROM indian_plants')

    if result then
        for i = 1, #result do
            local plantData = json.decode(result[i].properties)
            if plantData.id == plantId then

                MySQL.Async.execute('DELETE FROM indian_plants WHERE id = @id', {
                    ['@id'] = result[i].id
                })

                for k, v in pairs(Config.Plants) do
                    if v.id == plantId then
                        table.remove(Config.Plants, k)
                    end
                end
            end
        end
    end
end)

-- get plant
RegisterServerEvent('rsg_indiantobacco:server:getPlants')
AddEventHandler('rsg_indiantobacco:server:getPlants', function()
    local data = {}
    local result = MySQL.query.await('SELECT * FROM indian_plants')

    if result[1] then
        for i = 1, #result do
            local plantData = json.decode(result[i].properties)
            print(plantData.id)
            table.insert(Config.Plants, plantData)
        end
    end
end)

-- plant timer
Citizen.CreateThread(function()
    while true do
        Wait(Config.GrowthTimer)
        for i = 1, #Config.Plants do
            if Config.Plants[i].growth < 100 then
                if Config.Plants[i].grace then
                    Config.Plants[i].grace = false
                else
                    Config.Plants[i].thirst = Config.Plants[i].thirst - 1
                    Config.Plants[i].hunger = Config.Plants[i].hunger - 1
                    Config.Plants[i].growth = Config.Plants[i].growth + 1

                    if Config.Plants[i].growth > 100 then
                        Config.Plants[i].growth = 100
                    end

                    if Config.Plants[i].hunger < 0 then
                        Config.Plants[i].hunger = 0
                    end

                    if Config.Plants[i].thirst < 0 then
                        Config.Plants[i].thirst = 0
                    end

                    if Config.Plants[i].quality < 25 then
                        Config.Plants[i].quality = 25
                    end

                    if Config.Plants[i].thirst < 75 or Config.Plants[i].hunger < 75 then
                        Config.Plants[i].quality = Config.Plants[i].quality - 1
                    end
                end
            end
            TriggerEvent('rsg_indiantobacco:server:updateIndianPlants', Config.Plants[i].id, Config.Plants[i])
        end
        TriggerEvent('rsg_indiantobacco:server:updatePlants')
    end
end)