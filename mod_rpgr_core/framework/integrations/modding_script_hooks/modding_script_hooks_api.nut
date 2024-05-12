::Core.Integrations.ModdingScriptHooks.API <-
{
	function hook( _path, _function )
	{
		::mods_hookExactClass(_path, _function);
	}

	function hookBase( _path, _function )
	{
		::mods_hookNewObject(_path, _function);
	}

	function hookTree( _path, _function )
	{
		::mods_hookBaseClass(_path, _function);
	}

	function queue( _expressionString, _function )
	{
		::mods_queue(::Core.ID, _expressionString, _function);
	}

	function register()
	{
		::mods_registerMod(::Core.ID, ::Core.Version, ::Core.Name);
	}

	function wrap( _object, _methodName, _function, _procedure )
	{
		# Assign reference to the name of the parent of the target object.
		local parentName = _object.SuperName;

		# Attempt to store a reference to the original method (which may be inherited), to preserve functionality when wrapped (if applicable).
		local cachedMethod = this.cacheHookedMethod(_object, _methodName);

		_object.rawset(_methodName, function( ... )
		{
			# Assign a reference to the original method.
			local originalMethod = cachedMethod == null ? this[parentName][_methodName] : cachedMethod;

			if (!::Core.Patcher.validateParameters(originalMethod, vargv))
			{
				::Core.Standard.log(format("An invalid number of parameters were passed to %s, aborting wrap procedure.", _methodName), true);
				return;
			}

			local argumentsArray = ::Core.Patcher.prependContextObject(this, vargv);
			return ::Core.Patcher[_procedure](this, _function, originalMethod, argumentsArray);
		});
	}

	# This wrapper should be used circumstantially for base classes - that is, classes that neither inherit nor are inherited from.
	function wrapBase( _object, _methodName, _function, _procedure )
	{
		# Store a reference to the original method, to preserve functionality when wrapped (if applicable).
		local originalMethod = _object[_methodName];

		_object.rawset(_methodName, function( ... )
		{
			if (!::Core.Patcher.validateParameters(originalMethod, vargv))
			{
				::Core.Standard.log(format("An invalid number of parameters were passed to %s, aborting wrap procedure.", _methodName), true);
				return;
			}

			local argumentsArray = self.prependContextObject(this, vargv);
			return ::Core.Patcher[_procedure](this, _function, originalMethod, argumentsArray);
		});
	}
};