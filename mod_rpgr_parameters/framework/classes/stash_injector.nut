::PRM.StashInjector <-
{
	function getReproachBladeInjectedState()
	{
		return ::PRM.Standard.getFlag("ReproachBladeInjected", ::World.Statistics);
	}

	function injectReproachBladeIntoStash( _locationObject, _lootTable )
	{	// TODO: need to hook into the reproach blade, replace its description
		local injectionChance = 0;
		local locationID = _locationObject.getTypeID();
		local eligibleTypes = ::PRM.Utilities.getCommonField("LegendaryBladeEligibleLocations");

		foreach( key, dataTable in eligibleTypes )
		{
			if (locationID != dataTable.TypeID)
			{
				continue;
			}

			injectionChance += dataTable.Chance;
			break;
		}

		if (injectionChance == 0)
		{
			::logInfo("location not eligible!") // TODO: remove when done
			return;
		}

		if (::Math.rand(1, 100) > injectionChance)
		{
			::logInfo("rolled above chance!")
			return;
		}

		::logInfo("injecting sword blade")
		_lootTable.push(::new("scripts/items/special/legendary_sword_blade_item"));
		this.setReproachBladeInjectedState(true);
	}

	function isItemViableForRemoval( _item )
	{	// TODO: not comprehensive. this is removing the reproach blade
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

		::logInfo(_item.getID() + " is viable for removal")
		return true;
	}

	function removeLoot( _lootArray )
	{
		if (_lootArray == null || _lootArray.len() == 0)
		{
			return;
		}

		local removalChance = ::PRM.Mapper.mapToDatabase("LootRemovalChance");

		if (removalChance == 0)
		{
			return;
		}

		local newLoot = _lootArray.filter(function(_index, _item)
		{
			if (!::PRM.StashInjector.isItemViableForRemoval(_item))
			{
				return true;
			}

			if (::Math.rand(1, 100) > removalChance)
			{
				return true;
			}

			::logInfo("removed " + _item.getID())
			return false;
		});

		::Tactical.CombatResultLoot.assign(newLoot);
		::Tactical.CombatResultLoot.sort();
	}

	function setReproachBladeInjectedState( _newValue = true )
	{
		::PRM.Standard.setFlag("ReproachBladeInjected", _newValue, ::World.Statistics);
	}
};