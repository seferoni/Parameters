local Core = ::RPGR_Core;
::mods_hookBaseClass("factions/faction", function( _object )
{
	Core.Standard.wrap(_object, "spawnEntity", function( _party, _tile, _name, _uniqueName, _template, _resources )
	{
		local factionType = this.getType();

		if (!Core.Troops.isFactionViable(factionType))
		{
			return;
		}

		Core.Troops.compress(_party, factionType);
	});
});