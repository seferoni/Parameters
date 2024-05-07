::Core.Patcher <-
{
	function cacheHookedMethod( _object, _methodName )
	{
		local naiveMethod = null;

		if (_methodName in _object)
		{
			naiveMethod = _object[_methodName];
		}

		return naiveMethod;
	}

	function hook( _object )
	{

	}

	# Calls new method and passes result onto original method; if null, calls original method with original arguments.
	# It is the responsibility of the overriding function to return appropriate arguments.
	function overrideArguments( _object, _function, _originalMethod, _argumentsArray )
	{
		local returnValue = _function.acall(_argumentsArray),
		newArguments = returnValue == null ? _argumentsArray : this.prependContextObject(_object, returnValue);
		return _originalMethod.acall(newArguments);
	}

	# Calls and returns new method; if return value is null, calls and returns original method.
	function overrideMethod( _object, _function, _originalMethod, _argumentsArray )
	{
		local returnValue = _function.acall(_argumentsArray);
		return returnValue == null ? _originalMethod.acall(_argumentsArray) : (returnValue == ::Core.Internal.TERMINATE ? null : returnValue);
	}

	# Calls original method and passes result onto new method, returns new result.
	# It is the responsibility of the overriding function to ensure it takes on the appropriate arguments and returns appropriate values.
	function overrideReturn( _object, _function, _originalMethod, _argumentsArray )
	{
		local originalValue = _originalMethod.acall(_argumentsArray);

		if (originalValue != null)
		{
			_argumentsArray.insert(1, originalValue);
		} 

		local returnValue = _function.acall(_argumentsArray);
		return returnValue == null ? originalValue : (returnValue == ::Core.Internal.TERMINATE ? null : returnValue);
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

	function validateParameters( _originalFunction, _newParameters )
	{
		local originalInfo = _originalFunction.getinfos(), originalParameters = originalInfo.parameters;

		# Return a trivial evaluation if the evaluated function accepts variable arguments.
		if (originalParameters[originalParameters.len() - 1] == "...")
		{
			return true;
		}

		# This offset here accounts for the inclusion of the context object.
		local newLength = _newParameters.len() + 1;

		if (newLength <= originalParameters.len() && newLength >= originalParameters.len() - originalInfo.defparams.len())
		{
			return true;
		}

		return false;
	}

	function wrap( _object, _methodName, _function, _procedure = "overrideReturn" )
	{
		# Assign reference to this library for use in the wrapped method's closure.
		local self = this;

		# Assign reference to the name of the parent of the target object.
		local parentName = _object.SuperName;
		
		# Attempt to store a reference to the original method (which may be inherited), to preserve functionality when wrapped (if applicable).
		local cachedMethod = this.cacheHookedMethod(_object, _methodName);

		_object.rawset(_methodName, function( ... )
		{
			# Assign a reference to the original method.
			local originalMethod = cachedMethod == null ? this[parentName][_methodName] : cachedMethod;

			if (!self.validateParameters(originalMethod, vargv))
			{
				self.log(format("An invalid number of parameters were passed to %s, aborting wrap procedure.", _methodName), true);
				return;
			}

			local argumentsArray = self.prependContextObject(this, vargv);
			return self[_procedure](this, _function, originalMethod, argumentsArray);
		});
	}

	# This wrapper should be used circumstantially for base classes - that is, classes that neither inherit nor are inherited from.
	function wrapBase( _object, _methodName, _function, _procedure = "overrideReturn" )
	{
		# Assign reference to this library for use in the wrapped method's closure.
		local self = this;
		
		# Store a reference to the original method, to preserve functionality when wrapped (if applicable).
		local originalMethod = _object[_methodName];

		_object.rawset(_methodName, function( ... )
		{
			if (!self.validateParameters(originalMethod, vargv))
			{
				self.log(format("An invalid number of parameters were passed to %s, aborting wrap procedure.", _methodName), true);
				return;
			}

			local argumentsArray = self.prependContextObject(this, vargv);
			return self[_procedure](this, _function, originalMethod, argumentsArray);
		});
	}
};