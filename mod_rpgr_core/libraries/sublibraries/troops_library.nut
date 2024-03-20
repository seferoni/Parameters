local Core = ::RPGR_Core;
Core.Troops <-
{
	Excluded =
	[
		::Const.EntityType.CaravanDonkey,
		::Const.EntityType.MilitaryDonkey,
		::Const.EntityType.Mortar
	],
	Parameters =
	{
		ConversionThresholdFloor = 2
	},
	Thresholds =
	{
		Bandits = 20,
		Barbarians = 25,
		OrientalBandits = 25
	}

	function assignTokens( _tokens, _partyObject )
	{
		::logInfo("got tokens " + _tokens + " for " + _partyObject.getName())
		Core.Standard.setFlag("Tokens", _tokens, _partyObject);
	}

	function compileLedger( _troopArray, _factionType )
	{
		local threshold = this.Thresholds[this.getFactionNameFromType(_factionType)],
		ledger =
		{
			Troops = [],
			Tokens = 0
		};

		foreach( troop in _troopArray )
		{
			if (this.Excluded.find(troop.ID))
			{
				continue;
			}
			
			if (troop.Cost <= threshold)
			{
				ledger.Troops.push(troop);
				ledger.Tokens += troop.Cost;
			}
		}

		return ledger;
	}

	function convertToTokens( _partyObject, _factionType )
	{
		local ledger = this.compileLedger(_partyObject.getTroops(), _factionType);

		if (ledger.Troops.len() < this.Parameters.ConversionThresholdFloor)
		{
			return;
		}

		this.assignTokens(ledger.Tokens, _partyObject);
		this.removeTroops(ledger.Troops, _partyObject);
	}

	function getFactionNameFromType( _factionType )
	{
		foreach( factionName, factionEnum in ::Const.FactionType )
		{
			if (factionEnum == _factionType)
			{
				return factionName;
			}
		}
	}

	function isFactionViable( _factionType )
	{
		local factionName = this.getFactionNameFromType(_factionType),
		viableFactions = Core.Standard.getKeys(this.Thresholds);

		if (viableFactions.find(factionName) != null)
		{
			return true;
		}

		return false;
	}

	function removeTroops( _culledTroops, _partyObject )
	{	// TODO: this needs some way to calculate count
		::logInfo("removing culledTroops for " + _partyObject.getName() + " at a count of " + _culledTroops.len())
		local targetTroops = _partyObject.getTroops();

		foreach( troop in _culledTroops )
		{
			local index = targetTroops.find(troop);

			if (index != null)
			{
				::logInfo("removing " + troop.Script)
				targetTroops.remove(index);
			}
		}
	}
};