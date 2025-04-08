::PRM.Spawner <-
{
	function despawnDiscoveredBeasts( _entityArray )
	{
		foreach( entity in _entityArray )
		{
			if (!this.isBeastViableForDespawn(entity))
			{
				continue;
			}

			entity.die();
		}
	}

	function isBeastViableForDespawn( _entityObject )
	{	# Approximates vanilla procedures.
		if (!_entityObject.isDiscovered())
		{
			return false;
		}

		local maximumLifetime = 20.0 * ::World.getTime().SecondsPerDay;

		if (::Time.getVirtualTimeF() - _entityObject.getSpawnTime() < maximumLifetime)
		{
			return false;
		}

		local maximumDistance = 8;
		local player = ::World.State.getPlayer();

		if (player != null && player.getTile().getDistanceTo(_entityObject.getTile()) < maximumDistance)
		{
			return false;
		}

		return true;
	}
};