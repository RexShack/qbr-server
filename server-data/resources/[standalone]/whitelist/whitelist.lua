--[[
BU SCRIPT TUYSUZ KIRPI ye 
TURKCELESTIRMELERI Tuysuz KIRPI
]]

-- The whitelist array
local whitelistArray = {}

-- Read the "whitelist.json" file.
local data = LoadResourceFile(GetCurrentResourceName(), GetConvar("enfer.whitelist", "whitelist.json"))

-- If we got data from it, parse it and store it.
if data then
    whitelistArray = json.decode(data)
    print("" .. #whitelistArray .. " The player's whitelist has been uploaded!")
end

--[[
	When a player joins, check if they're in the whitelistArray.
	
	If they are, allow them to join. Otherwise don't let them.
]]
AddEventHandler("playerConnecting", function(playerName, setKickReason, deferrals)
    -- Tell the connection to defer until we have done
	deferrals.defer()
	
	-- Just in case "source" gets lost, store it
    local s = source
	
	-- If the player has been allowed to join the server
	local joined = false
	
	-- Tell the user we're checking stuff (not shown for long)
    deferrals.update("System is Trying to Perform Whitelist Control!")
	
	-- Needed, not sure why.
	Wait(100)
	
	-- A bunch of variables for calculating percentage
	local totalInWhitelist = #whitelistArray -- Total no of IDs in the array
	local noIdentifiers = #GetPlayerIdentifiers(s) -- How many Identifiers the player has (usually 2 or 3)
	local currentId = 0 -- The index of the id we're checking
	local totalChecksNeeded = totalInWhitelist * noIdentifiers -- The total number of interations we need (to check the entire array)
	
	-- Loop though the player's identifiers
    for myIdx,identifier in pairs(GetPlayerIdentifiers(s)) do
	
		-- Loop through the whitelist array
        for wIdx,i in ipairs(whitelistArray) do
			
			-- Check if the player exists in the array.
            if(string.lower(i) == string.lower(identifier))then
                deferrals.done() -- They're in it... Let them in!
                joined = true 
				break -- no longer need to loop 
            end
			
			-- Checking Whitelist
			deferrals.update(string.format("The whitelist is checked in order ... %.2f%%", (currentId / totalChecksNeeded)*100))

			Wait(1)
			currentId = currentId +1
        end
    end
	if joined then
		return
	end
	
	-- You Are Not In Whitelist
	deferrals.done("You are not registered with Whitelist ")
end)
