::PRM.Patcher.hook("scripts/factions/actions/build_unique_locations_action", function( p )
{
	::PRM.Patcher.wrap(p, "updateBuildings", function()
	{
		if (!::PRM.Mapper.mapToDatabase("DisableKraken"))
		{
			return;
		}

		this.m.BuildKrakenCult = false;
	});

	::PRM.Patcher.wrap(p, "onExecute", function( _faction )
	{
		if (!this.m.BuildKrakenCult)
		{
			return;
		}

		::PRM.Utilities.setKrakenBuiltState(true);
	});
});