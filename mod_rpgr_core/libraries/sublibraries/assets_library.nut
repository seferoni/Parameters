Core = ::RPGR_Core;
Core.Assets <-
{
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

		local attributeValue = Core.Standard.getSetting(_classAttribute);

		if (attributeValue == null)
		{
			attributeValue = this.Parameters[_classAttribute];
		}

		return attributeValue;
	}

	function getBeastPartsPriceMult()
	{
		return this.Settlement.BeastPartsPriceMult;
	}

	function getBuyPriceMult()
	{
		return this.Settlements.BuyPriceMult;
	}

	function getCombatLootChance()
	{
		Core.Standard.getSetting()
	}

	function getContractPaymentMult()
	{
		return this.World.ContractPayMult;
	}

	function getDailyWageMult()
	{
		return this.World.DailyWageMult;
	}

	function getFoodConsumptionMult()
	{
		return this.World.FoodConsumptionMult;
	}

	function getRecruitsMult()
	{
		return this.Settlements.RecruitsMult;
	}

	function getRepairSpeedMult()
	{
		return this.World.RepairSpeedMult;
	}

	function getSellPriceMult()
	{
		return this.Settlements.SellPriceMult;
	}

	function getXPMult()
	{
		return this.World.XPMult;
	}

	function initialiseSettlementParameters( _settlementObject )
	{
		foreach( key, value in this.Settlements )
		{
			_settlementObject.m[key] = this[format("get%s", key)()];
		}
	}

	function initialiseWorldParameters( _worldObject )
	{
		foreach( key, value in this.World )
		{
			_worldObject.m[key] = this[format("get%s", key)()];
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