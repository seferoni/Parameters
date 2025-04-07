::Parameters.Utilities <-
{
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
			if (!::Parameters.Utilities.isItemViableForRemoval(item))
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