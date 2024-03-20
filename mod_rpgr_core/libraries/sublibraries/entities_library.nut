local Core = ::RPGR_Core;
Core.Entities <-
{
	Descriptors =
	{
		Stout = 20,
		Strong = 40,
		Mighty = 60,
		Legendary = 80
	},
	Factions =
	{
		Bandits =
		{
			Threshold = 25,
			AttributeExchangeChance = 25,
			EquipmentExchangeChancer = 50,
			PerkExchangeChance = 25
		},
		Barbarians =
		{
			Threshold = 35,
			AttributeExchangeChance = 40,
			EquipmentExchangeChance = 20,
			PerkExchangeChance = 40
		},
		OrientalBandits =
		{

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

	function exchange( _entityObject, _combatStyle, _factionName, _allocatedTokens, _outletsArray = null )
	{
		local outlets = _outletsArray == null ? clone this.Outlets : _outletsArray;
		_allocatedTokens -= this[format("buy%s", this.rollForOutlet(_factionName, outlets))](_entityObject, _combatStyle, _factionName, _allocatedTokens);

		if (_allocatedTokens < this.Parameters.TokenExchangeFloor || outlets.len() == 0)
		{
			return;
		}

		this.exchange(_entityObject, _combatStyle, _factionName, _allocatedTokens, outlets);
	}

	function buyAttributes( _entityObject, _combatStyle, _factionName, _allocatedTokens )
	{

	}

	function buyEquipment( _entityObject, _combatStyle, _factionName, _allocatedTokens )
	{	// remember that the earliest entry in the filtered array is also the strongest offering
		local strength = _entityObject.getWorldTroops().Strength,
		isViable = function(_index, _itemTable) // may want to move this to its own method
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
		equipment = Core.Config.Entities[_factionName];

		# Find all affordable headgear groups.
		local headgear = equipment.Head.filter(isViable);

		# Find all affordable armour groups.
		local armour = equipment.Armour.filter(isViable);
	}

	function buyPerks( _entityObject, _combatStyle, _factionName, _allocatedTokens )
	{

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
		local faction = this.getFactionNameFromEnum(worldTroop.Faction);

		# This gauges the combat style of the entity based on the weapons currently equipped.
		local combatStyle = this.getCombatStyle(_entityObject);

		# Get token allowance for this particular entity, with respect to the other constituents within the party.
		local allocatedTokens = this.getAllocatedTokens(worldTroop, faction, tokens);

		this.exchange(_entityObject, combatStyle, faction, allocatedTokens)
	}

	function getAllocatedTokens( _troopTable, _factionName, _totalTokens )
	{
		local count = _troopTable.Party.getTroops().len(),
		threshold = this.Thresholds[_factionName],
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
		local weapon = _entity.getItems().getItemAtSlot(::Const.ItemSlot.Mainhand);

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

	function getFactionNameFromEnum( _factionEnum )
	{
		foreach( factionName, factionEnum in ::Const.Faction )
		{
			if (factionEnum == _factionEnum)
			{
				return factionName;
			}
		}
	}

	function getFaction( _entityObject )
	{
		local worldTroop = _entityObject.getWorldTroop();
		return worldTroop.Faction;
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
};