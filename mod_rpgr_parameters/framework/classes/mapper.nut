::PRM.Mapper <-
{
	function mapToDatabase( _classAttribute, _getPercentage = false )
	{
		if (_getPercentage)
		{
			return ::PRM.Standard.getNormalisedParameter(_classAttribute);
		}

		return ::PRM.Standard.getParameter(_classAttribute);
	}

	function initialiseSettlementParameters( _settlementModifiers )
	{
		foreach( key in ::PRM.Database.getSettlementKeys() )
		{
			if (!(key in _settlementModifiers))
			{
				::PRM.Standard.log(format("Could not find %s in settlement modifiers table, aborting patch.", key), true);
				continue;
			}

			_settlementModifiers[key] = this.mapToDatabase(key, true);
		}
	}

	function initialiseWorldParameters( _worldObject )
	{
		foreach( key in ::PRM.Database.getWorldKeys() )
		{
			if (!(key in _worldObject.m))
			{
				::PRM.Standard.log(format("Could not find %s in asset manager table, aborting patch.", key), true);
				continue;
			}

			_worldObject.m[key] = this.mapToDatabase(key, true);
		}
	}
};