# CES AI Medic Script - QBox & QBCore Compatible

A fully autonomous AI Medic system for FiveM, compatible with **QBox**, **QBCore**, and **Standalone** frameworks. This script detects when EMS are unavailable and sends a medic NPC in an ambulance to revive the player, complete with animations, a medbag prop, and hospital transport!

## 🧠 Features

✅ **Multi-Framework Support**: QBox, QBCore, and Standalone compatible  
✅ **Automatic Framework Detection**: Intelligently detects your framework  
✅ **Call AI EMS when no EMS are online**: Smart EMS availability checking  
✅ **AI Medic drives to you in an ambulance**: Realistic emergency response  
✅ **Custom revival animations and medbag prop**: Immersive medical treatment  
✅ **Configurable revive cost**: Customizable billing system  
✅ **Transports player to nearest hospital**: Complete medical service  
✅ **Displays cause of death in 3D text**: Detailed medical information  
✅ **Enhanced notifications**: Framework-specific notification system  
✅ **Debug commands**: Admin tools for troubleshooting  

## 🔧 Framework Compatibility

### QBox Framework
- ✅ Automatic detection of `qbx_core`
- ✅ QBox player data integration
- ✅ QBox job system compatibility
- ✅ QBox notification system
- ✅ QBox money/banking system
- ✅ QBox medical system integration

### QBCore Framework
- ✅ Full backward compatibility maintained
- ✅ All existing QBCore features preserved
- ✅ Seamless migration from QBCore setups

### Standalone Mode
- ✅ Works without any framework
- ✅ Basic GTA V native functions
- ✅ Chat-based notifications

## 📦 Installation

1. **Download the resource** and place it in your `resources` folder
2. **Add to server.cfg**:
   ```
   ensure CES_AI_Medic
   ```
3. **Configure** the script in `config.lua` to match your server setup
4. **Restart your server**

## 🔧 Configuration

```lua
Config = {}

-- Framework Detection (usually leave as 'auto')
Config.Framework = 'auto' -- 'auto', 'qbox', 'qbcore', 'standalone'

-- Models
Config.MedicModel = 's_m_m_paramedic_01'
Config.AmbulanceModel = 'ambulance'

-- Behavior
Config.ReviveDelay = 10000  -- Treatment time in milliseconds
Config.Fee = 500            -- Cost of EMS service
Config.MaxEMSOnline = 5     -- Max online EMS before AI is disabled

-- Framework-specific job names
Config.EMSJobNames = {
    qbox = 'ambulance',
    qbcore = 'ambulance',
    standalone = nil
}

-- Hospital locations (adjust to match your map)
Config.Hospitals = {
    city = vector3(308.24, -592.42, 43.28),
    sandy = vector3(1828.52, 3673.22, 34.28),
    paleto = vector3(-247.76, 6331.23, 32.43),
    default = vector3(293.0, -582.0, 43.0)
}
```

## 🎮 Usage

### For Players
- **Get injured/killed** in-game
- **Type** `/callmedic` in chat
- **Wait** for the AI medic to arrive
- **Get treated** and transported to hospital
- **Pay the fee** (automatically deducted)

### For Admins
- **Debug command**: `/debugmedic` (console only)
- **Check framework status**, EMS count, and configuration

## 🔍 Troubleshooting

### Framework Detection Issues
1. **Check console logs** for framework detection messages:
   ```
   [AI Medic] QBox framework detected and initialized
   [AI Medic] QBCore framework detected and initialized
   [AI Medic] No framework found, running in standalone mode
   ```

2. **Verify resource states**:
   - QBox: Ensure `qbx_core` is started
   - QBCore: Ensure `qb-core` is started

3. **Manual framework override** (if needed):
   ```lua
   Config.Framework = 'qbox'  -- Force QBox mode
   ```

### QBox Specific Issues
- **Medical system integration**: Ensure `qbx_medical` is properly configured
- **Job system**: Verify ambulance job exists in your QBox setup
- **Banking integration**: Check QBox money system compatibility

### QBCore Migration
- **No changes needed**: Existing QBCore servers work without modification
- **All features preserved**: Original functionality maintained
- **Seamless upgrade**: Drop-in replacement

## 📋 Dependencies

### Required
- **FiveM Server** (latest recommended)

### Optional (Framework-Specific)
- **QBox**: `qbx_core`, `qbx_medical` (recommended)
- **QBCore**: `qb-core`, medical scripts
- **Standalone**: None required

## 🔐 Permissions

No special permissions required. The script automatically adapts based on:
- Framework availability
- Player job status (for EMS checking)
- Player money (for billing)

## 📊 Performance

- **Optimized entity management**: Proper cleanup of spawned vehicles/NPCs
- **Efficient framework detection**: One-time detection at resource start
- **Minimal server impact**: Event-driven architecture
- **Memory conscious**: Automatic resource cleanup

## 🛠️ Advanced Configuration

### Custom Animations
```lua
-- In client.lua, modify:
RequestAnimDict("your_custom_anim_dict")
TaskPlayAnim(medic, "your_custom_anim_dict", "your_anim", ...)
```

### Custom Models
```lua
Config.MedicModel = 'your_custom_medic_model'
Config.AmbulanceModel = 'your_custom_ambulance_model'
```

### Framework-Specific Customization
```lua
-- Custom job names per framework
Config.EMSJobNames = {
    qbox = 'paramedic',      -- If you use 'paramedic' instead of 'ambulance'
    qbcore = 'ems',          -- If you use 'ems' instead of 'ambulance'
    standalone = nil
}
```

## 🧪 Testing

### Test Scenarios
1. **Framework Detection**: Check console logs on resource start
2. **EMS Count Checking**: Use `/debugmedic` to verify EMS detection
3. **Revival Process**: Test full medic call and revival sequence
4. **Money System**: Verify payment processing works
5. **Multi-Framework**: Test on both QBox and QBCore if available

### Debug Mode
```lua
Config.Debug = true  -- Enable detailed logging
```

## 🔄 Migration Guide

### From QBCore to QBox
1. **Update your server** to QBox framework
2. **No script changes needed** - automatic detection handles the switch
3. **Verify configuration** matches your QBox setup
4. **Test thoroughly** in your environment

### From Standalone to Framework
1. **Install your preferred framework** (QBox/QBCore)
2. **Script automatically detects** and enables framework features
3. **Configure framework-specific settings** as needed

## 📝 Changelog

### Version 2.0.0 (QBox Compatible)
- ✅ Added full QBox framework support
- ✅ Enhanced framework detection system
- ✅ Improved money system integration
- ✅ Updated notification systems
- ✅ Added debug commands
- ✅ Maintained full QBCore backward compatibility
- ✅ Enhanced error handling and logging

### Version 1.0.0 (Original)
- ✅ QBCore and Standalone support
- ✅ Basic AI medic functionality
- ✅ Hospital transport system

## 📞 Support

If you encounter issues:

1. **Check console logs** for error messages
2. **Verify framework compatibility** with `/debugmedic`
3. **Test in standalone mode** to isolate framework issues
4. **Check configuration** matches your server setup

## 👨‍💻 Credits

**Developed by Crazy Eyes Studio**
- Original QBCore/Standalone version
- Enhanced QBox compatibility
- Multi-framework architecture

## 📄 License

This script is provided as-is for FiveM community use. Please respect the original author's work and provide credit when sharing or modifying.
