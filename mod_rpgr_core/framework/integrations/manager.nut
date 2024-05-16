::Core.Integrations.Manager <-
{
	function createMSUTables()
	{
		::Core.Integrations.MSU <- {};
		::Core.Integrations.MSU.Builders <- {};
	}

	function createModdingScriptHooksTables()
	{
		::Core.Integrations.ModdingScriptHooks <- {};
	}

	function createModernHooksTables()
	{
		::Core.Integrations.ModernHooks <- {};
	}

	function createTables()
	{
		this.createMSUTables();
		this.createModdingScriptHooksTables();
		this.createModernHooksTables();
	}

	function getMSUSettingsAPI()
	{
		return ::Core.Integrations.MSU.API;
	}

	function getModdingScriptHooksAPI()
	{
		return ::Core.Integrations.ModdingScriptHooks.API;
	}

	function initialise()
	{
		this.createTables();
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