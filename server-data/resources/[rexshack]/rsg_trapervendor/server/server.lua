-- large
local perfect_large = 10
local good_large = 8
local poor_large = 6
-- medium
local perfect_medium = 8
local good_medium = 6
local poor_medium = 4
-- small
local perfect_small = 4
local good_small = 3
local poor_small = 2
-- bonus
local bonus = 10

RegisterServerEvent("rsg_trappervendor:server:sell")
AddEventHandler("rsg_trappervendor:server:sell", function()
    local src = source
	local Player = exports['qbr-core']:GetPlayer(src)
	local price = 0
	local hasitems = false
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then 
        for k, v in pairs(Player.PlayerData.items) do 
            if Player.PlayerData.items[k] ~= nil then
				-- bear fur
                if Player.PlayerData.items[k].name == "perfect_bear_fur" then 
                    price = price + (perfect_large * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_bear_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_bear_fur" then 
                    price = price + (good_large * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_bear_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_bear_fur" then 
                    price = price + (poor_large * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_bear_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- bighornram hide
				elseif Player.PlayerData.items[k].name == "perfect_bighornram_hide" then 
                    price = price + (perfect_medium * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_bighornram_hide", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_bighornram_hide" then 
                    price = price + (good_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_bighornram_hide", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_bighornram_hide" then 
                    price = price + (poor_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_bighornram_hide", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- boar_skin
				elseif Player.PlayerData.items[k].name == "perfect_boar_skin" then 
                    price = price + (perfect_medium * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_boar_skin", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_boar_skin" then 
                    price = price + (good_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_boar_skin", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_boar_skin" then 
                    price = price + (poor_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_boar_skin", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- buck fur
				elseif Player.PlayerData.items[k].name == "perfect_buck_fur" then 
                    price = price + (perfect_medium * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_buck_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_buck_fur" then 
                    price = price + (good_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_buck_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_buck_fur" then 
                    price = price + (poor_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_buck_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- bison hide
				elseif Player.PlayerData.items[k].name == "perfect_bison_hide" then 
                    price = price + (perfect_large * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_bison_hide", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_bison_hide" then 
                    price = price + (good_large * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_bison_hide", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_bison_hide" then 
                    price = price + (poor_large * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_bison_hide", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- bull hide
				elseif Player.PlayerData.items[k].name == "perfect_bull_hide" then 
                    price = price + (perfect_large * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_bull_hide", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_bull_hide" then 
                    price = price + (good_large * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_bull_hide", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_bull_hide" then 
                    price = price + (poor_large * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_bull_hide", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- deer hide
				elseif Player.PlayerData.items[k].name == "perfect_deer_hide" then 
                    price = price + (perfect_medium * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_deer_hide", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_deer_hide" then 
                    price = price + (good_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_deer_hide", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_deer_hide" then 
                    price = price + (poor_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_deer_hide", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- elk fur
				elseif Player.PlayerData.items[k].name == "perfect_elk_fur" then 
                    price = price + (perfect_large * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_elk_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_elk_fur" then 
                    price = price + (good_large * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_elk_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_elk_fur" then 
                    price = price + (poor_large * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_elk_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- redfox fur
				elseif Player.PlayerData.items[k].name == "perfect_redfox_fur" then 
                    price = price + (perfect_medium * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_redfox_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_redfox_fur" then 
                    price = price + (good_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_redfox_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_redfox_fur" then 
                    price = price + (poor_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_redfox_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- greywolf fur
				elseif Player.PlayerData.items[k].name == "perfect_greywolf_fur" then 
                    price = price + (perfect_medium * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_greywolf_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_greywolf_fur" then 
                    price = price + (good_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_greywolf_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_greywolf_fur" then 
                    price = price + (poor_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_greywolf_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- merinosheep wool
				elseif Player.PlayerData.items[k].name == "perfect_merinosheep_wool" then 
                    price = price + (perfect_medium * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_merinosheep_wool", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_merinosheep_wool" then 
                    price = price + (good_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_merinosheep_wool", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_merinosheep_wool" then 
                    price = price + (poor_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_merinosheep_wool", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- pronghorn fur
				elseif Player.PlayerData.items[k].name == "perfect_pronghorn_fur" then 
                    price = price + (perfect_medium * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_pronghorn_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_pronghorn_fur" then 
                    price = price + (good_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_pronghorn_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_pronghorn_fur" then 
                    price = price + (poor_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_pronghorn_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- berkshirepig skin
				elseif Player.PlayerData.items[k].name == "perfect_berkshirepig_skin" then 
                    price = price + (perfect_medium * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_berkshirepig_skin", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_berkshirepig_skin" then 
                    price = price + (good_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_berkshirepig_skin", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_berkshirepig_skin" then 
                    price = price + (poor_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_berkshirepig_skin", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- panther fur (bonus)
				elseif Player.PlayerData.items[k].name == "perfect_panther_fur" then 
                    price = price + (perfect_medium + bonus * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_panther_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_panther_fur" then 
                    price = price + (good_medium + bonus * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_panther_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_panther_fur" then 
                    price = price + (poor_medium + bonus * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_panther_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- cougar fur (bonus)
				elseif Player.PlayerData.items[k].name == "perfect_cougar_fur" then 
                    price = price + (perfect_medium + bonus * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_cougar_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_cougar_fur" then 
                    price = price + (good_medium + bonus * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_cougar_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_cougar_fur" then 
                    price = price + (poor_medium + bonus * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_cougar_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- crackercow hide
				elseif Player.PlayerData.items[k].name == "perfect_crackercow_hide" then 
                    price = price + (perfect_large * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_crackercow_hide", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_crackercow_hide" then 
                    price = price + (good_large * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_crackercow_hide", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_crackercow_hide" then 
                    price = price + (poor_large * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_crackercow_hide", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- coyote fur
				elseif Player.PlayerData.items[k].name == "perfect_coyote_fur" then 
                    price = price + (perfect_small * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_coyote_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_coyote_fur" then 
                    price = price + (good_small * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_coyote_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_coyote_fur" then 
                    price = price + (poor_small * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_coyote_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- alpinegoat hair
				elseif Player.PlayerData.items[k].name == "perfect_alpinegoat_hair" then 
                    price = price + (perfect_medium * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_alpinegoat_hair", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_alpinegoat_hair" then 
                    price = price + (good_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_alpinegoat_hair", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_alpinegoat_hair" then 
                    price = price + (poor_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_alpinegoat_hair", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- peccarypig skin
				elseif Player.PlayerData.items[k].name == "perfect_peccarypig_skin" then 
                    price = price + (perfect_medium * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_peccarypig_skin", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_peccarypig_skin" then 
                    price = price + (good_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_peccarypig_skin", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_peccarypig_skin" then 
                    price = price + (poor_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_peccarypig_skin", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- moose fur
				elseif Player.PlayerData.items[k].name == "perfect_moose_fur" then 
                    price = price + (perfect_large * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_moose_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_moose_fur" then 
                    price = price + (good_large * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_moose_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_moose_fur" then 
                    price = price + (poor_large * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_moose_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- angusox hide
				elseif Player.PlayerData.items[k].name == "perfect_angusox_hide" then 
                    price = price + (perfect_large * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_angusox_hide", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_angusox_hide" then 
                    price = price + (good_large * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_angusox_hide", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_angusox_hide" then 
                    price = price + (poor_large * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_angusox_hide", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- alligator skin
				elseif Player.PlayerData.items[k].name == "perfect_alligator_skin" then 
                    price = price + (perfect_medium * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_alligator_skin", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_alligator_skin" then 
                    price = price + (good_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_alligator_skin", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_alligator_skin" then 
                    price = price + (poor_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_alligator_skin", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- beaver fur
				elseif Player.PlayerData.items[k].name == "perfect_beaver_fur" then 
                    price = price + (perfect_medium * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_beaver_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_beaver_fur" then 
                    price = price + (good_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_beaver_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_beaver_fur" then 
                    price = price + (poor_medium * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_beaver_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				-- blackbear fur
				elseif Player.PlayerData.items[k].name == "perfect_blackbear_fur" then 
                    price = price + (perfect_large + bonus * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem("perfect_blackbear_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "good_blackbear_fur" then 
                    price = price + (good_large + bonus * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("good_blackbear_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				elseif Player.PlayerData.items[k].name == "poor_blackbear_fur" then 
                    price = price + (poor_large + bonus * Player.PlayerData.items[k].amount)
					Player.Functions.RemoveItem("poor_blackbear_fur", Player.PlayerData.items[k].amount, k)
					hasitems = true
				end				
			end
        end
		if hasitems == true then
			Player.Functions.AddMoney("cash", price, "sold-items")
			TriggerClientEvent('QBCore:Notify', src, 9, 'you have sold all your items for $'..price, 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
			hasitems = false
		end
	end
end)