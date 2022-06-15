local function EnableEagleeye(player, enable)
	Citizen.InvokeNative(0xA63FCAD3A6FEC6D2, player, enable)
end

AddEventHandler("playerSpawned", function(spawnInfo)
	EnableEagleeye(PlayerPedId(), true)
end)

AddEventHandler("onResourceStop", function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        EnableEagleeye(PlayerPedId(), false)
	end
end)
