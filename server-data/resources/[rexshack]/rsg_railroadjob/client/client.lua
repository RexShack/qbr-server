
Citizen.CreateThread(function()
	exports['qbr-core']:createPrompt('valentine-station', vector3(-162.8994, 638.43988, 114.03205), 0xF3830D8E, 'Railroad Menu', {
		type = 'client',
		event = 'rsg_railroadjob:client:menu',
		args = {}
	})  
end)

-- railroad menu
RegisterNetEvent('rsg_railroadjob:client:menu', function(data)
    exports['qbr-menu']:openMenu({
        {
            header = "| Railroad Menu |",
            isMenuHeader = true,
        },
        {
            header = "🚂 | Activate Train",
            txt = "spawn train to start work",
            params = {
                event = 'rsg_railroadjob:client:spawntrain',
				isServer = false,
				args = { trainHash = 987516329 }
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

local stops = {
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = -142.67,  ["y"] = 654.18,   ["z"] = 113.52, ["time"] = 60000, ["name"] = "Valentine Station"},
    {["dst"] = 400.0, ["dst2"] = 4.0, ["x"] = 2685.39,  ["y"] = -1480.33, ["z"] = 45.80,  ["time"] = 60000, ["name"] = "Saint Denis Station"},
    {["dst"] = 220.0, ["dst2"] = 4.0, ["x"] = 1197.48,  ["y"] = -1282.29, ["z"] = 76.45,  ["time"] = 60000, ["name"] = "Rhodes Station"},
    {["dst"] = 220.0, ["dst2"] = 4.0, ["x"] = -379.38,  ["y"] = -369.51,  ["z"] = 86.44,  ["time"] = 30000, ["name"] = "Flatneck Station"},
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = -1118.27, ["y"] = -567.17,  ["z"] = 82.67,  ["time"] = 30000, ["name"] = "Riggs Station"},
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = -1291.04, ["y"] = 440.69,   ["z"] = 94.36,  ["time"] = 30000, ["name"] = "Wallace Station"},
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = 610.54,   ["y"] = 1661.53,  ["z"] = 188.0,  ["time"] = 30000, ["name"] = "Bacchus Station"},
    {["dst"] = 220.0, ["dst2"] = 4.0, ["x"] = 2914.50,  ["y"] = 1238.53,  ["z"] = 44.73,  ["time"] = 60000, ["name"] = "Annesburg Station"},
    {["dst"] = 180.0, ["dst2"] = 4.0, ["x"] = 2879.30,  ["y"] = 592.75,   ["z"] = 57.84,  ["time"] = 60000, ["name"] = "Van Horn Tradin Post"}
} 

CURRENT_TRAIN = nil
train = nil
local trainspawned = false
local trainrunning = false

RegisterNetEvent('rsg_railroadjob:client:spawntrain')
AddEventHandler('rsg_railroadjob:client:spawntrain', function(data)
	PlayerJob = exports['qbr-core']:GetPlayerData().job.name
	print(PlayerJob)
	if PlayerJob == 'railroad' then
		if trainspawned == false then
			SetRandomTrains(false)
			--requestmodel--
			local trainWagons = N_0x635423d55ca84fc8(data.trainHash)
			for wagonIndex = 0, trainWagons - 1 do
				local trainWagonModel = N_0x8df5f6a19f99f0d5(data.trainHash, wagonIndex)
				while not HasModelLoaded(trainWagonModel) do
					Citizen.InvokeNative(0xFA28FE3A6246FC30, trainWagonModel, 1)
					Citizen.Wait(100)
				end
			end
			--spawn train--
			local train = N_0xc239dbd9a57d2a71(data.trainHash, GetEntityCoords(PlayerPedId()), 0, 1, 1, 1)
			SetTrainSpeed(train, 0.0)
			local coords = GetEntityCoords(train)
			local trainV = vector3(coords.x, coords.y, coords.z)
			-- warp ped into train (valentine)
			DoScreenFadeOut(500)
			Wait(1000)
			Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), -167.4587, 622.33398, 114.6397 -1, 141.77737)
			Wait(1000)
			DoScreenFadeIn(500)
			SetModelAsNoLongerNeeded(train)
			--blip--
			local blipname = "Train"
			local bliphash = -399496385
			local blip = Citizen.InvokeNative(0x23f74c2fda6e7c61, bliphash, train) -- blip for train
			SetBlipScale(blip, 1.5)
			CURRENT_TRAIN = train
			trainspawned = true
			trainrunning = true
		else
			exports['qbr-core']:Notify(9, 'train is already out, check map!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
		end
	else
		exports['qbr-core']:Notify(9, 'you do not work for the railroad!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)
		if trainrunning == true then
			for i = 1, #stops do
				local coords = GetEntityCoords(CURRENT_TRAIN)
				local trainV = vector3(coords.x, coords.y, coords.z)
				local distance = #(vector3(stops[i]["x"], stops[i]["y"], stops[i]["z"]) - trainV)
		
				--speed--
				local stopspeed = 0.0
				local cruisespeed = 5.0
				local fullspeed = 15.0
				if distance < stops[i]["dst"] then
					SetTrainCruiseSpeed(CURRENT_TRAIN, cruisespeed)
					Wait(200)
					if distance < stops[i]["dst2"] then
						SetTrainCruiseSpeed(CURRENT_TRAIN, stopspeed)
						Wait(stops[i]["time"])
						SetTrainCruiseSpeed(CURRENT_TRAIN, cruisespeed)
						Wait(10000)
					end
				elseif distance > stops[i]["dst"] then
					SetTrainCruiseSpeed(CURRENT_TRAIN, fullspeed)
					Wait(25)
				end
			end
		end
    end
end)

-- delete train
RegisterCommand('deletetrain', function()
	PlayerJob = exports['qbr-core']:GetPlayerData().job.name
	if PlayerJob == 'railroad' then
		DeleteEntity(CURRENT_TRAIN)
		trainspawned = false
		trainrunning = false
	else
		exports['qbr-core']:Notify(9, 'you do not work for the railroad!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)

-- reset train
RegisterCommand('resettrain', function()
	PlayerJob = exports['qbr-core']:GetPlayerData().job.name
	if PlayerJob == 'railroad' then
		DeleteEntity(CURRENT_TRAIN)
		trainspawned = false
		trainrunning = false
		DoScreenFadeOut(500)
		Wait(1000)
		Citizen.InvokeNative(0x203BEFFDBE12E96A, PlayerPedId(), -163.1477, 637.15832, 114.03209 -1, 337.03866)
		Wait(1000)
		DoScreenFadeIn(500)
	else
		exports['qbr-core']:Notify(9, 'you do not work for the railroad!', 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	end
end)