RegisterNetEvent("rsg_emotes:client:doemote")
AddEventHandler("rsg_emotes:client:doemote", function(emote)
	Citizen.InvokeNative(0xB31A277C1AC7B7FF, PlayerPedId(), 0, 0, emote, 1, 1, 0, 0)
end)