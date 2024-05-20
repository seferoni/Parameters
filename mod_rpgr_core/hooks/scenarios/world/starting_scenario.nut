::mods_hookBaseClass("scenarios/world/starting_scenario", function( _object )
{
	::Core.Patcher.wrap(_object, "onSpawnPlayer", function()
	{
		::Core.Assets.setRosterSize();
		::Core.Assets.setStashSize();
	});
});