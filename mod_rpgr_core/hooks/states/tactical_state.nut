::mods_hookExactClass("scripts/states/tactical_state", function( _object )
{
	::Core.Standard.wrap(_object, "gatherLoot", function()
	{
		if (this.isScenarioMode())
		{
			return;
		}

		if (this.m.StrategicProperties != null && this.m.StrategicProperties.IsArenaMode)
		{
			return;
		}

		::Core.Assets.removeLoot(this.m.CombatResultLoot.getItems());
	});
});