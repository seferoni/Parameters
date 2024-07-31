::Core.Patcher.hookTree("scripts/scenarios/world/starting_scenario", function(p)
{
	::Core.Patcher.wrap(p, "onInit", function()
	{
		::Core.Classes.Integrator.setRosterSize();
		::Core.Classes.Integrator.setStashSize();
	});
});