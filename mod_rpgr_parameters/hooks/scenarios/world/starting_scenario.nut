::PRM.Patcher.hookTree("scripts/scenarios/world/starting_scenario", function( p )
{
	::PRM.Patcher.wrap(p, "onInit", function()
	{
		::PRM.RosterHandler.setRosterSize();
		::PRM.RosterHandler.constrainFormation();
		::PRM.StashHandler.setStashSize();
	});
});