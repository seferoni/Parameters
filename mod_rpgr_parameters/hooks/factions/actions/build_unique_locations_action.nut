::Parameters.Patcher.hook("scripts/factions/actions/build_unique_locations_action", function( p )
{
	// TODO: don't forget to set appropriate flags. there's one for exploration.
	::Parameters.Patcher.wrap(p, "updateBuildings", function()
	{
		if (!::Parameters.Mapper.mapToDatabase("DisableKraken"))
		{
			return;
		}

		this.m.BuildKrakenCult = false;
	});
});