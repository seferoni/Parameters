::Core.Standard <-
{
	Case =
	{
		Upper = "toupper",
		Lower = "tolower"
	},
	Colour =
	{
		Green = "#2a5424",
		Red = "#691a1a"
	}

	function appendToStringList( _targetString, _string )
	{
		local newString = _targetString == "" ? format("%s", _string) : format("%s, %s", _targetString, _string);
		return newString;
	}

	function colourWrap( _text, _colour )
	{
		local string = _text;

		if (typeof _text != "string")
		{
			string = _text.tostring();
		}

		return format("[color=%s]%s[/color]", _colour, string)
	}

	function extendArrayWithTableValues( _table, _targetArray )
	{
		foreach( key, value in _table )
		{
			_targetArray.push(value);
		}
	}

	function extendTable( _table, _targetTable )
	{
		foreach( key, value in _table )
		{
			_targetTable[key] <- value;
		}
	}

	function getFlag( _string, _object )
	{
		local flagValue = _object.getFlags().get(format("mod_rpgr_core.%s", _string));

		if (flagValue == false)
		{
			flagValue = _object.getFlags().get(format("%s", _string));
		}

		return flagValue;
	}

	function getFlagAsInt( _string, _object )
	{
		local flagValue = _object.getFlags().getAsInt(format("mod_rpgr_core.%s", _string));

		if (flagValue == 0)
		{
			flagValue = _object.getFlags().getAsInt(format("%s", _string));
		}

		return flagValue;
	}

	function getKey( _valueToMatch, _table )
	{
		foreach( key, value in _table )
		{
			if (value == _valueToMatch)
			{
				return key;
			}
		}
	}

	function getKeys( _table )
	{
		local keys = [];

		foreach( key, value in _table )
		{
			keys.push(key);
		}

		return keys;
	}

	function getPercentageParameter( _settingID )
	{
		return (this.getSetting(_settingID) / 100.0);
	}

	function getParameter( _settingID )
	{
		if (::Core.getManager().isMSUInstalled())
		{
			return ::Core.getManager().getMSUInterface().ModSettings.getSetting(_settingID).getValue();
		}

		// TODO: remember, this should be retrieving defaults!
		local parameters = ::Core.Database.Manager.getParametersAggregated();

		foreach( parameterKey, parameterTable in parameters )
		{
			if (parameterKey == _settingID)
			{
				return parameterTable.Default;
			}
		}

		this.log(format("Invalid settingID %s passed to getSetting.", _settingID), true);
		return;
	}

	function incrementFlag( _string, _value, _object, _isNative = false )
	{
		local flag = _isNative ? format("%s", _string) : format("mod_rpgr_core.%s", _string);
		_object.getFlags().increment(flag, _value);
	}

	function isWeakRef( _object )
	{
		if (typeof _object != "instance")
		{
			return false;
		}

		if (!(_object instanceof ::WeakTableRef))
		{
			return false;
		}

		return true;
	}

	function log( _string, _isError = false )
	{
		if (_isError)
		{
			::logError(format("[Core] %s", _string));
			return;
		}

		::logInfo(format("[Core] %s", _string));
	}

	function removeFromArray( _object, _targetArray )
	{
		local culledObjects = typeof _object == "array" ? _object : [_object];

		foreach( entry in culledObjects )
		{
			local index = _targetArray.find(entry);
			if (index != null) _targetArray.remove(index);
		}
	}

	function setCase( _string, _case )
	{
		local character = _string[0].tochar()[_case]();
		return format("%s%s", character, _string.slice(1));
	}

	function setFlag( _string, _value, _object, _isNative = false )
	{
		local flag = _isNative ? format("%s", _string) : format("mod_rpgr_core.%s", _string);
		_object.getFlags().set(flag, _value);
	}
};
