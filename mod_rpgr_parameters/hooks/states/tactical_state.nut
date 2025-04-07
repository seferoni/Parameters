::Parameters.Patcher.hook("scripts/states/tactical_state", function( p )
{
	::Parameters.Patcher.wrap(p, "gatherLoot", function()
	{
		if (this.isScenarioMode())
		{
			return;
		}

		if (this.m.StrategicProperties != null && this.m.StrategicProperties.IsArenaMode)
		{
			return;
		}

		::Parameters.Utilities.removeLoot(this.m.CombatResultLoot.getItems());
	});
});