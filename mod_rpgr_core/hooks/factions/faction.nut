local Core = ::RPGR_Core;
::mods_hookExactClass("factions/faction", function( _object )
{
	Core.Standard.wrap(_object, "spawnEntity", function( _party, _tile, _name, _uniqueName, _template, _resources )
	{
		if (!Core.Troops.isFactionViable(this.getType()))
		{
			return;
		}

		Core.Troops.compress(_party);
	});
});