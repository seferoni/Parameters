::Parameters.Patcher.hookBase("scripts/entity/world/settlement_modifiers", function( p )
{
	::Parameters.Patcher.wrap(p, "create", function()
	{
		::Parameters.Mapper.initialiseSettlementParameters(this);
	});

	::Parameters.Patcher.wrap(p, "reset", function()
	{
		::Parameters.Mapper.initialiseSettlementParameters(this);
	});
});