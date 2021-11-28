

local craftActive = false
local progress1Active = false
local progress2Active = false
local progress3Active = false
local progress4Active = false
local progress5Active = false
local progress6Active = false
local progress7Active = false
local carryingProgress1Obj = false
local carryingProgress2Obj = false
local carryingProgress3Obj = false
local carryingProgress4Obj = false
local carryingProgress5Obj = false
local carryingProgress6Obj = false
local carryingProgress7Obj = false
local vehNameInProgress = nil
local veh = nil
local newProp = nil


local cars = {}


local playerdata = nil
local peds = {}


local car_spawns = {
    loc1 = vector4(-1605.8934326171875, 3094.365478515625, 31.56584548950195, 6.95276260375976),
    loc2 = vector4(-1601.3880615234375, 3094.423583984375, 31.56612396240234, 5.76158237457275),
    loc3 = vector4(-1596.9833984375, 3094.110595703125, 31.56612396240234, 19.12541389465332),
    loc4 = vector4(-1594.9599609375, 3088.1513671875, 31.56612396240234, 277.6378173828125),
    loc5 = vector4(-1593.51708984375, 3083.845458984375, 32.56612396240234, 263.13226318359375),
    loc6 = vector4(-1607.800048828125, 3083.080078125, 32.56612396240234, 183.6856231689453),
}


local ped_spawns = {
    car_ped = vector4(-1600.61767578125, 3083.916748046875, 31.56610107421875, 46.54573440551758),
    obj_ped = vector4(-1605.953125, 3100.30322265625, 31.56583404541015, 194.07135009765625)
}

QBCore = nil
Citizen.CreateThread(function()
    while true do
    Citizen.Wait(1)
         if QBCore == nil then
            TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)
            Citizen.Wait(200)
            playerdata = QBCore.Functions.GetPlayerData()
        end
    end
end)


RegisterNetEvent('lucid-craftcar:requestCars')
AddEventHandler('lucid-craftcar:requestCars', function(configcars)
    cars = configcars
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    playerdata = QBCore.Functions.GetPlayerData()
    createPed()
end)




function createPed()
    local hash =  GetHashKey("hc_driver")
    while not HasModelLoaded(hash) do
        RequestModel(hash)
        Citizen.Wait(1) 
    end
    for k,v in pairs(ped_spawns) do
        peds[k] = CreatePed(4, hash, v, false, true)
        FreezeEntityPosition(peds[k], true)
        SetEntityInvincible(peds[k], true)
        SetBlockingOfNonTemporaryEvents(peds[k], true)
    end
    SetModelAsNoLongerNeeded(hash)
end



Citizen.CreateThread(function()
    Citizen.Wait(1000)
    playerdata = QBCore.Functions.GetPlayerData()
    createPed()
     while true do
        Citizen.Wait(0)
        local dist = #(vector3(ped_spawns.car_ped.x, ped_spawns.car_ped.y, ped_spawns.car_ped.z ) - GetEntityCoords(PlayerPedId(), true))
        if dist < 3.0 then

            local text = ""

            if playerdata.metadata['carcraftprogress']['progress'] > 0 then
          
                if not craftActive then
                    QBCore.Functions.DrawText3D(ped_spawns.car_ped.x, ped_spawns.car_ped.y, ped_spawns.car_ped.z+2.0,'E continue to make car')
                    text = "K Reset Car 0"
                else
                    text = "E Reset Car 0"     
                end
            else
                if  not craftActive then
                    text = "Craft Car"     
                else
                    text = "E Reset Car 0"     
                end

            end
            QBCore.Functions.DrawText3D(ped_spawns.car_ped.x, ped_spawns.car_ped.y, ped_spawns.car_ped.z + 1.0,text)

            if IsControlJustPressed(0, 38) then
   

                if playerdata.metadata['carcraftprogress']['progress'] > 0 then
                    if not craftActive then
                        TriggerEvent('lucid:craft-car:continueCraftCar')
                    else
                        TriggerEvent('lucid:craft-car:resetCraftCar')
                        Citizen.Wait(750)

                    end
                else
                    if not craftActive then
                        TriggerEvent('lucid:craft-car:openmenu')
                    else
                        
                        TriggerEvent('lucid:craft-car:resetCraftCar')
                        Citizen.Wait(750)


                    end
                end
            end

            if IsControlJustPressed(0, 311) then

                if playerdata.metadata['carcraftprogress']['progress'] > 0 then
                    if not craftActive then
                        TriggerEvent('lucid:craft-car:resetCraftCar')
                        Citizen.Wait(750)
                    end
                end   
            end
        end
    end
end)



RegisterNetEvent('lucid:craft-object:openmenu')
AddEventHandler('lucid:craft-object:openmenu', function()
    local elements = {}
    if progress1Active and newProp == nil then
        table.insert(elements, { label="Craft Door [2 metalscrap - 2 Iron]", prop = "prop_car_door_01",  bone= 57005 , xpos = 0.4, ypos = 0.0, zpos = 0.0, 
        progress=1,xrot = 0, yrot = 270, zrot = 60,dict="anim@heists@narcotics@trash", anim="walk", requiredItems = { 
            ["metalscrap"] = {
                label = "Metal Scrap",
                reqAmount = 2,
            },
            ["iron"] = {
                label = "Iron",
                reqAmount = 2,
            }, 
         }})
    elseif progress2Active and newProp == nil then
        table.insert(elements, { label="Craft Door [2 metalscrap - 2 Iron]", prop = "prop_car_door_01",  bone= 57005 , xpos = 0.4, ypos = 0.0, zpos = 0.0, 
        progress=2,xrot = 0, yrot = 270, zrot = 60,dict="anim@heists@narcotics@trash", anim="walk", requiredItems = { 
            ["metalscrap"] = {
                label = "Metal Scrap",
                reqAmount = 2,
            },
            ["iron"] = {
                label = "Iron",
                reqAmount = 2,
            },  
         }})
    elseif progress3Active and newProp == nil then
        table.insert(elements, { label="Craft Door [2 metalscrap - 2 Iron]", prop = "prop_car_door_01",  bone= 57005 , xpos = 0.4, ypos = 0.0, zpos = 0.0, 
        progress=3,xrot = 0, yrot = 270, zrot = 60,dict="anim@heists@narcotics@trash", anim="walk", requiredItems = { 
            ["metalscrap"] = {
                label = "Metal Scrap",
                reqAmount = 2,
            },
            ["iron"] = {
                label = "Iron",
                reqAmount = 2,
            }, 
         }}) 
    elseif progress4Active and newProp == nil then
        table.insert(elements, { label="Craft Door [2 metalscrap - 2 Iron]", prop = "prop_car_door_01",  bone= 57005 , xpos = 0.4, ypos = 0.0, zpos = 0.0, 
        progress=4,xrot = 0, yrot = 270, zrot = 60,dict="anim@heists@narcotics@trash", anim="walk", requiredItems = { 
         ["metalscrap"] = {
                label = "Metal Scrap",
                reqAmount = 2,
            },
            ["iron"] = {
                label = "Iron",
                reqAmount = 2,
            }, 
         }})     
    elseif progress5Active and newProp == nil then
        table.insert(elements, {label="Craft Engine and boot [2 Silver - 2 Steel]", prop = "prop_cs_cardbox_01",  bone=28422, xpos = 0.0, ypos = -0.03, zpos = 0.0, 
        progress= 5, xrot = 5.0, yrot = 0.0, zrot = 0.0, dict="anim@heists@box_carry@", anim="idle", requiredItems = { 
            ["silver"] = {
                label = "Silver",
                reqAmount = 2,
            },
            ["steel"] = {
                label = "Steel",
                reqAmount = 2,
            }, 
         }}) 
    elseif progress6Active and newProp == nil then
        table.insert(elements, { label="Craft Trunk [2 Silver - 2 Steel]", prop = "prop_cs_cardbox_01",  bone=28422, xpos = 0.0, ypos = -0.03, zpos = 0.0, 
        progress=6,xrot = 5.0, yrot = 0.0, zrot = 0.0,dict="anim@heists@box_carry@", anim="idle", requiredItems = { 
        ["silver"] = {
                label = "Silver",
                reqAmount = 2,
            },
            ["steel"] = {
                label = "Steel",
                reqAmount = 2,
            }, 
         }})                                                  
    end
    if craftActive then
       QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'arac_parca', {
           title    = 'Car Materials',
           align    = 'left',
           elements = elements
       }, function(data, menu)
           TriggerServerEvent('lucid-craftCar:craftCarObject', data.current.prop,data.current.bone,data.current.xpos,data.current.ypos,data.current.zpos,data.current.xrot,data.current.yrot,data.current.zrot,data.current.dict, data.current.anim, data.current.progress,data.current.requiredItems)
           menu.close()
       end, function(data, menu)
           menu.close()
       end)
   end

end)

RegisterNetEvent('lucid-craftCar-client:craftCarObject')
AddEventHandler('lucid-craftCar-client:craftCarObject', function(prop, bone, xpos, ypos, zpos, xrot,yrot,zrot,dict, anim, progress)
     if progress == 1 then
        carryingProgress1Obj = true
    elseif progress == 2 then
        carryingProgress2Obj = true
    elseif progress == 3 then
        carryingProgress3Obj = true     
    elseif progress == 4 then
        carryingProgress4Obj = true 
    elseif progress == 5 then
        carryingProgress5Obj = true  
    elseif progress == 6 then
        carryingProgress6Obj = true                                        
    end
    createObject(prop, bone, xpos, ypos, zpos, xrot,yrot,zrot,dict, anim)
end)
    



RegisterNetEvent('lucid:craft-car:openmenu')
AddEventHandler('lucid:craft-car:openmenu', function()
    QBCore.UI.Menu.CloseAll()
    playerdata = QBCore.Functions.GetPlayerData()

    QBCore.Functions.TriggerCallback("lucid:getplayerscarblueprints", function(plyItems)
        local elements = {}
        local found = false
        for k,v in pairs(cars) do
            for _,item in pairs(plyItems) do
                if v.reqItem[1] == item.name then
                    table.insert(elements, {label ='craft '..v.label.. " ", value = k, item = v.reqItem[1]})
                    found = true
                end
            end
        end

        if not found then
           table.insert(elements, {label ="You don't have blueprint to craft car"})
        end
           
        QBCore.UI.Menu.Open('default', GetCurrentResourceName(), 'craft_car', {
                    title    = 'Craft Car',
                    align    = 'left',
                    elements = elements
            }, function(data, menu)
                if data.current.value then
                    TriggerEvent('lucid:setup-carcraft', data.current.value)
                    TriggerServerEvent('lucid-carcraft:removeItem', data.current.item)
                end
                menu.close()
        end, function(data, menu)
            menu.close()
        end)
    end)
end)

RegisterNetEvent('lucid:craft-car:continueCraftCar')
AddEventHandler('lucid:craft-car:continueCraftCar', function()
    
    local progress = playerdata.metadata['carcraftprogress']['progress'] 
    local vehName = playerdata.metadata['carcraftprogress']['veh'] 
    vehNameInProgress = vehName
    if progress == 1 then
        TriggerEvent('lucid:setup-carcraft', vehName)
    elseif progress == 2 then
        setUpVehicleProgress(2)
    elseif progress == 3 then
        setUpVehicleProgress(3)
    elseif progress == 4 then
        setUpVehicleProgress(4)
    elseif progress == 5 then
        setUpVehicleProgress(5)
    elseif progress == 6 then
        setUpVehicleProgress(6)
    elseif progress == 7 then
        setUpVehicleProgress(7)
    end
end)

RegisterNetEvent('lucid:craft-car:resetCraftCar')
AddEventHandler('lucid:craft-car:resetCraftCar', function()
    craftActive = false

    TriggerServerEvent('QBCore:Server:SetMetaData', "carcraftprogress", {progress = 0, veh = nil})
    if(veh ~= nil) then
        DeleteEntity(veh)
    end
    Citizen.Wait(300)
    playerdata = QBCore.Functions.GetPlayerData()
     
end)



RegisterNetEvent('lucid:setup-carcraft')
AddEventHandler('lucid:setup-carcraft', function(car)
    local hash = GetHashKey(car)
    vehNameInProgress = car
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(500)
    end

    local canSpawn = false
    for k,v in pairs(car_spawns) do
        if QBCore.Functions.IsSpawnPointClear(v, 2.5) then
            veh = CreateVehicle(hash, v, false, false)
            canSpawn = true
            break;
        end
    end


    if canSpawn then
        FreezeEntityPosition(veh, true)
        SetVehicleUndriveable(veh, true)
        local i = 0
        craftActive = true
        progress1Active = true
        -- 5 Bagaj
        -- 4 Kaput
        for i=0, 5 do 
            SetVehicleDoorBroken(veh, i, true) 
        end

        TriggerServerEvent('QBCore:Server:SetMetaData', "carcraftprogress", {progress = 1, veh = vehNameInProgress})
        Citizen.Wait(300)


        playerdata = QBCore.Functions.GetPlayerData()
    else
        QBCore.Functions.Notify("All the spawn locations are occopied", "error", 3000)
    end
    
end)

function setUpVehicleProgress(progress)
    local hash = GetHashKey(vehNameInProgress)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Citizen.Wait(500)
    end

    local canSpawn = false
    for k,v in pairs(car_spawns) do
        if QBCore.Functions.IsSpawnPointClear(v, 2.5) then
            veh = CreateVehicle(hash, v, false, false)
            canSpawn = true
            break;
        end
    end

    if canSpawn then

        if progress == 2 then
            SetVehicleDoorBroken(veh, 1, true) 
            SetVehicleDoorBroken(veh, 2, true) 
            SetVehicleDoorBroken(veh, 3, true) 
            SetVehicleDoorBroken(veh, 4, true) 
            SetVehicleDoorBroken(veh, 5, true) 
            progress1Active = false
            carryingProgress1Obj = false
            progress2Active = true   
            craftActive = true
        elseif progress == 3 then
            SetVehicleDoorBroken(veh, 2, true) 
            SetVehicleDoorBroken(veh, 3, true) 
            SetVehicleDoorBroken(veh, 4, true) 
            SetVehicleDoorBroken(veh, 5, true) 
            progress2Active = false
            carryingProgress2Obj = false
            progress3Active = true
            craftActive = true
        elseif progress == 4 then
            SetVehicleDoorBroken(veh, 3, true) 
            SetVehicleDoorBroken(veh, 4, true) 
            SetVehicleDoorBroken(veh, 5, true)
            progress3Active = false
            carryingProgress3Obj = false
            progress4Active = true 
            craftActive = true
        elseif progress == 5 then
            SetVehicleDoorBroken(veh, 4, true) 
            SetVehicleDoorBroken(veh, 5, true) 
            progress4Active = false
            carryingProgress4Obj = false
            progress5Active = true             
            craftActive = true
        elseif progress == 6 then
            progress5Active = false
            carryingProgress5Obj = false
            progress6Active = true    
            SetVehicleDoorBroken(veh, 5, true)  
            craftActive = true

        elseif progress == 7 then
            progress6Active = false
            carryingProgress6Obj = false
            progress7Active = true  
            craftActive = true
        end
    else
        QBCore.Functions.Notify("All the spawn locations are occopied", "error", 3000)
    end
end

function GetVehDoor(veh)
    return GetNumberOfVehicleDoors(veh)
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if craftActive then
            if progress1Active then
                if DoesEntityExist(veh) and IsEntityAVehicle(veh) then
                    local leftFrontDoor = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "seat_dside_f"))
                    local playerpos = GetEntityCoords(PlayerPedId(), 1)
                    local distanceToLeftFrontDoor = GetDistanceBetweenCoords(leftFrontDoor, playerpos, 1)
                    if distanceToLeftFrontDoor < 1.2 then
                        QBCore.Functions.DrawText3D(leftFrontDoor.x, leftFrontDoor.y, leftFrontDoor.z, "Attach The Left Front Door [E]")
        
                            if IsControlJustPressed(0, 38) then
                             if carryingProgress1Obj then
                                progressOne()
                             else
                                QBCore.Functions.Notify("You're not holding a door.", "error")
                            end
                        end
                    end
                end
            elseif progress2Active then
                if DoesEntityExist(veh) and IsEntityAVehicle(veh) then
                    local rightFrontDoor = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "seat_pside_f"))
                    local playerpos = GetEntityCoords(GetPlayerPed(-1), 1)
                    local distanceToRightFrontDoor = GetDistanceBetweenCoords(rightFrontDoor, playerpos, 1)
                    if distanceToRightFrontDoor < 1.55 then
                        QBCore.Functions.DrawText3D(rightFrontDoor.x, rightFrontDoor.y, rightFrontDoor.z,"E - Attach The Right Front Door")
                        if IsControlJustPressed(0, 38) then
                            if carryingProgress2Obj then
                                progressTwo()
                            else
                                QBCore.Functions.Notify("You're not holding a door.", "error")
                            end
                        end
                    end
                end
            elseif progress3Active then
                if DoesEntityExist(veh) and IsEntityAVehicle(veh) then
                    local leftBackDoor = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "door_dside_r"))
                    local playerpos = GetEntityCoords(GetPlayerPed(-1), 1)
                    local distanceToLeftBackDoor = GetDistanceBetweenCoords(leftBackDoor, playerpos, 1)
                    if distanceToLeftBackDoor < 1.55 then
                        QBCore.Functions.DrawText3D(leftBackDoor.x, leftBackDoor.y, leftBackDoor.z,"E - Attach The Back Left Door")
                        
                        if IsControlJustPressed(0, 38) then
                            if carryingProgress3Obj then
                                progressThree()
                            else
                                QBCore.Functions.Notify("You're not holding a door.", "error")
                            end
                        end
                    end
                end
            elseif progress4Active then
                if DoesEntityExist(veh) and IsEntityAVehicle(veh) then
                    local rightBackDoor = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "window_rr"))
                    local playerpos = GetEntityCoords(GetPlayerPed(-1), 1)
                    local distanceToRightBackDoor = GetDistanceBetweenCoords(rightBackDoor, playerpos, 1)
                    if distanceToRightBackDoor < 1.55 then
                        QBCore.Functions.DrawText3D(rightBackDoor.x, rightBackDoor.y, rightBackDoor.z,"E - Attach The Back Right Door")
                        if IsControlJustPressed(0, 38) then
                            if carryingProgress4Obj then
                                progressFour()
                            else
                                QBCore.Functions.Notify("You're not holding a door.", "error")
                            end
                        end
                    end
                end
            elseif progress5Active then
                if DoesEntityExist(veh) and IsEntityAVehicle(veh) then
                    local hoodPos = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "bonnet"))
                    local playerpos = GetEntityCoords(GetPlayerPed(-1), 1)
                    local distanceToHood = GetDistanceBetweenCoords(hoodPos, playerpos, 1)
                    if distanceToHood < 2.9 then
                        QBCore.Functions.DrawText3D(hoodPos.x, hoodPos.y, hoodPos.z - 0.3,"E - Attach The Boot")
                            if IsControlJustPressed(0, 38) then
                                if carryingProgress5Obj then
                                    progressFive()
                                else
                                    QBCore.Functions.Notify("You're not holding a boot.", "error")
                            end
                        end
                    end
                end
            elseif progress6Active then
                if DoesEntityExist(veh) and IsEntityAVehicle(veh) then
                    local trunkPos = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "boot"))
                    local playerpos = GetEntityCoords(GetPlayerPed(-1), 1)
                    local distanceToTrunk = GetDistanceBetweenCoords(trunkPos, playerpos, 1)
                    if distanceToTrunk < 2.9 then
                        QBCore.Functions.DrawText3D(trunkPos.x, trunkPos.y, trunkPos.z - 0.3,"E - Attach The Trunk")
                        if IsControlJustPressed(0, 38) then
                            if carryingProgress6Obj then
                                progressSix()
                            else
                                QBCore.Functions.Notify("You're not holding a trunk.", "error")
                            end
                        end
                    end
                end  
            elseif progress7Active then   
                if DoesEntityExist(veh) and IsEntityAVehicle(veh) then
                    local dist = #(GetEntityCoords(PlayerPedId(), true) - GetEntityCoords(veh, false))
                    local vehPos = GetWorldPositionOfEntityBone(veh, GetEntityBoneIndexByName(veh, "boot"))
                    if dist < 4.0 then
                         QBCore.Functions.DrawText3D(vehPos.x, vehPos.y, vehPos.z, "E - Complete the car craft")
                         if IsControlJustPressed(0, 38) then
                            local vehicleProps = {}
                            vehicleProps.plate = GeneratePlate()
                            QBCore.Functions.SetVehicleProperties(veh, vehicleProps)
                            TriggerServerEvent('lucid:insertVehToData',  QBCore.Functions.GetVehicleProperties(veh))
                            QBCore.Functions.Notify("You completed the car craft.", "primary", 3000)
                            FreezeEntityPosition(veh, false)
                            SetVehicleUndriveable(veh, false)
                            craftActive = false
                            TriggerServerEvent('QBCore:Server:SetMetaData', "carcraftprogress", {progress = 0, veh = nil})
                            progress7Active = false
                            Citizen.Wait(1000)
                            playerdata = QBCore.Functions.GetPlayerData()
                        end
                    end
                end                      
            end
        end
    end
end)


function progressOne()
    DeleteEntity(newProp)
    newProp = nil
    ClearPedTasks(PlayerPedId())
    QBCore.Functions.Progressbar("l_attach_door", "Attaching door..", math.random(2000, 5000), false, true, {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
      }, {
          task = "WORLD_HUMAN_WELDING"
      }, {}, {}, function() -- Done
        ClearPedTasksImmediately(PlayerPedId())    
        SetVehicleFixed(veh)
        SetVehicleDoorBroken(veh, 1, true) 
        SetVehicleDoorBroken(veh, 2, true) 
        SetVehicleDoorBroken(veh, 3, true) 
        SetVehicleDoorBroken(veh, 4, true) 
        SetVehicleDoorBroken(veh, 5, true) 
        TriggerServerEvent('QBCore:Server:SetMetaData', "carcraftprogress", {progress = 2, veh = vehNameInProgress})
        progress1Active = false
        carryingProgress1Obj = false
        progress2Active = true
        Citizen.Wait(1000)
        playerdata = QBCore.Functions.GetPlayerData()
      end, function() -- Cancel
          QBCore.Functions.Notify("Failure!", "error")
          ClearPedTasks(PlayerPedId())

      end) 
end




function progressTwo()
    DeleteEntity(newProp)
    newProp = nil
    ClearPedTasks(PlayerPedId())
    QBCore.Functions.Progressbar("l_attach_door2", "Attaching door..", math.random(2000, 5000), false, true, {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
      }, {
          task = "WORLD_HUMAN_WELDING"
      }, {}, {}, function() -- Done
   
        ClearPedTasksImmediately(PlayerPedId())
        SetVehicleFixed(veh)
        SetVehicleDoorBroken(veh, 2, true) 
        SetVehicleDoorBroken(veh, 3, true) 
        SetVehicleDoorBroken(veh, 4, true) 
        SetVehicleDoorBroken(veh, 5, true) 
        TriggerServerEvent('QBCore:Server:SetMetaData', "carcraftprogress", {progress = 3, veh = vehNameInProgress})

        if GetVehDoor(veh) == 6 then
            progress2Active = false
            carryingProgress2Obj = false
            progress3Active = true
        elseif GetVehDoor(veh) == 4 then
            progress2Active = false
            carryingProgress2Obj = false
            progress5Active = true
        elseif GetVehDoor(veh) == 3 then 
            progress2Active = false
            carryingProgress2Obj = false
            progress5Active = true             
        end
        Citizen.Wait(1000)
        playerdata = QBCore.Functions.GetPlayerData()
      end, function() -- Cancel
          QBCore.Functions.Notify("Failure!", "error")
          ClearPedTasks(PlayerPedId())
      end) 
end

function progressThree()
 DeleteEntity(newProp)
    newProp = nil
    ClearPedTasks(PlayerPedId())
    QBCore.Functions.Progressbar("l_attach_door3", "Attaching door..", math.random(2000, 5000), false, true, {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
      }, {
          task = "WORLD_HUMAN_WELDING"
      }, {}, {}, function() -- Done
        ClearPedTasksImmediately(PlayerPedId())
        SetVehicleFixed(veh)
        SetVehicleDoorBroken(veh, 3, true) 
        SetVehicleDoorBroken(veh, 4, true) 
        SetVehicleDoorBroken(veh, 5, true) 
        TriggerServerEvent('QBCore:Server:SetMetaData', "carcraftprogress", {progress = 4, veh = vehNameInProgress})
        progress3Active = false
        carryingProgress3Obj = false
        progress4Active = true
        Citizen.Wait(1000)
        playerdata = QBCore.Functions.GetPlayerData()
      end, function() -- Cancel
          QBCore.Functions.Notify("Failure!", "error")
          ClearPedTasks(PlayerPedId())
      end) 
end

function progressFour()
    DeleteEntity(newProp)
    newProp = nil
    ClearPedTasks(PlayerPedId())
    QBCore.Functions.Progressbar("l_attach_door4", "Attaching door..", math.random(2000, 5000), false, true, {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
      }, {
          task = "WORLD_HUMAN_WELDING"
      }, {}, {}, function() -- Done
        ClearPedTasksImmediately(PlayerPedId())
        SetVehicleFixed(veh)
        TriggerServerEvent('QBCore:Server:SetMetaData', "carcraftprogress", {progress = 5, veh = vehNameInProgress})
        SetVehicleDoorBroken(veh, 4, true) 
        SetVehicleDoorBroken(veh, 5, true) 
        progress4Active = false
        carryingProgress4Obj = false
        progress5Active = true
        Citizen.Wait(1000)
        playerdata = QBCore.Functions.GetPlayerData()
      end, function() -- Cancel
          QBCore.Functions.Notify("Failure!", "error")
          ClearPedTasks(PlayerPedId())
      end) 
end

function progressFive()
    DeleteEntity(newProp)
    newProp = nil
    ClearPedTasks(PlayerPedId())
    QBCore.Functions.Progressbar("l_attach_bonnet", " Attaching bonnet and engine..", math.random(2000, 5000), false, true, {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
      }, {
          task = "PROP_HUMAN_BUM_BIN"
      }, {}, {}, function() -- Done
        ClearPedTasksImmediately(PlayerPedId())
        SetVehicleFixed(veh)
        TriggerServerEvent('QBCore:Server:SetMetaData', "carcraftprogress", {progress = 6, veh = vehNameInProgress})
        SetVehicleDoorBroken(veh, 5, true) 
        progress5Active = false
        carryingProgress5Obj = false
        progress6Active = true
        Citizen.Wait(1000)
        playerdata = QBCore.Functions.GetPlayerData()
        end, function() -- Cancel
          QBCore.Functions.Notify("Failure!", "error")
          ClearPedTasks(PlayerPedId())
      end) 
end

function progressSix()
    DeleteEntity(newProp)
    newProp = nil
    ClearPedTasks(PlayerPedId())
    QBCore.Functions.Progressbar("l_kapi_tak", "Attaching Trunk..", math.random(2000, 5000), false, true, {
          disableMovement = true,
          disableCarMovement = true,
          disableMouse = false,
          disableCombat = true,
      }, {
          task = "PROP_HUMAN_BUM_BIN"
      }, {}, {}, function() -- Done
        ClearPedTasksImmediately(PlayerPedId())
        SetVehicleFixed(veh)
        TriggerServerEvent('QBCore:Server:SetMetaData', "carcraftprogress", {progress = 7, veh = vehNameInProgress})
        progress6Active = false
        carryingProgress6Obj = false
        progress7Active = true
        Citizen.Wait(1000)
        playerdata = QBCore.Functions.GetPlayerData()  
      end, function() -- Cancel
          QBCore.Functions.Notify("Failure!", "error")
          ClearPedTasks(PlayerPedId())
      end) 
end


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if craftActive then
            local ply = PlayerPedId()
            local coords = vector3(ped_spawns['obj_ped'].x,ped_spawns['obj_ped'].y,ped_spawns['obj_ped'].z)
            local plyCoords = GetEntityCoords(ply, true)
            local dist = #(plyCoords - coords)
            if dist < 2.4 then
                QBCore.Functions.DrawText3D(coords.x, coords.y, coords.z + 1.0,"E - Craft Material")
                if IsControlJustPressed(0, 38) then
                    TriggerEvent('lucid:craft-object:openmenu')
                end
            end
        end
    end
end)


function createObject(prop,bone,xpos,ypos,zpos,xrot,yrot,zrot,dict, anim)
 	newProp = CreateObject(GetHashKey(prop), -1605.8934326171875, 3094.365478515625, 31.56584548950195, true)
 	SetEntityCollision(newProp, false, false)
 	PlaceObjectOnGroundProperly(newProp)
 	if DoesEntityExist(newProp) then
 		AttachEntityToEntity(newProp, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), bone), xpos,ypos,zpos,xrot,yrot,zrot, true, true, false, true, 1, true)
 		ClearPedTasks(PlayerPedId())
 	end

    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end
 	TaskPlayAnim(PlayerPedId(), dict, anim, 8.0, 8.0, -1, 50, 0, false, false, false)

end





local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

function GeneratePlate()
	local generatedPlate
	local doBreak = false

	while true do
		Citizen.Wait(2)
		math.randomseed(GetGameTimer())

		generatedPlate = string.upper(GetRandomNumber(3) .. GetRandomLetter(3) .. GetRandomNumber(2))

		QBCore.Functions.TriggerCallback('esx_vehicleshop:isPlateTaken', function(isPlateTaken)
			if not isPlateTaken then
				doBreak = true
			end
		end, generatedPlate)

		if doBreak then
			break
		end
	end

	return generatedPlate
end

-- mixing async with sync tasks
function IsPlateTaken(plate)
	local callback = 'waiting'

	QBCore.Functions.TriggerCallback('esx_vehicleshop:isPlateTaken', function(isPlateTaken)
		callback = isPlateTaken
	end, plate)

	while type(callback) == 'string' do
		Citizen.Wait(0)
	end

	return callback
end

function GetRandomNumber(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(0)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end
