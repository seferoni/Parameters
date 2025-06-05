::PRM.Patcher.hookBase("scripts/states/world/asset_manager", function( p )
{
	::PRM.Patcher.wrap(p, "setCampaignSettings", function( _settings )
	{
		::PRM.Mapper.mapToWorldParameters(this);
	});

	::PRM.Patcher.wrap(p, "resetToDefaults", function()
	{
		::PRM.Mapper.mapToWorldParameters(this);
	});

	::PRM.Patcher.wrap(p, "addBusinessReputation", function( _f )
	{
		local reputationScalar = ::PRM.Mapper.mapToDatabase(_f > 0 ? "BusinessReputationGoodRate" : "BusinessReputationBadRate", true);
		return [_f * reputationScalar];
	}, "overrideArguments");
});