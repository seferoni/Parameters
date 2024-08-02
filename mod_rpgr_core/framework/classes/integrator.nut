::Core.Classes.Integrator <-
{
	function get( _classAttribute, _getPercentage = false )
	{
		if (_getPercentage)
		{
			return ::Core.Standard.getNormalisedParameter(_classAttribute);
		}

		return ::Core.Standard.getParameter(_classAttribute);
	}

	function getViableBrothers()
	{
		local candidates = [];
		local roster = ::World.getPlayerRoster().getAll();

		foreach( brother in roster )
		{
			if (::Core.Standard.getFlag("IsPlayerCharacter", brother))
			{
				continue;
			}

			candidates.push(brother);
		}

		return candidates;
	}

	function initialiseSettlementParameters( _settlementModifiers )
	{
		foreach( key in ::Core.Database.getSettlementKeys() )
		{
			_settlementModifiers[key] = this.get(key, true);
		}
	}

	function initialiseWorldParameters( _worldObject )
	{
		foreach( key in ::Core.Database.getWorldKeys() )
		{
			_worldObject.m[key] = this.get(key, true);
		}
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
		local removalChance = this.get("LootRemovalChance");

		if (removalChance == 0)
		{
			return;
		}

		local newLoot = _lootArray.filter(function(_index, _item)
		{
			if (!::Core.Classes.Integrator.isItemViableForRemoval(item))
			{
				return false;
			}

			if (::Math.rand(1, 100) > removalChance)
			{
				return false;
			}

			return true;
		});

		::Tactical.CombatResultLoot.assign(newLoot);
		::Tactical.CombatResultLoot.sort();
	}

	function setFormationSize()
	{
		if (!this.get("ConstrainRoster"))
		{
			return;
		}

		local roster = ::World.getPlayerRoster();
		local targetSize = this.get("MaximumBrothersInCombat");

		if (roster.getSize() < formationSize)
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

		local eligibleSlots = ::Core.Standard.createInclusiveLinearSequence(17, 27);
		::Core.Standard.removeFromArray(filledReserveSlots, eligibleSlots);

		for( local i = 0; i < brothersInFormation.len() - formationSize; i++ )
		{
			brothersInFormation[i].setPlaceInFormation(eligibleSlots[i]);
		}

		::World.Assets.m.BrothersMaxInCombat = formationSize;
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

		local viableBrothers = this.getViableBrothers();

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