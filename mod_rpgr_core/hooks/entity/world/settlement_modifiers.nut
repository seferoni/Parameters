::Core.Patcher.hook("entity/world/settlement_modifiers", function( _object )
{
	::Core.Patcher.wrapBase(_object, "create", function()
	{
		::Core.Assets.initialiseSettlementParameters(this);
	}),

	::Core.Patcher.wrapBase(_object, "reset", function()
	{
		::Core.Assets.initialiseSettlementParameters(this);
	})
});