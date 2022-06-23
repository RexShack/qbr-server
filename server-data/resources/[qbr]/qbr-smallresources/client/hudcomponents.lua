-- https://vespura.com/doc/natives/?_0xC116E6DF68DCE667

--[[
------------------------------
0 : ICON_STAMINA,
1 : ICON_STAMINA_CORE,
2 : ICON_DEADEYE,
3 : ICON_DEADEYE_CORE,
4 : ICON_HEALTH,
5 : ICON_HEALTH_CORE,
6 : ICON_HORSE_HEALTH,
7 : ICON_HORSE_HEALTH_CORE,
8 : ICON_HORSE_STAMINA,
9 : ICON_HORSE_STAMINA_CORE,
10 : ICON_HORSE_COURAGE,
11 : ICON_HORSE_COURAGE_CORE
------------------------------
1 = show
2 = hide
------------------------------

--]]

Citizen.CreateThread(function()

	--Citizen.InvokeNative(0xC116E6DF68DCE667, 0, 2) -- ICON_STAMINA / HIDE
	--Citizen.InvokeNative(0xC116E6DF68DCE667, 1, 2) -- ICON_STAMINA_CORE / HIDE
	
	Citizen.InvokeNative(0xC116E6DF68DCE667, 2, 2) -- ICON_DEADEYE / HIDE
	Citizen.InvokeNative(0xC116E6DF68DCE667, 3, 2) -- ICON_DEADEYE_CORE / HIDE
	
	--Citizen.InvokeNative(0xC116E6DF68DCE667, 4, 2) -- ICON_HEALTH / HIDE
	--Citizen.InvokeNative(0xC116E6DF68DCE667, 5, 2) -- ICON_HEALTH_CORE / HIDE
	
	--Citizen.InvokeNative(0xC116E6DF68DCE667, 6, 2) -- ICON_HORSE_HEALTH / HIDE
	--Citizen.InvokeNative(0xC116E6DF68DCE667, 7, 2) -- ICON_HORSE_HEALTH_CORE / HIDE
	
	--Citizen.InvokeNative(0xC116E6DF68DCE667, 8, 2) -- ICON_HORSE_STAMINA / HIDE
	--Citizen.InvokeNative(0xC116E6DF68DCE667, 9, 2) -- ICON_HORSE_STAMINA_CORE / HIDE
	
	--Citizen.InvokeNative(0xC116E6DF68DCE667, 10, 2) -- ICON_HORSE_COURAGE / HIDE
	--Citizen.InvokeNative(0xC116E6DF68DCE667, 11, 2) -- ICON_HORSE_COURAGE_CORE / HIDE
	
end)