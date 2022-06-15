
local ShowBlips = false
local ShowNames = false
local names = {}
local gamerTagCompsEnum = {
  GamerName = 0,
  CrewTag = 1,
  HealthArmour = 2,
  BigText = 3,
  AudioIcon = 4,
  UsingMenu = 5,
  PassiveMode = 6,
  WantedStars = 7,
  Driver = 8,
  CoDriver = 9,
  Tagged = 12,
  GamerNameNearby = 13,
  Arrow = 14,
  Packages = 15,
  InvIfPedIsFollowing = 16,
  RankText = 17,
  Typing = 18
}

CreateThread(function()
  local sleep = 150
  while true do
    if ShowNames then
      showNames()
      sleep = 50
    else
      sleep = 500
    end

    Wait(sleep)
  end
end)

showNames = function()
  local curCoords = GetEntityCoords(PlayerPedId())
  local allActivePlayers = GetActivePlayers()
  for _,i in ipairs(allActivePlayers) do
    local targetPed = GetPlayerPed(i)
    local playerStr = '[' .. GetPlayerServerId(i) .. ']' .. ' ' .. GetPlayerName(i)

    if not names[i] or not IsMpGamerTagActive(names[i].gamerTag) then
      names[i] = {
        gamerTag = CreateFakeMpGamerTag(targetPed, playerStr, false, false, 0),
        ped = targetPed
      }
    end

    local targetTag = names[i].gamerTag
    local targetPedCoords = GetEntityCoords(targetPed)
  end
end

RegisterNetEvent('admin:client:toggleNames', function()
	ShowNames = not ShowNames
	if not ShowNames then
		exports['qbr-core']:Notify(9, Lang:t("error.names_deactivated"), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
	else
		exports['qbr-core']:Notify(9, Lang:t("success.names_activated"), 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
	end
end)