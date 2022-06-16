-- funtions
function SET_PED_RELATIONSHIP_GROUP_HASH ( iVar0, iParam0 )
    return Citizen.InvokeNative( 0xC80A74AC829DDD92, iVar0, _GET_DEFAULT_RELATIONSHIP_GROUP_HASH( iParam0 ) )
end

function _GET_DEFAULT_RELATIONSHIP_GROUP_HASH ( iParam0 )
    return Citizen.InvokeNative( 0x3CC4A718C258BDD0 , iParam0 );
end

function modelrequest( model )
    Citizen.CreateThread(function()
        RequestModel( model )
    end)
end

-- load NPCs
Citizen.CreateThread(function()
    for z, x in pairs(Config.PetShopNpc) do
    while not HasModelLoaded( GetHashKey(Config.PetShopNpc[z]["Model"]) ) do
        Wait(500)
        modelrequest( GetHashKey(Config.PetShopNpc[z]["Model"]) )
    end
    local npc = CreatePed(GetHashKey(Config.PetShopNpc[z]["Model"]), Config.PetShopNpc[z]["Pos"].x, Config.PetShopNpc[z]["Pos"].y, Config.PetShopNpc[z]["Pos"].z, Config.PetShopNpc[z]["Heading"], false, false, 0, 0)
    while not DoesEntityExist(npc) do
        Wait(300)
    end
    Citizen.InvokeNative(0x283978A15512B2FE, npc, true)
    FreezeEntityPosition(npc, false)
    SetEntityInvincible(npc, true)
    TaskStandStill(npc, -1)
    Wait(100)
    SET_PED_RELATIONSHIP_GROUP_HASH(npc, GetHashKey(Config.PetShopNpc[z]["Model"]))
    SetEntityCanBeDamagedByRelationshipGroup(npc, false, `PLAYER`)
    SetEntityAsMissionEntity(npc, true, true)
    SetModelAsNoLongerNeeded(GetHashKey(Config.PetShopNpc[z]["Model"]))
    end
end)