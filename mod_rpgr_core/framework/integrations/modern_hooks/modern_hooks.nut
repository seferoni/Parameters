::Core.Integrations.ModernHooks <-
{
	function hook( _path, _function )
	{
		::Core.getModernHooksInterface().hook(_path, @(q) _function(q));
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

	function wrap( q, _function )
	{
		
	}
}