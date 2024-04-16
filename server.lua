RegisterNetEvent('miska_interactions:ziptie_detainee:detain',function (targetPlayerId)
    local ziptiesCount =exports.ox_inventory:GetItemCount(source,Config.Items.ziptiesItem)
    local captor = GetPlayerPed(source)
    local detainee = GetPlayerPed(targetPlayerId)
    local detaineeCoords = GetEntityCoords(detainee)
    local captorCoords = GetEntityCoords(captor)
    local distance = #(captorCoords -detaineeCoords)

    if ziptiesCount == 0 or targetPlayerId == -1 or distance < 4.0  then
        DropPlayer(source,'Cheating')
    else
    exports.ox_inventory:RemoveItem(source,Config.Items.ziptiesItem,1)
  
    TriggerClientEvent('miska_interactions:ziptie_detainee:detaincli',targetPlayerId)
    Wait(2800)
    Player(targetPlayerId).state.isZiptied = true
    end

end)
RegisterNetEvent('miska_interactions:ziptie_free',function (targetPlayerId)
    Player(targetPlayerId).state.isZiptied = nil

end)
RegisterNetEvent('miska_interactions:handcuff_detainee:detain',function (targetPlayerId)
    local handcuffsCount =exports.ox_inventory:GetItemCount(source,Config.Items.handcuffsItem)
    local captor = GetPlayerPed(source)
    local detainee = GetPlayerPed(targetPlayerId)
    local detaineeCoords = GetEntityCoords(detainee)
    local captorCoords = GetEntityCoords(captor)
    local distance = #(captorCoords -detaineeCoords)
    if handcuffsCount == 0 or targetPlayerId == -1 or distance < 4.0 then
        DropPlayer(source,'Cheating')
    else
    exports.ox_inventory:RemoveItem(source,Config.Items.handcuffsItem,1)
    

   
    TriggerClientEvent('miska_interactions:handcuff_detainee:detaincli',targetPlayerId)
    Wait(2800)
    Player(targetPlayerId).state.isHandCuffed = true
    end

end)
RegisterNetEvent('miska_interactions:handcuff_free',function (targetPlayerId)
    Player(targetPlayerId).state.isHandCuffed = nil
    exports.ox_inventory:AddItem(source,Config.Items.handcuffsItem,1)
    
end)
RegisterNetEvent('miska_interactions:dragging',function (targetPlayerId,ped)
    Player(targetPlayerId).state.isBeingDragged = true 

    TriggerClientEvent('miska_interactions:drag',targetPlayerId,ped)
end)
RegisterNetEvent('miska_interactions:stop_dragging',function (targetPlayerId)
    Player(targetPlayerId).state.isBeingDragged = nil 

    TriggerClientEvent('miska_interactions:stop_dragging',targetPlayerId)
end)
RegisterNetEvent('miska_interactions:put_into_car',function (targetPlayerId,vehicle)
    TriggerClientEvent('miska_interactions:put_into_carcl',targetPlayerId,vehicle)
end)
RegisterNetEvent('miska_interactions:leave_car',function (targetPlayerId)
    TriggerClientEvent('miska_interactions:leave_carcl',targetPlayerId)
end)
RegisterNetEvent('miska_interactions:put_bag_on',function (targetPlayerId)
    bagCount = exports.ox_inventory:GetItemCount(source,Config.Items.bagItem)
    
    if bagCount == 0 or targetPlayerId == -1 then
        DropPlayer(source,'Cheating')
    else
        Player(targetPlayerId).state.hasBagOnHead = true
    exports.ox_inventory:RemoveItem(source,Config.Items.bagItem,1)
        
    TriggerClientEvent('miska_interactions:put_bag_oncl',targetPlayerId)
    end
end)
RegisterNetEvent('miska_interactions:put_bag_off',function (targetPlayerId)
if targetPlayerId == -1 then
    DropPlayer(source,'Cheating')
end

    exports.ox_inventory:AddItem(source,Config.Items.bagItem,1)

Player(targetPlayerId).state.hasBagOnHead = nil
    TriggerClientEvent('miska_interactions:put_bag_offcl',targetPlayerId)
end)

RegisterNetEvent('miska_interactions:put_into_trunk',function (targetPlayerId,vehicle)
    Entity(NetworkGetEntityFromNetworkId(vehicle)).state.PlayerInTrunk = targetPlayerId
    Player(targetPlayerId).state.InTrunk = vehicle
    Wait(400)
    TriggerClientEvent('miska_interactions:put_into_trunkcl',targetPlayerId,vehicle)
    
  
end)
RegisterNetEvent('miska_interactions:take_out_of_trunk',function (targetPlayerId,vehicle)
    

    TriggerClientEvent('miska_interactions:take_out_of_trunkcl',targetPlayerId,vehicle)
    
    Wait(500)
    Player(targetPlayerId).state.InTrunk = nil
    if vehicle ~= nil then
    Entity(NetworkGetEntityFromNetworkId(vehicle)).state.PlayerInTrunk = nil
    end
end)
RegisterNetEvent('miska_interactions:change_trunk_state',function (vehicle,value)
    Entity(NetworkGetEntityFromNetworkId(vehicle)).state.PlayerInTrunk = value
    
end)
RegisterNetEvent('miska_interactions:carry',function (targetPlayerId,ped)
    TriggerClientEvent('miska_interactions:carrycl',targetPlayerId,source,ped)
end)
RegisterNetEvent('miska_interactions:carry_accepted',function (targetPlayerId)
    TriggerClientEvent('miska_interactions:carry_acceptedcl',targetPlayerId,source)
end)
RegisterNetEvent('miska_interactions:carry_stop',function (playerId)
    TriggerClientEvent('miska_interactions:carry_stopcl',playerId) 
end)
RegisterNetEvent('miska_interactions:delete_entity',function (entity)
    DeleteEntity(NetworkGetEntityFromNetworkId(entity))
end)
AddEventHandler('playerDropped', function (reason)
    if Player(source).state.InTrunk ~= nil then
            Entity(NetworkGetEntityFromNetworkId(Player(source).state.InTrunk)).state.PlayerInTrunk = nil
    end
    if Player(source).state.isBeingDragged ~= nil then
        Player(Player(source).state.isBeingDragged).state.Dragging = nil
Player(Player(source).state.isBeingDragged).state.canUseWeapons = true

    end
    if Player(source).state.Dragging ~= nil then
       TriggerClientEvent('miska_interactions:stop_dragging',Player(source).state.Dragging)
    end
    if Player(source).state.isBeingCarried ~= nil then
        Player(Player(source).state.isBeingCarried ~= nil).state.isCarrying = nil
Player(Player(source).state.isBeingCarried ~= nil).state.canUseWeapons = true
    end
    if Player(source).state.isCarrying ~= nil then
       TriggerClientEvent('miska_interactions:carry_stopcl',Player(source).state.isCarrying)
    end
  end)