PRM.Utilities.formatString = function( _string, _placeholderReplacements )
{
	var fetchReplacement = function( _fullPlaceholderString, _captureGroupString )
	{
		var placeholderIndex = Number(_captureGroupString);

		if (isNaN(placeholderIndex))
		{
			return _fullPlaceholderString;
		}

		if (_placeholderReplacements[placeholderIndex] === undefined)
		{
			return _fullPlaceholderString;
		}

		return _placeholderReplacements[placeholderIndex];
	};

	return _string.replace(/\{(\d+)}/g, fetchReplacement);
};

PRM.Utilities.log = function( _message )
{
	console.error(this.formatString("{0} {1}", ["[Parameters]", _message]));
};