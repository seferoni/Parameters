::PRM.Mapper <-
{
	function getParameterDatabase( _databaseKey )
	{
		return ::PRM.Database.getField("Settings", _databaseKey);
	}

	function mapToDatabase( _classAttribute, _getPercentage = false )
	{
		if (_getPercentage)
		{
			return ::PRM.Standard.getNormalisedParameter(_classAttribute);
		}

		return ::PRM.Standard.getParameter(_classAttribute);
	}

	function mapToSettlementParameters( _settlementModifiers )
	{
		this.mapToGameObject(_settlementModifiers, "Settlements");
	}

	function mapToWorldParameters( _worldObject )
	{
		this.mapToGameObject(_worldObject, "World");
	}

	function mapToGameObject( _propertyTable, _databaseKey )
	{
		local database = this.getParameterDatabase(_databaseKey);

		foreach( key, dataTable in database )
		{
			if ("IgnoreForImplicitMapping" in dataTable && dataTable.IgnoreForImplicitMapping)
			{
				continue;
			}

			if (!(key in _propertyTable))
			{
				::PRM.Standard.log(format("Could not find %s in target table, aborting patch.", key), true);
				continue;
			}

			_propertyTable[key] = this.mapToDatabase(key, true);
		}
	}
};