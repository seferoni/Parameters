::Core.Integrations <-
{
	function getMSUSettingsAPI()
	{
		return this.MSU;
	}

	function getModdingScriptHooksAPI()
	{
		return this.ModdingScriptHooks;
	}

	function initialise()
	{
		this.loadAPI();
		this.initialiseAPI();
	}

	function initialiseAPI()
	{
		this.initialiseMSUAPI();
	}

	function initialiseMSUAPI()
	{
		if (!::Core.getManager().isMSUInstalled())
		{
			return;
		}

		this.getMSUSettingsAPI().initialise();
	}

	function loadFile( _filePath )
	{
		::include(format("mod_rpgr_core/framework/integrations/%s", _filePath));
	}

	function loadAPI()
	{
		this.loadFile("msu/msu_api.nut");
		this.loadFile("modern_hooks/modern_hooks_api.nut");
		this.loadFile("modding_script_hooks/modding_script_hooks_api.nut");
	}
};