::PRM.WorldSpawner <-
{
	function despawnDiscoveredBeasts( _entityArray )
	{
		foreach( entity in _entityArray )
		{
			if (entity == null || !entity.isAlive())
			{
				continue;
			}

			if (!this.isPartyViableForDespawn(entity))
			{
				continue;
			}

			entity.die();
		}
	}

	function isPartyViableForDespawn( _entityObject )
	{
		# Simple safeguard to prevent contract targets from being despawned.
		if (::World.Contracts.getActiveContract() != null)
		{
			return false;
		}

		# Approximates vanilla procedures.
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
		local playerParty = ::World.State.getPlayer();

		if (playerParty != null && playerParty.getTile().getDistanceTo(_entityObject.getTile()) < maximumDistance)
		{
			return false;
		}

		return true;
	}
};