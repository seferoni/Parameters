::Parameters.Patcher.hookTree("scripts/scenarios/world/starting_scenario", function( p )
{
	::Parameters.Patcher.wrap(p, "onInit", function()
	{
		::Parameters.Mapper.setStashSize();
	});
});