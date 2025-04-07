::Parameters.Utilities <-
{
	function constrainFormation()
	{
		if (!this.get("ConstrainRoster"))
		{
			return;
		}

		local roster = ::World.getPlayerRoster();
		local targetSize = this.get("MaximumBrothersInCombat");

		if (roster.getSize() < targetSize)
		{
			::World.Assets.m.BrothersMax = targetSize;
			return;
		}

		local brothersInFormation = [];
		local filledReserveSlots = [];

		foreach( brother in roster.getAll() )
		{
			local formationSlot = brother.getPlaceInFormation();

			if (!this.isReserveSlot(formationSlot))
			{
				brothersInFormation.push(brother);
				continue;
			}

			filledReserveSlots.push(formationSlot);
		}

		if (brothersInFormation.len() <= targetSize)
		{
			::World.Assets.m.BrothersMaxInCombat = targetSize;
			return;
		}

		local eligibleSlots = ::Parameters.Standard.createInclusiveLinearSequence(17, 27);
		::Parameters.Standard.removeFromArray(filledReserveSlots, eligibleSlots);

		for( local i = 0; i < brothersInFormation.len() - targetSize; i++ )
		{
			brothersInFormation[i].setPlaceInFormation(eligibleSlots[i]);
		}

		::World.Assets.m.BrothersMaxInCombat = targetSize;
	}

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

	function getViableBrothersForRemoval()
	{
		local candidates = [];
		local roster = ::World.getPlayerRoster().getAll();

		foreach( brother in roster )
		{
			if (::Parameters.Standard.getFlag("IsPlayerCharacter", brother))
			{
				continue;
			}

			candidates.push(brother);
		}

		return candidates;
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

	function isItemViableForRemoval( _item )
	{
		if (_item.isItemType(::Const.Items.ItemType.Legendary))
		{
			return false;
		}

		if (_item.m.ItemType == ::Const.Items.ItemType.Misc)
		{
			return false;
		}

		if (_item.getID() == "weapon.player_banner")
		{
			return false;
		}

		return true;
	}

	function isReserveSlot( _formationSlot )
	{
		return _formationSlot >= 17;
	}

	function removeLoot( _lootArray )
	{
		if (_lootArray == null || _lootArray.len() == 0)
		{
			return;
		}

		local removalChance = this.get("LootRemovalChance");

		if (removalChance == 0)
		{
			return;
		}

		local newLoot = _lootArray.filter(function(_index, _item)
		{
			if (!::Parameters.Utilities.isItemViableForRemoval(_item))
			{
				return true;
			}

			if (::Math.rand(1, 100) > removalChance)
			{
				return true;
			}

			return false;
		});

		::Tactical.CombatResultLoot.assign(newLoot);
		::Tactical.CombatResultLoot.sort();
	}

	function setRosterSize()
	{
		if (!this.get("ConstrainRoster"))
		{
			return;
		}

		local roster = ::World.getPlayerRoster();
		local targetSize = this.get("RosterSize");

		if (roster.getSize() <= targetSize)
		{
			::World.Assets.m.BrothersMax = targetSize;
			return;
		}

		local viableBrothers = this.getViableBrothersForRemoval();

		if (viableBrothers.len() < roster.getSize() - targetSize)
		{
			::World.Assets.m.BrothersMax = roster.getSize();
			return;
		}

		while (roster.getSize() > targetSize)
		{
			roster.remove(viableBrothers[::Math.rand(0, viableBrothers.len() - 1)])
		}

		::World.Assets.m.BrothersMax = targetSize;
	}

	function setStashSize()
	{
		::World.Assets.getStash().resize(this.get("StashSize"));
	}
};