::Parameters.Mapper <-
{
	// TODO: also incorporate relation decay and gain, business rep mult, etc
	// TODO: could do with a roster offset instead?
	function get( _classAttribute, _getPercentage = false )
	{
		if (_getPercentage)
		{
			return ::Parameters.Standard.getNormalisedParameter(_classAttribute);
		}

		return ::Parameters.Standard.getParameter(_classAttribute);
	}

	function initialiseSettlementParameters( _settlementModifiers )
	{
		foreach( key in ::Parameters.Database.getSettlementKeys() )
		{
			_settlementModifiers[key] = this.get(key, true);
		}
	}

	function initialiseWorldParameters( _worldObject )
	{
		foreach( key in ::Parameters.Database.getWorldKeys() )
		{
			_worldObject.m[key] = this.get(key, true);
		}
	}
};