local Core = ::RPGR_Core;
::mods_hookExactClass("entity/world/settlement", function( _object )
{
    Core.Standard.wrap(_object, "create", function()
    {   // TODO: this doesn't work the way you think
        Core.Assets.initialiseSettlementParameters(this);
    })
});