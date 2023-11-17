local Core = ::RPGR_Core;
::mods_hookNewObject("states/world/asset_manager", function( _object )
{
    local vanilla_setCampaignSettings = _object.setCampaignSettings;
    _object.setCampaignSettings = function( _settings )
    {
        vanilla_setCampaignSettings(_settings);
        Core.Assets.initialiseWorldParameters(this);
    }

    local vanilla_resetToDefaults = _object.resetToDefaults;
    _object.resetToDefaults = function()
    {
        vanilla_resetToDefaults();
        Core.Assets.initialiseWorldParameters(this);
    }

    local vanilla_getBrothersMax = _object.getBrothersMax;
    _object.getBrothersMax = function()
    {   // TODO: revise this as object class is created
        local items = ::World.Assets.getStash().getItems().filter(@(_index, _item) _item != null && _item.getID() == "misc.camping_supplies");
        // FIXME: this.getStash()?
        if (items.len() == 0)
        {
            return Core.Assets.Parameters.BrothersMaxFloor;
        }

        return Core.Standard.getFlag("Beds", items[0]);
    }
});

