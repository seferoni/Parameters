local Core = ::RPGR_Core;
::mods_hookNewObject("states/world/asset_manager", function( _object )
{ 
    Core.Assets.initialiseWorldParameters(_object);
    local vanilla_resetToDefaults = _object.resetToDefaults;
    _object.resetToDefaults = function()
    {
        vanilla_resetToDefaults();
        Core.Assets.initialiseWorldParameters(this);
    }
});

