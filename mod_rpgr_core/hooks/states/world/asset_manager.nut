::Core.Patcher.hookBase("scripts/states/world/asset_manager", function( p )
{
	::Core.Patcher.wrap(p, "setCampaignSettings", function( _settings )
	{
		::Core.Mapper.initialiseWorldParameters(this);
	});

	::Core.Patcher.wrap(p, "resetToDefaults", function()
	{
		::Core.Mapper.initialiseWorldParameters(this);
	});
});