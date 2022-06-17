local sharedItems = exports['qbr-core']:GetItems()
local moonshinekit = 0
isLoggedIn = false
PlayerJob = {}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    isLoggedIn = true
    PlayerJob = exports['qbr-core']:GetPlayerData().job
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

function DrawText3Ds(x, y, z, text)
    local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)
    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(9)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end

-- setup moonshine
RegisterNetEvent('rsg_moonshiner:client:moonshinekit')
AddEventHandler('rsg_moonshiner:client:moonshinekit', function(itemName) 
    if moonshinekit ~= 0 then
        SetEntityAsMissionEntity(moonshinekit)
        DeleteObject(moonshinekit)
        moonshinekit = 0
    else
		local playerPed = PlayerPedId()
		TaskStartScenarioInPlace(playerPed, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 10000, true, false, false, false)
		Wait(10000)
		ClearPedTasks(playerPed)
		SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true)
		local x,y,z = table.unpack(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0.75, -1.55))
		--local modelHash = `p_still03x`
		local modelHash = GetHashKey(Config.Prop)
		if not HasModelLoaded(modelHash) then
			-- If the model isnt loaded we request the loading of the model and wait that the model is loaded
			RequestModel(modelHash)
			while not HasModelLoaded(modelHash) do
				Wait(1)
			end
		end
		local prop = CreateObject(modelHash, x, y, z, true)
		SetEntityHeading(prop, GetEntityHeading(PlayerPedId()))
		PlaceObjectOnGroundProperly(prop)
		PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0)
		moonshinekit = prop
	end
end, false)

-- create moonshine still / destroy (lawman only)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local pos, awayFromObject = GetEntityCoords(PlayerPedId()), true
		local moonshineObject = GetClosestObjectOfType(pos, 5.0, GetHashKey(Config.Prop), false, false, false)
		if moonshineObject ~= 0 and PlayerJob.name ~= Config.LawJobName then
			local objectPos = GetEntityCoords(moonshineObject)
			if #(pos - objectPos) < 3.0 then
				awayFromObject = false
				DrawText3Ds(objectPos.x, objectPos.y, objectPos.z + 1.0, "~g~J~w~ - Brew")
				if IsControlJustReleased(0, 0xF3830D8E) then -- [J]
					TriggerEvent('rsg_moonshiner:client:menu')
				end
			end
		else
			local objectPos = GetEntityCoords(moonshineObject)
			if #(pos - objectPos) < 3.0 then
				awayFromObject = false
				DrawText3Ds(objectPos.x, objectPos.y, objectPos.z + 1.0, "~g~J~w~ - Destroy")
				if IsControlJustReleased(0, 0xF3830D8E) then -- [J]
					local player = PlayerPedId()
					TaskStartScenarioInPlace(player, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), 5000, true, false, false, false)
					Wait(5000)
					ClearPedTasks(player)
					SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
					DeleteObject(moonshineObject)
					PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0)
					exports['rsg_notify']:DisplayNotification('moonshine destroyed!', 5000)
				end
			end
		end
		if awayFromObject then
			Citizen.Wait(1000)
		end
	end
end)

-- moonshine menu
RegisterNetEvent('rsg_moonshiner:client:menu', function(data)
    exports['qbr-menu']:openMenu({
        {
            header = "| Moonshine |",
            isMenuHeader = true,
        },
        {
            header = "Make Moonshine",
            txt = "1 x Sugar 1 x Water and 1 x Corn",
            params = {
                event = 'rsg_moonshiner:client:moonshine',
				isServer = false,
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

-- make moonshine
RegisterNetEvent("rsg_moonshiner:client:moonshine")
AddEventHandler("rsg_moonshiner:client:moonshine", function()
	exports['qbr-core']:TriggerCallback('QBCore:HasItem', function(hasItem) 
		if hasItem then
			local player = PlayerPedId()
			TaskStartScenarioInPlace(player, GetHashKey('WORLD_HUMAN_CROUCH_INSPECT'), Config.BrewTime, true, false, false, false)
			Wait(Config.BrewTime)
			ClearPedTasks(player)
			SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)
			TriggerServerEvent('QBCore:Server:RemoveItem', "sugar", 1)
			TriggerServerEvent('QBCore:Server:RemoveItem', "corn", 1)
			TriggerServerEvent('QBCore:Server:RemoveItem', "water", 1)
			TriggerServerEvent('QBCore:Server:AddItem', "moonshine", 1)
			TriggerEvent("inventory:client:ItemBox", sharedItems["moonshine"], "add")
			PlaySoundFrontend("SELECT", "RDRO_Character_Creator_Sounds", true, 0)
			exports['rsg_notify']:DisplayNotification('you made some moonshine', 5000)
		else
			exports['rsg_notify']:DisplayNotification('you don\'t have the ingredients to make this!', 5000)
		end
	end, { ['sugar'] = 1, ['corn'] = 1, ['water'] = 1 })
end)