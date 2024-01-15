local Core = ::RPGR_Core;
::mods_hookNewObject("states/world/asset_manager", function( _object )
{
	Core.Standard.wrapRoot(_object, "setCampaignSettings", function( _settings )
	{
		Core.Assets.initialiseWorldParameters(this);
	});

	Core.Standard.wrapRoot(_object, "resetToDefaults", function()
	{
		Core.Assets.initialiseWorldParameters(this);
	});
});

