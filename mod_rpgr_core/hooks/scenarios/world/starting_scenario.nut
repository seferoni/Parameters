local Core = ::RPGR_Core;
::mods_hookBaseClass("scenarios/world/starting_scenario", function( _object )
{
	Core.Standard.wrap(_object, "onSpawnPlayer", function()
	{
		Core.Assets.setRosterSize();
		Core.Assets.setStashSize();
	});
});