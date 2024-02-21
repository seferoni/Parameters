Core = ::RPGR_Core;
Core.Assets <-
{	// TODO: stash size should be configurable
	Parameters =
	{
		CombatLootChance = 60
	},
	Settlements =
	{
		BeastPartsPriceMult = 1.5,
		BuyPriceMult = 2.3,
		SellPriceMult = 1.2,
		RecruitsMult = 0.2,
	},
	World =
	{
		ContractPaymentMult = 0.7,
		DailyWageMult = 1.6,
		FoodConsumptionMult = 1.4,
		RepairSpeedMult = 0.3,
		XPMult = 0.4
	}

	function get( _classAttribute )
	{	// TODO
		if (_classAttribute in this.World)
		{
			return this.World[_classAttribute];
		}

		if (_classAttribute in this.Settlements)
		{
			return this.Settlements[_classAttribute];
		}

		return this.Parameters[_classAttribute];
	}

	function initialiseSettlementParameters( _settlementObject )
	{
		foreach( key, value in this.Settlements )
		{
			_settlementObject.m[key] = this.get(key);
		}
	}

	function initialiseWorldParameters( _worldObject )
	{
		foreach( key, value in this.World )
		{
			_worldObject.m[key] = this.get(key);
		}
	}

	function removeLoot( _lootArray )
	{
		local retentionChance = this.getCombatLootChance(),
		newLoot = _lootArray.filter(@(_index, _item) ::Math.rand(1, 100) > retentionChance);
		::Tactical.CombatResultLoot.assign(newLoot);
		::Tactical.CombatResultLoot.sort();
	}
}