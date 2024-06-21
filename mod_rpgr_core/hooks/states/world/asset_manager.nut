::Core.Patcher.hookBase("states/world/asset_manager", function( _object )
{
	::Core.Patcher.wrapBase(_object, "setCampaignSettings", function( _settings )
	{
		::Core.Assets.initialiseWorldParameters(this);
	});

	::Core.Patcher.wrapBase(_object, "resetToDefaults", function()
	{
		::Core.Assets.initialiseWorldParameters(this);
	});
});