local Core = ::RPGR_Core;
::mods_hookExactClass("factions/faction", function( _object )
{
	Core.Standard.wrap(_object, "spawnEntity", function( _party, _tile, _name, _uniqueName, _template, _resources )
	{	// TODO: we examine the contents of the party, considering faction type. if there are sufficient number of weak enemies, replace with strong variant

	});
});