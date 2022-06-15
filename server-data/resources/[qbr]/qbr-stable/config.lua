Config = {}

Config.Stables = {
	Valentine = {
		Pos = vector3(-367.73, 787.72, 116.26),
		Name = 'Stable Valentine',
        	Heading = -30.65,
		SpawnPoint = {
			Pos = vector3(-372.43, 791.79, 116.13),
			CamPos = {x=1, y=-3, z=0},
			Heading = 182.3
        }
    },
	Blackwater = {
		Pos = vector3(-864.84, -1365.96, 43.54),
		Name = 'Stable Blackwater',
        	Heading = -30.65,
		SpawnPoint = {
			Pos = vector3(-867.74, -1361.69, 43.66),
			CamPos = {x=1, y=-3, z=0},
			Heading = 178.59
        }
    },
	SaintDenis = {
		Pos = vector3(2503.13, -1449.08, 46.3),
		Name = 'Stable Saint Denis',
        	Heading = -30.65,
		SpawnPoint = {
			Pos = vector3(2508.41, -1446.89, 46.4),
			CamPos = {x=1, y=-3, z=0},
			Heading = 87.88
        }		
	},
	Annesburg = {
		Pos = vector3(2972.35, 1425.35, 44.67),
		Name = 'Stable Annesburg',
        	Heading = -30.65,
		SpawnPoint = {
			Pos = vector3(2970.43, 1429.35, 44.7),
			CamPos = {x=1, y=-3, z=0},
			Heading = 223.94
        }		
	},
	Rhodes = {
		Pos = vector3(1321.46, -1358.66, 78.39),
		Name = 'Stable Rhodes',
        	Heading = -30.65,
		SpawnPoint = {
			Pos = vector3(1318.74, -1354.64, 78.18),
			CamPos = {x=1, y=-3, z=0},
			Heading = 249.45
        }		
	},
	Tumbleweed = {
		Pos = vector3(-5519.43, -3043.45, -2.39),
		Name = 'Stable Tumbleweed',
        	Heading = 0.0,
		SpawnPoint = {
			Pos = vector3(-5522.14, -3039.16, -2.29),
			CamPos = {x=1, y=-3, z=0},
			Heading = 189.93
        }		
	},		
}

Config.Horses = {
	{
		name = "Arabian",
		["A_C_Horse_Arabian_White"] = {"White", 1500, 1500},
		["A_C_Horse_Arabian_RoseGreyBay"] = {"Rose Grey Bay", 1350, 12350},
		["A_C_Horse_Arabian_Black"] = {"Black", 1250, 1250},
		["A_C_Horse_Arabian_Grey"] = {"Grey", 1150, 1150},
		["A_C_Horse_Arabian_WarpedBrindle_PC"] = {"Warped Brindle", 650, 650},
		["A_C_Horse_Arabian_RedChestnut"] = {"Red Chestnut", 350, 350},
	},
	{
		name = "Ardennes",
		["A_C_Horse_Ardennes_IronGreyRoan"] = {"Iron Grey Roan", 1200, 1200},
		["A_C_Horse_Ardennes_StrawberryRoan"] = {"Strawberry Roan", 450, 450},
		["A_C_Horse_Ardennes_BayRoan"] = {"Bay Roan", 140, 140},
	},	
	{
		name = "Missouri Fox Trotter",
		["A_C_Horse_MissouriFoxTrotter_AmberChampagne"] = {"Amber Champagne", 950, 950},
		["A_C_Horse_MissouriFoxTrotter_SableChampagne"] = {"Sable Champagne", 950, 950},
		["A_C_Horse_MissouriFoxTrotter_SilverDapplePinto"] = {"Silver Dapple Pinto", 950, 950},
	},
	{
		name = "Turkoman",
		["A_C_Horse_Turkoman_Gold"] = {"Gold", 950, 950},
		["A_C_Horse_Turkoman_Silver"] = {"Silver", 950, 950},
		["A_C_Horse_Turkoman_DarkBay"] = {"Dark Bay", 925, 925},
	},
	{
		name = "Appaloosa",
		["A_C_Horse_Appaloosa_BlackSnowflake"] = {"Snow Flake", 900, 900},
		["A_C_Horse_Appaloosa_BrownLeopard"] = {"Brown Leopard", 450, 450},
		["A_C_Horse_Appaloosa_Leopard"] = {"Leopard", 430, 430},
		["A_C_Horse_Appaloosa_FewSpotted_PC"] = {"Few Spotted", 140, 140},
		["A_C_Horse_Appaloosa_Blanket"] = {"Blanket", 200, 200},
		["A_C_Horse_Appaloosa_LeopardBlanket"] = {"Lepard Blanket", 130, 130},
	},	
	{
		name = "Mustang",
		["A_C_Horse_Mustang_GoldenDun"] = {"Golden Dun", 950, 950},
		["A_C_Horse_Mustang_TigerStripedBay"] = {"Tiger Striped Bay", 350, 350},
		["A_C_Horse_Mustang_GrulloDun"] = {"Grullo Dun", 130, 130},
		["A_C_Horse_Mustang_WildBay"] = {"Wild Bay", 130, 130},
	},	
	{
		name = "Thoroughbred",
		["A_C_Horse_Thoroughbred_BlackChestnut"] = {"Black Chestnut", 550, 550},
		["A_C_Horse_Thoroughbred_BloodBay"] = {"Blood Bay", 550, 550},
		["A_C_Horse_Thoroughbred_Brindle"] = {"Brindle", 550, 550},
		["A_C_Horse_Thoroughbred_ReverseDappleBlack"] = {"Reverse Dapple Black", 550, 550},
		["A_C_Horse_Thoroughbred_DappleGrey"] = {"Dapple Grey", 130, 130},
	},	
	{
		name = "Andalusian",
		["A_C_Horse_Andalusian_Perlino"] = {"Perlino", 450, 450},
		["A_C_Horse_Andalusian_RoseGray"] = {"Rose Gray", 440, 440},
		["A_C_Horse_Andalusian_DarkBay"] = {"Dark Bay", 140, 140},
	},	
	{
		name = "Dutch Warmblood",
		["A_C_Horse_DutchWarmblood_ChocolateRoan"] = {"Chocolate Roan", 450, 450},
		["A_C_Horse_DutchWarmblood_SealBrown"] = {"Seal Brown", 150, 150},
		["A_C_Horse_DutchWarmblood_SootyBuckskin"] = {"Sooty Buckskin", 150, 150},
	},
	{
		name = "Nokota",
		["A_C_Horse_Nokota_ReverseDappleRoan"] = {"Reverse Dapple Roan", 450, 450},
		["A_C_Horse_Nokota_BlueRoan"] = {"Blue Roan", 130, 130},
		["A_C_Horse_Nokota_WhiteRoan"] = {"White Roan", 130, 130},
	},
	{
		name = "American Paint",
		["A_C_Horse_AmericanPaint_Greyovero"] = {"Grey Overo", 425, 425},
		["A_C_Horse_AmericanPaint_SplashedWhite"] = {"Splashed White", 140, 140},
		["A_C_Horse_AmericanPaint_Tobiano"] = {"Tobiano", 140, 140},
		["A_C_Horse_AmericanPaint_Overo"] = {"Overo", 130, 130},
	},	
	{
		name = "American Standardbred",
		["A_C_Horse_AmericanStandardbred_SilverTailBuckskin"] = {"Silver Tail Buckskin", 400, 400},
		["A_C_Horse_AmericanStandardbred_PalominoDapple"] = {"Palomino Dapple", 150, 150},
		["A_C_Horse_AmericanStandardbred_Black"] = {"Black", 130, 130},
		["A_C_Horse_AmericanStandardbred_Buckskin"] = {"Buckskin", 130, 130},
	},	
	{
		name = "Kentucky Saddle",
		["A_C_Horse_KentuckySaddle_ButterMilkBuckskin_PC"] = {"Butter Milk Buckskin", 240, 240},
		["A_C_Horse_KentuckySaddle_Black"] = {"Black", 50, 50},
		["A_C_Horse_KentuckySaddle_ChestnutPinto"] = {"Chestnut Pinto", 50, 50},
		["A_C_Horse_KentuckySaddle_Grey"] = {"Grey", 50, 50},
		["A_C_Horse_KentuckySaddle_SilverBay"] = {"Silver Bay", 50, 50},
	},	
	{
		name = "Hungarian Halfbred",
		["A_C_Horse_HungarianHalfbred_DarkDappleGrey"] = {"Dark Dapple Grey", 150, 150},
		["A_C_Horse_HungarianHalfbred_LiverChestnut"] = {"Liver Chestnut", 150, 150},
		["A_C_Horse_HungarianHalfbred_FlaxenChestnut"] = {"Flaxen Chestnut", 130, 130},
		["A_C_Horse_HungarianHalfbred_PiebaldTobiano"] = {"Piebald Tobiano", 130, 130},
	},	
	{
		name = "Suffolk Punch",
		["A_C_Horse_SuffolkPunch_RedChestnut"] = {"Red Chestnut", 150, 150},
		["A_C_Horse_SuffolkPunch_Sorrel"] = {"Sorrel", 120, 120},
	},	
	{
		name = "Tennessee Walker",
		["A_C_Horse_TennesseeWalker_FlaxenRoan"] = {"Flaxen Roan", 150, 150},
		["A_C_Horse_TennesseeWalker_BlackRabicano"] = {"Black Rabicano", 60, 60},
		["A_C_Horse_TennesseeWalker_Chestnut"] = {"Chestnut", 60, 60},
		["A_C_Horse_TennesseeWalker_DappleBay"] = {"Dapple Bay", 60, 60},
		["A_C_Horse_TennesseeWalker_MahoganyBay"] = {"Mahogany Bay", 60, 60},
		["A_C_Horse_TennesseeWalker_RedRoan"] = {"Red Roan", 60, 60},
		["A_C_Horse_TennesseeWalker_GoldPalomino_PC"] = {"Gold Palomino", 60, 60},
	},
	{
		name = "Shire",
		["A_C_Horse_Shire_LightGrey"] = {"Light Grey", 130, 130},
		["A_C_Horse_Shire_RavenBlack"] = {"Raven Black", 130, 130},
		["A_C_Horse_Shire_DarkBay"] = {"Dark Bay", 120, 120},
	},
	{
		name = "Belgian Draft",
		["A_C_Horse_Belgian_BlondChestnut"] = {"Blond Chestnut", 120, 120},
		["A_C_Horse_Belgian_MealyChestnut"] = {"Mealy Chestnut", 120, 120},
	},			
	{
		name = "Morgan",
		["A_C_Horse_Morgan_Palomino"] = {"Palomino", 60, 60},
		["A_C_Horse_Morgan_Bay"] = {"Bay", 55, 55},
		["A_C_Horse_Morgan_BayRoan"] = {"Bay Roan", 55, 55},
		["A_C_Horse_Morgan_FlaxenChestnut"] = {"Flaxen Chestnut", 55, 55},
		["A_C_Horse_Morgan_LiverChestnut_PC"] = {"Liver Chestnut", 55, 55},
	},		
	{
		name = "Other",
		["A_C_Horse_Gang_Dutch"] = {"Gang Duch", 3000, 3000},
		["A_C_HorseMule_01"] = {"Mule", 18, 18},
		["A_C_HorseMulePainted_01"] = {"Zebra", 15, 15},
		["A_C_Donkey_01"] = {"Donkey", 15, 15},
		["A_C_Horse_MP_Mangy_Backup"] = {"Mangy Backup", 15, 15},
	}
}
