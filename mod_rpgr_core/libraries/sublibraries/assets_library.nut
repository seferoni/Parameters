local Core = ::RPGR_Core;
Core.Assets <-
{
	function get( _classAttribute, _getPercentage = false )
	{
		if (_getPercentage)
		{
			return Core.Standard.getPercentageSetting(_classAttribute);
		}

		return Core.Standard.getSetting(_classAttribute);
	}

	function getViableBrothers()
	{
		local candidates = [],
		roster = ::World.getPlayerRoster().getAll();

		foreach( brother in roster )
		{
			if (Core.Standard.getFlag("IsPlayerCharacter", brother))
			{
				continue;
			}

			candidates.push(brother);
		}

		return candidates;
	}

	function initialiseSettlementParameters( _settlementModifiers )
	{
		foreach( key, value in Core.Defaults.Settlements )
		{
			_settlementModifiers[key] = this.get(key, true);
		}
	}

	function initialiseWorldParameters( _worldObject )
	{
		foreach( key, value in Core.Defaults.World )
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

		local newLoot = [],
		skipCurrent = @() ::Math.rand(1, 100) > removalChance;

		foreach( item in _lootArray )
		{
			if (!this.isItemViable(item))
			{
				continue;
			}

			if (skipCurrent())
			{
				continue;
			}

			newLoot.push(item);
		}

		::Tactical.CombatResultLoot.assign(newLoot);
		::Tactical.CombatResultLoot.sort();
	}

	function setRosterSize()
	{
		local targetSize = this.get("RosterSize"),
		setSize = @() ::World.Assets.m.BrothersMax = targetSize,
		roster = ::World.getPlayerRoster();

		if (roster.getSize() <= targetSize)
		{
			setSize();
			return;
		}

		local brothers = this.getViableBrothers();

		while (roster.getSize() > targetSize)
		{
			roster.remove(brothers[::Math.rand(0, brothers.len() - 1)])
		}

		setSize();
	}

	function setStashSize()
	{
		::World.Assets.getStash().resize(this.get("StashSize"));
	}
}