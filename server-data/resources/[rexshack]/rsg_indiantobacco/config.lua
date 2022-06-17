Config = Config or {}

Config.Plants = {}

Config.GrowthTimer = 60000 -- 60000 = every 1 min / testing 1000 = 1 seconds

Config.StartingThirst = 100.0
Config.StartingHunger = 100.0

Config.HungerIncrease = 25.0
Config.ThirstIncrease = 25.0

Config.Degrade = {min = 3, max = 5}
Config.QualityDegrade = {min = 8, max = 12}
Config.GrowthIncrease = {min = 10, max = 20}

Config.YieldRewards = {
    {type = "indtobacco", rewardMin = 5, rewardMax = 6, item = 'indtobacco', label = 'Indian Tobacco'},
}

Config.MaxPlantCount = 40

Config.SeedLocations = {
    {x = -362.6657, y = 831.84191, z = 116.8031, h = 27.709245},
}

Config.DrugEffect = 300000 -- 5mins