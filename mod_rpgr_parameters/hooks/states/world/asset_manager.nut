::PRM.Patcher.hookBase("scripts/states/world/asset_manager", function( p )
{
	::PRM.Patcher.wrap(p, "setCampaignSettings", function( _settings )
	{
		::PRM.Mapper.initialiseWorldParameters(this);
	});

	::PRM.Patcher.wrap(p, "resetToDefaults", function()
	{
		::PRM.Mapper.initialiseWorldParameters(this);
	});
});