::Core.Patcher.hookTree("scenarios/world/starting_scenario", function(p)
{
	::Core.Patcher.wrap(p, "onSpawnPlayer", function()
	{
		::Core.Classes.Assets.setRosterSize();
		::Core.Classes.Assets.setStashSize();
	});
});