::Core.Patcher.hookTree("scripts/scenarios/world/starting_scenario", function(p)
{
	::Core.Patcher.wrap(p, "onInit", function()
	{
		::Core.Classes.Assets.setRosterSize();
		::Core.Classes.Assets.setStashSize();
	});
});