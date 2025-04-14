::PRM.LocationHandler <-
{
	function isLocationViableForScaling( _locationObject )
	{
		local scalingParameters = ::PRM.Utilities.getField("LocationScalingParameters");

		foreach( locationType in scalingParameters.ForbiddenTypesInclusive )
		{
			if (_locationObject.isLocationType(locationType))
			{
				return false;
			}
		}

		foreach( locationType in scalingParameters.ForbiddenTypesExclusive )
		{
			if (_locationObject.getLocationType() == locationType)
			{
				return false;
			}
		}

		foreach( locationID in scalingParameters.ForbiddenLocationIDs )
		{
			if (_locationObject.getID() == locationID)
			{
				return false;
			}
		}

		return true;
	}
};