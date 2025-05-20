::PRM.Patcher.hookBase("scripts/entity/world/settlement_modifiers", function( p )
{
	::PRM.Patcher.wrap(p, "create", function()
	{
		::PRM.Mapper.mapToSettlementParameters(this);
	});

	::PRM.Patcher.wrap(p, "reset", function()
	{
		::PRM.Mapper.mapToSettlementParameters(this);
	});
});