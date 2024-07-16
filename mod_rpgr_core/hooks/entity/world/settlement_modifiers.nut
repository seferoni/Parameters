::Core.Patcher.hookBase("scripts/entity/world/settlement_modifiers", function(p)
{
	::Core.Patcher.wrap(p, "create", function()
	{
		::Core.Classes.Assets.initialiseSettlementParameters(this);
	});

	::Core.Patcher.wrap(p, "reset", function()
	{
		::Core.Classes.Assets.initialiseSettlementParameters(this);
	});
});