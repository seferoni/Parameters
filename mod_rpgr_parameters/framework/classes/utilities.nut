::PRM.Utilities <-
{
	function getCommonField( _fieldName )
	{
		return this.getField("Common")[_fieldName];
	}

	function getField( _fieldName )
	{
		return ::PRM.Database.getField("Generic", _fieldName);
	}

	function getKrakenBuiltState()
	{
		return ::PRM.Standard.getFlag("KrakenBuilt", ::World.Statistics);
	}

	function getItemString( _fieldName )
	{
		return this.getStringField("Items")[_fieldName]
	}

	function getStringField( _fieldName )
	{
		return ::PRM.Strings.getField("Generic", _fieldName);
	}

	function getTooltipString( _fieldName )
	{
		return this.getStringField("Tooltips")[_fieldName];
	}

	function setKrakenBuiltState( _newValue = true )
	{
		::PRM.Standard.setFlag("KrakenBuilt", _newValue, ::World.Statistics);
	}
};