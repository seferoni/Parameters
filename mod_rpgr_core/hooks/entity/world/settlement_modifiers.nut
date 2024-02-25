local Core = ::RPGR_Core;
::mods_hookNewObject("entity/world/settlement_modifiers", function( _object )
{
	Core.Standard.wrapBase(_object, "create", function()
	{
		Core.Assets.initialiseSettlementParameters(this);
	});

	Core.Standard.wrapBase(_object, "reset", function()
	{
		Core.Assets.initialiseSettlementParameters(this);
	});
});