-- GetUserInput function inspired by vMenu (https://github.com/TomGrobbe/vMenu/blob/master/vMenu/CommonFunctions.cs)
function GetUserInput(windowTitle, defaultText, maxInputLength)
  -- Create the window title string.
  local resourceName = string.upper(GetCurrentResourceName())
  local textEntry = resourceName .. "_WINDOW_TITLE"
  if windowTitle == nil then
    windowTitle = "Enter:"
  end
  AddTextEntry(textEntry, windowTitle)

  -- Display the input box.
  DisplayOnscreenKeyboard(1, textEntry, "", defaultText or "", "", "", "", maxInputLength or 30)
  Wait(0)
  -- Wait for a result.
  while true do
    local keyboardStatus = UpdateOnscreenKeyboard();
    if keyboardStatus == 3 then -- not displaying input field anymore somehow
      return nil
    elseif keyboardStatus == 2 then -- cancelled
      return nil
    elseif keyboardStatus == 1 then -- finished editing
      return GetOnscreenKeyboardResult()
    else
      Wait(0)
    end
  end
end

function handleArrowInput(center, heading)
  delta = 0.05
  if IsDisabledControlPressed(2, Keys["CTRL"]) then -- ctrl held down
    delta = 0.01
  end

  if IsControlPressed(2, Keys["UP"]) then -- arrow up
    local newCenter =  PolyZone.rotate(center.xy, vector2(center.x, center.y + delta), heading)
    return vector3(newCenter.x, newCenter.y, center.z)
  end
  if IsControlPressed(2, Keys["DOWN"]) then -- arrow down
    local newCenter =  PolyZone.rotate(center.xy, vector2(center.x, center.y - delta), heading)
    return vector3(newCenter.x, newCenter.y, center.z)
  end
  if IsControlPressed(2, Keys["LEFT"]) then -- arrow left
    local newCenter =  PolyZone.rotate(center.xy, vector2(center.x - delta, center.y), heading)
    return vector3(newCenter.x, newCenter.y, center.z)
  end
  if IsControlPressed(2, Keys["RIGHT"]) then -- arrow right
    local newCenter =  PolyZone.rotate(center.xy, vector2(center.x + delta, center.y), heading)
    return vector3(newCenter.x, newCenter.y, center.z)
  end

  return center
end
Keys = {
    ["MWUP"] = 0x3076E97C,
    ["MWDOWN"] = 0x8BDE7443,
    ["CTRL"] = 0xDB096B85,
    ["SHIFT"] = 0x8FFC75D6,
    ["LALT"] = 0x8AAA0AD4,
    ["Z"] = 0x26E9DC00,
    ["UP"] = 0x6319DB71,
    ["DOWN"] = 0x05CA7C52,
    ["LEFT"] = 0xA65EBAB4,
    ["RIGHT"] = 0xDEB34313,
}



function DisableControls()
	DisableControlAction(2, Keys["MWUP"], true)
	DisableControlAction(2, Keys["MWDOWN"], true)
	DisableControlAction(2, Keys["CTRL"], true)
	DisableControlAction(2, Keys["SHIFT"], true)
	DisableControlAction(2, Keys["LALT"], true)
	DisableControlAction(2, Keys["CTRL"], true)
end