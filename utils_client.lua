Utils = {}
Utils.QBCore = nil
Utils.QBX = nil
Utils.Framework = 'standalone'

CreateThread(function()
    -- Check for QBox framework first
    if GetResourceState('qbx_core') == 'started' then
        Utils.QBX = exports.qbx_core
        Utils.Framework = 'qbox'
        print('[AI Medic Client] QBox framework detected and initialized')
    -- Check for QBCore framework
    elseif GetResourceState('qb-core') == 'started' then
        Utils.QBCore = exports['qb-core']:GetCoreObject()
        Utils.Framework = 'qbcore'
        print('[AI Medic Client] QBCore framework detected and initialized')
    else
        Utils.Framework = 'standalone'
        print('[AI Medic Client] No framework found, running in standalone mode')
    end
end)

function Utils.NotifyClient(msg, type)
    print('[AI Medic Client] Notify: ' .. msg)
    
    if Utils.Framework == 'qbox' then
        TriggerEvent('qbx_core:client:notify', {
            text = msg,
            type = type or 'primary'
        })
    elseif Utils.Framework == 'qbcore' then
        TriggerEvent('QBCore:Notify', msg, type or 'primary')
    else
        -- Standalone fallback
        TriggerEvent('chat:addMessage', {
            color = {255, 0, 0},
            multiline = true,
            args = {"EMS", msg}
        })
    end
end

function Utils.GetPlayerData()
    if Utils.Framework == 'qbox' then
        return exports.qbx_core:GetPlayerData()
    elseif Utils.Framework == 'qbcore' then
        return Utils.QBCore.Functions.GetPlayerData()
    else
        return nil
    end
end

function Utils.IsPlayerDead()
    local playerPed = PlayerPedId()
    
    if Utils.Framework == 'qbox' then
        local playerData = Utils.GetPlayerData()
        if playerData and playerData.metadata then
            return playerData.metadata.isdead or playerData.metadata.inlaststand
        end
    elseif Utils.Framework == 'qbcore' then
        local playerData = Utils.GetPlayerData()
        if playerData and playerData.metadata then
            return playerData.metadata['isdead'] or playerData.metadata['inlaststand']
        end
    end
    
    -- Fallback to native check
    return IsEntityDead(playerPed)
end
