::PRM.Utilities <-
{
	function getKrakenBuiltState()
	{
		return ::PRM.Standard.getFlag("KrakenBuilt", ::World.Statistics);
	}

	function getCommonField( _fieldName )
	{
		return this.getField("Common")[_fieldName];
	}

	function getField( _fieldName )
	{
		return ::PRM.Database.getField("Generic", _fieldName);
	}

	function setKrakenBuiltState( _newValue = true )
	{
		::PRM.Standard.setFlag("KrakenBuilt", _newValue, ::World.Statistics);
	}
};