::Core.Integrations.ModernHooks <-
{
	function hook( _path, _function )
	{
		::Core.getManager().getModernHooksInterface().hook(_path, function(q) _function(q));
	}

	function hookBase( _path, _function )
	{
		this.hook(_path, _function);
	}

	function hookTree( _path, _function )
	{
		::Core.getManager().getModernHooksInterface().hookTree(_path, function(q) _function(q));
	}

	function wrap( q, _methodName, _function, _procedure )
	{
		q[_methodName] <- @(__original) function( ... )
		{
			local argumentsArray = ::Core.Patcher.prependContextObject(this, vargv);
			return ::Core.Patcher[_procedure](this, _function, __original, argumentsArray);
		}
	}
};