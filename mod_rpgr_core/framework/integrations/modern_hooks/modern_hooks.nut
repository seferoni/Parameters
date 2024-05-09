::Core.Integrations.ModernHooks <-
{
	function hook( _path, _function )
	{
		::Core.getModernHooksInterface().hook(_path, function(q) _function(q));
	}

	function hookTree( _path, _function )
	{
		::Core.getModernHooksInterface().hookTree(_path, function(q) _function(q));
	}

	function wrap( q, _methodName, _function, _procedure )
	{
		q[_methodName] = @(__original) function( ... )
		{
			if (!::Core.Patcher.validateParameters(__original, vargv))
			{
				::Core.Standard.log(format("An invalid number of parameters were passed to %s, aborting wrap procedure.", _methodName), true);
				return;
			}

			local argumentsArray = ::Core.Patcher.prependContextObject(this, vargv);
			return ::Core.Patcher[_procedure](this, _function, __original, argumentsArray);
		}
	}
};