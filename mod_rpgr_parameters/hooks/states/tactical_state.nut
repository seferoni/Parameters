::PRM.Patcher.hook("scripts/states/tactical_state", function( p )
{
	::PRM.Patcher.wrap(p, "gatherLoot", function()
	{
		if (this.isScenarioMode())
		{
			return;
		}

		if (this.m.StrategicProperties == null)
		{
			return;
		}

		if (this.m.StrategicProperties.IsArenaMode)
		{
			return;
		}

		if (this.m.StrategicProperties.IsLootingProhibited)
		{
			return;
		}

		::PRM.StashInjector.removeLoot(this.m.CombatResultLoot.getItems());
	});
});