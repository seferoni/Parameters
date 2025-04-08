::PRM.StashInjector <-
{
	function getReproachBladeInjectedState()
	{
		return ::PRM.Standard.getFlag("ReproachBladeInjected", ::World.Statistics);
	}

	function injectReproachBladeIntoStash( _locationObject, _lootTable )
	{
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

	function isItemViableForRemoval( _itemObject )
	{
		local removalParameters = ::PRM.Utilities.getField("ItemRemovalParameters");

		foreach( itemType in removalParameters.ForbiddenTypesInclusive )
		{
			if (_itemObject.isItemType(itemType))
			{
				return false;
			}
		}

		foreach( itemType in removalParameters.ForbiddenTypesExclusive )
		{
			if (_itemObject.m.ItemType == itemType)
			{
				return false;
			}
		}

		foreach( itemID in removalParameters.ForbiddenItemIDs )
		{
			if (_itemObject.getID() == itemID)
			{
				return false;
			}
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