::Parameters.Patcher.hook("scripts/entity/world/location", function( p )
{
	::Parameters.Patcher.wrap(p, "dropTreasure", function( _num, _items, _lootTable )
	{
		if (::Parameters.StashInjector.getReproachBladeInjectionState())
		{
			return;
		}

		::Parameters.StashInjector.injectReproachBladeIntoStash(this, _lootTable);
	}, "overrideArguments");
});