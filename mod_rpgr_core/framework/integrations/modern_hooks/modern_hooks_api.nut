::Core.Integrations.ModernHooks <-
{
	function hook( _path, _function )
	{
		::Core.getManager().getModernHooksInterface().rawHook(_path, _function);
	}

	function hookBase( _path, _function )
	{
		this.hook(_path, _function);
	}

	function hookTree( _path, _function )
	{
		::Core.getManager().getModernHooksInterface().rawHookTree(_path, @(p) _function); // TODO: why does this work? why does wrapping the function in lambda work?
	}
};