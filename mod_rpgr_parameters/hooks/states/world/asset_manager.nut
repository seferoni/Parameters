::Parameters.Patcher.hookBase("scripts/states/world/asset_manager", function( p )
{
	::Parameters.Patcher.wrap(p, "setCampaignSettings", function( _settings )
	{
		::Parameters.Mapper.initialiseWorldParameters(this);
	});

	::Parameters.Patcher.wrap(p, "resetToDefaults", function()
	{
		::Parameters.Mapper.initialiseWorldParameters(this);
	});
});