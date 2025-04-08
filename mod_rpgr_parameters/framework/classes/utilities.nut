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

	function getString( _fieldName )
	{
		return this.getStringField("Common")[_fieldName]
	}

	function getStringField( _fieldName )
	{
		return ::PRM.Strings.getField("Generic", _fieldName);
	}

	function setKrakenBuiltState( _newValue = true )
	{
		::PRM.Standard.setFlag("KrakenBuilt", _newValue, ::World.Statistics);
	}
};