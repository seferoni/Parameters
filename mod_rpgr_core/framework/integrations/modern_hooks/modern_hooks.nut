::Core.Integrations.ModernHooks <-
{
	function hook( _path, _function )
	{
		::Core.getModernHooksInterface().hook(_path, function(q) _function(q));
	}

	function overrideArguments()
	{

	}

	function overrideMethod()
	{

	}

	function overrideReturn()
	{

	}

	function wrap( _object, _methodName, _function )
	{
		_object[_methodName] = @( __original ) _function();
	}
}