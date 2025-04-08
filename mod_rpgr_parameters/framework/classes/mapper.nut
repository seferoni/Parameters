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
			_settlementModifiers[key] = this.mapToDatabase(key, true);
		}
	}

	function initialiseWorldParameters( _worldObject )
	{
		foreach( key in ::PRM.Database.getWorldKeys() )
		{
			_worldObject.m[key] = this.mapToDatabase(key, true);
		}
	}

	function setStashSize()
	{
		::World.Assets.getStash().resize(this.mapToDatabase("StashSize"));
	}
};