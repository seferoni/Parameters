::PRM.Patcher.hook("scripts/factions/actions/send_beast_roamers_action", function( p )
{
	::PRM.Patcher.wrap(p, "onUpdate", function( _faction )
	{
		if (!::PRM.Mapper.mapToDatabase("FixBeastSpawns"))
		{
			return;
		}

		::PRM.Spawner.despawnDiscoveredBeasts(_faction.getUnits());
	});
});