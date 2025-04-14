::PRM.Patcher.hookBase("scripts/factions/faction", function( p )
{
	::PRM.Patcher.wrap(p, "spawnEntity", function( _tile, _name, _uniqueName, _template, _resources, _minibossify = 0 )
	{
		local resourcesScalar = ::PRM.Mapper.mapToDatabase("PartyResourcesMult", true);
		return [_tile, _name, _uniqueName, _template, _resources * resourcesScalar, _minibossify];
	}, "overrideArguments");
});