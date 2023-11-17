local Core = ::RPGR_Core;
::mods_hookBaseClass("scripts/scenarios/world/starting_scenario", function( _object )
{
    Core.Standard.wrap(_object, "onInit", function()
    {
        local campingSupplies = ::new("scripts/items/misc/camping_supplies_item");
        campingSupplies.setBeds(::World.getPlayerRoster().getSize());
        ::World.Assets.getStash().add(campingSupplies);
    });
})