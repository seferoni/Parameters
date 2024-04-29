::mods_hookNewObject("states/world/asset_manager", function( _object )
{
	::Core.Standard.wrapBase(_object, "setCampaignSettings", function( _settings )
	{
		::Core.Assets.initialiseWorldParameters(this);
	});

	::Core.Standard.wrapBase(_object, "resetToDefaults", function()
	{
		::Core.Assets.initialiseWorldParameters(this);
	});
});

