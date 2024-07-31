::Core.Classes.Integrator <-
{	// TODO: difficulty mults for faction action stuff
	function get( _classAttribute, _getPercentage = false )
	{
		if (_getPercentage)
		{
			return ::Core.Standard.getNormalisedParameter(_classAttribute);
		}

		return ::Core.Standard.getParameter(_classAttribute);
	}

	function getViableBrothers()
	{	// TODO: this might cause an infinite loop when roster is culled
		local candidates = [],
		roster = ::World.getPlayerRoster().getAll();

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

	function setRosterSize()
	{	// TODO: this is vulnerable
		local targetSize = this.get("RosterSize");

		if (targetSize == 0)
		{
			return;
		}

		local roster = ::World.getPlayerRoster();

		if (roster.getSize() <= targetSize)
		{
			::World.Assets.m.BrothersMax = targetSize;
			return;
		}

		local brothers = this.getViableBrothers();

		while (roster.getSize() > targetSize)
		{
			roster.remove(brothers[::Math.rand(0, brothers.len() - 1)])
		}

		::World.Assets.m.BrothersMax = targetSize;
	}

	function setStashSize()
	{
		::World.Assets.getStash().resize(this.get("StashSize"));
	}
};