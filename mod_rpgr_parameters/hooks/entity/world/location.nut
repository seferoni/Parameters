::PRM.Patcher.hook("scripts/entity/world/location", function( p )
{
	::PRM.Patcher.wrap(p, "onSpawned", function()
	{
		if (!::PRM.LocationHandler.isLocationViableForScaling(this))
		{
			return;
		}

		local scalar = ::PRM.Mapper.mapToDatabase("LocationResourcesMult", true);
		this.m.Resources = ::Math.floor(this.m.Resources * scalar);
	}, "overrideArguments");

	::PRM.Patcher.wrap(p, "dropTreasure", function( _num, _items, _lootTable )
	{
		if (!::Const.DLC.Unhold)
		{
			return;
		}

		if (::PRM.Utilities.getKrakenBuiltState())
		{
			return;
		}

		if (::PRM.StashHandler.getReproachBladeInjectedState())
		{
			return;
		}

		::PRM.StashHandler.injectReproachBladeIntoStash(this, _lootTable);
	}, "overrideArguments");
});