local ButcherPrompt
local hasAlreadyEnteredMarker
local currentZone = nil

local PromptGorup = GetRandomIntInRange(0, 0xffffff)

function SetupButcherPrompt()
    Citizen.CreateThread(function()
        local str = 'Sell Item'
        ButcherPrompt = PromptRegisterBegin()
        PromptSetControlAction(ButcherPrompt, 0xE8342FF2)
        str = CreateVarString(10, 'LITERAL_STRING', str)
        PromptSetText(ButcherPrompt, str)
        PromptSetEnabled(ButcherPrompt, 1)
        PromptSetVisible(ButcherPrompt, 1)
        PromptSetHoldMode(ButcherPrompt, 1)
        PromptSetGroup(ButcherPrompt, PromptGorup)
        PromptRegisterEnd(ButcherPrompt)
    end)
end

local blip = {}

if Config.Blips == true then
    Citizen.CreateThread(function()
        for _, info in pairs(Config.shops) do
            local number = #blip + 1
            blip[number] = N_0x554d9d53f696d002(1664425300, info.coords.x, info.coords.y, info.coords.z)
            SetBlipSprite(blip[number], -1665418949, 1)
            SetBlipScale(blip[number], 0.2)
            Citizen.InvokeNative(0x9CB1A1623062F402, blip[number], 'Butcher')
        end  
    end)
end

Citizen.CreateThread(function()
    SetupButcherPrompt()
	while true do
		Wait(500)
		local isInMarker, tempZone = false
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)

        for _,v in pairs(Config.shops) do 
            local distance = #(coords - v.coords)
            if distance < 1.5 then
                local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
                if holding ~= false then
                    isInMarker  = true
                    tempZone = 'butcher'
                end
            end
		end

		if isInMarker and not hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = true
			currentZone = tempZone
		end

		if not isInMarker and hasAlreadyEnteredMarker then
			hasAlreadyEnteredMarker = false
			currentZone = nil
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

        if currentZone then
            local label  = CreateVarString(10, 'LITERAL_STRING', "Butcher")
            PromptSetActiveGroupThisFrame(PromptGorup, label)
            if PromptHasHoldModeCompleted(ButcherPrompt) then
                Selltobutcher()
				currentZone = nil
			end
        else
			Citizen.Wait(500)
		end
	end
end)

function DeleteThis(holding)
    NetworkRequestControlOfEntity(holding)
    SetEntityAsMissionEntity(holding, true, true)
    Wait(100)
    DeleteEntity(holding)
    Wait(500)
    local entitycheck = Citizen.InvokeNative(0xD806CD2A4F2C2996, PlayerPedId())
    local holdingcheck = GetPedType(entitycheck)
    if holdingcheck == 0 then
        return true
    else
        return false
    end
end

function Selltobutcher()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    for k = 1, #Config.shops do 
        local distance = #(Config.shops[k]["coords"] - coords)
        if distance < 3.0 then
            local holding = Citizen.InvokeNative(0xD806CD2A4F2C2996, ped)
            local quality = Citizen.InvokeNative(0x31FEF6A20F00B963, holding)
            local model = GetEntityModel(holding)
            local type = GetPedType(holding)
			
            if holding ~= false then
                for i, row in pairs(Config.Animal) do
                    if type == 28 then
                        if model == Config.Animal[i]["model"] then
                            local reward = Config.shops[k]["gain"] * Config.Animal[i]["reward"]
							local item = Config.Animal[i]["item"]

                            local deleted = DeleteThis(holding)
            
                            if deleted then
                                TriggerServerEvent("rsg_butcher:reward", reward, item)
                            else
								exports['qbr-core']:Notify(9, 'something went wrong!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
                            end

                        end
                    end
                    if quality ~= false then
                        if quality == Config.Animal[i]["poor"] then

                            local rewardresult = Config.shops[k]["gain"] * Config.Animal[i]["reward"]
                            local reward = rewardresult * 0.5

                            local deleted = DeleteThis(holding)
            
                            if deleted then
                                TriggerServerEvent("rsg_butcher:reward", reward, item)
                            else
                                exports['qbr-core']:Notify(9, 'something went wrong!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
                            end

                        elseif quality == Config.Animal[i]["good"] then

                            local rewardresult = Config.shops[k]["gain"] * Config.Animal[i]["reward"]
                            local reward = rewardresult * 0.75

                            local deleted = DeleteThis(holding)
            
                            if deleted then
                                TriggerServerEvent("rsg_butcher:reward", reward, item)
                            else
                                exports['qbr-core']:Notify(9, 'something went wrong!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
                            end

                        elseif quality == Config.Animal[i]["perfect"] then

                            local reward = Config.shops[k]["gain"] * Config.Animal[i]["reward"]

                            local deleted = DeleteThis(holding)
            
                            if deleted then
                                TriggerServerEvent("rsg_butcher:reward",reward, item)
                            else
								exports['qbr-core']:Notify(9, 'something went wrong!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
                            end

                        end
                    end
                end
            else
				exports['qbr-core']:Notify(9, 'you are not holding anything!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
            end
        end
    end
end

AddEventHandler('onResourceStop', function(resource)
    if resource == GetCurrentResourceName() then
        PromptSetEnabled(ButcherPrompt, false)
        PromptSetVisible(ButcherPrompt, false)
        for k,v in pairs(blip) do
            RemoveBlip(blip[k])
        end
    end
end)