local Core = ::RPGR_Core;
Core.Troops <-
{
	Template =
	{
		Low = [],
		Medium = []
	},

	function addTroop( _partyObject, _troopType, _count )
	{
		for( local i = 0; i < _count; i++ )
		{
			::Const.World.Common.addTroop(_partyObject, _troopType, true);
		}
	}

	function compress( _partyObject, _factionType )
	{
		local troops = _partyObject.getTroops(),
		factionName = this.getFactionNameFromType(_factionType);

		local ledger = clone this.Template,
		tokens = Core.Config.Troops.Tokens[factionName],
		types = Core.Config.Troops.Types[factionName];

		troops.apply(function(entity)
		{
			foreach( ledgerKey, tally in ledger )
			{
				local list = types[ledgerKey];

				if (list.find(entity))
				{
					tally.push(entity);
				}
			}
		});

		foreach( tokenType, tally in ledger )
		{
			local count = tally.len(),
			tokenTable = tokens[tokenType];

			if (tokenTable.High <= count)
			{
				this.exchange(tally, types.High, troops, ::Math.floor(count / tokenTable.High));
			}

			if ("Medium" in tokenTable && tokenTable.Medium <= count)
			{
				this.exchange(tally, types.Medium, troops, ::Math.floor(count / tokenTable.Medium));
			}
		}
	}

	function exchange( _culledTroops, _addedTroops, _targetTroops, _count )
	{
		this.removeTroops(_culledTroops, _targetTroops, _count);
		this.addTroops(this.formatTroopType(_addedTroops), _targetTroops, _count);
	}

	function formatTroopType( _troopsArray )
	{
		local troops = _troopsArray.map(@(_troopString) ::Const.World.Spawn.Troops[_troopString]);
		return troops;
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
		viableFactions = Core.Standard.getKeys(Core.Config.Troops.Types);

		if (viableFactions.find(factionName) != null)
		{
			return true;
		}

		return false;
	}

	function processTokens( _currentTokens, _referenceTable, _partyObject )
	{

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
};