QBCore = nil
TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)




QBCore.Functions.CreateCallback('lucid:getplayerscarblueprints', function(source, cb)
    local ply = QBCore.Functions.GetPlayer(source)
    local items = {}
    local plyItems = ply.PlayerData.items
    for k,v in pairs(plyItems) do
        for _,reqItem in pairs(QBCore.Shared.Vehicles) do
            if v.name == reqItem.model.."_blueprint" then
                table.insert(items, v)
            end
        end
    end
    cb(items)

end)


RegisterServerEvent('lucid:insertVehToData')
AddEventHandler('lucid:insertVehToData', function(vehicleProps)
    local ply = QBCore.Functions.GetPlayer(source)

	exports.ghmattimysql:execute('INSERT INTO player_vehicles (steam, citizenid, plate, vehicle,model) VALUES (@steam,@citizenid, @plate, @vehicle, @model)', {
		['@steam']   = ply.PlayerData.steam,
		['@citizenid']   = ply.PlayerData.citizenid,
		['@plate']   = vehicleProps.plate,
		['@vehicle'] = json.encode(vehicleProps),
        ['@model'] = vehicleProps.model,
	}, function()

	end)
    
    QBCore.Functions.ExecuteSql(false, "INSERT INTO `player_vehicles` (`steam`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `garage`) VALUES ('"..ply.PlayerData.steam.."', '"..ply.PlayerData.citizenid.."', '"..vData["model"].."', '"..GetHashKey(vData["model"]).."', '{}', '"..plate.."', '"..garage.."')")


end)

QBCore.Functions.CreateCallback('esx_vehicleshop:isPlateTaken', function(source, cb, plate)
	exports.ghmattimysql:execute('SELECT 1 FROM player_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)
		cb(result[1] ~= nil)
	end)
end)



RegisterServerEvent('lucid-carcraft:removeItem')
AddEventHandler('lucid-carcraft:removeItem', function(item)
    local ply = QBCore.Functions.GetPlayer(source)
    ply.Functions.RemoveItem(item, 1)
end)

RegisterCommand('createcars', function(source)

    createCars(source)
end)


function createCars(source)
    local cars = {};
    for k,v in pairs(QBCore.Shared.Vehicles) do
        cars[k] = {
            label = v.name,
            reqItem = {
                v.model.."_blueprint"
            },
        }
    end
    TriggerClientEvent('lucid-craftcar:requestCars', source, cars)

end


RegisterServerEvent('lucid-craftCar:craftCarObject')
AddEventHandler('lucid-craftCar:craftCarObject', function(prop, bone, xpos, ypos, zpos, xrot,yrot,zrot,dict, anim, progress, reqItems)
    local src = source
    local ply = QBCore.Functions.GetPlayer(source)
    for k,v in pairs(reqItems) do
       local item = ply.Functions.GetItemByName(k)
       if item == nil or tonumber(item.amount) < tonumber(v.reqAmount) then
            TriggerClientEvent('QBCore:Notify', src, "You don't have enough item to craft.", "error")
            return
       end  
    end
     for k,v in pairs(reqItems) do
        ply.Functions.RemoveItem(k, v.reqAmount)
     end
     TriggerClientEvent('lucid-craftCar-client:craftCarObject', src, prop, bone, xpos, ypos, zpos, xrot,yrot,zrot,dict, anim, progress)
end)

