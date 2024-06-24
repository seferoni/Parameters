::Core.Patcher.hookTree("scenarios/world/starting_scenario", function(p)
{	// TODO: not working. hooks both p and p's descendants
	::Core.Patcher.wrap(p, "onSpawnPlayer", function()
	{
		::Core.Classes.Assets.setRosterSize();
		::Core.Classes.Assets.setStashSize();
	});
});