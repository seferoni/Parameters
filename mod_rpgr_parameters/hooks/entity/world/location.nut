::PRM.Patcher.hook("scripts/entity/world/location", function( p )
{
	::PRM.Patcher.wrap(p, "dropTreasure", function( _num, _items, _lootTable )
	{
		if (::PRM.StashInjector.getReproachBladeInjectedState())
		{
			return;
		}

		if (::PRM.Utilities.getKrakenBuiltState())
		{
			return;
		}

		::PRM.StashInjector.injectReproachBladeIntoStash(this, _lootTable);
	}, "overrideArguments");
});