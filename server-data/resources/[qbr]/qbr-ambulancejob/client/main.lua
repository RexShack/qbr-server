
local getOutDict = 'script_re@campfire_massacre'
local getOutAnim = 'cry_getup_man'
local walkHealthDict = 'arthur_healthy'
local walkHealthAnim = 'default'
local canLeaveBed = true
local bedOccupying = nil
local bedObject = nil
local bedOccupyingData = nil
local closestBed = nil
local doctorCount = 0
local CurrentDamageList = {}
inBedDict = "script_common@dead@male"
inBedAnim = "faceup_01"
isInHospitalBed = false
isBleeding = 0
bleedTickTimer, advanceBleedTimer = 0, 0
fadeOutTimer, blackoutTimer = 0, 0
legCount = 0
armcount = 0
headCount = 0
playerHealth = nil
isDead = false
isStatusChecking = false
statusChecks = {}
statusCheckTime = 0
isHealingPerson = false
injured = {}

BodyParts = {
    ['HEAD'] =          { label = Lang:t('body.head'),          causeLimp = false, isDamaged = false, severity = 0 },
    ['NECK'] =          { label = Lang:t('body.neck'),          causeLimp = false, isDamaged = false, severity = 0 },
    ['SPINE'] =         { label = Lang:t('body.spine'),         causeLimp = true, isDamaged = false, severity = 0 },
    ['UPPER_BODY'] =    { label = Lang:t('body.upper_body'),    causeLimp = false, isDamaged = false, severity = 0 },
    ['LOWER_BODY'] =    { label = Lang:t('body.lower_body'),    causeLimp = true, isDamaged = false, severity = 0 },
    ['LARM'] =          { label = Lang:t('body.left_arm'),      causeLimp = false, isDamaged = false, severity = 0 },
    ['LHAND'] =         { label = Lang:t('body.left_hand'),     causeLimp = false, isDamaged = false, severity = 0 },
    ['LFINGER'] =       { label = Lang:t('body.left_fingers'),  causeLimp = false, isDamaged = false, severity = 0 },
    ['LLEG'] =          { label = Lang:t('body.left_leg'),      causeLimp = true, isDamaged = false, severity = 0 },
    ['LFOOT'] =         { label = Lang:t('body.left_foot'),     causeLimp = true, isDamaged = false, severity = 0 },
    ['RARM'] =          { label = Lang:t('body.right_arm'),     causeLimp = false, isDamaged = false, severity = 0 },
    ['RHAND'] =         { label = Lang:t('body.right_hand'),    causeLimp = false, isDamaged = false, severity = 0 },
    ['RFINGER'] =       { label = Lang:t('body.right_fingers'), causeLimp = false, isDamaged = false, severity = 0 },
    ['RLEG'] =          { label = Lang:t('body.right_leg'),     causeLimp = true, isDamaged = false, severity = 0 },
    ['RFOOT'] =         { label = Lang:t('body.right_foot'),    causeLimp = true, isDamaged = false, severity = 0 },
}

WeaponDamageList = {
	['WEAPON_UNARMED'] = Lang:t('damage.unarmed'),
	['WEAPON_ANIMAL'] = Lang:t('damage.animal'),
	['WEAPON_COUGAR'] = Lang:t('damage.animal'),
    ['WEAPON_REVOLVER_CATTLEMAN'] = Lang:t('damage.revolver'),
	['WEAPON_REVOLVER_CATTLEMAN_MEXICAN'] = Lang:t('damage.revolver'),
	['WEAPON_REVOLVER_DOUBLEACTION_GAMBLER'] = Lang:t('damage.revolver'),
	['WEAPON_REVOLVER_SCHOFIELD'] = Lang:t('damage.revolver'),
	['WEAPON_REVOLVER_LEMAT'] = Lang:t('damage.revolver'),
	['WEAPON_REVOLVER_NAVY'] = Lang:t('damage.revolver'),
	['WEAPON_PISTOL_VOLCANIC'] = Lang:t('damage.pistol'),
	['WEAPON_PISTOL_M1899'] = Lang:t('damage.pistol'),
	['WEAPON_PISTOL_MAUSER'] = Lang:t('damage.pistol'),
	['WEAPON_PISTOL_SEMIAUTO'] = Lang:t('damage.pistol'),
	['WEAPON_REPEATER_CARBINE'] = Lang:t('damage.rifle'),
	['WEAPON_REPEATER_WINCHESTER'] = Lang:t('damage.rifle'),
	['WEAPON_REPEATER_HENRY'] = Lang:t('damage.rifle'),
	['WEAPON_REPEATER_EVANS'] = Lang:t('damage.rifle'),
	['WEAPON_RIFLE_VARMINT'] = Lang:t('damage.rifle'),
	['WEAPON_RIFLE_SPRINGFIELD'] = Lang:t('damage.rifle'),
	['WEAPON_RIFLE_BOLTACTION'] = Lang:t('damage.rifle'),
	['WEAPON_RIFLE_ELEPHANT'] = Lang:t('damage.rifle'),
	['WEAPON_SHOTGUN_DOUBLEBARREL'] = Lang:t('damage.shotgun'),
	['WEAPON_SHOTGUN_DOUBLEBARREL_EXOTIC'] = Lang:t('damage.shotgun'),
	['WEAPON_SHOTGUN_SAWEDOFF'] = Lang:t('damage.shotgun'),
	['WEAPON_SHOTGUN_SEMIAUTO'] = Lang:t('damage.shotgun'),
	['WEAPON_SNIPERRIFLE_ROLLINGBLOCK'] = Lang:t('damage.sniper'),
	['WEAPON_SNIPERRIFLE_ROLLINGBLOCK_EXOTIC'] = Lang:t('damage.sniper'),
	['WEAPON_SNIPERRIFLE_CARCANO'] = Lang:t('damage.sniper'),
	['WEAPON_BOW'] = Lang:t('damage.bow'),
	['WEAPON_BOW_IMPROVED'] = Lang:t('damage.bow'),
	['WEAPON_LASSO'] = Lang:t('damage.placeholder'),
    ['WEAPON_LASSO_REINFORCED'] = Lang:t('damage.placeholder'),
	['WEAPON_MELEE_KNIFE'] = Lang:t('damage.stab'),
	['WEAPON_MELEE_KNIFE_JAWBONE']  = Lang:t('damage.stab'),
	['WEAPON_MELEE_HAMMER'] = Lang:t('damage.placeholder'),
	['WEAPON_THROWN_DYNAMITE'] = Lang:t('damage.placeholder'),
	['WEAPON_THROWN_MOLOTOV'] = Lang:t('damage.placeholder'),
	['WEAPON_THROWN_THROWING_KNIVES'] = Lang:t('damage.stab'),
	['WEAPON_THROWN_TOMAHAWK'] = Lang:t('damage.stab'),
	['WEAPON_THROWN_TOMAHAWK_ANCIENT'] = Lang:t('damage.stab'),
	['WEAPON_THROWN_BOLAS'] = Lang:t('damage.placeholder'),
	['WEAPON_MELEE_CLEAVER'] = Lang:t('damage.placeholder'),
	['WEAPON_MELEE_LANTERN'] = Lang:t('damage.hburns'),
	['WEAPON_MELEE_DAVY_LANTERN'] = Lang:t('damage.hburns'),
	['WEAPON_MELEE_TORCH'] = Lang:t('damage.hburns'),
	['WEAPON_MELEE_HATCHET'] = Lang:t('damage.stab'),
	['WEAPON_MELEE_MACHETE'] = Lang:t('damage.stab'),
	['WEAPON_DROWNING'] = Lang:t('damage.drowned'),
	['WEAPON_DROWNING_IN_VEHICLE'] = Lang:t('damage.drowned'),
	['WEAPON_BLEEDING'] =  Lang:t('damage.blood'),
	['WEAPON_EXPLOSION'] = Lang:t('damage.burns'),
	['WEAPON_FALL'] = Lang:t('damage.bones'),
	['WEAPON_EXHAUSTION'] = Lang:t('damage.exhaustion'),
	['WEAPON_RAMMED_BY_CAR'] = Lang:t('damage.cart'),
	['WEAPON_RUN_OVER_BY_CAR'] = Lang:t('damage.veh'),
	['WEAPON_FIRE'] = Lang:t('damage.mburns'),
}

-- Functions
local function GetAvailableBed(bedId)
    local pos = GetEntityCoords(PlayerPedId())
    local retval = nil
    if bedId == nil then
        for k, v in pairs(Config.Locations['beds']) do
            if not Config.Locations['beds'][k].taken then
                if #(pos - vector3(Config.Locations['beds'][k].coords.x, Config.Locations['beds'][k].coords.y, Config.Locations['beds'][k].coords.z)) < 500 then
                        retval = k
                end
            end
        end
    else
        if not Config.Locations['beds'][bedId].taken then
            if #(pos - vector3(Config.Locations['beds'][bedId].coords.x, Config.Locations['beds'][bedId].coords.y, Config.Locations['beds'][bedId].coords.z))  < 500 then
                retval = bedId
            end
        end
    end
    return retval
end

local function GetDamagingWeapon(ped)
    for k, v in pairs(Config.Weapons) do
        if Citizen.InvokeNative(0xDCF06D0CDFF68424, ped, k, 0) then --HasPedBeenDamagedByWeapon(ped, k, 0)
            return v
        end
    end

    return nil
end

local function IsDamagingEvent(damageDone, weapon)
    local luck = math.random(100)
    local multi = damageDone / Config.HealthDamage

    return luck < (Config.HealthDamage * multi) or (damageDone >= Config.ForceInjury or multi > Config.MaxInjuryChanceMulti or Config.ForceInjuryWeapons[weapon])
end

local function DoLimbAlert()
    if not isDead and not InLaststand then
        if #injured > 0 then
            local limbDamageMsg = ''
            if #injured <= Config.AlertShowInfo then
                for k, v in pairs(injured) do
                    limbDamageMsg = limbDamageMsg..Lang:t('info.pain_message', {limb = v.label, severity = Config.WoundStates[v.severity]})
                    if k < #injured then
                        limbDamageMsg = limbDamageMsg .. " | "
                    end
                end
            else
                limbDamageMsg = Lang:t('info.many_places')
            end
            exports['qbr-core']:Notify(9, limbDamageMsg, 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
        end
    end
end

local function DoBleedAlert()
    if not isDead and tonumber(isBleeding) > 0 then
        exports['qbr-core']:Notify(9, Lang:t('info.bleed_alert', {bleedstate = Config.BleedingStates[tonumber(isBleeding)].label}), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end

local function ApplyBleed(level)
    if isBleeding ~= 4 then
        if isBleeding + level > 4 then
            isBleeding = 4
        else
            isBleeding = isBleeding + level
        end
        DoBleedAlert()
    end
end

local function SetClosestBed()
    local pos = GetEntityCoords(PlayerPedId(), true)
    local current = nil
    local dist = nil
    for k, v in pairs(Config.Locations['beds']) do
        local dist2 = #(pos - vector3(Config.Locations['beds'][k].coords.x, Config.Locations['beds'][k].coords.y, Config.Locations['beds'][k].coords.z))
        if current then
            if dist2 < dist then
                current = k
                dist = dist2
            end
        else
            dist = dist2
            current = k
        end
    end
    if current ~= closestBed and not isInHospitalBed then
        closestBed = current
    end
end

local function IsInjuryCausingLimp()
    for k, v in pairs(BodyParts) do
        if v.causeLimp and v.isDamaged then
            return true
        end
    end
    return false
end

local function ProcessRunStuff(ped, bone)
    if bone ~= nil then
        if IsInjuryCausingLimp() then
            if Config.Bones[bone] == "RLEG" then
                print("Injured RLEG Walkstyle")
                Citizen.InvokeNative(0x923583741DC87BCE, ped, 'default')
                Citizen.InvokeNative(0x89F5E7ADECCCB49C, ped, 'injured_right_leg')
            elseif Config.Bones[bone] == "LLEG" then
                print("Injured LLEG Walkstyle")
                Citizen.InvokeNative(0x923583741DC87BCE, ped, 'default')
                Citizen.InvokeNative(0x89F5E7ADECCCB49C, ped, 'injured_left_leg')
            elseif Config.Bones[bone] == "RARM" then
                print("Injured RARM Walkstyle")
                Citizen.InvokeNative(0x923583741DC87BCE, ped, 'default')
                Citizen.InvokeNative(0x89F5E7ADECCCB49C, ped, 'injured_right_arm')
            elseif Config.Bones[bone] == "LARM" then
                print("Injured LARM Walkstyle")
                Citizen.InvokeNative(0x923583741DC87BCE, ped, 'default')
                Citizen.InvokeNative(0x89F5E7ADECCCB49C, ped, 'injured_left_arm')
            else
                print("Injured Walkstyle")
                Citizen.InvokeNative(0x923583741DC87BCE, ped, 'default')
                Citizen.InvokeNative(0x89F5E7ADECCCB49C, ped, 'injured_general')
            end
        end
    else
        print("Normal Walkstyle")
        Citizen.InvokeNative(0x923583741DC87BCE, ped, walkHealthDict)
        Citizen.InvokeNative(0xAA74EC0CB0AAEA2C, ped, walkHealthAnim)
    end
end

function ResetPartial()
    for k, v in pairs(BodyParts) do
        if v.isDamaged and v.severity <= 2 then
            v.isDamaged = false
            v.severity = 0
        end
    end

    for k, v in pairs(injured) do
        if v.severity <= 2 then
            v.severity = 0
            table.remove(injured, k)
        end
    end

    if isBleeding <= 2 then
        isBleeding = 0
        bleedTickTimer = 0
        advanceBleedTimer = 0
        fadeOutTimer = 0
        blackoutTimer = 0
    end

    TriggerServerEvent('hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })

    ProcessRunStuff(PlayerPedId(), nil)
    DoLimbAlert()
    DoBleedAlert()

    TriggerServerEvent('hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })
end

local function ResetAll()
    isBleeding = 0
    bleedTickTimer = 0
    advanceBleedTimer = 0
    fadeOutTimer = 0
    blackoutTimer = 0
    onDrugs = 0
    wasOnDrugs = false
    onPainKiller = 0
    wasOnPainKillers = false
    injured = {}

    for k, v in pairs(BodyParts) do
        v.isDamaged = false
        v.severity = 0
    end

    TriggerServerEvent('hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })

    CurrentDamageList = {}
    TriggerServerEvent('hospital:server:SetWeaponDamage', CurrentDamageList)

    ProcessRunStuff(PlayerPedId(), nil)
    DoLimbAlert()
    DoBleedAlert()

    TriggerServerEvent('hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })
    TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", 100)
    TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", 100)
end

local function loadAnimDict(dict)
	while(not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Wait(1)
	end
end

local function SetBedCam()
    isInHospitalBed = true
    canLeaveBed = false
    local player = PlayerPedId()

    DoScreenFadeOut(1000)

    while not IsScreenFadedOut() do
        Wait(100)
    end

	if IsPedDeadOrDying(player) then
		local pos = GetEntityCoords(player, true)
		NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(player), true, false)
    end

    bedObject = GetClosestObjectOfType(bedOccupyingData.coords.x, bedOccupyingData.coords.y, bedOccupyingData.coords.z, 1.0, bedOccupyingData.model, false, false, false)
    FreezeEntityPosition(bedObject, true)

    SetEntityCoords(player, bedOccupyingData.coords.x, bedOccupyingData.coords.y, bedOccupyingData.coords.z + 0.07)
    SetEntityInvincible(PlayerPedId(), true)
    Wait(500)
    FreezeEntityPosition(player, true)

    loadAnimDict(inBedDict)

    TaskPlayAnim(player, inBedDict , inBedAnim, 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
    SetEntityHeading(player, bedOccupyingData.coords.w)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, player, 31085, 0, 1.0, 1.0 , true)
    SetCamFov(cam, 90.0)
    local heading = GetEntityHeading(player)
    heading = (heading > 180) and heading - 180 or heading + 180
    SetCamRot(cam, -45.0, 0.0, heading, 2)

    DoScreenFadeIn(1000)

    Wait(1000)
    FreezeEntityPosition(player, true)
end

local function LeaveBed()
    local player = PlayerPedId()

    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Wait(0)
    end

    FreezeEntityPosition(player, false)
    SetEntityInvincible(player, false)
    SetEntityHeading(player, bedOccupyingData.coords.w - 90)
    TaskPlayAnim(player, getOutDict , getOutAnim, 100.0, 1.0, -1, 8, -1, 0, 0, 0)
    Wait(4000)
    ClearPedTasks(player)
    TriggerServerEvent('hospital:server:LeaveBed', bedOccupying)
    FreezeEntityPosition(bedObject, true)
    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)

    bedOccupying = nil
    bedObject = nil
    bedOccupyingData = nil
    isInHospitalBed = false
end

local function DrawText3D(x, y, z, text)
	local onScreen,_x,_y=GetScreenCoordFromWorldCoord(x, y, z)

    SetTextScale(0.35, 0.35)
    SetTextFontForCurrentCommand(1)
    SetTextColor(255, 255, 255, 215)
    local str = CreateVarString(10, "LITERAL_STRING", text, Citizen.ResultAsLong())
    SetTextCentre(1)
    DisplayText(str,_x,_y)
end

local function IsInDamageList(damage)
    local retval = false
    if CurrentDamageList then
        for k, v in pairs(CurrentDamageList) do
            if CurrentDamageList[k] == damage then
                retval = true
            end
        end
    end
    return retval
end

local function CheckWeaponDamage(ped)
    local detected = false
    for k, v in pairs(WeaponDamageList) do
        if Citizen.InvokeNative(0xDCF06D0CDFF68424, ped, GetHashKey(k), 0) then --HasPedBeenDamagedByWeapon(
            detected = true
            if not IsInDamageList(k) then
                exports['qbr-core']:Notify(9, Lang:t('info.status')..': '..v, 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
                CurrentDamageList[#CurrentDamageList+1] = k
            end
        end
    end
    if detected then
        TriggerServerEvent("hospital:server:SetWeaponDamage", CurrentDamageList)
    end
    ClearEntityLastDamageEntity(ped)
end

local function ApplyImmediateEffects(ped, bone, weapon, damageDone)
    local armor = 0
    if Config.MinorInjurWeapons[weapon] and damageDone < Config.DamageMinorToMajor then
        if Config.CriticalAreas[Config.Bones[bone]] then
            if armor <= 0 then
                ApplyBleed(1)
            end
        end

        if Config.StaggerAreas[Config.Bones[bone]] and (Config.StaggerAreas[Config.Bones[bone]].armored or armor <= 0) then
            if math.random(100) <= math.ceil(Config.StaggerAreas[Config.Bones[bone]].minor) then
                SetPedToRagdoll(ped, 1500, 2000, 3, true, true, false)
            end
        end
    elseif Config.MajorInjurWeapons[weapon] or (Config.MinorInjurWeapons[weapon] and damageDone >= Config.DamageMinorToMajor) then
        if Config.CriticalAreas[Config.Bones[bone]] then
            if armor > 0 and Config.CriticalAreas[Config.Bones[bone]].armored then
                if math.random(100) <= math.ceil(Config.MajorArmoredBleedChance) then
                    ApplyBleed(1)
                end
            else
                ApplyBleed(1)
            end
        else
            if armor > 0 then
                if math.random(100) < (Config.MajorArmoredBleedChance) then
                    ApplyBleed(1)
                end
            else
                if math.random(100) < (Config.MajorArmoredBleedChance * 2) then
                    ApplyBleed(1)
                end
            end
        end

        if Config.StaggerAreas[Config.Bones[bone]] and (Config.StaggerAreas[Config.Bones[bone]].armored or armor <= 0) then
            if math.random(100) <= math.ceil(Config.StaggerAreas[Config.Bones[bone]].major) then
                SetPedToRagdoll(ped, 1500, 2000, 3, true, true, false)
            end
        end
    end
end

local function CheckDamage(ped, bone, weapon, damageDone)
    if weapon == nil then return end

    if Config.Bones[bone] and not isDead and not InLaststand then
        ApplyImmediateEffects(ped, bone, weapon, damageDone)

        if not BodyParts[Config.Bones[bone]].isDamaged then
            BodyParts[Config.Bones[bone]].isDamaged = true
            BodyParts[Config.Bones[bone]].severity = math.random(1, 3)
            injured[#injured+1] = {
                part = Config.Bones[bone],
                label = BodyParts[Config.Bones[bone]].label,
                severity = BodyParts[Config.Bones[bone]].severity
            }
        else
            if BodyParts[Config.Bones[bone]].severity < 4 then
                BodyParts[Config.Bones[bone]].severity = BodyParts[Config.Bones[bone]].severity + 1

                for k, v in pairs(injured) do
                    if v.part == Config.Bones[bone] then
                        v.severity = BodyParts[Config.Bones[bone]].severity
                    end
                end
            end
        end

        TriggerServerEvent('hospital:server:SyncInjuries', {
            limbs = BodyParts,
            isBleeding = tonumber(isBleeding)
        })

        ProcessRunStuff(ped, bone)
    end
end

local function ProcessDamage(ped)
    if not isDead and not InLaststand and not onPainKillers then
        for k, v in pairs(injured) do
            if (v.part == 'LLEG' and v.severity > 1) or (v.part == 'RLEG' and v.severity > 1) or (v.part == 'LFOOT' and v.severity > 2) or (v.part == 'RFOOT' and v.severity > 2) then
                if legCount >= Config.LegInjuryTimer then
                    if not IsPedRagdoll(ped) and IsPedOnFoot(ped) then
                        local chance = math.random(100)
                        if (IsPedRunning(ped) or IsPedSprinting(ped)) then
                            if chance <= Config.LegInjuryChance.Running then
                                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
                                SetPedToRagdollWithFall(ped, 1500, 2000, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
                            end
                        else
                            if chance <= Config.LegInjuryChance.Walking then
                                ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
                                SetPedToRagdollWithFall(ped, 1500, 2000, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
                            end
                        end
                    end
                    legCount = 0
                else
                    legCount = legCount + 1
                end
            elseif (v.part == 'LARM' and v.severity > 1) or (v.part == 'LHAND' and v.severity > 1) or (v.part == 'LFINGER' and v.severity > 2) or (v.part == 'RARM' and v.severity > 1) or (v.part == 'RHAND' and v.severity > 1) or (v.part == 'RFINGER' and v.severity > 2) then
                if armcount >= Config.ArmInjuryTimer then
                    local chance = math.random(100)

                    if (v.part == 'LARM' and v.severity > 1) or (v.part == 'LHAND' and v.severity > 1) or (v.part == 'LFINGER' and v.severity > 2) then
                        local isDisabled = 15
                        CreateThread(function()
                            while isDisabled > 0 do
                                if IsPedInAnyVehicle(ped, true) then
                                    DisableControlAction(0, 63, true) -- veh turn left
                                end

                                if IsPlayerFreeAiming(PlayerId()) then
                                    DisablePlayerFiring(PlayerId(), true) -- Disable weapon firing
                                end

                                isDisabled = isDisabled - 1
                                Wait(1)
                            end
                        end)
                    else
                        local isDisabled = 15
                        CreateThread(function()
                            while isDisabled > 0 do
                                if IsPedInAnyVehicle(ped, true) then
                                    DisableControlAction(0, 63, true) -- veh turn left
                                end

                                if IsPlayerFreeAiming(PlayerId()) then
                                    DisableControlAction(0, 25, true) -- Disable weapon firing
                                end

                                isDisabled = isDisabled - 1
                                Wait(1)
                            end
                        end)
                    end

                    armcount = 0
                else
                    armcount = armcount + 1
                end
            elseif (v.part == 'HEAD' and v.severity > 2) then
                if headCount >= Config.HeadInjuryTimer then
                    local chance = math.random(100)

                    if chance <= Config.HeadInjuryChance then
                        SetFlash(0, 0, 100, 10000, 100)

                        DoScreenFadeOut(100)
                        while not IsScreenFadedOut() do
                            Wait(0)
                        end

                        if not IsPedRagdoll(ped) and IsPedOnFoot(ped) and not IsPedSwimming(ped) then
                            ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.08) -- change this float to increase/decrease camera shake
                            SetPedToRagdoll(ped, 5000, 1, 2)
                        end

                        Wait(5000)
                        DoScreenFadeIn(250)
                    end
                    headCount = 0
                else
                    headCount = headCount + 1
                end
            end
        end
    end
end

-- Events
RegisterNetEvent('ambulance:client:promptCheckin', function()
    if doctorCount >= Config.MinimalDoctors then
        TriggerServerEvent("hospital:server:SendDoctorAlert")
    else
        exports['qbr-core']:Progressbar("hospital_checkin", Lang:t('progress.checking_in'), 2000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true,
        }, {}, {}, {}, function() -- Done
            local bedId = GetAvailableBed()
            if bedId then

                TriggerServerEvent("hospital:server:SendToBed", bedId, true)
            else
                exports['qbr-core']:Notify(9, Lang:t('error.beds_taken'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
            end
        end, function() -- Cancel
            exports['qbr-core']:Notify(9, Lang:t('error.canceled'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
        end)
    end
end)

RegisterNetEvent('ambulance:client:promptBed',function()
    if GetAvailableBed(closestBed) then
        TriggerServerEvent("hospital:server:SendToBed", closestBed, true)
    else
        exports['qbr-core']:Notify(9, Lang:t('error.beds_taken'), 5000, 0, 'mp_lobby_textures', 'cross', 'COLOR_WHITE')
    end
end)

RegisterNetEvent('hospital:client:ambulanceAlert', function(coords, text)
    exports['qbr-core']:Notify(9, text, "ambulance")
    local transG = 250
    local blipText = Lang:t('info.ems_alert', {text = text})
    local blip = N_0x554d9d53f696d002(1664425300, coords.x, coords.y, coords.z) --AddBlip
    SetBlipSprite(blip, 960467426, 1)
    SetBlipScale(blip, 0.2)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, text) --SetBlipName
    while transG ~= 0 do
        Wait(Config.DispatchTimer * 4)
        transG = transG - 1
        --Citizen.InvokeNative(0x45FF974EEE1C8734, blip, transG) --SetBlipAlpha
        if transG == 0 then
            RemoveBlip(blip)
            return
        end
    end
end)

RegisterNetEvent('hospital:client:Revive', function()
    local player = PlayerPedId()

    if isDead or InLaststand then
        local pos = GetEntityCoords(player, true)
        NetworkResurrectLocalPlayer(pos.x, pos.y, pos.z, GetEntityHeading(player), true, false)
        isDead = false
        SetEntityInvincible(player, false)
        SetLaststand(false)
    end

    if isInHospitalBed then
        loadAnimDict(inBedDict)
        TaskPlayAnim(player, inBedDict , inBedAnim, 8.0, 1.0, -1, 1, 0, 0, 0, 0 )
        SetEntityInvincible(player, true)
        canLeaveBed = true
    end

    TriggerServerEvent("hospital:server:RestoreWeaponDamage")
    SetEntityMaxHealth(player, 200)
    SetEntityHealth(player, GetEntityMaxHealth(player))
    ClearPedBloodDamage(player)
    ResetAll()
    TriggerServerEvent('hud:server:RelieveStress', 100)
    TriggerServerEvent("hospital:server:SetDeathStatus", false)
    TriggerServerEvent("hospital:server:SetLaststandStatus", false)
    emsNotified = false
    exports['qbr-core']:Notify(9, Lang:t('info.healthy'), 5000, 0, 'blips', 'blip_radius_search', 'COLOR_WHITE')
end)

RegisterNetEvent('hospital:client:SetPain', function()
    ApplyBleed(math.random(1,4))
    if not BodyParts[Config.Bones[14410]].isDamaged then
        BodyParts[Config.Bones[14410]].isDamaged = true
        BodyParts[Config.Bones[14410]].severity = math.random(1, 4)
        injured[#injured+1] = {
            part = Config.Bones[14410],
            label = BodyParts[Config.Bones[14410]].label,
            severity = BodyParts[Config.Bones[14410]].severity
        }
    end

    if not BodyParts[Config.Bones[54187]].isDamaged then
        BodyParts[Config.Bones[54187]].isDamaged = true
        BodyParts[Config.Bones[54187]].severity = math.random(1, 4)
        injured[#injured+1] = {
            part = Config.Bones[54187],
            label = BodyParts[Config.Bones[54187]].label,
            severity = BodyParts[Config.Bones[54187]].severity
        }
    end

    TriggerServerEvent('hospital:server:SyncInjuries', {
        limbs = BodyParts,
        isBleeding = tonumber(isBleeding)
    })
end)

RegisterNetEvent('hospital:client:KillPlayer', function()
    SetEntityHealth(PlayerPedId(), 0)
end)

RegisterNetEvent('hospital:client:HealInjuries', function(type)
    if type == "full" then
        ResetAll()
    else
        ResetPartial()
    end
    TriggerServerEvent("hospital:server:RestoreWeaponDamage")
    exports['qbr-core']:Notify(9, Lang:t('success.wounds_healed'), 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
end)

RegisterNetEvent('hospital:client:SendToBed', function(id, data, isRevive)
    bedOccupying = id
    bedOccupyingData = data
    SetBedCam()
    CreateThread(function ()
        Wait(5)
        if isRevive then
            exports['qbr-core']:Notify(9, Lang:t('success.being_helped'), 5000, 0, 'hud_textures', 'check', 'COLOR_WHITE')
            Wait(Config.AIHealTimer * 1000)
            TriggerEvent("hospital:client:Revive")
        else
            canLeaveBed = true
        end
    end)
end)

RegisterNetEvent('hospital:client:SetBed', function(id, isTaken)
    Config.Locations['beds'][id].taken = isTaken
end)

RegisterNetEvent('hospital:client:RespawnAtHospital', function()
    TriggerServerEvent("hospital:server:RespawnAtHospital", closestBed)
    if exports['qbr-policejob']:IsHandcuffed() then
        TriggerEvent("police:client:GetCuffed", -1)
    end
    TriggerEvent("police:client:DeEscort")
end)

RegisterNetEvent('hospital:client:SendBillEmail', function(amount)
    SetTimeout(math.random(2500, 4000), function()
        local gender = Lang:t('info.mr')
        if exports['qbr-core']:GetPlayerData().charinfo.gender == 1 then
            gender = Lang:t('info.mrs')
        end
        local charinfo = exports['qbr-core']:GetPlayerData().charinfo
        TriggerServerEvent('qb-phone:server:sendNewMail', {
            sender = Lang:t('mail.sender'),
            subject = Lang:t('mail.subject'),
            message = Lang:t('mail.message', {gender = gender, lastname = charinfo.lastname, costs = amount}),
            button = {}
        })
    end)
end)

RegisterNetEvent('hospital:client:SetDoctorCount', function(amount)
    doctorCount = amount
end)

RegisterNetEvent('hospital:client:adminHeal', function()
    local ped = PlayerPedId()
    SetEntityHealth(ped, 200)
    TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", 100)
    TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", 100)
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload', function()
    local ped = PlayerPedId()
    TriggerServerEvent("hospital:server:SetDeathStatus", false)
    TriggerServerEvent('hospital:server:SetLaststandStatus', false)
    TriggerServerEvent("hospital:server:SetArmor", GetPedArmour(ped))
    if bedOccupying then
        TriggerServerEvent("hospital:server:LeaveBed", bedOccupying)
    end
    isDead = false
    deathTime = 0
    SetEntityInvincible(ped, false)
    ResetAll()
end)

-- Threads
CreateThread(function()
    for k, v in pairs(Config.Locations['stations']) do
        local AmbulanceBlip = N_0x554d9d53f696d002(1664425300, v.coords)
        SetBlipSprite(AmbulanceBlip, 3599598875, 52)
        SetBlipScale(AmbulanceBlip, 0.2)
        Citizen.InvokeNative(0x9CB1A1623062F402, tonumber(AmbulanceBlip), v.label)
    end
end)

CreateThread(function()
    while true do
        sleep = 1000
        if isInHospitalBed and canLeaveBed then
            sleep = 0
            local pos = GetEntityCoords(PlayerPedId())
            DrawText3D(pos.x, pos.y, pos.z, Lang:t('text.bed_out'))
            if IsControlJustReleased(0, 0xCEFD9220) then
                LeaveBed()
            end
        end
        Wait(sleep)
    end
end)

CreateThread(function()
    while true do
        Wait((1000 * Config.MessageTimer))
        DoLimbAlert()
    end
end)

CreateThread(function()
    while true do
        Wait(1000)
        SetClosestBed()
        if isStatusChecking then
            statusCheckTime = statusCheckTime - 1
            if statusCheckTime <= 0 then
                statusChecks = {}
                isStatusChecking = false
            end
        end
    end
end)

-- Armor might be removed
CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local health = GetEntityHealth(ped)
        local armor = 0

        if not playerHealth then
            playerHealth = health
        end

        if not playerArmor then
            playerArmor = armor
        end

        local armorDamaged = (playerArmor ~= armor and armor < (playerArmor - Config.ArmorDamage) and armor > 0) -- Players armor was damaged
        local healthDamaged = (playerHealth ~= health) -- Players health was damaged

        local damageDone = (playerHealth - health)

        if armorDamaged or healthDamaged then
            local hit, bone = GetPedLastDamageBone(ped)
            local bodypart = Config.Bones[bone]
            local weapon = GetDamagingWeapon(ped)

            if hit and bodypart ~= 'NONE' then
                local checkDamage = true
                if damageDone >= Config.HealthDamage then
                    if weapon then
                        if armorDamaged and (bodypart == 'SPINE' or bodypart == 'UPPER_BODY') or weapon == Config.WeaponClasses['NOTHING'] then
                            checkDamage = false -- Don't check damage if the it was a body shot and the weapon class isn't that strong
                            if armorDamaged then
                                TriggerServerEvent("hospital:server:SetArmor", GetPedArmour(ped))
                            end
                        end

                        if checkDamage then
                            if IsDamagingEvent(damageDone, weapon) then
                                CheckDamage(ped, bone, weapon, damageDone)
                            end
                        end
                    end
                elseif Config.AlwaysBleedChanceWeapons[weapon] then
                    if armorDamaged and (bodypart == 'SPINE' or bodypart == 'UPPER_BODY') or weapon == Config.WeaponClasses['NOTHING'] then
                        checkDamage = false -- Don't check damage if the it was a body shot and the weapon class isn't that strong
                    end
                    if math.random(100) < Config.AlwaysBleedChance and checkDamage then
                        ApplyBleed(1)
                    end
                end
            end

            CheckWeaponDamage(ped)
        end

        playerHealth = health
        playerArmor = armor

        if not isInHospitalBed then
            ProcessDamage(ped)
        end
        Wait(100)
    end
end)
