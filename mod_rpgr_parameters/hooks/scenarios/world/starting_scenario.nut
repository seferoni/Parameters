::PRM.Patcher.hookTree("scripts/scenarios/world/starting_scenario", function( p )
{
	::PRM.Patcher.wrap(p, "onInit", function()
	{	// TODO: setting description says this is only ever called once per new playthrough. is that actually the case?
		::PRM.RosterHandler.setRosterSize();
		::PRM.RosterHandler.constrainFormation();
		::PRM.Mapper.setStashSize();
	});
});