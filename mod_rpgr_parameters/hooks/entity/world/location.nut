::PRM.Patcher.hook("scripts/entity/world/location", function( p )
{
	::PRM.Patcher.wrap(p, "dropTreasure", function( _num, _items, _lootTable )
	{
		if (!::Const.DLC.Unhold)
		{
			return;
		}

		if (::PRM.StashHandler.getReproachBladeInjectedState())
		{
			return;
		}

		if (::PRM.Utilities.getKrakenBuiltState())
		{
			return;
		}

		::PRM.StashHandler.injectReproachBladeIntoStash(this, _lootTable);
	}, "overrideArguments");
});