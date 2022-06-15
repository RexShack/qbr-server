Config = {}

Config.cardTypes = { "visa", "mastercard"}

Config.ATMModels = {
    -- "prop_atm_01",
    -- "prop_atm_02",
    -- "prop_atm_03",
    -- "prop_fleeca_atm"
}

Config.BankLocations = {
    {name = 'Bank of Rhodes',           bankType = "BANKS",     coords = vector3(1292.307, -1301.539, 77.04012),    showblip = true},
    {name = 'Lemoyne National Bank',    bankType = "BANKS2",    coords = vector3(2644.579, -1292.313, 52.24956),    showblip = true},
    {name = 'Valentine Savings Bank',   bankType = "BANKS3",    coords = vector3(-308.4189, 775.8842, 118.7017),    showblip = true},
    {name = 'First National Bank',      bankType = "BANKS4",    coords = vector3(-813.1633, -1277.486, 43.63771),   showblip = true},
}

Config.BankDoors = { --Doors that will always be open unless robbery has started
	-- Valentine Savings Bank
	2642457609, -- main door
	3886827663, -- main door
	1340831050, -- bared right
	2343746133, -- bared left
	334467483, -- inner door1
	3718620420, -- inner door2
	576950805, -- vault door
	
	-- Bank of Rhodes
	3317756151, -- main door
	3088209306, -- main door
	2058564250, -- inner door1
	3142122679, -- inner door2
	1634148892, -- inner door3
	3483244267, -- vault
  
	-- Lemoyne National Bank Saint Denis
	2158285782, -- main door
	1733501235, -- main door
	2089945615, -- main door
	2817024187, -- main door
	1830999060, -- inner private door
	965922748, -- manager door
	1634115439, -- manager door
	1751238140, -- vault
	
	-- West Elizabeth Co-Operative Bank Blackwater
	531022111, -- main door
	2117902999, -- inner door
	2817192481, -- manager door
	1462330364, -- vault door
	
	-- Bank of Armadillo
	3101287960, -- main door
	3550475905, -- inner door
	1329318347, -- inner door
	1366165179, -- back door
}