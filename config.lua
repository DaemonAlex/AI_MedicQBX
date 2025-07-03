Config = {}

-- Framework Detection
Config.Framework = 'auto' -- 'auto', 'qbox', 'qbcore', 'standalone'

-- Models
Config.MedicModel = 's_m_m_paramedic_01' -- Fallback: 's_m_m_doctor_01'
Config.AmbulanceModel = 'ambulance'

-- Behavior
Config.ReviveDelay = 10000 -- Time for medic to "treat" player (ms)
Config.Fee = 500 -- Cost of EMS service
Config.MaxEMSOnline = 5 -- Max online EMS before AI medic is disabled

-- Framework-specific job names
Config.EMSJobNames = {
    qbox = 'ambulance',
    qbcore = 'ambulance',
    standalone = nil
}

-- Framework-specific revival events
Config.ReviveEvents = {
    qbox = 'qbx_medical:client:revive',
    qbcore = 'hospital:client:Revive',
    standalone = 'custom_aimedic:standaloneRevive'
}

-- Framework-specific notification events
Config.NotifyEvents = {
    qbox = 'qbx_core:client:notify',
    qbcore = 'QBCore:Notify',
    standalone = 'chat:addMessage'
}

-- Hospital locations (ensure these match your map)
Config.Hospitals = {
    city = vector3(308.24, -592.42, 43.28),
    sandy = vector3(1828.52, 3673.22, 34.28),
    paleto = vector3(-247.76, 6331.23, 32.43),
    -- Fallback hospital if none are valid
    default = vector3(293.0, -582.0, 43.0)
}

-- Debug settings
Config.Debug = false -- Set to true for detailed console logs

-- Advanced settings
Config.Advanced = {
    -- Medic behavior
    medicDriveSpeed = 25.0,
    medicWalkSpeed = 2.0,
    
    -- Timeouts (in milliseconds)
    driveTimeout = 30000,
    walkTimeout = 10000,
    hospitalDriveTimeout = 60000,
    
    -- Visual settings
    progressBarWidth = 0.15,
    progressBarHeight = 0.02,
    progressBarPosX = 0.5,
    progressBarPosY = 0.9,
    
    -- 3D text settings
    textScale = 0.35,
    textFont = 4,
    textHeight = 1.1,
    
    -- Blip settings
    blipSprite = 56,
    blipScale = 0.9,
    blipColor = 1,
    blipName = "AI Medic"
}
