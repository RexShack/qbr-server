local function handleInput(radius, center, useZ)
  local delta = 0.05
  -- BlockWeaponWheelThisFrame()
  if IsDisabledControlPressed(2, Keys["CTRL"]) then -- ctrl held down
    delta = 0.01
  end
  if IsDisabledControlJustPressed(2, Keys["MWDOWN"]) then
    if IsDisabledControlPressed(2, Keys["LALT"]) then -- alt held down
      return radius, vector3(center.x, center.y, center.z - delta), useZ
    end
    return math.max(0.0, radius - delta), center, useZ
  end
  if IsDisabledControlJustPressed(2, Keys["MWUP"]) then
    if IsDisabledControlPressed(2, Keys["LALT"]) then -- alt held down
      return radius, vector3(center.x, center.y, center.z + delta), useZ
    end
    return radius + delta, center, useZ
  end

  if IsControlJustPressed(2, Keys["Z"]) then -- Z pressed
    return radius, center, not useZ
  end

  local rot = GetGameplayCamRot(2)
  center = handleArrowInput(center, rot.z)

  return radius, center, useZ
end

function circleStart(name, radius, useZ)
  local center = GetEntityCoords(PlayerPedId())
  useZ = useZ or false
  createdZone = CircleZone:Create(center, radius, {name = tostring(name), useZ = useZ})
  Citizen.CreateThread(function()
    LocalPlayer.state:set("PolyZoneCreation", true, true)
    while createdZone do
      DisableControls()
      radius, center, useZ = handleInput(radius, center, useZ)
      createdZone:setRadius(radius)
      createdZone:setCenter(center)
      createdZone.useZ = useZ
      Wait(0)
    end
    LocalPlayer.state:set("PolyZoneCreation", false, true)
  end)
end

function circleFinish()
  TriggerServerEvent("polyzone:printCircle",
    {name=createdZone.name, center=createdZone.center, radius=createdZone.radius, useZ=createdZone.useZ})
end