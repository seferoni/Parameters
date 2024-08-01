::Core.Patcher.hookTree("scripts/scenarios/world/starting_scenario", function(p)
{	// TODO: this is not working for roster size override
	::Core.Patcher.wrap(p, "onInit", function()
	{
		::Core.Classes.Integrator.setRosterSize();
		::Core.Classes.Integrator.setStashSize();
	});
});