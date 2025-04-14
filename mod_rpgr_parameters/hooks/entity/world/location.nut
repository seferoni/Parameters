::PRM.Patcher.hook("scripts/entity/world/location", function( p )
{
	::PRM.Patcher.wrap(p, "onSpawned", function()
	{	// TODO: requires testing
		if (!::PRM.LocationHandler.isLocationViableForScaling(this))
		{
			return;
		}

		local scalar = ::PRM.Mapper.mapToDatabase("LocationResourcesMult");
		this.m.Resources = ::Math.floor(this.m.Resources * scalar);
	}, "overrideArguments");

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