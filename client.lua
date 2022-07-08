CreateThread(function()
    local bikes = {
        `bmx`
    }
    exports['bt-target']:AddTargetModel(bikes, {
        options = {
            {
                event = 'gl-miscstuff:getOnHandleBars',
                icon = "fas fa-tint",
                label = "Ride Handlebars",
            },       
            {
                event = 'gl-miscstuff:getOnBack',
                icon = "fas fa-tint",
                label = "Ride on Back",
            },                      
        },
        job = {"all"},
        distance = 2.5
    })

end)


local bike
local isRiding = false
RegisterNetEvent('gl-miscstuff:getOnHandleBars',function()
    local playerPed = PlayerPedId()
    local coordA = GetEntityCoords(playerPed, 1)
    local coordB = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
    bike = getVehicleInDirection(coordA, coordB)


    LoadAnimDict('timetable@ron@ig_5_p3')
    local boneIndex = GetEntityBoneIndexByName(bike,"chassis")
    if IsVehicleModel(bike,'bmx') then
        AttachEntityToEntity(PlayerPedId(),bike, boneIndex, 0.05, 1.028, 1.001, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
        TaskPlayAnim(playerPed, 'timetable@ron@ig_5_p3','ig_5_p3_base', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
        Wait(200)
        ridingBike()
    end
end)

RegisterNetEvent('gl-miscstuff:getOnBack',function()
    local playerPed = PlayerPedId()
    local coordA = GetEntityCoords(playerPed, 1)
    local coordB = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
    bike = getVehicleInDirection(coordA, coordB)
    LoadAnimDict('anim@amb@clubhouse@bar@drink@idle_a')
    local boneIndex = GetEntityBoneIndexByName(bike,"chassis")
    if IsVehicleModel(bike,'bmx') then
        AttachEntityToEntity(PlayerPedId(),bike, boneIndex, 0.0, -0.528, 1.001, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
        TaskPlayAnim(playerPed, 'anim@amb@clubhouse@bar@drink@idle_a','idle_a_bartender', 8.0, 8.0, -1, 1, 1, 0, 0, 0)
        Wait(200)
        ridingBike()
    end
end)


function ridingBike()
    isRiding = true
    CreateThread(function()
        while isRiding do
            Wait(0)
            if IsControlJustPressed(0, 38) then
                isRiding = false
                Wait(200)
                DetachEntity(PlayerPedId())
                ClearPedTasks(PlayerPedId())
                break
            end
        end
    end)
end

function getVehicleInDirection(coordFrom, coordTo)
    local rayHandle = CastRayPointToPoint(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, PlayerPedId(), 0)
    local a, b, c, d, vehicle = GetRaycastResult(rayHandle)
    return vehicle
end
[06:12]
function LoadAnimDict( dict )
    while ( not HasAnimDictLoaded( dict ) ) do
        RequestAnimDict( dict )
        Citizen.Wait( 5 )
    end
end
