::PRM.Patcher.hookBase("scripts/factions/faction", function( p )
{
	::PRM.Patcher.wrap(p, "spawnEntity", function( _tile, _name, _uniqueName, _template, _resources, _minibossify = 0 )
	{
		local resourcesScalar = ::PRM.Mapper.mapToDatabase("PartyResourcesMult", true);

		if (::Math.rand(1, 100) > ::PRM.Mapper.mapToDatabase("EntityScaleChance"))
		{
			resourcesScalar = 1.0;
		}

		return [_tile, _name, _uniqueName, _template, _resources * resourcesScalar, _minibossify];
	}, "overrideArguments");

	::PRM.Patcher.wrap(p, "addPlayerRelationEx", function( _r, _reason = "" )
	{
		local relationScalar = ::PRM.Mapper.mapToDatabase(_r > 0 ? "RelationChangeGoodMult" : "RelationChangeBadMult", true);
		return [_r * relationScalar, _reason];
	}, "overrideArguments");
});