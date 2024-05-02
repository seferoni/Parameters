::Core.Standard <-
{
	Colour =
	{
		Green = "PositiveValue",
		Red = "NegativeValue"
	}

	function appendToStringList( _targetString, _string )
	{
		local newString = _targetString == "" ? format("%s", _string) : format("%s, %s", _targetString, _string);
		return newString;
	}

	function cacheHookedMethod( _object, _methodName )
	{
		local naiveMethod = null;

		if (_methodName in _object)
		{
			naiveMethod = _object[_methodName];
		}

		return naiveMethod;
	}

	function colourWrap( _text, _colour )
	{
		local string = _text;

		if (typeof _text != "string")
		{
			string = _text.tostring();
		}

		return format("[color=%s]%s[/color]", ::Const.UI.Color[_colour], string)
	}

	function extendTable( _table, _targetTable )
	{
		foreach( key, value in _table )
		{
			_targetTable[key] <- value;
		}
	}

	function formatVersion()
	{
		if (::Core.Internal.MSUFound)
		{
			return;
		}

		::Core.Version = this.parseSemVer(::Core.Version);
	}

	function getDescriptor( _valueToMatch, _referenceTable )
	{
		foreach( descriptor, value in _referenceTable )
		{
			if (value == _valueToMatch)
			{
				return descriptor;
			}
		}
	}

	function getFlag( _string, _object )
	{
		local flagValue = _object.getFlags().get(format("mod_rpgr_core.%s", _string));

		if (!flagValue)
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

	function getKeys( _table )
	{
		local keys = [];

		foreach( key, value in _table )
		{
			keys.push(key);
		}

		return keys;
	}

	function getMSUState()
	{
		return ::Core.Internal.MSUFound;
	}

	function getPercentageSetting( _settingID )
	{
		return (this.getSetting(_settingID) / 100.0)
	}

	function getSetting( _settingID )
	{
		if (this.getMSUState())
		{
			return ::Core.Mod.ModSettings.getSetting(_settingID).getValue();
		}

		foreach( tableKey, table in ::Core.Database )
		{
			if (_settingID in table)
			{
				return ::Core.Database[tableKey][_settingID];
			}
		}

		this.log(format("Invalid settingID %s passed to getSetting.", _settingID), true);
		return;
	}

	function initialise()
	{
		this.initialiseTables();
		this.loadHelpers();
		this.loadFiles();
		this.initialiseHelpers();
	}

	function initialiseHelpers()
	{
		::Core.Localisation.Helper.initialise();
		::Core.Database.Helper.initialise();
	}

	function initialiseTables()
	{
		::Core.Database <- {};
		::Core.Integrations <- {};
		::Core.Localisation <- {};
		::Core.Classes <- {};
	}

	function includeFiles( _path )
	{
		local filePaths = ::IO.enumerateFiles(_path);

		foreach( file in filePaths )
		{
			::include(file);
		}
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

	function loadHelpers()
	{
		::include("mod_rpgr_core/framework/localisation/helper.nut");
		::include("mod_rpgr_core/framework/database/helper.nut");
	}

	function loadFiles()
	{
		this.includeFiles("mod_rpgr_core/framework/integrations");
		this.includeFiles("mod_rpgr_core/framework/classes");
		this.includeFiles("mod_rpgr_core/hooks");
	}

	function log( _string, _isError = false )
	{
		if (_isError)
		{
			::logError(format("[::Core] %s", _string));
			return;
		}

		::logInfo(format("[::Core] %s", _string));
	}

	function overrideArguments( _object, _function, _originalMethod, _argumentsArray )
	{	# Calls new method and passes result onto original method; if null, calls original method with original arguments.
		# It is the responsibility of the overriding function to return appropriate arguments.
		local returnValue = _function.acall(_argumentsArray),
		newArguments = returnValue == null ? _argumentsArray : this.prependContextObject(_object, returnValue);
		return _originalMethod.acall(newArguments);
	}

	function overrideMethod( _object, _function, _originalMethod, _argumentsArray )
	{	# Calls and returns new method; if return value is null, calls and returns original method.
		local returnValue = _function.acall(_argumentsArray);
		return returnValue == null ? _originalMethod.acall(_argumentsArray) : (returnValue == ::Core.Internal.TERMINATE ? null : returnValue);
	}

	function overrideReturn( _object, _function, _originalMethod, _argumentsArray )
	{	# Calls original method and passes result onto new method, returns new result.
		# It is the responsibility of the overriding function to ensure it takes on the appropriate arguments and returns appropriate values.
		local originalValue = _originalMethod.acall(_argumentsArray);
		if (originalValue != null) _argumentsArray.insert(1, originalValue);
		local returnValue = _function.acall(_argumentsArray);
		return returnValue == null ? originalValue : (returnValue == ::Core.Internal.TERMINATE ? null : returnValue);
	}

	function parseSemVer( _version )
	{
		local versionArray = split(_version, ".");
		if (versionArray.len() > 3) versionArray.resize(3);
		return format("%s.%s%s", versionArray[0], versionArray[1], versionArray[2]).tofloat();
	}

	function prependContextObject( _object, _arguments )
	{
		local array = [_object];

		if (typeof _arguments != "array")
		{
			array.push(_arguments);
			return array;
		}

		foreach( entry in _arguments )
		{
			array.push(entry);
		}

		return array;
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

	function setMSUState()
	{
		::Core.Internal.MSUFound <- "MSU" in ::getroottable();
	}

	function setFlag( _string, _value, _object, _isNative = false )
	{
		local flag = _isNative ? format("%s", _string) : format("mod_rpgr_core.%s", _string);
		_object.getFlags().set(flag, _value);
	}

	function validateParameters( _originalFunction, _newParameters )
	{
		local originalInfo = _originalFunction.getinfos(), originalParameters = originalInfo.parameters;

		if (originalParameters[originalParameters.len() - 1] == "...")
		{
			return true;
		}

		local newLength = _newParameters.len() + 1;

		if (newLength <= originalParameters.len() && newLength >= originalParameters.len() - originalInfo.defparams.len())
		{
			return true;
		}

		return false;
	}

	function wrap( _object, _methodName, _function, _procedure = "overrideReturn" )
	{
		local cachedMethod = this.cacheHookedMethod(_object, _methodName),
		Standard = this, parentName = _object.SuperName;

		_object.rawset(_methodName, function( ... )
		{
			local originalMethod = cachedMethod == null ? this[parentName][_methodName] : cachedMethod;

			if (!Standard.validateParameters(originalMethod, vargv))
			{
				Standard.log(format("An invalid number of parameters were passed to %s, aborting wrap procedure.", _methodName), true);
				return;
			}

			local argumentsArray = Standard.prependContextObject(this, vargv);
			return Standard[_procedure](this, _function, originalMethod, argumentsArray);
		});
	}

	function wrapBase( _object, _methodName, _function, _procedure = "overrideReturn" )
	{
		local originalMethod =_object[_methodName],
		Standard = this;

		_object.rawset(_methodName, function( ... )
		{
			if (!Standard.validateParameters(originalMethod, vargv))
			{
				Standard.log(format("An invalid number of parameters were passed to %s, aborting wrap procedure.", _methodName), true);
				return;
			}

			local argumentsArray = Standard.prependContextObject(this, vargv);
			return Standard[_procedure](this, _function, originalMethod, argumentsArray);
		});
	}
};
