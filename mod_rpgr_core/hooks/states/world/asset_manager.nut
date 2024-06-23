::Core.Patcher.hookBase("states/world/asset_manager", function(p)
{
	::Core.Patcher.wrapBase(p, "setCampaignSettings", function( _settings )
	{
		::Core.Classes.Assets.initialiseWorldParameters(this);
	});

	::Core.Patcher.wrapBase(p, "resetToDefaults", function()
	{
		::Core.Classes.Assets.initialiseWorldParameters(this);
	});
});