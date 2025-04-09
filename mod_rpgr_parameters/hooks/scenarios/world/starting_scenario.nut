::PRM.Patcher.hookTree("scripts/scenarios/world/starting_scenario", function( p )
{
	::PRM.Patcher.wrap(p, "onInit", function()
	{	// TODO: this is called every time on start. test edge cases
		::PRM.RosterHandler.setRosterSize();
		::PRM.RosterHandler.constrainFormation();
		::PRM.Mapper.setStashSize();
	});
});