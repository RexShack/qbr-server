Citizen.CreateThread(function()
    local active = false
    local timer = 0
    while true do 
        Wait(0)
        if IsControlJustPressed(0,0xCEFD9220) then -- E KEY
            timer = 0
            active = true
            while  timer < 200 do 
                Wait(0)
                timer = timer + 1
                SetRelationshipBetweenGroups(1, `PLAYER`, `PLAYER`)
            end
            
            active = false
        end

        if IsControlJustPressed(0,0xB2F377E8) then -- F KEY
			Wait(500)
			SetRelationshipBetweenGroups(1, `PLAYER`, `PLAYER`)
			active = false
			timer = 0
        end
            
        if active == false and not IsPedOnMount(PlayerPedId()) and not IsPedInAnyVehicle(PlayerPedId()) then
            SetRelationshipBetweenGroups(5, `PLAYER`, `PLAYER`)
        end	
    end
end)