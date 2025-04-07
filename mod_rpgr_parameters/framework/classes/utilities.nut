::Parameters.Utilities <-
{
	function getCommonField( _fieldName )
	{
		return this.getField("Common")[_fieldName];
	}

	function getField( _fieldName )
	{
		return ::Parameters.Database.getField("Generic", _fieldName);
	}
};