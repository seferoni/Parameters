::Core.Patcher.hookTree("scripts/scenarios/world/starting_scenario", function( p )
{
	::Core.Patcher.wrap(p, "onInit", function()
	{
		::Core.Mapper.setRosterSize();
		::Core.Mapper.setFormationSize();
		::Core.Mapper.setStashSize();
	});
});