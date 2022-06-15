

local frozen = false

local permissions = {
  ['kill'] = 'admin',
  ['revive'] = 'admin',
  ['heal'] = 'admin',
  ['goto'] = 'admin',
  ['freeze'] = 'admin',
  ['spectate'] = 'admin',
  ['ban'] = 'admin',
  ['noclip'] = 'admin',
  ['kickall'] = 'admin',
  ['kick'] = 'admin',
  ['time'] = 'god',
  ['showcoords'] = 'admin',
  ['perms'] = 'god',
}

exports['qbr-core']:AddCommand('admin', 'Open the admin menu (Admin Only)', {}, false, function(source)
  local src = source
  TriggerClientEvent('admin:client:OpenMenu', src)
end, 'admin')

exports['qbr-core']:AddCommand('noclip', 'No Clip (Admin Only)', {}, false, function(source)
	local src = source
	TriggerClientEvent('admin:client:ToggleNoClip', src)
end, 'admin')

exports['qbr-core']:CreateCallback('admin:server:hasperms', function(source, cb, action)
  local src = source
  if exports['qbr-core']:HasPermission(src, permissions[action]) or IsPlayerAceAllowed(src, 'command') then
      cb(true)
  else
      cb(false)
  end
end)

exports['qbr-core']:CreateCallback('admin:server:getplayers', function(source, cb)
  local src = source
  local players = {}
  for k,v in pairs(exports['qbr-core']:GetPlayers()) do
    local target = GetPlayerPed(v)
    local ped = exports['qbr-core']:GetPlayer(v)
    players[#players + 1] = {
      name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | (' .. GetPlayerName(v) .. ')',
      id = v,
      coords = GetEntityCoords(target),
      citizenid = ped.PlayerData.citizenid,
      sources = GetPlayerPed(ped.PlayerData.source),
      sourceplayer = ped.PlayerData.source
    }
  end

  table.sort(players, function(a, b)
    return a.id < b.id
  end)

  cb(players)
end)

RegisterNetEvent('admin:server:getPlayersForBlips', function()
  local src = source
  local players = {}
  for k,v in pairs(exports['qbr-core']:GetPlayers()) do
    local target = GetPlayerPed(v)
    local ped = exports['qbr-core']:GetPlayer(v)
    players[#players + 1] = {
      name = ped.PlayerData.charinfo.firstname .. ' ' .. ped.PlayerData.charinfo.lastname .. ' | ' .. GetPlayerName(v),
      id = v,
      coords = GetEntityCoords(target),
      citizenid = ped.PlayerData.citizenid,
      sources = GetPlayerPed(ped.PlayerData.source),
      sourceplayer = ped.PlayerData.source
    }
  end

  TriggerClientEvent('admin:client:show', src, players)
end)

RegisterNetEvent('admin:server:kill', function(player)
  local src = source
  if exports['qbr-core']:HasPermission(src, permissions['kill']) or IsPlayerAceAllowed(src, 'command') then
    TriggerClientEvent('hospital:client:KillPlayer', player.id)
  end
end)

RegisterNetEvent('admin:server:revive', function(player)
  local src = source
  if exports['qbr-core']:HasPermission(src, permissions['revive']) or IsPlayerAceAllowed(src, 'command') then
    -- TriggerClientEvent('hospital:client:KillPlayer', player.id)
    TriggerClientEvent('admin:client:revivePlayer', player.id)
  end
end)

RegisterNetEvent('admin:server:heal', function(player)
  local src = source
  if exports['qbr-core']:HasPermission(src, permissions['heal']) or IsPlayerAceAllowed(src, 'command') then
    -- TriggerClientEvent('hospital:client:KillPlayer', player.id)
    TriggerClientEvent('admin:client:healPlayer', player.id)
  end
end)

RegisterNetEvent('admin:server:cloth', function(player)
  local src = source
  if exports['qbr-core']:HasPermission(src, permissions['perms']) or IsPlayerAceAllowed(src, 'command') then
    TriggerClientEvent('qbr-clothing:client:openMenu', player.id,'all')
  end
end)

RegisterNetEvent('admin:server:kick', function(player, reason)
  local src = source
  if exports['qbr-core']:HasPermission(src, permissions['kick']) or IsPlayerAceAllowed(src, 'command') then
    TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Kicked', 'red', string.format('%s was kicked by %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), true)
    DropPlayer(player.id, Lang:t("info.kicked_server") .. ':\n' .. reason .. '\n\n' .. Lang:t("info.check_discord") .. exports['qbr-core']:GetConfig().Server.discord)
  end
end)

RegisterNetEvent('admin:server:goto', function(player)
  local src = source
  if exports['qbr-core']:HasPermission(src, permissions['goto']) or IsPlayerAceAllowed(src, 'command') then
    local target = GetPlayerPed(player.id)
    local targetCoords = GetEntityCoords(target)
    TriggerClientEvent('admin:client:spectate', src, player.id, coords)
  end
end)

RegisterNetEvent('admin:server:spectate', function(player)
  local src = source
  if exports['qbr-core']:HasPermission(src, permissions['spectate']) or IsPlayerAceAllowed(src, 'command') then
    local admin = GetPlayerPed(src)
    local target = GetEntityCoords(GetPlayerPed(player.id))
    SetEntityCoords(admin, target)
  end
end)

RegisterNetEvent('admin:server:freeze', function(player)
  local src = source
  if exports['qbr-core']:HasPermission(src, permissions['freeze']) or IsPlayerAceAllowed(src, 'command') then
    local target = GetPlayerPed(player.id)
    if not frozen then
      frozen = true
      FreezeEntityPosition(target, true)
    else
      frozen = false
      FreezeEntityPosition(target, false)
    end
  end
end)

RegisterNetEvent('admin:server:inventory', function(player)
  local src = source
  if exports['qbr-core']:HasPermission(src, permissions['perms']) or IsPlayerAceAllowed(src, 'command') then
    TriggerClientEvent('admin:client:inventory', src, player.id)
  end
end)



RegisterNetEvent('admin:server:ban', function(player, time, reason)
  local src = source
  if exports['qbr-core']:HasPermission(src, permissions['ban']) or IsPlayerAceAllowed(src, 'command') then
    local time = tonumber(time)
    local banTime = tonumber(os.time() + time)
    if banTime > 2147483647 then
      banTime = 2147483647
    end
    local timeTable = os.date('*t', banTime)

    MySQL.Async.insert('INSERT INTO bans (name, license, discord, ip, reason, expire, bannedby) VALUES (?, ?, ?, ?, ?, ?, ?)', {
      GetPlayerName(player.id),
      exports['qbr-core']:GetIdentifier(player.id, 'license'),
      exports['qbr-core']:GetIdentifier(player.id, 'discord'),
      exports['qbr-core']:GetIdentifier(player.id, 'ip'),
      reason,
      banTime,
      GetPlayerName(src)
    })

    TriggerClientEvent('chat:addMessage', -1, {
      template = "<div class=chat-message server'><strong>ANNOUNCEMENT | {0} has been banned:</strong> {1}</div>",
      args = {GetPlayerName(player.id), reason}
    })

    TriggerEvent('qb-log:server:CreateLog', 'bans', 'Player Banned', 'red', string.format('%s was banned by %s for %s', GetPlayerName(player.id), GetPlayerName(src), reason), true)
      if banTime >= 2147483647 then
        DropPlayer(player.id, Lang:t("info.banned") .. '\n' .. reason .. Lang:t("info.ban_perm") .. exports['qbr-core']:GetConfig().Server.discord)
      else
        DropPlayer(player.id, Lang:t("info.banned") .. '\n' .. reason .. Lang:t("info.ban_expires") .. timeTable['day'] .. '/' .. timeTable['month'] .. '/' .. timeTable['year'] .. ' ' .. timeTable['hour'] .. ':' .. timeTable['min'] .. '\n🔸 Check our Discordformore information: ' .. exports['qbr-core']:GetConfig().Server.discord)
      end
  end
end)
