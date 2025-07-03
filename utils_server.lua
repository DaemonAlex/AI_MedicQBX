Utils = {}
Utils.QBCore = nil
Utils.QBX = nil
Utils.Framework = 'standalone'

CreateThread(function()
    -- Check for QBox framework first
    if GetResourceState('qbx_core') == 'started' then
        Utils.QBX = exports.qbx_core
        Utils.Framework = 'qbox'
        print('[AI Medic] QBox framework detected and initialized')
    -- Check for QBCore framework
    elseif GetResourceState('qb-core') == 'started' then
        Utils.QBCore = exports['qb-core']:GetCoreObject()
        Utils.Framework = 'qbcore'
        print('[AI Medic] QBCore framework detected and initialized')
    else
        Utils.Framework = 'standalone'
        print('[AI Medic] No framework found, running in standalone mode')
    end
end)

function Utils.GetPlayerFramework(source)
    if Utils.Framework == 'qbox' then
        local player = exports.qbx_core:GetPlayer(source)
        if player then
            print('[AI Medic] QBox player framework retrieved for source: ' .. source)
            return player
        else
            print('[AI Medic] Failed to get QBox player framework for source: ' .. source)
        end
    elseif Utils.Framework == 'qbcore' then
        local player = Utils.QBCore.Functions.GetPlayer(source)
        if player then
            print('[AI Medic] QBCore player framework retrieved for source: ' .. source)
            return player
        else
            print('[AI Medic] Failed to get QBCore player framework for source: ' .. source)
        end
    end
    return nil
end

function Utils.Notify(src, msg, type)
    print('[AI Medic] Notify sent to ' .. src .. ': ' .. msg)
    
    if Utils.Framework == 'qbox' then
        TriggerClientEvent('qbx_core:client:notify', src, {
            text = msg,
            type = type or 'primary'
        })
    elseif Utils.Framework == 'qbcore' then
        TriggerClientEvent('QBCore:Notify', src, msg, type or 'primary')
    else
        -- Standalone fallback
        TriggerClientEvent('chat:addMessage', src, {
            color = {255, 0, 0},
            multiline = true,
            args = {"EMS", msg}
        })
    end
end

function Utils.RemoveMoney(player, amount)
    if not player then
        print('[AI Medic] No player provided for money removal')
        return false
    end
    
    if Utils.Framework == 'qbox' then
        local success = player.Functions.RemoveMoney('bank', amount, 'ai-medic-fee')
        print('[AI Medic] QBox money removal attempt for ' .. player.PlayerData.source .. ': $' .. amount .. ' - Success: ' .. tostring(success))
        return success
    elseif Utils.Framework == 'qbcore' then
        local success = player.Functions.RemoveMoney('bank', amount)
        print('[AI Medic] QBCore money removal attempt for ' .. player.PlayerData.source .. ': $' .. amount .. ' - Success: ' .. tostring(success))
        return success
    else
        print('[AI Medic] Money removal skipped (standalone mode)')
        if player.PlayerData and player.PlayerData.source then
            Utils.Notify(player.PlayerData.source, 'EMS fee skipped in standalone mode', 'info')
        end
        return true -- Always succeed in standalone mode
    end
end

function Utils.GetOnlineEMSCount()
    local onlineEMS = 0
    local jobName = Config.EMSJobNames[Utils.Framework] or 'ambulance'
    
    if Utils.Framework == 'qbox' then
        local players = exports.qbx_core:GetQBPlayers()
        for _, player in pairs(players) do
            if player.PlayerData.job.name == jobName and player.PlayerData.job.onduty then
                onlineEMS = onlineEMS + 1
            end
        end
        print('[AI Medic] QBox Online EMS count: ' .. onlineEMS)
    elseif Utils.Framework == 'qbcore' then
        for _, id in pairs(Utils.QBCore.Functions.GetPlayers()) do
            local ply = Utils.QBCore.Functions.GetPlayer(id)
            if ply and ply.PlayerData.job.name == jobName then
                onlineEMS = onlineEMS + 1
            end
        end
        print('[AI Medic] QBCore Online EMS count: ' .. onlineEMS)
    else
        print('[AI Medic] Standalone mode - EMS count check skipped')
    end
    
    return onlineEMS
end

function Utils.RevivePlayer(target)
    print('[AI Medic] Revive requested for target: ' .. target)
    
    if Utils.Framework == 'qbox' then
        -- QBox revival method - check if qbx_medical exists
        if GetResourceState('qbx_medical') == 'started' then
            exports.qbx_medical:RevivePlayer(target, true)
            print('[AI Medic] QBox medical revive triggered')
        else
            -- Fallback to generic QBox revive event
            TriggerClientEvent('qbx_medical:client:revive', target)
            print('[AI Medic] QBox fallback revive event triggered')
        end
    elseif Utils.Framework == 'qbcore' then
        -- QBCore revival method
        TriggerClientEvent('hospital:client:Revive', target)
        print('[AI Medic] QBCore revive event triggered')
    else
        -- Standalone revival
        TriggerClientEvent('custom_aimedic:standaloneRevive', target)
        print('[AI Medic] Standalone revive event triggered')
    end
end
