local Core = ::RPGR_Core;
Core.Troops <-
{
	Parameters =
	{
		ConversionThresholdFloor = 2,
		TroopRemovalCountFloor = 2,
		TroopRemovalCountPrefactor = 0.6
	}

	function assignTokens( _tokens, _partyObject )
	{
		::logInfo("got tokens " + _tokens + " for " + _partyObject.getName())
		Core.Standard.setFlag("Tokens", _tokens, _partyObject);
	}

	function compileLedger( _troopArray, _factionType )
	{
		# Get faction-specific troop cost threshold to prevent high-value troops from being culled.
		local costThreshold = Core.Config.Troops.Thresholds[this.getFactionNameFromType(_factionType)];

		# Get viable troops only.
		local troops = _troopArray.filter(@(_index, _troop) Core.Troops.isTroopViable(_troop.ID) && _troop.Cost <= costThreshold);

		# Tally up individual troop types by ID.
		local tally = this.tallyTroops(troops);

		# Prepare ledger template.
		local ledger =
		{
			Troops = [],
			Tokens = 0
		};

		foreach( troop in troops )
		{
			# Ensure tokenisation does not lead to adverse effects on troop diversity.
			if (tally[troop.ID] <= this.Parameters.TroopRemovalCountFloor)
			{
				continue;
			}

			ledger.Troops.push(troop);
			ledger.Tokens += troop.Cost;
			tally[troop.ID]--;
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

	function isTroopViable( _troopID )
	{
		return Core.Config.Troops.Excluded.find(_troopID) != null;
	}

	function removeTroops( _culledTroops, _partyObject )
	{
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

	function tallyTroops( _troopArray )
	{
		local tally = {};

		foreach( troop in _troopArray )
		{
			if (!(troop.ID in tally))
			{
				tally[troop.ID] <- 1;
				continue;
			}

			tally[troop.ID]++;
		}

		foreach( troopTally in tally )
		{
			if (troopTally <= this.Parameters.TroopRemovalCountFloor)
			{
				continue;
			}

			troopTally = ::Math.rand(::Math.ceil(troopTally * this.Parameters.TroopRemovalCountPrefactor), troopTally);
		}

		return tally;
	}
};