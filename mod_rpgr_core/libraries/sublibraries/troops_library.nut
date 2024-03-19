local Core = ::RPGR_Core;
Core.Troops <-
{
	Parameters =
	{
		ConversionThresholdFloor = 2
	}

	function assignTokens( _tokens, _partyObject )
	{
		Core.Standard.setFlag("Tokens", _tokens, _partyObject);
	}

	function compileLedger( _troopArray, _factionType )
	{
		local threshold = Core.Config.Thresholds[this.getFactionNameFromType(_factionType)],
		ledger =
		{
			Troops = [],
			Tokens = 0
		};

		foreach( troop in _troopArray )
		{
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
		viableFactions = Core.Standard.getKeys(Core.Config.Troops.Thresholds);

		if (viableFactions.find(factionName) != null)
		{
			return true;
		}

		return false;
	}

	function removeTroops( _culledTroops, _partyObject )
	{
		::logInfo("removing culledTroops for " + _partyObject.getName())
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