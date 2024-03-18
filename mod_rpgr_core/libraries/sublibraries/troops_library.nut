local Core = ::RPGR_Core;
Core.Troops <-
{
	Template =
	{
		Low = [],
		Medium = []
	},

	function addTroop( _partyObject, _troopType, _count )
	{	// TODO: this doesn't work. we're passing an array of troop types to this method
		// these types, in turn, need to be in a table structure {Type = ::Const.World.Spawn...} etc etc
		local troopTable = {Type = _troopType};

		for( local i = 0; i < _count; i++ )
		{
			::Const.World.Common.addTroop(_partyObject, troopTable, true);
		}
	}

	function compileLedger( _troopsArray, _factionType )
	{
		local ledger = clone this.Template,
		referenceIDs = this.getTroopTypes(_factionType, true);

		foreach( troop in _troopsArray )
		{
			local ID = troop.Type.ID;

			if (referenceIDs.Medium.find(ID))
			{
				ledger.Medium.push(troop);
				continue;
			}

			if (referenceIDs.Low.find(ID))
			{
				ledger.Low.push(troop);
			}
		}

		return ledger;
	}

	function compress( _partyObject, _factionType )
	{
		local troops = _partyObject.getTroops();

		# Process troops and tally up appropriate token types in ledger.
		local ledger = this.compileLedger(troops, _factionType);

		# Terminate execution if no eligible troop types are present.
		if (ledger.Medium.len() == 0 && ledger.Low.len() == 0)
		{
			return;
		}

		# Process tokens.
		this.processTokens(ledger, troops, _factionType);
		this.setName(_partyObject);
	}

	function exchange( _culledTroops, _addedTroops, _targetTroops, _count )
	{
		this.removeTroops(_culledTroops, _targetTroops, _count);
		this.addTroops(_addedTroops, _targetTroops, _count);
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

		return IDs;
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

	function processTokens( _tokenWallet, _troopsArray, _factionType )
	{
		local types = this.getTroopTypes(_factionType),
		tokens = this.getTokens(_factionType);

		foreach( tokenType, tally in _tokenWallet )
		{
			local count = tally.len(),
			tokenTable = tokens[tokenType];

			if (tokenTable.High <= count)
			{
				this.exchange(tally, types.High, _troopsArray, ::Math.floor(count / tokenTable.High));
			}

			if ("Medium" in tokenTable && tokenTable.Medium <= count)
			{
				this.exchange(tally, types.Medium, _troopsArray, ::Math.floor(count / tokenTable.Medium));
			}
		}
	}

	function removeTroops( _culledTroops, _targetTroops, _count )
	{
		local garbage = _culledTroops.resize(_count);

		foreach( troop in garbage )
		{
			local index = _targetTroops.find(troop);

			if (index != null)
			{
				_targetTroops.remove(index);
			}
		}
	}

	function setName( _partyObject )
	{
		local name = _partyObject.getName();
		_partyObject.setName(format("Compressed %s", name));
	}
};