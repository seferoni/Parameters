local Core = ::RPGR_Core;
Core.Entities <-
{
	Descriptors =
	{
		Stout = 0,
		Strong = 0,
		Mighty = 0,
		Legendary = 0
	},
	Factions =
	{
		Bandits =
		{
			StrengthThreshold = 25,
			AttributeExchangeChance = 25,
			EquipmentExchangeChance = 50,
			PerkExchangeChance = 25
		},
		Barbarians =
		{
			StrengthThreshold = 35,
			AttributeExchangeChance = 40,
			EquipmentExchangeChance = 20,
			PerkExchangeChance = 40
		},
		OrientalBandits =
		{
			StrengthThreshold = 30,
			AttributeExchangeChance = 25,
			EquipmentExchangeChance = 25,
			PerkExchangeChance = 50
		},
		OrientalCityState = 
		{	// TODO: plc
			StrengthThreshold = 30,
			AttributeExchangeChance = 25,
			EquipmentExchangeChance = 25,
			PerkExchangeChance = 50
		},
		NobleHouse =
		{
			StrengthThreshold = 30,
			AttributeExchangeChance = 60,
			EquipmentExchangeChance = 20,
			PerkExchangeChance = 20
		}
	},
	Outlets =
	[
		"Attributes",
		"Equipment",
		"Perks"
	],
	Parameters =
	{
		TokenAllocationPrefactor = 0.5,
		TokenExchangeFloor = 20
	}

	function buyAttributes( _entityObject, _combatStyle, _factionName, _allocatedTokens )
	{
		// TODO:
	}

	function buyEquipment( _entityObject, _combatStyle, _factionName, _allocatedTokens )
	{
		::logInfo("buying stuff with tokens " + _allocatedTokens)
		local expenditure = 0,
		strength = _entityObject.getWorldTroop().Strength,
		isViable = function(_index, _itemTable)
		{
			if (_itemTable.Cost > _allocatedTokens)
			{
				return false;
			}

			if (_itemTable.Strength.Minimum > strength)
			{
				return false;
			}

			if (_itemTable.Strength.Maximum < strength)
			{
				return false;
			}

			return true;
		},
		equipment = Core.Config.Entities.Equipment[_factionName][_combatStyle];

		foreach( itemGroup in equipment )
		{
			local viableGroups = itemGroup.filter(isViable);

			if (viableGroups.len() == 0)
			{
				::logInfo("found no viable groups")
				continue;
			}

			local chosenGroup = viableGroups[0];
			::logInfo("found with cost " + chosenGroup.Cost + "!");
			this.equip(_entityObject, chosenGroup);
			expenditure += chosenGroup.Cost;
		}

		return expenditure;
	}

	function buyPerks( _entityObject, _combatStyle, _factionName, _allocatedTokens )
	{
		// TODO:
	}

	function disburseTokens( _entityObject )
	{
		# At this point in the process flow, this can be safely considered non-null.
		local worldTroop = _entityObject.getWorldTroop();

		# Get total token pool assigned during party spawn.
		local tokens = Core.Standard.getFlag("Tokens", worldTroop.Party);

		if (!tokens)
		{
			return;
		}

		# This variable acquires the name of the entity's faction through ::Const.Faction, rather than through ::Const.FactionTypes.
		local factionName = Core.Troops.getFactionNameFromType(this.getFactionType(_entityObject));

		# This gauges the combat style of the entity based on the weapons currently equipped.
		local combatStyle = this.getCombatStyle(_entityObject);

		# Get token allowance for this particular entity, with respect to the other constituents within the party.
		local allocatedTokens = this.getAllocatedTokens(worldTroop, factionName, tokens);

		this.exchange(_entityObject, combatStyle, factionName, allocatedTokens)
	}

	function equip( _entityObject, _itemTable )
	{
		# Get item container from actor.
		local equippedItems = _entityObject.getItems();

		# Create item by concatenating directory path with random script name.
		local newItem = ::new(format("%s%s", _itemTable.Path, _itemTable.Scripts[::Math.rand(0, _itemTable.Scripts.len() - 1)]));

		# Unequip item corresponding to newly created item's slot type.
		equippedItems.unequip(equippedItems.getItemAtSlot(newItem.getSlotType()))
		::logInfo("equipping " + item.getName())
		# Equip item.
		equippedItems.equip(item);
	}

	function exchange( _entityObject, _combatStyle, _factionName, _allocatedTokens, _outletsArray = null )
	{
		::logInfo("token wallet has " + _allocatedTokens);
		::logInfo(_outletsArray == null ? "outlets array is null" : "outletsArray has length " + _outletsArray.len());
		local outlets = _outletsArray == null ? this.getOutlets(_entityObject) : _outletsArray;
		_allocatedTokens -= this[format("buy%s", this.rollForOutlet(_factionName, outlets))](_entityObject, _combatStyle, _factionName, _allocatedTokens);

		if (_allocatedTokens < this.Parameters.TokenExchangeFloor || outlets.len() == 0)
		{
			return;
		}

		this.exchange(_entityObject, _combatStyle, _factionName, _allocatedTokens, outlets);
	}

	function getAllocatedTokens( _troopTable, _factionName, _totalTokens )
	{
		local count = _troopTable.Party.getTroops().len(),
		threshold = this.Factions[_factionName].StrengthThreshold,
		allocatedTokens = ::Math.ceil(_totalTokens / count);

		# This presumes weaker troops always remain present within the party to benefit from the remaining tokens.
		if (_troopTable.Strength >= threshold)
		{
			allocatedTokens = ::Math.ceil(allocatedTokens * this.Parameters.TokenAllocationPrefactor);
		}

		return allocatedTokens;
	}

	function getCombatStyle( _entityObject )
	{
		local weapon = _entityObject.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);

		if (weapon == null)
		{
			return "Melee";
		}

		if (weapon.isItemType(::Const.Items.ItemType.MeleeWeapon))
		{
			return "Melee";
		}

		if (weapon.isItemType(::Const.Items.ItemType.RangedWeapon))
		{
			return "Ranged";
		}

		return null;
	}

	function getFactionType( _entityObject )
	{
		local factionType = ::World.FactionManager.getFaction(_entityObject.getFaction()).getType();
		return factionType;
	}

	function getOutlets( _entityObject )
	{
		local outlets = clone this.Outlets;

		if (!::isKindOf(_entityObject, "human"))
		{
			outlets.remove(outlets.find("Equipment"));
		}

		return outlets;
	}

	function isPartyViable( _partyObject )
	{
		return Core.Standard.getFlag("Tokens", _partyObject) != false;
	}

	function rollForOutlet( _factionName, _outletsArray )
	{
		local chosenOutlet = null;

		foreach( outlet in _outletsArray )
		{
			local chance = this.Factions[_factionName][format("%sExchangeChance", outlet)];

			if (::Math.rand(1, 100) <= chance)
			{
				chosenOutlet = outlet;
			}
		}

		if (chosenOutlet == null)
		{
			chosenOutlet = _outletsArray[::Math.rand(0, _outletsArray.len() - 1)];
		}

		_outletsArray.remove(_outletsArray.find(chosenOutlet));
		return chosenOutlet;
	}

	function setName( _entityObject, _allocatedTokens )
	{

	}
};