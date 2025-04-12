::PRM.Patcher.hookTree("scripts/scenarios/world/starting_scenario", function( p )
{
	::PRM.Patcher.wrap(p, "onSpawnPlayer", function()
	{
		::PRM.StashHandler.setStashSize();
	});
});