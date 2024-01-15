local Core = ::RPGR_Core;
::mods_hookNewObject("entity/world/settlement_modifiers", function( _object )
{
	Core.Standard.wrapRoot(_object, "create", function()
	{
		Core.Assets.initialiseSettlementParameters(this);
	});

	Core.Standard.wrapRoot(_object, "reset", function()
	{
		Core.Assets.initialiseSettlementParameters(this);
	});
});