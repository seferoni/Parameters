::Core.Patcher.hook("states/tactical_state", function(p)
{
	::Core.Patcher.wrap(p, "gatherLoot", function()
	{
		if (this.isScenarioMode())
		{
			return;
		}

		if (this.m.StrategicProperties != null && this.m.StrategicProperties.IsArenaMode)
		{
			return;
		}

		::Core.Classes.Assets.removeLoot(this.m.CombatResultLoot.getItems());
	});
});