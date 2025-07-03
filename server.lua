RegisterCommand('callmedic', function(source)
    print('[AI Medic] callmedic command triggered by source: ' .. source)
    
    local onlineEMS = Utils.GetOnlineEMSCount()
    
    if onlineEMS >= Config.MaxEMSOnline then
        Utils.Notify(source, "EMS are available, please call them instead.", "error")
        return
    end

    local ped = GetPlayerPed(source)
    local coords = GetEntityCoords(ped)
    if not coords then
        print('[AI Medic] Failed to get coords for source: ' .. source)
        Utils.Notify(source, "Error: Could not get your location.", "error")
        return
    end
    
    print('[AI Medic] Triggering revivePlayer for source: ' .. source .. ' at coords: ' .. tostring(coords))
    TriggerClientEvent('custom_aimedic:revivePlayer', source, coords)
end, false)

RegisterNetEvent('custom_aimedic:chargePlayer')
AddEventHandler('custom_aimedic:chargePlayer', function(target)
    local src = target or source
    print('[AI Medic] Charging player: ' .. src)
    
    local Player = Utils.GetPlayerFramework(src)
    if Player then
        if Utils.RemoveMoney(Player, Config.Fee) then
            Utils.Notify(src, "You were charged $" .. Config.Fee .. " for EMS service.", "success")
        else
            Utils.Notify(src, "You don't have enough money to pay for EMS!", "error")
        end
    else
        print('[AI Medic] No player framework for source: ' .. src)
        Utils.Notify(src, "EMS fee skipped due to server error.", "error")
    end
end)

-- Custom revive event with framework compatibility
RegisterNetEvent('custom_aimedic:revivePlayer')
AddEventHandler('custom_aimedic:revivePlayer', function(target)
    local src = target or source
    Utils.RevivePlayer(src)
end)

-- Debug command for admins
RegisterCommand('debugmedic', function(source, args)
    if source == 0 then -- Console only
        print('[AI Medic Debug] Framework: ' .. Utils.Framework)
        print('[AI Medic Debug] Online EMS: ' .. Utils.GetOnlineEMSCount())
        print('[AI Medic Debug] Max EMS Online: ' .. Config.MaxEMSOnline)
        
        if Utils.Framework == 'qbox' then
            print('[AI Medic Debug] QBox Core State: ' .. GetResourceState('qbx_core'))
            print('[AI Medic Debug] QBox Medical State: ' .. GetResourceState('qbx_medical'))
        elseif Utils.Framework == 'qbcore' then
            print('[AI Medic Debug] QBCore State: ' .. GetResourceState('qb-core'))
        end
    end
end, true)
