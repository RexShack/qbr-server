local config = {
    pedFrequency = 1.0,
    trafficFrequency = 0.3,
    animalFrequency = 1.0,
}

Citizen.CreateThread(function()
	while true do
		Citizen.InvokeNative(0xC0258742B034DFAF, config.animalFrequency) 	-- SetAmbientAnimalDensityMultiplierThisFrame
	    Citizen.InvokeNative(0xBA0980B5C0A11924, config.pedFrequency) 		-- SetAmbientHumanDensityMultiplierThisFrame
	    Citizen.InvokeNative(0xAB0D553FE20A6E25, config.pedFrequency) 		-- SetAmbientPedDensityMultiplierThisFrame
		Citizen.InvokeNative(0xDB48E99F8E064E56, config.animalFrequency) 	-- SetScenarioAnimalDensityMultiplierThisFrame
		Citizen.InvokeNative(0x28CB6391ACEDD9DB, config.pedFrequency) 		-- SetScenarioHumanDensityMultiplierThisFrame
		Citizen.InvokeNative(0x7A556143A1C03898, config.pedFrequency)		-- SetScenarioPedDensityMultiplierThisFrame

		Citizen.InvokeNative(0xFEDFA97638D61D4A, config.trafficFrequency) 	-- SetParkedVehicleDensityMultiplierThisFrame
		Citizen.InvokeNative(0x1F91D44490E1EA0C, config.trafficFrequency) 	-- SetRandomVehicleDensityMultiplierThisFrame
		Citizen.InvokeNative(0x606374EBFC27B133, config.trafficFrequency) 	-- SetVehicleDensityMultiplierThisFrame

		Citizen.Wait(1)
	end
end)
