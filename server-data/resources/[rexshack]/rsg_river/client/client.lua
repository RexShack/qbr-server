

local WaterTypes = {
    [1] =  {["name"] = "Sea of Coronado",       ["waterhash"] = -247856387, ["watertype"] = "lake"},
    [2] =  {["name"] = "San Luis River",        ["waterhash"] = -1504425495, ["watertype"] = "river"},
    [3] =  {["name"] = "Lake Don Julio",        ["waterhash"] = -1369817450, ["watertype"] = "lake"},
    [4] =  {["name"] = "Flat Iron Lake",        ["waterhash"] = -1356490953, ["watertype"] = "lake"},
    [5] =  {["name"] = "Upper Montana River",   ["waterhash"] = -1781130443, ["watertype"] = "river"},
    [6] =  {["name"] = "Owanjila",              ["waterhash"] = -1300497193, ["watertype"] = "river"},
    [7] =  {["name"] = "HawkEye Creek",         ["waterhash"] = -1276586360, ["watertype"] = "river"},
    [8] =  {["name"] = "Little Creek River",    ["waterhash"] = -1410384421, ["watertype"] = "river"},
    [9] =  {["name"] = "Dakota River",          ["waterhash"] = 370072007, ["watertype"] = "river"},
    [10] =  {["name"] = "Beartooth Beck",       ["waterhash"] = 650214731, ["watertype"] = "river"},
    [11] =  {["name"] = "Lake Isabella",        ["waterhash"] = 592454541, ["watertype"] = "lake"},
    [12] =  {["name"] = "Cattail Pond",         ["waterhash"] = -804804953, ["watertype"] = "lake"},
    [13] =  {["name"] = "Deadboot Creek",       ["waterhash"] = 1245451421, ["watertype"] = "river"},
    [14] =  {["name"] = "Spider Gorge",         ["waterhash"] = -218679770, ["watertype"] = "river"},
    [15] =  {["name"] = "O'Creagh's Run",       ["waterhash"] = -1817904483, ["watertype"] = "lake"},
    [16] =  {["name"] = "Moonstone Pond",       ["waterhash"] = -811730579, ["watertype"] = "lake"},
    [17] =  {["name"] = "Roanoke Valley",       ["waterhash"] = -1229593481, ["watertype"] = "river"},
    [18] =  {["name"] = "Elysian Pool",         ["waterhash"] = -105598602, ["watertype"] = "lake"},
    [19] =  {["name"] = "Lannahechee River",    ["waterhash"] = -2040708515, ["watertype"] = "river"},
    [20] =  {["name"] = "Dakota River",         ["waterhash"] = 370072007, ["watertype"] = "river"},
    [21] =  {["name"] = "Random1",              ["waterhash"] = 231313522, ["watertype"] = "river"},
    [22] =  {["name"] = "Random2",              ["waterhash"] = 2005774838, ["watertype"] = "river"},
    [23] =  {["name"] = "Random3",              ["waterhash"] = -1287619521, ["watertype"] = "river"},
    [24] =  {["name"] = "Random4",              ["waterhash"] = -1308233316, ["watertype"] = "river"},
    [25] =  {["name"] = "Random5",              ["waterhash"] = -196675805, ["watertype"] = "river"},
}

--menu
local RiverGroup = GetRandomIntInRange(0, 0xffffff)

local WashPrompt
function WashPrompt()
    
    Citizen.CreateThread(function()
        local str ="Wash"
        local wait = 0
        WashPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(WashPrompt, 0xC7B5340A) -- [ENTER]
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(WashPrompt, str)
        PromptSetEnabled(WashPrompt, true)
        PromptSetVisible(WashPrompt, true)
        PromptSetHoldMode(WashPrompt, true)
        PromptSetGroup(WashPrompt, RiverGroup)
        PromptRegisterEnd(WashPrompt)   
    end)
end

local DrinkPrompt
function DrinkPrompt()
    Citizen.CreateThread(function()
        local str ="Drink"
        local wait = 0
        DrinkPrompt = Citizen.InvokeNative(0x04F97DE45A519419)
        PromptSetControlAction(DrinkPrompt, 0xF3830D8E) -- [J] 
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(DrinkPrompt, str)
        PromptSetEnabled(DrinkPrompt, true)
        PromptSetVisible(DrinkPrompt, true)
        PromptSetHoldMode(DrinkPrompt, true)
        PromptSetGroup(DrinkPrompt, RiverGroup)
        PromptRegisterEnd(DrinkPrompt)
    end)
end

Citizen.CreateThread(function()
    WashPrompt()
    DrinkPrompt()
	while true do
		Citizen.Wait(1)
        local coords = GetEntityCoords(PlayerPedId())
        local Water = Citizen.InvokeNative(0x5BA7A68A346A5A91,coords.x+3, coords.y+3, coords.z)
        local playerPed = PlayerPedId()
            for k,v in pairs(WaterTypes) do 
            if Water == WaterTypes[k]["waterhash"]  then
                if IsPedOnFoot(PlayerPedId()) then
                    if IsEntityInWater(PlayerPedId()) then
						-- wash
						local Wash  = CreateVarString(10, 'LITERAL_STRING',"Water")
						PromptSetActiveGroupThisFrame(RiverGroup, Wash)
						
						if PromptHasHoldModeCompleted(WashPrompt) then
							StartWash("amb_misc@world_human_wash_face_bucket@ground@male_a@idle_d", "idle_l")
						end
						-- drink
						local drink  = CreateVarString(10, 'LITERAL_STRING',"Water")
						PromptSetActiveGroupThisFrame(RiverGroup, drink)
						
						if PromptHasHoldModeCompleted(DrinkPrompt) then
							TriggerEvent('rsg_river:client:drink')	
						end
					end
				end
			end
		end
	end
end)

-- drink
AddEventHandler('rsg_river:client:drink', function()
    local src = source
	if drink ~= 0 then
		SetEntityAsMissionEntity(drink)
		DeleteObject(nativerioprop)
		drink = 0
	end
	local playerPed = PlayerPedId()
	Citizen.Wait(0)
	TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_BUCKET_DRINK_GROUND'), -1, true, false, false, false)
	Citizen.Wait(17000)
	TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", exports['qbr-core']:GetPlayerData().metadata["thirst"] + math.random(50, 100))
	ClearPedTasks(PlayerPedId())
end)

-- wash
StartWash = function(dic, anim)
    LoadAnim(dic)
    TaskPlayAnim(PlayerPedId(), dic, anim, 1.0, 8.0, 5000, 0, 0.0, false, false, false)
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
	ClearPedEnvDirt(PlayerPedId())
	ClearPedBloodDamage(PlayerPedId())
	N_0xe3144b932dfdff65(PlayerPedId(), 0.0, -1, 1, 1)
	ClearPedDamageDecalByZone(PlayerPedId(), 10, "ALL")
	Citizen.InvokeNative(0x7F5D88333EE8A86F, PlayerPedId(), 1)
end

LoadAnim = function(dic)
    RequestAnimDict(dic)
    while not (HasAnimDictLoaded(dic)) do
        Citizen.Wait(0)
    end
end

function whenKeyJustPressed(key)
    if Citizen.InvokeNative(0x580417101DDB492F, 0, key) then
        return true
    else
        return false
    end
end