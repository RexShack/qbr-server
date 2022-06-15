local LegsComponent = 0
local TorsoComponent = 0

LoadSkin = function(ped, data)
  local dataExist = false 

  if data and next(data) then 
    dataExist = true 
  else
    data.skin = 1
    data.heads = 1
    data.hair = 1
    data.eyes = 1
    data.beard = 1
    dataExist = true
  end

    while not Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, ped) do
      Citizen.Wait(1)
    end

    local sex = IsPedMale(ped) and 'Male' or 'Female'
    if data.height then 
      local value = tonumber(data.height)
      SetPedScale(ped, tonumber(value / 100))
    end

    if data.skin > 0 then
      local value = tonumber(data.skin)

      if sex == 'Male' then 
        if value == 1 then
          LegsComponent = Skins[sex]['BODIES_LOWER'][1]
          TorsoComponent = Skins[sex]['BODIES_UPPER'][1]
          texture_types["male"].albedo = GetHashKey("mp_head_mr1_sc08_c0_000_ab")
        elseif value == 2 then
          LegsComponent = Skins[sex]['BODIES_LOWER'][3]
          TorsoComponent = Skins[sex]['BODIES_UPPER'][3]
          texture_types["male"].albedo = GetHashKey("head_mr1_sc02_rough_c0_002_ab")
        elseif value == 3 then
          LegsComponent = Skins[sex]['BODIES_LOWER'][8]
          TorsoComponent = Skins[sex]['BODIES_UPPER'][8]
          texture_types["male"].albedo = GetHashKey("MP_head_mr1_sc01_c0_000_ab")
        elseif value == 4 then
          LegsComponent = Skins[sex]['BODIES_LOWER'][10]
          TorsoComponent = Skins[sex]['BODIES_UPPER'][10]
          texture_types["male"].albedo = GetHashKey("MP_head_mr1_sc03_c0_000_ab")
        elseif value == 5 then
          LegsComponent = Skins[sex]['BODIES_LOWER'][11]
          TorsoComponent = Skins[sex]['BODIES_UPPER'][11]
          texture_types["male"].albedo = GetHashKey("head_mr1_sc04_rough_c0_002_ab")
        elseif value == 6 then
          LegsComponent = Skins[sex]['BODIES_LOWER'][30]
          TorsoComponent = Skins[sex]['BODIES_UPPER'][30]
          texture_types["male"].albedo = GetHashKey("MP_head_mr1_sc05_c0_000_ab")
        end
      else
        if value == 1 then
          LegsComponent = Skins[sex]['BODIES_LOWER'][1]
          TorsoComponent = Skins[sex]['BODIES_UPPER'][1]
          texture_types["female"].albedo = GetHashKey("mp_head_fr1_sc08_c0_000_ab")
        elseif value == 2 then
          LegsComponent = Skins[sex]['BODIES_LOWER'][3]
          TorsoComponent = Skins[sex]['BODIES_UPPER'][3]
          texture_types["female"].albedo = GetHashKey("MP_head_fr1_sc03_c0_000_ab")
        elseif value == 3 then
          LegsComponent = Skins[sex]['BODIES_LOWER'][8]
          TorsoComponent = Skins[sex]['BODIES_UPPER'][8]
          texture_types["female"].albedo = GetHashKey("MP_head_fr1_sc01_c0_000_ab")
        elseif value == 4 then
          LegsComponent = Skins[sex]['BODIES_LOWER'][10]
          TorsoComponent = Skins[sex]['BODIES_UPPER'][10]
          texture_types["female"].albedo = GetHashKey("MP_head_fr1_sc03_c0_000_ab")
        elseif value == 5 then
          LegsComponent = Skins[sex]['BODIES_LOWER'][11]
          TorsoComponent = Skins[sex]['BODIES_UPPER'][11]
          texture_types["female"].albedo = GetHashKey("head_fr1_sc04_rough_c0_002_ab")
        elseif value == 6 then
          LegsComponent = Skins[sex]['BODIES_LOWER'][30]
          TorsoComponent = Skins[sex]['BODIES_UPPER'][30]
          texture_types["female"].albedo = GetHashKey("MP_head_fr1_sc05_c0_000_ab")
        end
      end

      Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(TorsoComponent), false, true, true)
      Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(LegsComponent), false, true, true)
      Citizen.InvokeNative(0x704C908E9C405136, ped)
    end

    if data.heads then 
      local value = tonumber(data.heads)
      local hash = Skins[sex]['heads'][value] 
      Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(hash), false, true, true)
    end

    if data.hair then 
      local value = tonumber(data.hair)
      local hash = Skins[sex]['hair'][value] 
      Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(hash), false, true, true)
    end

    if data.eyes then 
      local value = tonumber(data.eyes)
      local hash = Skins[sex]['eyes'][value] 
      Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(hash), false, true, true)
    end

    if sex == 'Male' and data.beard then 
      local value = tonumber(data.beard)
      local hash = Skins[sex]['beard'][value] 
      Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(hash), false, true, true)
    end

    if data.body_size then 
      Citizen.InvokeNative(0x1902C4CFCC5BE57C, ped, Config.BodyTypes[data.body_size])
    end

    for k,v in pairs(data) do 
      if Config.Features[k] then 
        Citizen.InvokeNative(0x5653AB26C82938CF, ped, Config.Features[k], tonumber(v / 100))
      end
    end

    if data.overlays then 
      for k,v in pairs(data.overlays) do 
        if k == 'eyebrows' then 
          ToggleOverlayChange('eyebrows', 1, tonumber(v.type), 0, 0, 0, 1.0, 0, tonumber(v.color_palette), tonumber(v.main_color), tonumber(v.second_color), tonumber(v.third_color), tonumber(0), tonumber(v.visibility / 100), ped)
        end
      end
    end

    Citizen.Wait(250)
    Citizen.InvokeNative(0x704C908E9C405136, ped)
    Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, 0)
    SkinData = data
  -- else
  --   SkinData = {}
  -- end
end

exports('loadSkin', LoadSkin)

ChangeNotUpdate = function(ped, data)
  while not Citizen.InvokeNative(0xA0BC8FAED8CFEB3C, ped) do
    Citizen.Wait(1)
  end

  local sex = IsPedMale(ped) and 'Male' or 'Female'
  if data.height then 
    local value = tonumber(data.height)
    SetPedScale(ped, tonumber(value / 100))
  end

  if data.skin > 0 then 
    local value = tonumber(data.skin)
    if sex == 'Male' then 
      if value == 1 then
        LegsComponent = Skins[sex]['BODIES_LOWER'][1]
        TorsoComponent = Skins[sex]['BODIES_UPPER'][1]
        texture_types["male"].albedo = GetHashKey("mp_head_mr1_sc08_c0_000_ab")
      elseif value == 2 then
        LegsComponent = Skins[sex]['BODIES_LOWER'][3]
        TorsoComponent = Skins[sex]['BODIES_UPPER'][3]
        texture_types["male"].albedo = GetHashKey("head_mr1_sc02_rough_c0_002_ab")
      elseif value == 3 then
        LegsComponent = Skins[sex]['BODIES_LOWER'][8]
        TorsoComponent = Skins[sex]['BODIES_UPPER'][8]
        texture_types["male"].albedo = GetHashKey("MP_head_mr1_sc01_c0_000_ab")
      elseif value == 4 then
        LegsComponent = Skins[sex]['BODIES_LOWER'][10]
        TorsoComponent = Skins[sex]['BODIES_UPPER'][10]
        texture_types["male"].albedo = GetHashKey("MP_head_mr1_sc03_c0_000_ab")
      elseif value == 5 then
        LegsComponent = Skins[sex]['BODIES_LOWER'][11]
        TorsoComponent = Skins[sex]['BODIES_UPPER'][11]
        texture_types["male"].albedo = GetHashKey("head_mr1_sc04_rough_c0_002_ab")
      elseif value == 6 then
        LegsComponent = Skins[sex]['BODIES_LOWER'][30]
        TorsoComponent = Skins[sex]['BODIES_UPPER'][30]
        texture_types["male"].albedo = GetHashKey("MP_head_mr1_sc05_c0_000_ab")
      end
    else
      if value == 1 then
        LegsComponent = Skins[sex]['BODIES_LOWER'][1]
        TorsoComponent = Skins[sex]['BODIES_UPPER'][1]
        texture_types["female"].albedo = GetHashKey("mp_head_fr1_sc08_c0_000_ab")
      elseif value == 2 then
        LegsComponent = Skins[sex]['BODIES_LOWER'][3]
        TorsoComponent = Skins[sex]['BODIES_UPPER'][3]
        texture_types["female"].albedo = GetHashKey("MP_head_fr1_sc03_c0_000_ab")
      elseif value == 3 then
        LegsComponent = Skins[sex]['BODIES_LOWER'][8]
        TorsoComponent = Skins[sex]['BODIES_UPPER'][8]
        texture_types["female"].albedo = GetHashKey("MP_head_fr1_sc01_c0_000_ab")
      elseif value == 4 then
        LegsComponent = Skins[sex]['BODIES_LOWER'][10]
        TorsoComponent = Skins[sex]['BODIES_UPPER'][10]
        texture_types["female"].albedo = GetHashKey("MP_head_fr1_sc03_c0_000_ab")
      elseif value == 5 then
        LegsComponent = Skins[sex]['BODIES_LOWER'][11]
        TorsoComponent = Skins[sex]['BODIES_UPPER'][11]
        texture_types["female"].albedo = GetHashKey("head_fr1_sc04_rough_c0_002_ab")
      elseif value == 6 then
        LegsComponent = Skins[sex]['BODIES_LOWER'][30]
        TorsoComponent = Skins[sex]['BODIES_UPPER'][30]
        texture_types["female"].albedo = GetHashKey("MP_head_fr1_sc05_c0_000_ab")
      end
    end

    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(TorsoComponent), false, true, true)
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(LegsComponent), false, true, true)
    Citizen.InvokeNative(0x704C908E9C405136, ped)
  end

  if data.heads then 
    local value = tonumber(data.heads)
    local hash = Skins[sex]['heads'][value] 
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(hash), false, true, true)
  end

  if data.hair then 
    local value = tonumber(data.hair)
    local hash = Skins[sex]['hair'][value] 
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(hash), false, true, true)
  end

  if data.eyes then 
    local value = tonumber(data.eyes)
    local hash = Skins[sex]['eyes'][value] 
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(hash), false, true, true)
  end

  if data.beard then 
    local value = tonumber(data.beard)
    local hash = Skins[sex]['beard'][value] 
    Citizen.InvokeNative(0xD3A7B003ED343FD9, ped, tonumber(hash), false, true, true)
  end

  if data.body_size then 
    Citizen.InvokeNative(0x1902C4CFCC5BE57C, ped, Config.BodyTypes[data.body_size])
  end

  for k,v in pairs(data) do 
    if Config.Features[k] then 
      Citizen.InvokeNative(0x5653AB26C82938CF, ped, Config.Features[k], tonumber(v / 100))
    end
  end

  if data.overlays then 
    for k,v in pairs(data.overlays) do 
      if k == 'eyebrows' then 
        ToggleOverlayChange('eyebrows', 1, tonumber(v.type), 0, 0, 0, 1.0, 0, tonumber(v.color_palette), tonumber(v.main_color), tonumber(v.second_color), tonumber(v.third_color), tonumber(0), tonumber(v.visibility / 100), ped)
      end
    end
  end

  Citizen.Wait(250)
  Citizen.InvokeNative(0x704C908E9C405136, ped)
  Citizen.InvokeNative(0xCC8CA3E88256E58F, ped, 0, 1, 1, 1, 0)
  PreviewSkinData = data
end

ToggleOverlayChange = function(_name,_visibility,_tx_id,_tx_normal,_tx_material,_tx_color_type,_tx_opacity,_tx_unk,_palette_id,_palette_color_primary,_palette_color_secondary,_palette_color_tertiary,_var,_opacity, _targets)
  Citizen.CreateThread(function()
    local name = _name
    local visibility = _visibility
    local tx_id = _tx_id
    local tx_normal = _tx_normal
    local tx_material = _tx_material
    local tx_color_type = _tx_color_type
    local tx_opacity = _tx_opacity
    local tx_unk = _tx_unk
    local palette_id = _palette_id
    local palette_color_primary = _palette_color_primary
    local palette_color_secondary = _palette_color_secondary
    local palette_color_tertiary = _palette_color_tertiary
    local var = _var
    local opacity = _opacity
    local target = _targets

    for k,v in pairs(overlay_all_layers) do
      if v.name==name then
        v.visibility = visibility
        if visibility ~= 0 then
          v.tx_normal = tx_normal
          v.tx_material = tx_material
          v.tx_color_type = tx_color_type
          v.tx_opacity =  tx_opacity
          v.tx_unk =  tx_unk
          if tx_color_type == 0 then
            v.palette = color_palettes[palette_id][1]
            v.palette_color_primary = palette_color_primary
            v.palette_color_secondary = palette_color_secondary
            v.palette_color_tertiary = palette_color_tertiary
          end
          if name == "shadows" or name == "eyeliners" or name == "lipsticks" then
            v.var = var
            v.tx_id = overlays_info[name][1].id
          else
            v.var = 0
            v.tx_id = overlays_info[name][tx_id].id
          end

          v.opacity = opacity
        end
      end
    end

    local ped = target

    if IsPedMale(ped) then
      current_texture_settings = texture_types["male"]
    else
      current_texture_settings = texture_types["female"]
    end

    if textureId ~= -1 then
      Citizen.InvokeNative(0xB63B9178D0F58D82,textureId)  -- reset texture
      Citizen.InvokeNative(0x6BEFAA907B076859,textureId)  -- remove texture
    end

    textureId = Citizen.InvokeNative(0xC5E7204F322E49EB,current_texture_settings.albedo, current_texture_settings.normal, current_texture_settings.material);

    for k,v in pairs(overlay_all_layers) do
      if v.visibility ~= 0 then
        local overlay_id = Citizen.InvokeNative(0x86BB5FF45F193A02,textureId, v.tx_id , v.tx_normal, v.tx_material, v.tx_color_type, v.tx_opacity,v.tx_unk); 
        if v.tx_color_type == 0 then
          Citizen.InvokeNative(0x1ED8588524AC9BE1,textureId,overlay_id,v.palette);
          Citizen.InvokeNative(0x2DF59FFE6FFD6044,textureId,overlay_id,v.palette_color_primary,v.palette_color_secondary,v.palette_color_tertiary)
        end

        Citizen.InvokeNative(0x3329AAE2882FC8E4,textureId,overlay_id, v.var); 
        Citizen.InvokeNative(0x6C76BC24F8BB709A,textureId,overlay_id, v.opacity); 
      end
    end

    while not Citizen.InvokeNative(0x31DC8D3F216D8509,textureId) do  -- wait till texture fully loaded
      Citizen.Wait(0)
    end

    Citizen.InvokeNative(0x0B46E25761519058,ped,GetHashKey("heads"),textureId)  -- apply texture to current component in category "heads"
    Citizen.InvokeNative(0x92DAABA2C1C10B0E,textureId)      -- update texture
    Citizen.InvokeNative(0xCC8CA3E88256E58F,ped, 0, 1, 1, 1, false);  -- refresh ped components
  end)
end