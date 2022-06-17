QBShared = QBShared or {}

QBShared.Items = {
	-- rsg items
	['bloodmoney']		= {['name'] = 'bloodmoney',			['label'] = 'Blood Money',		['weight'] = 0,		['type'] = 'item',	['image'] = 'rsg_bloodmoney.png',		['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'blood money'},
	["raw_meat"] 		= {["name"] = "raw_meat", 			["label"] = "BigGame Meat", 	["weight"] = 300, 	["type"] = "item",	["image"] = "rsg_raw_meat.png", 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	["description"] = "ready for cooking"},
	['canoe']			= {['name'] = 'canoe',				['label'] = 'Canoe',			['weight'] = 500,	['type'] = 'item',	['image'] = 'rsg_canoe.png',			['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'deployable canoe'},
	["cooked_meat"]		= {["name"] = "cooked_meat",		["label"] = "Cooked Meat",		["weight"] = 50, 	["type"] = "item",	["image"] = "rsg_cooked_meat.png",		['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	["description"] = "ready to eat"},
	["fishmeat"]		= {["name"] = "fishmeat",			["label"] = "Fish Meat",		["weight"] = 50, 	["type"] = "item",	["image"] = "rsg_fishmeat.png",			['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	["description"] = "ready for cooking"},
	["cooked_fishmeat"]	= {["name"] = "cooked_fishmeat",	["label"] = "Fish Steak",		["weight"] = 50, 	["type"] = "item",	["image"] = "rsg_cooked_fishmeat.png",	['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	["description"] = "ready to eat"},
	["cookkit"]			= {["name"] = "cookkit",			["label"] = "Cooking Kit",		["weight"] = 500, 	["type"] = "item",	["image"] = "rsg_cookkit.png",			['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	["description"] = "used for cooking"},
	['smallfish']		= {['name'] = 'smallfish',			['label'] = 'Small Fish',		['weight'] = 100,	['type'] = 'item',	['image'] = 'rsg_smallfish.png',		['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'used for fishing'},
	['mediumfish']		= {['name'] = 'mediumfish',			['label'] = 'Medium Fish',		['weight'] = 200,	['type'] = 'item',	['image'] = 'rsg_mediumfish.png',		['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'used for fishing'},
	['largefish']		= {['name'] = 'largefish',			['label'] = 'Large Fish',		['weight'] = 300,	['type'] = 'item',	['image'] = 'rsg_largefish.png',		['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'used for fishing'},

	-- crafting bpos
	['bposhovel']			= {['name'] = 'bposhovel',			['label'] = 'BPO Shovel',		['weight'] = 0,		['type'] = 'item',	['image'] = 'bposhovel.png',			['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'blueprint original'},
	['bpopickaxe']			= {['name'] = 'bpopickaxe',			['label'] = 'BPO Pickaxe',		['weight'] = 0,		['type'] = 'item',	['image'] = 'bpopickaxe.png',			['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'blueprint original'},
	['bpoaxe']				= {['name'] = 'bpoaxe',				['label'] = 'BPO Axe',			['weight'] = 0,		['type'] = 'item',	['image'] = 'bpoaxe.png',				['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'blueprint original'},
	['bpoknife']			= {['name'] = 'bpoknife',			['label'] = 'BPO Knife',		['weight'] = 0,		['type'] = 'item',	['image'] = 'bpoknife.png',				['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'blueprint original'},
	['bpomoonshinekit']		= {['name'] = 'bpomoonshinekit',	['label'] = 'BPO Moonshine',	['weight'] = 0,		['type'] = 'item',	['image'] = 'bpomoonshinekit.png',		['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'blueprint original'},
	-- crafting bpcs
	['bpcshovel']			= {['name'] = 'bpcshovel',			['label'] = 'BPC Shovel',		['weight'] = 0,		['type'] = 'item',	['image'] = 'bpcshovel.png',			['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = '3 x Steel 1 x Wood'},
	['bpcpickaxe']			= {['name'] = 'bpcpickaxe',			['label'] = 'BPC Pickaxe',		['weight'] = 0,		['type'] = 'item',	['image'] = 'bpcpickaxe.png',			['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = '3 x Steel 1 x Wood'},
	['bpcaxe']				= {['name'] = 'bpcaxe',				['label'] = 'BPC Axe',			['weight'] = 0,		['type'] = 'item',	['image'] = 'bpcaxe.png',				['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = '3 x Steel 1 x Wood'},
	['bpcknife']			= {['name'] = 'bpcknife',			['label'] = 'BPC Knife',		['weight'] = 0,		['type'] = 'item',	['image'] = 'bpcknife.png',				['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = '2 x Steel 1 x Wood'},
	['bpcmoonshinekit']		= {['name'] = 'bpcmoonshinekit',	['label'] = 'BPC Moonshine',	['weight'] = 0,		['type'] = 'item',	['image'] = 'bpcmoonshinekit.png',		['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = '10 x Copper 5 x Wood 5 x Water 3 x Steel'},
	-- crafting items
	["shovel"]				= {["name"] = "shovel",				["label"] = "Shovel",			["weight"] = 100,	["type"] = "item",	["image"] = "rsg_shovel.png",			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	["description"] = "equipment for digging"},
	["pickaxe"]				= {["name"] = "pickaxe",			["label"] = "Pickaxe",			["weight"] = 100,	["type"] = "item",	["image"] = "rsg_pickaxe.png",			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	["description"] = "equipment for mining"},
	["axe"]					= {["name"] = "axe",				["label"] = "Axe",				["weight"] = 100,	["type"] = "item",	["image"] = "rsg_axe.png",				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	["description"] = "equipment for chopping"},
	["moonshinekit"]		= {["name"] = "moonshinekit",		["label"] = "Moonshine Kit",	["weight"] = 500,	["type"] = "item",	["image"] = "rsg_moonshinekit.png",		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	["description"] = "equipment for making moonshine"},
	-- crafting materials
	["copper"]				= {["name"] = "copper",				["label"] = "Copper",			["weight"] = 100,	["type"] = "item",	["image"] = "rsg_copper.png",			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	["description"] = "crafting material"},
	["aluminum"]			= {["name"] = "aluminum",			["label"] = "Aluminum",			["weight"] = 100,	["type"] = "item",	["image"] = "rsg_aluminum.png",			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	["description"] = "crafting material"},
	["iron"]				= {["name"] = "iron",				["label"] = "Iron",				["weight"] = 100,	["type"] = "item",	["image"] = "rsg_iron.png",				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	["description"] = "crafting material"},
	["steel"]				= {["name"] = "steel",				["label"] = "Steel",			["weight"] = 100,	["type"] = "item",	["image"] = "rsg_steel.png",			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	["description"] = "crafting material"},
	["wood"]				= {["name"] = "wood",				["label"] = "Wood",				["weight"] = 100,	["type"] = "item",	["image"] = "rsg_wood.png",				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	["description"] = "crafting material"},
	['water']				= {['name'] = 'water',				['label'] = 'Water',			['weight'] = 100,	['type'] = 'item',	['image'] = 'rsg_water.png',			['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'just water'},

	-- rsg pets
	['foxhound']		= {['name'] = 'foxhound',		['label'] = 'Fox Hound',		['weight'] = 500,	['type'] = 'item',	['image'] = 'animal_dog_americanfoxhound.png',		['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'American Foxhound'},
	['sheperd']			= {['name'] = 'sheperd',		['label'] = 'Shepherd',			['weight'] = 500,	['type'] = 'item',	['image'] = 'animal_dog_australianshepherd.png',	['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'Australian Sheperd'},
	['coonhound']		= {['name'] = 'coonhound',		['label'] = 'Coon Hound',		['weight'] = 500,	['type'] = 'item',	['image'] = 'animal_dog_bluetickcoonhound.png',		['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'Bluetick Coonhound'},
	['catahoulacur']	= {['name'] = 'catahoulacur',	['label'] = 'Catahoula Cur',	['weight'] = 500,	['type'] = 'item',	['image'] = 'animal_dog_catahoularcur.png',			['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'Catahoula Cur'},
	['bayretriever']	= {['name'] = 'bayretriever',	['label'] = 'Retriever',		['weight'] = 500,	['type'] = 'item',	['image'] = 'animal_dog_chesbayretriever.png',		['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'Ches Bay Retriever'},
	['collie']			= {['name'] = 'collie',			['label'] = 'Collie',			['weight'] = 500,	['type'] = 'item',	['image'] = 'animal_dog_collie.png',				['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'Collie'},
	['hound']			= {['name'] = 'hound',			['label'] = 'Hound',			['weight'] = 500,	['type'] = 'item',	['image'] = 'animal_dog_hound.png',					['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'Hound'},
	['husky']			= {['name'] = 'husky',			['label'] = 'Husky',			['weight'] = 500,	['type'] = 'item',	['image'] = 'animal_dog_husky.png',					['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'Husky'},
	['lab']				= {['name'] = 'lab',			['label'] = 'Lab',				['weight'] = 500,	['type'] = 'item',	['image'] = 'animal_dog_lab.png',					['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'Lab'},
	['poodle']			= {['name'] = 'poodle',			['label'] = 'Poodle',			['weight'] = 500,	['type'] = 'item',	['image'] = 'animal_dog_poodle.png',				['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'Poodle'},
	['street']			= {['name'] = 'street',			['label'] = 'Street',			['weight'] = 500,	['type'] = 'item',	['image'] = 'animal_dog_street.png',				['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	['combinable'] = nil,	['level'] = 0,	['description'] = 'Street'},
	
	-- qbr default items
 	['water_bottle'] 			= {['name'] = 'water_bottle', 			['label'] = 'Bottle of Water', 				['weight'] = 500, 		['type'] = 'item', 				['image'] = 'generic_bottle.png', 			['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0,		['description'] = 'For all the thirsty out there'},
 	['bread'] 					= {['name'] = 'bread', 					['label'] = 'Bread Roll', 					['weight'] = 125, 		['type'] = 'item', 				['image'] = 'consumable_bread_roll.png', 	['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0,		['description'] = 'A small bread roll'},
 	['chocolate'] 				= {['name'] = 'chocolate', 				['label'] = 'Chocolate Bar', 				['weight'] = 100, 		['type'] = 'item', 				['image'] = 'consumable_chocolate_bar.png', ['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0,		['description'] = 'A nice little comfort snack'},
	['sandwich'] 				= {['name'] = 'sandwich', 			 	['label'] = 'Sandwich', 					['weight'] = 125, 		['type'] = 'item', 				['image'] = 'bread.png', 					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,    	['level'] = 0,		['description'] = 'A sandwich with toppings.'},
	['beer'] 					= {['name'] = 'beer', 			  	  	['label'] = 'Beer', 						['weight'] = 500, 		['type'] = 'item', 				['image'] = 'beer.png', 					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,    	['level'] = 0,		['description'] = 'For all the thirsty out there'},
	['whiskey'] 				= {['name'] = 'whiskey', 			  	['label'] = 'Whiskey', 						['weight'] = 500, 		['type'] = 'item', 				['image'] = 'whiskey.png', 					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,    	['level'] = 0,		['description'] = 'For all the thirsty out there'},
	['vodka'] 					= {['name'] = 'vodka', 			  	  	['label'] = 'Vodka', 						['weight'] = 500, 		['type'] = 'item', 				['image'] = 'vodka.png', 					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,    	['level'] = 0,		['description'] = 'For all the thirsty out there'},
	['coffee'] 					= {['name'] = 'coffee', 				['label'] = 'Coffee', 						['weight'] = 200, 		['type'] = 'item', 				['image'] = 'coffee.png', 					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,    	['level'] = 0,		['description'] = 'S rustic pick me up'},
	['cigarette'] 				= {['name'] = 'cigarette', 			 	['label'] = 'Cigarette',	    			['weight'] = 1,			['type'] = 'item', 				['image'] = 'cigarette.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,    	['level'] = 0,		['description'] = 'A little bit of goodness'},
	['cigar'] 					= {['name'] = 'cigar', 			 	  	['label'] = 'Cigar',	    				['weight'] = 1,			['type'] = 'item', 				['image'] = 'cigar.png', 					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,   ['combinable'] = nil,    	['level'] = 0,		['description'] = 'A relief from stress'},
	['lighter'] 				= {['name'] = 'lighter', 			  	['label'] = 'Lighter', 						['weight'] = 0, 		['type'] = 'item', 				['image'] = 'lighter.png', 					['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,    	['level'] = 0,		['description'] = 'On new years eve a nice fire to stand next to'},
	['apple'] 					= {['name'] = 'apple', 					['label'] = 'Apple',						['weight'] = 100,		['type'] = 'item', 				['image'] = 'consumable_apple.png',					['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0,		['description'] = 'An apple a day keeps my stomach filled. No worries about a fricking scurvy. It is only natural that it keeps the doctor away'},
	['bandage'] 				= {['name'] = 'bandage', 				['label'] = 'Bandage', 		    			['weight'] = 0, 		['type'] = 'item', 				['image'] = 'bandage.png', 		    		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0,      ['description'] = 'bandage.'},
	['painkillers'] 			= {['name'] = 'painkillers', 			['label'] = 'painkillers', 					['weight'] = 0, 		['type'] = 'item', 				['image'] = 'painkillers.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0,      ['description'] = 'painkillers.'},
	['firstaid'] 				= {['name'] = 'firstaid', 				['label'] = 'firstaid', 					['weight'] = 0, 		['type'] = 'item', 				['image'] = 'firstaid.png', 				['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0,      ['description'] = 'firstaid.'},
	['cannedbeans'] 			= {['name'] = 'cannedbeans', 			['label'] = 'Beans in a can',				['weight'] = 100,		['type'] = 'item', 				['image'] = 'cannedbeans.png',				['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0,		['description'] = 'Canned beans, not something somebody would want to eat willingly. Atleast I can now make a bean joke about it'},
	['coins1'] 			        = {['name'] = 'coins1', 			    ['label'] = '1 coins',				        ['weight'] = 100,		['type'] = 'item', 				['image'] = 'coins.png',				    ['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0,		['description'] = 'Coins'},
	['coins5'] 			        = {['name'] = 'coins5', 			    ['label'] = '5 coins',				        ['weight'] = 100,		['type'] = 'item', 				['image'] = 'coins.png',				    ['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0,		['description'] = 'Coins'},
	['coins10'] 		        = {['name'] = 'coins10', 			    ['label'] = '5 coins',				        ['weight'] = 100,		['type'] = 'item', 				['image'] = 'coins.png',				    ['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0,		['description'] = 'Coins'},
	['metalscrap'] 				= {['name'] = 'metalscrap', 			['label'] = 'Metalscrap',					['weight'] = 100,		['type'] = 'item', 				['image'] = 'metalscrap.png',				['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0,		['description'] = 'Placeholder'},
	['plastic'] 				= {['name'] = 'plastic', 				['label'] = 'Plastic',						['weight'] = 100,		['type'] = 'item', 				['image'] = 'plastic.png',					['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0,		['description'] = 'Placeholder'},
	['lockpick'] 				= {['name'] = 'lockpick', 				['label'] = 'Lockpick',						['weight'] = 100,		['type'] = 'item', 				['image'] = 'lockpick.png',					['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0,		['description'] = 'Placeholder'},
	['coffeeseeds'] 			= {['name'] = 'coffeeseeds', 			['label'] = 'Coffeeseeds',					['weight'] = 100,		['type'] = 'item', 				['image'] = 'seed_weed.png',				['unique'] = false,		['useable'] = true,		['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0,		['description'] = 'Placeholder'},
	['cash'] 					= {['name'] = 'cash', 					['label'] = 'Cash',							['weight'] = 0,			['type'] = 'item', 				['image'] = 'money_moneyclip.png',			['unique'] = false,		['useable'] = false,	['shouldClose'] = false,  ['combinable'] = true,	['level'] = 0,		['description'] = 'Cash'},
	['satchel'] 				= {['name'] = 'satchel', 				['label'] = 'Satchel',						['weight'] = 0,			['type'] = 'item', 				['image'] = 'clothing_satchel_001.png',		['unique'] = false,		['useable'] = false,	['shouldClose'] = false,  ['combinable'] = false,	['level'] = 0,		['description'] = 'A Satchel'},
	['evidence_satchel'] 		= {['name'] = 'evidence_satchel', 		['label'] = 'Evidence Satchel',				['weight'] = 200,		['type'] = 'item', 				['image'] = 'clothing_satchel_001.png',		['unique'] = true,		['useable'] = false,	['shouldClose'] = false,  ['combinable'] = false,	['level'] = 0,		['description'] = 'A Satchel filled with evidence'},
	['moneybag'] 				= {['name'] = 'moneybag', 				['label'] = 'Moneybag',						['weight'] = 0,			['type'] = 'item', 				['image'] = 'money_coinpurse.png',			['unique'] = true,		['useable'] = true,		['shouldClose'] = true,	  ['combinable'] = false,	['level'] = 0,		['description'] = 'A bag filled with money'},

	--AMMO
	['ammo_repeater'] 			= {['name'] = 'ammo_repeater', 			['label'] = 'Ammo Repeater', 				['weight'] = 200, 		['type'] = 'item',				['image'] = 'ammo_bullet_normal.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0, 		['description'] = 'Repeater Ammo'},
	['ammo_revolver'] 			= {['name'] = 'ammo_revolver', 			['label'] = 'Ammo Revolver', 				['weight'] = 200, 		['type'] = 'item',				['image'] = 'ammo_bullet_normal.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0, 		['description'] = 'Revolver Ammo'},
	['ammo_rifle'] 				= {['name'] = 'ammo_rifle', 			['label'] = 'Ammo Rifle', 					['weight'] = 200, 		['type'] = 'item',				['image'] = 'ammo_bullet_normal.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0, 		['description'] = 'Rifle Ammo'},
	['ammo_pistol'] 			= {['name'] = 'ammo_pistol', 			['label'] = 'Ammo Pistol', 					['weight'] = 200, 		['type'] = 'item',				['image'] = 'ammo_bullet_normal.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0, 		['description'] = 'Pistol Ammo'},
	['ammo_shotgun'] 			= {['name'] = 'ammo_shotgun', 			['label'] = 'Ammo Shotgun', 				['weight'] = 200, 		['type'] = 'item',				['image'] = 'ammo_bullet_normal.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0, 		['description'] = 'Shotgun Ammo'},
	['ammo_arrow'] 				= {['name'] = 'ammo_arrow', 			['label'] = 'Arrow', 						['weight'] = 200, 		['type'] = 'item',				['image'] = 'ammo_bullet_normal.png', 		['unique'] = false, 	['useable'] = true, 	['shouldClose'] = true,	  ['combinable'] = nil,		['level'] = 0, 		['description'] = 'Arrow'},

	-- WEAPONS
	['weapon_revolver_cattleman'] 				= {['name'] = 'weapon_revolver_cattleman', 				['attachPoint'] = 2,  		['label'] = 'Colt M1873 Single Action',			['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_REVOLVER', 			['image'] = 'weapon_revolver_cattleman.png',				['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Every cowboy has a first. And this revolver will probably be it'},
	['weapon_revolver_cattleman_mexican'] 		= {['name'] = 'weapon_revolver_cattleman_mexican', 		['attachPoint'] = 2,		['label'] = 'Steel Colt M1873',					['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_REVOLVER', 			['image'] = 'weapon_revolver_cattleman_mexican.png',		['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Every cowboy has a first. And this revolver will probably be it, for the rich cowboys atleast'},
	['weapon_revolver_doubleaction_gambler'] 	= {['name'] = 'weapon_revolver_doubleaction_gambler', 	['attachPoint'] = 2, 		['label'] = 'Colt M1892 Double-action',			['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_REVOLVER', 			['image'] = 'weapon_revolver_doubleaction_gambler.png',		['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_revolver_schofield'] 				= {['name'] = 'weapon_revolver_schofield', 				['attachPoint'] = 2,		['label'] = 'Smith & Wesson No. 3',				['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_REVOLVER', 			['image'] = 'weapon_revolver_schofield.png',				['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_revolver_lemat'] 					= {['name'] = 'weapon_revolver_lemat', 					['attachPoint'] = 2, 		['label'] = 'LeMat Revolver',					['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_REVOLVER', 			['image'] = 'weapon_revolver_lemat.png',					['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_revolver_navy'] 					= {['name'] = 'weapon_revolver_navy', 					['attachPoint'] = 2,		['label'] = 'Navy Revolver 1851',				['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_REVOLVER', 			['image'] = 'weapon_revolver_navy.png',						['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_pistol_volcanic'] 					= {['name'] = 'weapon_pistol_volcanic', 				['attachPoint'] = 2, 		['label'] = 'Volcanic Pistol',					['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_PISTOL',	 			['image'] = 'weapon_pistol_volcanic.png',					['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_pistol_m1899'] 					= {['name'] = 'weapon_pistol_m1899', 					['attachPoint'] = 2,		['label'] = 'FN Browning M1900',				['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_PISTOL',	 			['image'] = 'weapon_pistol_m1899.png',						['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_pistol_mauser'] 					= {['name'] = 'weapon_pistol_mauser', 					['attachPoint'] = 2,		['label'] = 'Mauser C96',						['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_PISTOL',	 			['image'] = 'weapon_pistol_mauser.png',						['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_pistol_semiauto'] 					= {['name'] = 'weapon_pistol_semiauto', 				['attachPoint'] = 2,		['label'] = 'Borchardt C-93',					['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_PISTOL',	 			['image'] = 'weapon_pistol_semiauto.png',					['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_repeater_carbine'] 				= {['name'] = 'weapon_repeater_carbine', 				['attachPoint'] = 9, 		['label'] = 'Spencer Model 1865',				['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_REPEATER',	 			['image'] = 'weapon_repeater_carbine.png',					['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_repeater_winchester'] 				= {['name'] = 'weapon_repeater_winchester', 			['attachPoint'] = 9,		['label'] = 'Winchester Model 1866',			['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_REPEATER',	 			['image'] = 'weapon_repeater_winchester.png',				['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_repeater_henry'] 					= {['name'] = 'weapon_repeater_henry', 					['attachPoint'] = 9,		['label'] = 'Henry Model 1860',					['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_REPEATER',	 			['image'] = 'weapon_repeater_henry.png',					['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_repeater_evans'] 					= {['name'] = 'weapon_repeater_evans', 					['attachPoint'] = 9,		['label'] = 'Evans Repeating Rifle',			['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_REPEATER',	 			['image'] = 'weapon_repeater_evans.png',					['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_rifle_varmint'] 					= {['name'] = 'weapon_rifle_varmint', 					['attachPoint'] = 9,		['label'] = 'Winchester Model 1890',			['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_RIFLE',	 			['image'] = 'weapon_rifle_varmint.png',						['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_rifle_springfield'] 				= {['name'] = 'weapon_rifle_springfield', 				['attachPoint'] = 9,		['label'] = 'Springfield Model 1873',			['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_RIFLE',	 			['image'] = 'weapon_rifle_springfield.png',					['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_rifle_boltaction'] 				= {['name'] = 'weapon_rifle_boltaction', 				['attachPoint'] = 9,		['label'] = 'Springfield Model 1892',			['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_RIFLE',	 			['image'] = 'weapon_rifle_boltaction.png',					['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_rifle_elephant'] 					= {['name'] = 'weapon_rifle_elephant', 					['attachPoint'] = 9,		['label'] = 'Elephant Rifle',					['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_RIFLE',	 			['image'] = 'weapon_rifle_elephant.png',					['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_shotgun_doublebarrel'] 			= {['name'] = 'weapon_shotgun_doublebarrel', 			['attachPoint'] = 9,		['label'] = 'Colt Hammer Shotgun 1878',			['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_SHOTGUN',	 			['image'] = 'weapon_shotgun_doublebarrel.png',				['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_shotgun_doublebarrel_exotic'] 		= {['name'] = 'weapon_shotgun_doublebarrel_exotic', 	['attachPoint'] = 9,		['label'] = 'Steel Hammer Shotgun 1878',		['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_SHOTGUN',	 			['image'] = 'weapon_shotgun_doublebarrel_exotic.png',		['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_shotgun_sawedoff'] 				= {['name'] = 'weapon_shotgun_sawedoff', 				['attachPoint'] = 9,		['label'] = 'Hamerless Shotgun 1883',			['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_SHOTGUN',	 			['image'] = 'weapon_shotgun_sawedoff.png',					['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_shotgun_semiauto'] 				= {['name'] = 'weapon_shotgun_semiauto', 				['attachPoint'] = 9,		['label'] = 'Browning Auto-5',					['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_SHOTGUN',	 			['image'] = 'weapon_shotgun_semiauto.png',					['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_sniperrifle_rollingblock'] 		= {['name'] = 'weapon_sniperrifle_rollingblock', 		['attachPoint'] = 10, 		['label'] = 'Remington M1867',					['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_RIFLE',	 			['image'] = 'weapon_sniperrifle_rollingblock.png',			['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_sniperrifle_rollingblock_exotic'] 	= {['name'] = 'weapon_sniperrifle_rollingblock_exotic', ['attachPoint'] = 10, 		['label'] = 'Steel Remington M1867',			['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_RIFLE',	 			['image'] = 'weapon_sniperrifle_rollingblock_exotic.png',	['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_sniperrifle_carcano'] 				= {['name'] = 'weapon_sniperrifle_carcano',				['attachPoint'] = 10, 	 	['label'] = 'Carcano 1891 Short Rifle',			['weight'] = 1000,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_RIFLE',	 			['image'] = 'weapon_sniperrifle_carcano.png',				['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_bow'] 								= {['name'] = 'weapon_bow', 							['attachPoint'] = 7,		['label'] = 'Flatbow',							['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_ARROW',	 			['image'] = 'weapon_bow.png',								['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_bow_improved'] 					= {['name'] = 'weapon_bow_improved', 					['attachPoint'] = 7,		['label'] = 'Sturdy Flatbow',					['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = 'AMMO_ARROW',	 			['image'] = 'weapon_bow_improved.png',						['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_lasso'] 							= {['name'] = 'weapon_lasso', 							['attachPoint'] = 5, 		['label'] = 'Lasso',							['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = nil,	 						['image'] = 'weapon_lasso.png',								['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_lasso_reinforced'] 				= {['name'] = 'weapon_lasso_reinforced',  				['attachPoint'] = 5,		['label'] = 'Sturdy Lasso',						['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = nil,	 						['image'] = 'weapon_lasso_reinforced.png',					['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_melee_knife'] 						= {['name'] = 'weapon_melee_knife', 					['attachPoint'] = 4, 		['label'] = 'Knife',							['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = nil,	 						['image'] = 'weapon_melee_knife.png',						['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_melee_knife_jawbone'] 				= {['name'] = 'weapon_melee_knife_jawbone', 			['attachPoint'] = 4, 		['label'] = 'Jawbone Knife',					['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = nil,	 						['image'] = 'weapon_melee_knife_jawbone.png',				['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_melee_hammer'] 					= {['name'] = 'weapon_melee_hammer', 					['attachPoint'] = 13,		['label'] = 'Hammer',							['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = nil,	 						['image'] = 'weapon_melee_hammer.png',						['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_thrown_dynamite']					= {['name'] = 'weapon_thrown_dynamite', 				['attachPoint'] = 6,		['label'] = 'Throwable Dynamite',				['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = nil,	 						['image'] = 'weapon_thrown_dynamite.png',					['unique'] = false,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_thrown_molotov']					= {['name'] = 'weapon_thrown_molotov',					['attachPoint'] = 6, 		['label'] = 'Throwable Molotov',				['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = nil,	 						['image'] = 'weapon_thrown_molotov.png',					['unique'] = false,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_thrown_throwing_knives'] 			= {['name'] = 'weapon_thrown_throwing_knives', 			['attachPoint'] = 6,		['label'] = 'Throwing Knives',					['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = nil,	 						['image'] = 'weapon_thrown_throwing_knives.png',			['unique'] = false,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_thrown_tomahawk'] 					= {['name'] = 'weapon_thrown_tomahawk',					['attachPoint'] = 6,		['label'] = 'Throwable Axe',					['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = nil,	 						['image'] = 'weapon_thrown_tomahawk.png',					['unique'] = false,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_thrown_tomahawk_ancient'] 			= {['name'] = 'weapon_thrown_tomahawk_ancient', 		['attachPoint'] = 6,		['label'] = 'Throwable Old Axe',				['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = nil,	 						['image'] = 'weapon_thrown_tomahawk_ancient.png',			['unique'] = false,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_thrown_bolas'] 					= {['name'] = 'weapon_thrown_bolas',					['attachPoint'] = 6,		['label'] = 'Throwable Bolas',					['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = nil,	 						['image'] = 'weapon_thrown_bolas.png',						['unique'] = false,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_melee_cleaver'] 					= {['name'] = 'weapon_melee_cleaver',		 			['attachPoint'] = 3,		['label'] = 'Throwable Cleaver', 				['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = nil,	 						['image'] = 'weapon_melee_cleaver.png',						['unique'] = false,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_melee_lantern'] 					= {['name'] = 'weapon_melee_lantern',					['attachPoint'] = 11,		['label'] = 'Silver Lantern',					['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = nil,	 						['image'] = 'weapon_melee_lantern.png',						['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_melee_davy_lantern'] 				= {['name'] = 'weapon_melee_davy_lantern',				['attachPoint'] = 11,		['label'] = 'Golden Lantern', 					['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = nil,	 						['image'] = 'weapon_melee_davy_lantern.png',				['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_melee_torch'] 						= {['name'] = 'weapon_melee_torch',						['attachPoint'] = 13, 		['label'] = 'Wooden Torch',  					['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = nil,	 						['image'] = 'weapon_melee_torch.png',						['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_melee_hatchet'] 					= {['name'] = 'weapon_melee_hatchet',					['attachPoint'] = 13, 		['label'] = 'Hatchet',							['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = nil,	 						['image'] = 'weapon_melee_hatchet.png',						['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_melee_machete'] 					= {['name'] = 'weapon_melee_machete',					['attachPoint'] = 13, 		['label'] = 'Machete',							['weight'] = 100,	['type'] = 'weapon', 		['ammotype'] = nil,	 						['image'] = 'weapon_melee_machete.png',						['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
	['weapon_kit_metal_detector']  				= {['name'] = 'weapon_kit_metal_detector',  			['attachPoint'] = 11,  		['label'] = 'Metal Detector',  					['weight'] = 100,  	['type'] = 'weapon',  		['ammotype'] = nil,  						['image'] = 'weapon_kit_metal_detector.png',    			['unique'] = true,		['useable'] = true,		['level'] = 0,		['description'] = 'Placeholder'},
}