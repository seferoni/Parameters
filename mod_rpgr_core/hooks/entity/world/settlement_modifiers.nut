::Core.Patcher.hookBase("scripts/entity/world/settlement_modifiers", function( p )
{
	::Core.Patcher.wrap(p, "create", function()
	{
		::Core.Mapper.initialiseSettlementParameters(this);
	});

	::Core.Patcher.wrap(p, "reset", function()
	{
		::Core.Mapper.initialiseSettlementParameters(this);
	});
});