PRM.Patcher.wrap = function( _object, _methodName, _function, _procedure )
{
	var dummy = function()
	{
		return;
	};
	var originalMethod = _methodName in _object ? _object[_methodName] : dummy;
	_object[_methodName] = function()
	{
		var argumentsArray = Array.prototype.slice.call(arguments);
		return PRM.Patcher[_procedure](this, originalMethod, argumentsArray, _function);
	};
};

PRM.Patcher.overrideReturn = function( _contextObject, _originalMethod, _argumentsArray, _function )
{
	var originalResult = _originalMethod.apply(_contextObject, _argumentsArray);

	if (originalResult != null)
	{
		_argumentsArray.unshift(originalResult);
	}

	var returnValue = _function.apply(_contextObject, _argumentsArray);
	
	if (returnValue == null)
	{
		return originalResult;
	}

	return returnValue;
};

PRM.Patcher.overrideMethod = function( _contextObject, _originalMethod, _argumentsArray, _function )
{
	var returnValue = _function.apply(_contextObject, _argumentsArray);

	if (returnValue === undefined)
	{
		return;
	}

	if (returnValue === null)
	{
		return _originalMethod.apply(_contextObject, _argumentsArray);
	}

	return returnValue;
};