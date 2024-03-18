local Core = ::RPGR_Core;
Core.Troops <-
{
	Template =
	{
		Low = [],
		Medium = []
	},

	function addTroops( _troopsArray, _partyObject, _count )
	{
		local troops = _troopsArray.map(@(_troop) {Type = _troop});

		for( local i = 0; i < _count; i++ )
		{
			local troop = troops[::Math.rand(0, troops.len() - 1)];
			::logInfo("adding " + troop.Type.Script)
			::Const.World.Common.addTroop(_partyObject, troop, true);
		}
	}

	function compileLedger( _troopsArray, _factionType )
	{
		local ledger = clone this.Template,
		referenceIDs = this.getTroopTypes(_factionType, true);

		::logInfo("compiling ledger for " + this.getFactionNameFromType(_factionType));

		foreach( troop in _troopsArray )
		{
			local ID = troop.ID;

			if (referenceIDs.Medium.find(ID))
			{
				::logInfo("found " + troop.Script + " for Medium")
				ledger.Medium.push(troop);
				continue;
			}

			if (referenceIDs.Low.find(ID))
			{
				::logInfo("found " + troop.Script + " for Low")
				ledger.Low.push(troop);
			}
		}

		return ledger;
	}

	function compress( _partyObject, _factionType )
	{
		::logInfo("compressing " + _partyObject.getName());
		local troops = _partyObject.getTroops();
		::logInfo("original length is " + troops.len())

		# Process troops and tally up appropriate token types in ledger.
		local ledger = this.compileLedger(troops, _factionType);

		# Terminate execution if no eligible troop types are present.
		if (ledger.Medium.len() == 0 && ledger.Low.len() == 0)
		{
			return;
		}

		# Process tokens.
		this.processTokens(ledger, _partyObject, _factionType);
		::logInfo("final length is " + _partyObject.getTroops().len() + " for " + _partyObject.getName())
		this.setName(_partyObject);
	}

	function exchange( _culledTroops, _addedTroops, _partyObject, _count )
	{
		this.removeTroops(_culledTroops, _partyObject, _count);
		this.addTroops(_addedTroops, _partyObject, _count);
	}

	function formatTroopType( _troopString )
	{
		return ::Const.World.Spawn.Troops[_troopString];
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

	function getNaiveTroopTypes( _factionType )
	{	# This returns a table that contains arrays of sugared troop type names.
		return Core.Config.Troops.Types[this.getFactionNameFromType(_factionType)];
	}

	function getTokens( _factionType )
	{
		return Core.Config.Troops.Tokens[this.getFactionNameFromType(_factionType)];
	}

	function getTroopTypes( _factionType, _getIDs = false )
	{
		local typeList = {},
		format = @(_troopString) _getIDs ? ::Const.World.Spawn.Troops[_troopString].ID : ::Const.World.Spawn.Troops[_troopString],
		naiveTypes = this.getNaiveTroopTypes(_factionType);

		foreach( type, troopArray in naiveTypes )
		{
			typeList[type] <- troopArray.map(format);
		}

		return typeList;
	}

	function isFactionViable( _factionType )
	{
		local factionName = this.getFactionNameFromType(_factionType),
		viableFactions = Core.Standard.getKeys(Core.Config.Troops.Types);

		if (viableFactions.find(factionName) != null)
		{
			return true;
		}

		return false;
	}

	function processTokens( _tokenWallet, _partyObject, _factionType )
	{
		local types = this.getTroopTypes(_factionType),
		tokens = this.getTokens(_factionType);

		foreach( tokenType, tally in _tokenWallet )
		{
			local count = tally.len(),
			tokenTable = tokens[tokenType];
			::logInfo("culled count for " + tokenType + " is " + count)
 
			if (tokenTable.High <= count)
			{
				this.removeTroops(tally, _partyObject, count);
				this.addTroops(types.Medium, _partyObject, ::Math.floor(count / tokenTable.Medium))
				continue;
			}

			if ("Medium" in tokenTable && tokenTable.Medium <= count)
			{	// TODO: this is not removing the correct number of troops. could be over
				this.removeTroops(tally, _partyObject, count);
				this.addTroops(types.Medium, _partyObject, ::Math.floor(count / tokenTable.Medium))
			}
		}
	}

	function removeTroops( _culledTroops, _partyObject, _count )
	{
		::logInfo("removing culledTroops for " + _partyObject.getName())
		local targetTroops = _partyObject.getTroops();
		_culledTroops.resize(_count);

		foreach( troop in _culledTroops )
		{
			if (troop == null)
			{
				continue;
			}
			local index = targetTroops.find(troop);

			if (index != null)
			{
				::logInfo("removing " + troop.Script)
				targetTroops.remove(index);
			}
		}
	}

	function setName( _partyObject )
	{
		local name = _partyObject.getName();
		_partyObject.setName(format("Compressed %s", name));
	}
};