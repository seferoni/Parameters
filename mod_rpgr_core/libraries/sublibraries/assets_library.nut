Core = ::RPGR_Core;
Core.Assets <-
{	// TODO: stash size should be configurable
	// TODO: roster size config
	function get( _classAttribute )
	{
		return Core.Standard.getSetting(_classAttribute);
	}

	function initialiseSettlementParameters( _settlementObject )
	{
		foreach( key, value in Core.Defaults.Settlements )
		{
			_settlementObject.m[key] = this.get(key);
		}
	}

	function initialiseWorldParameters( _worldObject )
	{
		foreach( key, value in Core.Defaults.World )
		{
			_worldObject.m[key] = this.get(key);
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

		if (removalChance == 100)
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
}