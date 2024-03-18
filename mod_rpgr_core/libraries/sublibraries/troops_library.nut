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
		::logInfo("compressing " + _partyObject.getName());
		local troops = _partyObject.getTroops();
		::logInfo("original length is " + troops.len())

		local ledger = clone this.Template,
		tokens = this.getTokenTypes(_factionType),
		types = this.getTroopTypes(_factionType);
		::MSU.Log.printData(types.Low[0], 2, false)
		::logInfo("starting loop")

		troops.apply(function( entity )
		{
			::MSU.Log.printData(entity, 2, false);
			foreach( ledgerKey, tally in ledger )
			{
				local list = types[ledgerKey];

				if (list.find(entity))
				{
					tally.push(entity);
				}
			}
		});

		# Process tokens.
		foreach( tokenType, tally in ledger )
		{
			local count = tally.len(),
			tokenTable = tokens[tokenType];
			::logInfo("culled count for " + tokenType + " is " + count)

			if (tokenTable.High <= count)
			{
				this.exchange(tally, types.High, troops, ::Math.floor(count / tokenTable.High));
			}

			if ("Medium" in tokenTable && tokenTable.Medium <= count)
			{
				this.exchange(tally, types.Medium, troops, ::Math.floor(count / tokenTable.Medium));
			}
		}

		_partyObject.m.Name = (format("Compressed %s", _partyObject.getName()));
		::logInfo("compression done for " + _partyObject.getName())
	}

	function exchange( _culledTroops, _addedTroops, _targetTroops, _count )
	{
		this.removeTroops(_culledTroops, _targetTroops, _count);
		this.addTroops(_addedTroops, _targetTroops, _count);
	}

	function formatTroopTypeArray( _troopsArray )
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

	function getTokenTypes( _factionType )
	{
		return Core.Config.Troops.Tokens[this.getFactionNameFromType(_factionType)];
	}

	function getTroopTypes( _factionType )
	{
		local types = {},
		masterList = Core.Config.Troops.Types[this.getFactionNameFromType(_factionType)];

		foreach( troopType, troopArray in masterList )
		{
			types[troopType] <- this.formatTroopTypeArray(troopArray);
		}

		return types;
	}

	function isFactionViable( _factionType )
	{
		local factionName = this.getFactionNameFromType(_factionType),
		viableFactions = Core.Standard.getKeys(Core.Config.Troops.Types);

		::logInfo(factionName)
		::logInfo(viableFactions[0]);

		if (viableFactions.find(factionName) != null)
		{
			return true;
		}

		return false;
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