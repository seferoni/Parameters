::Parameters.Patcher.hook("scripts/factions/actions/send_beast_roamers_action", function( p )
{
	::Parameters.Patcher.wrap(p, "onUpdate", function( _faction )
	{
		if (!::Parameters.Mapper.get("FixBeastSpawns"))
		{
			return;
		}

		::Parameters.Utilities.despawnDiscoveredBeasts(_faction.getUnits());
	});
});