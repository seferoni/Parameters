::Parameters.Mapper <-
{	// TODO: disable stone pillars/KrakenCult by hooking into 'build_unique_locations_action'
	// then distribute the reward into random beasts OR perhaps a lair
	// TODO: fix for discovered beasts not despawning
	// TODO: also incorporate relation decay and gain, business rep mult, etc
	// TODO: could do with a roster offset instead?
	function get( _classAttribute, _getPercentage = false )
	{
		if (_getPercentage)
		{
			return ::Parameters.Standard.getNormalisedParameter(_classAttribute);
		}

		return ::Parameters.Standard.getParameter(_classAttribute);
	}

	function initialiseSettlementParameters( _settlementModifiers )
	{
		foreach( key in ::Parameters.Database.getSettlementKeys() )
		{
			_settlementModifiers[key] = this.get(key, true);
		}
	}

	function initialiseWorldParameters( _worldObject )
	{
		foreach( key in ::Parameters.Database.getWorldKeys() )
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
			if (!::Parameters.Mapper.isItemViableForRemoval(item))
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

	function setStashSize()
	{
		::World.Assets.getStash().resize(this.get("StashSize"));
	}
};