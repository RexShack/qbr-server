
-- local MenuData = exports['ow-menubase']:GetMenus()

local ShowingCoords = false
local Invisible = false
local Godmode = false
local LastSpectateCoord = nil
local IsSpectating = false
local deleteLazer = false

local menuLocation = 'topright'
local menuSize = 'size-125'
local mainMenu = MenuV:CreateMenu(false, Lang:t('menu.admin_menu'), menuLocation, 220, 20, 60, menuSize, 'qbcore', 'menuv', 'test1')
local adminOptions = MenuV:CreateMenu(false, Lang:t('menu.admin_options'), menuLocation, 220, 20, 60, menuSize, 'qbcore', 'menuv', 'test2')
local playerOptions = MenuV:CreateMenu(false, Lang:t('menu.online_players'), menuLocation, 220, 20, 60, menuSize, 'qbcore', 'menuv', 'test3')
local serverOptions = MenuV:CreateMenu(false, Lang:t('menu.manage_server'), menuLocation, 220, 20, 60, menuSize, 'qbcore', 'menuv', 'test4')
local developerOptions = MenuV:CreateMenu(false, Lang:t('menu.developer_options'), menuLocation, 220, 20, 60, menuSize, 'qbcore', 'menuv', 'test5')

local mainMenu_button1 = mainMenu:AddButton({
  icon = '😀',
  label = Lang:t('menu.admin_options'),
  value = adminOptions,
  description = Lang:t('desc.admin_options_desc')
})
local mainMenu_button2 = mainMenu:AddButton({
  icon = '👨‍👩‍👧',
  label = Lang:t('menu.online_players'),
  value = playerOptions,
  description = Lang:t('desc.player_management_desc')
})
local mainMenu_button3 = mainMenu:AddButton({
  icon = '🌍',
  label = Lang:t('menu.manage_server'),
  value = serverOptions,
  description = Lang:t('desc.server_management_desc')
})
local mainMenu_button4 = mainMenu:AddButton({
  icon = '🔧',
  label = Lang:t('menu.developer_options'),
  value = developerOptions,
  description = Lang:t('desc.developer_desc')
})

adminOptions:On('open', function(menu)
  menu:ClearItems()
  menu:AddButton({
    icon = '🍪',
    label = Lang:t('menu.tpm'),
    select = function()
      TriggerServerEvent('qbr-logs:server:CreateLog', 'admin', 'Admin Options', 'red', GetPlayerName() .. ' > REVIVED SELF <')
      GotoMarker()
    end
  })
  menu:AddButton({
    icon = '🍪',
    label = Lang:t('menu.revive'),
    select = function()
      TriggerServerEvent('qbr-logs:server:CreateLog', 'admin', 'Admin Options', 'red', GetPlayerName() .. ' > REVIVED SELF <')
      RevivePlayer()
    end
  })
  menu:AddButton({
    icon = '🍪',
    label = Lang:t('menu.heal'),
    select = function()
      TriggerServerEvent('qbr-logs:server:CreateLog', 'admin', 'Admin Options', 'red', GetPlayerName() .. ' > REVIVED SELF <')
      HealPlayer()
    end
  })
  menu:AddButton({
    icon = '🍪',
    label = Lang:t('menu.invisible'),
    select = function()
      TriggerServerEvent('qbr-logs:server:CreateLog', 'admin', 'Admin Options', 'red', GetPlayerName() .. ' toggled > INVISIBILITY <')
      if Invisible then
        SetEntityVisible(PlayerPedId(), true)
        Invisible = false
      else
        SetEntityVisible(PlayerPedId(), false)
        Invisible = true
      end
    end
  })
  menu:AddButton({
    icon = '🍪',
    label = Lang:t('menu.god'),
    select = function()
      Godmode = not Godmode
      TriggerServerEvent('qbr-logs:server:CreateLog', 'admin', 'Admin Options', 'red', GetPlayerName() .. ' toggled > GODMODE <')
      if Godmode then
        while Godmode do
          Wait(0)
          SetPlayerInvincible(PlayerPedId(), true)
        end

        SetPlayerInvincible(PlayerPedId(), false)
      end
    end
  })
  menu:AddButton({
    icon = '🍪',
    label = Lang:t('menu.names'),
    select = function()
      TriggerEvent('admin:client:toggleNames')
    end
  })
end)

playerOptions:On('open', function(menu)
  menu:ClearItems()
  exports['qbr-core']:TriggerCallback('admin:server:getplayers', function(players)
    for k,v in pairs(players) do
      menu:AddButton({
        icon = '⭐',
        value = v,
        label = Lang:t('info.id') .. v.id .. ' | ' .. v.name,
        select = function(btn)
          local select = btn.Value
          OpenPlayerMenu(select)
        end
      })
    end
  end)
end)

serverOptions:On('open', function(menu)
  menu:ClearItems()
  exports['qbr-core']:TriggerCallback('admin:server:hasperms', function(hasperms)
    if hasperms then
      local menuSlider1 = menu:AddSlider({
        icon = '⛈️',
        label = Lang:t("menu.weather_options"),
        value = GetClockHours(),
        values = {
          {
            icon = '🌨️',
            label = Lang:t("weather.blizzard"),
            value = "BLIZZARD",
            description = Lang:t("weather.blizzed_desc")
          },{
            icon = '☁',
            label = Lang:t('weather.clouds'),
            value = 'CLOUDS',
            description = Lang:t('weather.clouds_desc')
          },{
            icon = '☀',
            label = Lang:t('weather.drizzle'),
            value = 'DRIZZLE',
            description = Lang:t('weather.drizzle_desc')
          },{
            icon = '☀',
            label = Lang:t('weather.fog'),
            value = 'FOG',
            description = Lang:t('weather.fog_desc')
          },{
            icon = '☀',
            label = Lang:t('weather.ground_blizzard'),
            value = 'GROUNDBLIZZARD',
            description = Lang:t('weather.ground_blizzard_desc')
          },{
            icon = '🌁',
            label = Lang:t('weather.hail'),
            value = 'HAIL',
            description = Lang:t('weather.hail_desc')
          },{
            icon = '🌁',
            label = Lang:t('weather.high_pressure'),
            value = 'HIGHPRESSURE',
            description = Lang:t('weather.high_pressure_desc')
          },{
            icon = '🌁',
            label = Lang:t('weather.hurricane'),
            value = 'HURRICANE',
            description = Lang:t('weather.hurricane_desc')
          },{
            icon = '🌁',
            label = Lang:t('weather.misty'),
            value = 'MISTY',
            description = Lang:t('weather.misty_desc')
          },{
            icon = '⛅',
            label = Lang:t('weather.overcast'),
            value = 'OVERCAST',
            description = Lang:t('weather.overcast_desc')
          },{
            icon = '⛅',
            label = Lang:t('weather.overcast_dark'),
            value = 'OVERCASTDARK',
            description = Lang:t('weather.overcast_dark_desc')
          },{
            icon = '☂️',
            label = Lang:t("weather.rain"),
            value = "RAIN",
            description = Lang:t("weather.rain_desc")
          },{
            icon = '☂️',
            label = Lang:t("weather.sandstorm"),
            value = "SANDSTORM",
            description = Lang:t("weather.sandstorm_desc")
          },{
            icon = '☂️',
            label = Lang:t("weather.shower"),
            value = "SHOWER",
            description = Lang:t("weather.shower_desc")
          },{
            icon = '☂️',
            label = Lang:t("weather.sleet"),
            value = "SLEET",
            description = Lang:t("weather.sleet_desc")
          },{
            icon = '❄️',
            label = Lang:t("weather.snow"),
            value = "SNOW",
            description = Lang:t("weather.snow_desc")
          },{
            icon = '❄️',
            label = Lang:t("weather.light_snow"),
            value = "SNOWLIGHT",
            description = Lang:t("weather.light_snow_desc")
          }, {
            icon = '🌤',
            label = Lang:t('weather.sunny'),
            value = 'SUNNY',
            description = Lang:t('weather.sunny_desc')
          }, {
            icon = '⛈️',
            label = Lang:t("weather.thunder"),
            value = "THUNDER",
            description = Lang:t("weather.thunder_desc")
          },{
            icon = '⛈️',
            label = Lang:t("weather.thunder_storm"),
            value = "THUNDERSTORM",
            description = Lang:t("weather.thunder_storm_desc")
          },
          {
            icon = '❄️',
            label = Lang:t("weather.whiteout"),
            value = "WHITEOUT",
            description = Lang:t("weather.whiteout_desc")
          }        
        }
      })

      local menuSlider2 = menu:AddSlider({
        icon = '⏲️',
        label = Lang:t("menu.server_time"),
        value = GetClockHours(),
        values = {{
            label = '00',
            value = '00',
            description = Lang:t("menu.time")
        }, {
            label = '01',
            value = '01',
            description = Lang:t("menu.time")
        }, {
            label = '02',
            value = '02',
            description = Lang:t("menu.time")
        }, {
            label = '03',
            value = '03',
            description = Lang:t("menu.time")
        }, {
            label = '04',
            value = '04',
            description = Lang:t("menu.time")
        }, {
            label = '05',
            value = '05',
            description = Lang:t("menu.time")
        }, {
            label = '06',
            value = '06',
            description = Lang:t("menu.time")
        }, {
            label = '07',
            value = '07',
            description = Lang:t("menu.time")
        }, {
            label = '08',
            value = '08',
            description = Lang:t("menu.time")
        }, {
            label = '09',
            value = '09',
            description = Lang:t("menu.time")
        }, {
            label = '10',
            value = '10',
            description = Lang:t("menu.time")
        }, {
            label = '11',
            value = '11',
            description = Lang:t("menu.time")
        }, {
            label = '12',
            value = '12',
            description = Lang:t("menu.time")
        }, {
            label = '13',
            value = '13',
            description = Lang:t("menu.time")
        }, {
            label = '14',
            value = '14',
            description = Lang:t("menu.time")
        }, {
            label = '15',
            value = '15',
            description = Lang:t("menu.time")
        }, {
            label = '16',
            value = '16',
            description = Lang:t("menu.time")
        }, {
            label = '17',
            value = '17',
            description = Lang:t("menu.time")
        }, {
            label = '18',
            value = '18',
            description = Lang:t("menu.time")
        }, {
            label = '19',
            value = '19',
            description = Lang:t("menu.time")
        }, {
            label = '20',
            value = '20',
            description = Lang:t("menu.time")
        }, {
            label = '21',
            value = '21',
            description = Lang:t("menu.time")
        }, {
            label = '22',
            value = '22',
            description = Lang:t("menu.time")
        }, {
            label = '23',
            value = '23',
            description = Lang:t("menu.time")
        }}
      })

      menuSlider1:On('select', function(item, value)
        TriggerServerEvent("qbr-weathersync:server:setWeather", value)
      end)

      menuSlider2:On('select', function(item, value)
        TriggerServerEvent("qbr-weathersync:server:setTime", value, value)
      end)
    end
  end, 'time')
end)

developerOptions:On('open', function(menu)
  menu:ClearItems()

  menu:AddCheckbox({
    icon = '📍',
    value = nil,
    label = Lang:t('menu.display_coords'),
    change = function(btn)
      ToggleShowCoordinates()
    end
  })
  menu:AddCheckbox({
    icon = '🛫',
    value = nil,
    label = Lang:t('menu.noclip'),
    change = function(btn)
      ToggleNoclip()
    end
  })
  menu:AddButton({
    icon = '📝',
    value = nil,
    label = Lang:t('menu.copy_vector3'),
    select = function(btn)
      CopyToClipboard('coords3')
    end
  })
  menu:AddButton({
    icon = '📝',
    value = nil,
    label = Lang:t('menu.copy_vector4'),
    select = function(btn)
      CopyToClipboard('coords4')
    end
  })
  menu:AddButton({
    icon = '📝',
    value = nil,
    label = Lang:t('menu.copy_heading'),
    select = function(btn)
      CopyToClipboard('heading')
    end
  })
  menu:AddCheckbox({
    icon = '🔫',
    value = nil,
    label = Lang:t('menu.delete_lazer'),
    change = function(btn)
      deletelazer = not deletelazer
      print('Coming Soon..')
    end
  })
end)

OpenPlayerMenu = function(player)
  local playerMenu = MenuV:CreateMenu(false, player.id .. Lang:t('info.options'), menuLocation, 220, 20, 60, menuSize, 'qbcore', 'menuv', 'test6')
  playerMenu:ClearItems()
  MenuV:OpenMenu(playerMenu)

  local elements = {
    {
      icon = '💀',
      label = Lang:t("menu.kill"),
      value = "kill",
      description = Lang:t("menu.kill").. " " .. player.id
    },
    {
      icon = '🏥',
      label = Lang:t("menu.revive"),
      value = "revive",
      description = Lang:t("menu.revive") .. " " .. player.id
    },
    {
      icon = '🏥',
      label = Lang:t("menu.heal"),
      value = "heal",
      description = Lang:t("menu.heal") .. " " .. player.id
    },
    {
      icon = '🥶',
      label = Lang:t("menu.freeze"),
      value = "freeze",
      description = Lang:t("menu.freeze") .. " " .. player.id
    },
    {
      icon = '👀',
      label = Lang:t("menu.spectate"),
      value = "spectate",
      description = Lang:t("menu.spectate") .. " " .. player.id
    },
    {
      icon = '➡️',
      label = Lang:t("info.goto"),
      value = "goto",
      description = Lang:t("info.goto") .. " " .. player.id .. Lang:t("info.position")
    },
    {
      icon = '⬅️',
      label = Lang:t("menu.bring"),
      value = "bring",
      description = Lang:t("menu.bring") .. " " .. player.id .. " " .. Lang:t("info.your_position")
    },
    {
      icon = '🚗',
      label = Lang:t("menu.sit_in_vehicle"),
      value = "intovehicle",
      description = Lang:t("desc.sit_in_veh_desc") .. " " .. player.id .. " " .. Lang:t("desc.sit_in_veh_desc2")
    },
    {
      icon = '🎒',
      label = Lang:t("menu.open_inv"),
      value = "inventory",
      description = Lang:t("info.open") .. " " .. player.id .. Lang:t("info.inventories")
    },
    {
      icon = '👕',
      label = Lang:t("menu.give_clothing_menu"),
      value = "cloth",
      description = Lang:t("desc.clothing_menu_desc") .. " " .. player.id
    },
    {
      icon = '🥾',
      label = Lang:t("menu.kick"),
      value = "kick",
      description = Lang:t("menu.kick") .. " " .. player.id .. " " .. Lang:t("info.reason")
    },
    {
      icon = '🚫',
      label = Lang:t("menu.ban"),
      value = "ban",
      description = Lang:t("menu.ban") .. " " .. player.id .. " " .. Lang:t("info.reason")
    },
    {
      icon = '🎟️',
      label = Lang:t("menu.permissions"),
      value = "perms",
      description = Lang:t("info.give") .. " " .. player.id .. " " .. Lang:t("menu.permissions")
    }
  }

  for k,v in ipairs(elements) do
    playerMenu:AddButton({
      icon = v.icon,
      label = ' ' .. v.label,
      value = v.value,
      description = v.description,
      select = function(btn)
        local values = btn.Value
        if values ~= 'ban' and values ~= 'kick' and values ~= 'perms' then
          TriggerServerEvent('admin:server:' .. values, player)
        elseif values == 'ban' then
          OpenBanMenu(player)
        elseif values == 'kick' then
          OpenKickMenu(player)
        elseif values == 'perms' then
          OpenPermsMenu(player)
        end
      end
    })
  end
end

OpenBanMenu = function(banplayer)
  local banMenu = MenuV:CreateMenu(false, Lang:t('menu.ban'), menuLocation, 220, 20, 60, menuSize, 'qbcore', 'menuv', 'test9')
  banMenu:ClearItems()
  MenuV:OpenMenu(banMenu)

  banMenu:AddButton({
    label = Lang:t('info.reason'),
    value = 'reason',
    description = Lang:t('desc.ban_reason'),
    select = function(btn)
      banreason = LocalInput(Lang:t('desc.ban_reason'), 255)
    end
  })

  banMenu:AddSlider({
    icon = '⌚',
    label = Lang:t('info.length'),
    value = '3600',
    values = {{
      label = Lang:t("time.1hour"),
      value = '3600',
      description = Lang:t("time.ban_length")
    }, {
      label = Lang:t("time.6hour"),
      value ='21600',
      description = Lang:t("time.ban_length")
    }, {
      label = Lang:t("time.12hour"),
      value = '43200',
      description = Lang:t("time.ban_length")
    }, {
      label = Lang:t("time.1day"),
      value = '86400',
      description = Lang:t("time.ban_length")
    }, {
      label = Lang:t("time.3day"),
      value = '259200',
      description = Lang:t("time.ban_length")
    }, {
      label = Lang:t("time.1week"),
      value = '604800',
      description = Lang:t("time.ban_length")
    }, {
      label = Lang:t("time.1month"),
      value = '2678400',
      description = Lang:t("time.ban_length")
    }, {
      label = Lang:t("time.3month"),
      value = '8035200',
      description = Lang:t("time.ban_length")
    }, {
      label = Lang:t("time.6month"),
      value = '16070400',
      description = Lang:t("time.ban_length")
    }, {
      label = Lang:t("time.1year"),
      value = '32140800',
      description = Lang:t("time.ban_length")
    }, {
      label = Lang:t("time.permenent"),
      value = '99999999999',
      description = Lang:t("time.ban_length")
    }, {
      label = Lang:t("time.self"),
      value = "self",
      description = Lang:t("time.ban_length")
    }},

    select = function(btn, newValue, oldValue)
      if newValue == 'self' then
        banlength = LocalInputInt('Ban Length', 11)
      else
        banlength = newValue
      end
    end
  })

  banMenu:AddButton({
    label = Lang:t('info.confirm'),
    value = 'ban',
    description = Lang:t('desc.confirm_ban'),
    select = function(btn)
      if banreason ~= 'Unknown' and banlength ~= nil then
        TriggerServerEvent('admin:server:ban', banplayer, banlength, banreason)
        banreason = 'Unknown'
        banlength = nil
      else
        exports['qbr-core']:Notify(9, Lang:t('error.invalid_reason_length_ban'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
      end
    end
  })
end

OpenKickMenu = function(kickplayer)
  local kickMenu = MenuV:CreateMenu(false, Lang:t('menu.kick'), menuLocation, 220, 20, 60, menuSize, 'qbcore', 'menuv', 'test7')
  kickMenu:ClearItems()
  MenuV:OpenMenu(kickMenu)

  kickMenu:AddButton({
    label = Lang:t('info.reason'),
    value = 'reason',
    description = Lang:t('desc.kick_reason'),
    select = function(btn)
      kickreason = LocalInput(Lang:t('desc.kick_reason'), 255)
    end
  })

  banMenu:AddButton({
    label = Lang:t('info.confirm'),
    value = 'kick',
    description = Lang:t('desc.confirm_ban'),
    select = function(btn)
      if kickreason ~= 'Unknown' then
        TriggerServerEvent('admin:server:kick', kickplayer, banreason)
        kickreason = 'Unknown'
      else
        exports['qbr-core']:Notify(9, Lang:t('error.missing_reason'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
      end
    end
  })
end

OpenPermsMenu = function(permsplayer)
  exports['qbr-core']:TriggerCallback('admin:server:hasperms', function(hasperms)
    if hasperms then
      local permMenu = MenuV:CreateMenu(false, Lang:t('menu.perms'), menuLocation, 220, 20, 60, menuSize, 'qbcore', 'menuv', 'test8')
      permMenu:ClearItems()
      MenuV:OpenMenu(permMenu)

      permMenu:AddSlider({
        label = 'Group',
        value = 'user',
        values = {
          {
            label = 'User',
            value = 'user',
            description = 'Group'
          },
          {
            label = 'Admin',
            value = 'admin',
            description = 'Group'
          },
          {
            label = 'God',
            value = 'god',
            description = 'Group'
          }
        },
        change = function(item, newValue, oldValue)
          local vcal = newValue
          if vcal == 1 then
            selectedgroup = {}
            selectedgroup[#selectedgroup + 1] = {rank = 'user', label = 'User'}
          elseif vcal == 2 then
            selectedgroup = {}
            selectedgroup[#selectedgroup + 1] = {rank = 'admin', label = 'Admin'}
          elseif vcal == 3 then
            selectedgroup = {}
            selectedgroup[#selectedgroup + 1] = {rank = 'god', label = 'God'}
          end
        end
      })

      permMenu:AddButton({
        label = Lang:t('info.confirm'),
        value = 'giveperms',
        description = 'Give the permission group',
        select = function(btn)
          if selectedgroup ~= 'Unknown' then
            TriggerServerEvent('admin:server:setpermission', permsplayer.id, selectedgroup)
            exports['qbr-core']:Notify(9, Lang:t('success.changed_perms'), 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
            selectedgroup = 'Unknown'
          else
            exports['qbr-core']:Notify(9, Lang:t('error.changed_perm_failed'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
          end
        end
      })
    else
      MenuV:CloseMenu(mainMenu)
    end
  end, 'perms')
end

CopyToClipboard = function(dataType)
  local ped = PlayerPedId()
  if dataType == 'coords3' then
    local coords = GetEntityCoords(ped)
    local x = round(coords.x, 2)
    local y = round(coords.y, 2)
    local z = round(coords.z, 2)
    SendNUIMessage({
        string = string.format('vector3(%s, %s, %s)', x, y, z)
    })
    exports['qbr-core']:Notify(9, Lang:t("success.coords_copied"), 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
  elseif dataType == 'coords4' then
    local coords = GetEntityCoords(ped)
    local x = round(coords.x, 2)
    local y = round(coords.y, 2)
    local z = round(coords.z, 2)
    local heading = GetEntityHeading(ped)
    local h = round(heading, 2)
    SendNUIMessage({
        string = string.format('vector4(%s, %s, %s, %s)', x, y, z, h)
    })
    exports['qbr-core']:Notify(9, Lang:t("success.coords_copied"), 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
  elseif dataType == 'heading' then
    local heading = GetEntityHeading(ped)
    local h = round(heading, 2)
    SendNUIMessage({
        string = h
    })
    exports['qbr-core']:Notify(9, Lang:t("success.heading_copied"), 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
  end
end

ToggleShowCoordinates = function()
  ShowingCoords = not ShowingCoords
  CreateThread(function()
    while ShowingCoords do
      local coords = GetEntityCoords(PlayerPedId())
      local heading = GetEntityHeading(PlayerPedId())
      local c = {}
      c.x = round(coords.x, 2)
      c.y = round(coords.y, 2)
      c.z = round(coords.z, 2)
      c.w = round(heading, 2)
      Wait(0)
      DrawScreenText(string.format('~w~COORDS: ~b~vector4(~w~%s~b~, ~w~%s~b~, ~w~%s~b~, ~w~%s~b~)', c.x, c.y, c.z, c.w), 0.4, 0.025, true)
    end
  end)
end

RevivePlayer = function()
  local ped = PlayerPedId()
  local pos = GetEntityCoords(ped)
  NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(ped), true, false)
  SetEntityInvincible(ped, false)
  SetEntityMaxHealth(ped, 200)
  SetEntityHealth(ped, 200)
  ClearPedBloodDamage(ped)
  TriggerServerEvent('hud:server:RelieveStress', 100)
  exports['qbr-core']:Notify(9, Lang:t('info.health'), 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
end

HealPlayer = function()
  local ped = PlayerPedId()
  SetEntityInvincible(ped, false)
  SetEntityMaxHealth(ped, 200)
  SetEntityHealth(ped, 200)
  ClearPedBloodDamage(ped)
  TriggerServerEvent('hud:server:RelieveStress', 100)
end

ToggleNoclip = function()
  TriggerEvent('admin:client:ToggleNoClip')
end

GotoCoords = function(coords)
  if type(coords) ~= 'vector3' then
    exports['qbr-core']:Notify(9, Lang:t('error.invalid_coords'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
  end

  local x = coords[1]
  local y = coords[2]
  local z = coords[3]
  local ped = PlayerPedId()

  DoScreenFadeOut(500)
  while not IsScreenFadedOut() do
    Wait(0)
  end

  SetEntityCoords(ped, x, y, 100.0)
  if z == 0 then
    local _finalZ
    local delay = 500
    for i = 1, 5 do
      if _finalZ ~= nil then
        break
      end

      _finalZ = findZ(x, y)
      if _z == nil then
        Wait(delay)
      end
    end

    if _finalZ ~= nil then
      z = _finalZ
    end
  end

  SetEntityCoords(ped, x, y, z)
  DoScreenFadeIn(500)
end

GotoMarker = function()
  local waypoint = GetWaypointCoords()
  if waypoint.x ~= 0 and waypoint.y ~= 0 then
    GotoCoords(vec3(waypoint.x, waypoint.y, 0))
  else
    exports['qbr-core']:Notify(9, Lang:t('error.invalid_coords'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
  end
end

round = function(input, decimalPlaces)
  return tonumber(string.format('%.' .. (decimalPlaces or 0) .. 'f', input))
end

findZ = function(x, y)
  local found = true
  local start_z = 1500
  local z = start_z

  while found and z > 0 do
    local _found, _z, _normal = GetGroundZAndNormalFor_3dCoord(x, y, z + 0.0)
    if _found then
        z = _z + 0.0
    end
    found = _found
    Wait(0)
  end

  if z == start_z then
    return nil
  end

  return z + 0.0
end

LocalInput = function(text, number, window)
  AddTextEntry('FMMC_MPM_NA', text)
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)

  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0)
    Wait(0)
  end

  if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
    return result
  end
end

LocalInput = function(text, number, window)
  AddTextEntry("FMMC_MPM_NA", text)
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", windows or "", "", "", "", number or 30)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0)
    Wait(0)
  end
  if (GetOnscreenKeyboardResult()) then
    local result = GetOnscreenKeyboardResult()
    return tonumber(result)
  end
end

DrawScreenText = function(text, x, y, centred)
  SetTextScale(0.35, 0.35)
	SetTextColor(255, 255, 255, 255)
	SetTextCentre(centred)
	SetTextDropshadow(1, 0, 0, 0, 200)
	SetTextFontForCurrentCommand(0)
	DisplayText(CreateVarString(10, "LITERAL_STRING", text), x, y)
end

RegisterNetEvent('admin:client:OpenMenu', function()
  MenuV:OpenMenu(mainMenu)
end)

RegisterNetEvent('admin:client:revivePlayer', function()
  RevivePlayer()
end)

RegisterNetEvent('admin:client:healPlayer', function()
  HealPlayer()
end)

RegisterNetEvent('admin:client:spectate', function(targetPed, coords)
  local myPed = PlayerPedId()
  local targetPlayer =  GetPlayerFromServerId(targetPed)
  local target = GetPlayerPed(targetPlayer)
  if not IsSpectating then
    IsSpectating = true
    SetEntityVisible(myPed, false)
    SetEntityInvincible(myPed, true)
    LastSpectateCoord = GetEntityCoords(myPed)
    SetEntityCoords(myPed, coords)
    NetworkIsInSpectatorMode(true, target)
  else
    IsSpectating = false
    NetworkIsInSpectatorMode(false, target)
    SetEntityCoords(myPed, LastSpectateCoord)
    SetEntityVisible(myPed, true)
    SetEntityInvincible(myPed, false)
    LastSpectateCoord = nil
  end
end)