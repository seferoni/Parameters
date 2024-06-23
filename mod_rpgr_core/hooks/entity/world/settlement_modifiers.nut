::Core.Patcher.hookBase("entity/world/settlement_modifiers", function(p)
{
	::Core.Patcher.wrapBase(p, "create", function()
	{
		::Core.Classes.Assets.initialiseSettlementParameters(this);
	});

	::Core.Patcher.wrapBase(p, "reset", function()
	{
		::Core.Classes.Assets.initialiseSettlementParameters(this);
	});
});