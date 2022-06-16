------------------------------------------
--Name: K_DOGGO
--URI: https://github.com/kurdt94/k_doggo
--Description: A brief description
--Version: 1.0
--Author: kurdt94
--Author URI: https://github.com/kurdt94
--License: GNU General Public License v3.0
------------------------------------------
function newDoggo(model,name)

    object = {}
    object.spawned = false
    object.model = model
    object.pos = false
    object.id = false
    object.name = name
    object.state = false
    object.blip = false
    object.isSleeping = false
    object.following_range = 4.0
    object.wandering_range = 10.0
    object.smelling_range = 60.0
    object.player_range = 1.2
    object.counters = {resting=0,}
    object.huntingList = {}
    object.foundList = {}
    object.volume = Citizen.InvokeNative(0xB3FB80A32BAE3065, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, object.smelling_range, object.smelling_range, object.smelling_range)
    object.itemset = CreateItemset(1)

    --- INIT
    Citizen.CreateThread(function()
        while not object.spawned do
            Wait(100)
            print("loading pet : " .. object.model)
            local pedModel = GetHashKey(object.model)
            while not HasModelLoaded(pedModel) do
                modelrequest(pedModel)
                Wait(500)
            end
            local player = PlayerPedId()
            local offset = GetOffsetFromEntityInWorldCoords(player,0.0,5.0,0.0)
            local a, groundZ = GetGroundZAndNormalFor_3dCoord( offset.x, offset.y, offset.z + 10 )
            while not groundZ do
                Wait(100)
            end
            object.id = CreatePed(pedModel,offset.x,offset.y,groundZ,180.0,true,false)
            while not DoesEntityExist(object.id) do
                Wait(300)
            end
            Citizen.InvokeNative(0x283978A15512B2FE, object.id, true) --Mandatory
            SetPedAsGroupMember(object.id, GetPedGroupIndex(PlayerPedId()))
            SetPedPromptName(object.id, object.name) -- set promptname for ped
            SetBlockingOfNonTemporaryEvents(object.id,true) -- edit
            object.pos = GetEntityCoords(object.id)
            object.spawned = true
            -- blip
            if Config.enable_blip then Citizen.InvokeNative(0x23f74c2fda6e7c61, -1749618580, object.id) end
            -- follow
            --print("init followTask")
            object.followTask()
        end
    end)

    Citizen.CreateThread(function()
    while true do
        Wait(200)
        --print("main thread 100 tick")
        local playerpos = GetEntityCoords(PlayerPedId())
        object.pos = GetEntityCoords(object.id)
        local dist = Vdist(playerpos.x, playerpos.y, playerpos.z, object.pos.x,  object.pos.y, object.pos.z)

        Citizen.InvokeNative(0x541B8576615C33DE, object.volume, object.pos.x, object.pos.y, object.pos.z) -- SET_VOLUME_COORDS
        Wait(100)

        local pedsFound = Citizen.InvokeNative(0x886171A12F400B89, object.volume, object.itemset, 1)
        Wait(100)
        --DrawText3D(object.pos.x, object.pos.y, object.pos.z, tostring(pedsFound))

        if pedsFound then
            n = 0
            while n < pedsFound do
                local item = GetIndexedItemInItemset(n, object.itemset)
                if IsEntityDead(item) and Citizen.InvokeNative(0x93C8B64DEB84728C,item) == PlayerPedId() and not Citizen.InvokeNative(0xB980061DA992779D,item) and object.huntingList[item] ~= 'found' then
                    object.huntingList[item] = item
                    object.state = "hunting"
                end
                n = n + 1
            end
            --print("found :: ? :: ".. n)
            Citizen.InvokeNative(0x20A4BF0E09BEE146, object.itemset) -- _EMPTY_ITEM_SET? [SpanSer]
        end

        if dist <= object.player_range and object.state ~= "hunting" and object.state ~= "sleeping" and object.state ~= "resting" and Citizen.InvokeNative(0xAC29253EEF8F0180,player) then
            object.state = "resting"
            TaskStartScenarioInPlace(object.id, GetHashKey('WORLD_ANIMAL_DOG_SITTING'), -1, true, false, false, false)
            --print("resting state")
        end
    end
    end)

    Citizen.CreateThread(function()
    while true do
        Wait(1000)
        player = PlayerPedId()
        local dCoords = GetEntityCoords(object.id)
        local pCoords = GetEntityCoords(PlayerPedId())
        local dist = Vdist(dCoords.x,dCoords.y,dCoords.z,pCoords.x,pCoords.y,pCoords.z)

        if Citizen.InvokeNative(0xAC29253EEF8F0180,player) and object.state ~= "wandering" and object.state ~= "hunting" and object.state ~= "resting" and object.state ~= "sleeping" then
            --print("wander task from 1000tick")
            object.state = "wandering"
            object.isSleeping = false
            object.wanderTask()
        elseif object.state == "resting" and Citizen.InvokeNative(0xAC29253EEF8F0180,player) and object.state ~= "hunting" then
            --print("restingTask from 1000tick")
            object.isSleeping = false
            object.restingTask()
        elseif object.state == "hunting" then
            --print("huntingTask from 1000tick")
            object.isSleeping = false
            object.huntingTask()
        elseif object.state == "agro" then
            --print("not implemented!")
        elseif object.state == "playing" then
            --print("not implemented!")
        else
            if not Citizen.InvokeNative(0xAC29253EEF8F0180,player) and object.state ~= "following" and object.state ~= "hunting" then
                object.isSleeping = false
                object.followTask()
            end
        end
    end
    end)

    -- WORLD_ANIMAL_DOG_MARK_TERRITORY_A [[ 0,5 % ]]
    Citizen.CreateThread(function ()
        while true do
            Wait(1000)
            if object.state == "wandering" then
                local markx = math.random(1,10000)
                if markx > 9975 then
                    --print("DOG PISSING REACHED")
                    TaskStartScenarioInPlace(object.id, GetHashKey('WORLD_ANIMAL_DOG_MARK_TERRITORY_A'), 3000, true, false, false, false)
                    Wait(3000)
                    object.wanderTask()
                end
            end
        end
    end)

    function object:getVolume()
        return  object.volume
    end

    function object:delete()
        SetEntityAsMissionEntity(object.id, true, true)
        DeletePed(object.id)
    end

    function object:getPos()
        --print("getPos")
        return  GetEntityCoords(object.id)
    end

    function object:whistle()
        Citizen.InvokeNative(0xD6401A1B2F63BED6, PlayerPedId(), 869278708, 1971704925)
        object.state = "following"
        Citizen.InvokeNative(0x304AE42E357B8C7E, object.id, PlayerPedId(), 0.0,4.0,0.0, -1,-1, object.following_range,true,true,false,true,true)
    end

    function object:getModel()
        --print("getModel")
        return  object.model
    end

    function object:setName(name)
        --print("setName")
        object.name = name
        SetPedPromptName(object.id, object.name)
    end

    function object:setState(state)
        --print("setState")
        object.state = state
    end

    function object:followTask()
        --print("followTask called")
        object.state = "following"
        Citizen.InvokeNative(0x304AE42E357B8C7E, object.id, PlayerPedId(), 0.0,4.0,0.0, -1,-1, object.following_range,true,true,false,true,true)
    end

    function object:sleepingTask()
        --print("sleepingTask called")
        if not object.isSleeping then
            object.isSleeping = true
            TaskStartScenarioInPlace(object.id, GetHashKey('WORLD_ANIMAL_DOG_SLEEPING'), -1, true, false, false, false)
        end
    end

    function object:wanderTask()
        --print("wanderTask called")
        local player = PlayerPedId()
        local coords = GetEntityCoords(player)
        Citizen.InvokeNative(0xE054346CA3A0F315, object.id, coords.x, coords.y, coords.z, object.wandering_range, tonumber(1077936128), tonumber(1086324736), 1)
        Wait(4000)
        object.counters.resting = 0
    end

    function object:restingTask()
        --print("restingTask called")
        object.counters.resting = object.counters.resting + 1
        if object.counters.resting >= 94 then
            if math.random(1,100) > 40 then
                -- dog sleeping . or dog wandering
                object.wanderTask()
                Wait(4000)
                object.state = "wandering"

                return
            else
                -- dog sleeping . or dog wandering
                object.sleepingTask()
                Wait(4000)
                object.state = "sleeping"

                return
            end
        end
        if IsPedUsingAnyScenario(object.id) then
                --print("pedInScenario called")
            return
        else
            TaskStartScenarioInPlace(object.id, GetHashKey('WORLD_ANIMAL_DOG_SITTING'), -1, true, false, false, false)
        end
    end

    function object:huntingTask()
        --print("huntingTask called")
        local target = 1000
        local closest = false
        if tablelength(object.huntingList) > 0 then
            for k,v in pairs(object.huntingList) do

                local eCoords = GetEntityCoords(k)
                local pCoords = GetEntityCoords(PlayerPedId())
                local dist = Vdist(eCoords.x,eCoords.y,eCoords.z,pCoords.x,pCoords.y,pCoords.z)
                if dist < target then
                    target = dist
                    closest = k
                end

            end
        end

        if closest then
            local arrived = false
            Citizen.CreateThread(function ()
                while not arrived and object.huntingList[closest] ~= 'found' do
                    Wait(10)
                    local cCoords = GetEntityCoords(closest)
                    local dCoords = object.pos
                    local dDist = Vdist(cCoords.x,cCoords.y,cCoords.z,dCoords.x,dCoords.y,dCoords.z)
                    local barktime = 7000
                    if dDist < 3 then
                        arrived = true
                        --print("here we are. barking !")
                        TaskStartScenarioInPlace(object.id, GetHashKey('WORLD_ANIMAL_DOG_BARKING_UP'),barktime, true, false, false, false)
                        Wait(barktime)
                        object.huntingList[closest] = 'found'
                        object.followTask()
                    end
                --print("not arrived ...")
                end
            end)

            if IsEntityDead(closest) and not arrived and object.huntingList[closest] ~= 'found' then
                --print("sending dog to target")
                Citizen.InvokeNative(0x6A071245EB0D1882, object.id, closest, -1, 2.4, 2.0, 0, 0) --TASK_GO_TO_ENTITY
            end
        end
    end

    -- Debug Thread
    Citizen.CreateThread(function()
        while Config.enable_debugger do
            Wait(1)

            DrawText(0.5,0.02,"Ped spawned: "..tostring(object.spawned))
            DrawText(0.5,0.04,"Ped model: "..tostring(object.model))
            DrawText(0.5,0.06,"Ped pos: "..tostring(object.pos))
            DrawText(0.5,0.08,"Ped id: "..tostring(object.id))
            DrawText(0.5,0.10,"Ped name: "..tostring(object.name))
            DrawText(0.5,0.12,"Ped state: "..tostring(object.state))
            DrawText(0.5,0.14,"Ped blip: "..tostring(object.blip))
            DrawText(0.5,0.16,"Ped following_range: "..tostring(object.following_range))
            DrawText(0.5,0.18,"Ped wandering_range: "..tostring(object.wandering_range))
            DrawText(0.5,0.20,"Ped smelling_range: "..tostring(object.smelling_range))
            DrawText(0.5,0.22,"Ped player_range: "..tostring(object.player_range))
            DrawText(0.5,0.24,"Ped counters.resting: "..tostring(object.counters.resting))
            DrawText(0.5,0.26,"Ped volume: "..tostring(object.volume))
            DrawText(0.5,0.28,"Ped huntingList: "..tostring(tablelength(object.huntingList)))
            DrawText(0.5,0.30,"Ped itemset: "..tostring(object.itemset))

            local txtpos = 0.32
            for k,v in pairs(object.huntingList) do
                txtpos = txtpos + 0.02
                DrawText(0.5,txtpos,"Ped key=".. k .." "..tostring(v))
            end

        end
    end)

    return object

end