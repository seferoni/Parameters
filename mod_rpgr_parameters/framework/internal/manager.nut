::PRM.Manager <-
{
	function awake()
	{
		this.createTables();
		this.updateIntegrationRegistry();
		this.register();
	}

	function createMSUInterface()
	{
		if (!this.isMSUInstalled())
		{
			return;
		}

		::PRM.Interfaces.MSU <- ::MSU.Class.Mod(::PRM.ID, ::PRM.Version, ::PRM.Name);
	}

	function createTables()
	{
		::PRM.Interfaces <- {};
	}

	function formatVersion()
	{
		if (this.isMSUInstalled())
		{
			return;
		}

		if (this.isModernHooksInstalled())
		{
			return;
		}

		::PRM.Version = this.parseSemVer(::PRM.Version);
	}

	function isMSUInstalled()
	{
		return ::PRM.Internal.MSUFound;
	}

	function isModernHooksInstalled()
	{
		return ::PRM.Internal.ModernHooksFound;
	}

	function initialise()
	{
		this.createMSUInterface();
		this.loadJS();
		this.loadLibraries();
		this.loadHandlers();
		this.initialiseHandlers();
		this.loadFiles();
	}

	function initialiseHandlers()
	{
		::PRM.Database.initialise();
		::PRM.Strings.initialise();
		::PRM.Integrations.initialise();
	}

	function includeFiles( _path )
	{
		local filePaths = ::IO.enumerateFiles(_path);

		foreach( file in filePaths )
		{
			::include(file);
		}
	}

	function loadHandlers()
	{
		::include("mod_rpgr_parameters/framework/database/database_handler.nut");
		::include("mod_rpgr_parameters/framework/strings/string_handler.nut");
		::include("mod_rpgr_parameters/framework/integrations/mod_integration.nut");
	}

	function loadLibraries()
	{
		::include("mod_rpgr_parameters/framework/libraries/standard_library.nut");
		::include("mod_rpgr_parameters/framework/libraries/patcher_library.nut");
	}

	function loadFiles()
	{
		this.includeFiles("mod_rpgr_parameters/framework/classes");
		this.includeFiles("mod_rpgr_parameters/hooks");
	}

	function loadJS()
	{
		this.registerJS("registry.js");
		this.registerJS("js_helpers/patcher.js");
		this.registerJS("patches/character_screen_inventory_list_module.js");
		this.registerJS("patches/character_screen_datasource.js");
	}

	function parseSemVer( _versionString )
	{
		local stringArray = split(_versionString, ".");

		if (stringArray.len() > 3)
		{
			stringArray.resize(3);
		}

		return format("%s.%s%s", stringArray[0], stringArray[1], stringArray[2]).tofloat();
	}

	function queue()
	{
		local queued = @() ::PRM.Manager.initialise();

		if (this.isModernHooksInstalled())
		{
			::PRM.Interfaces.ModernHooks.queue(">mod_msu", queued);
			return;
		}

		::mods_queue(::PRM.ID, ">mod_msu", queued);
	}

	function register()
	{
		this.formatVersion();
		this.registerMod();
	}

	function registerJS( _path )
	{
		if (this.isModernHooksInstalled())
		{
			::Hooks.registerJS(format("ui/mods/mod_rpgr_parameters/%s", _path));
			return;
		}

		::mods_registerJS(format("mod_rpgr_parameters/%s", _path));
	}

	function registerMod()
	{
		if (this.isModernHooksInstalled())
		{
			::PRM.Interfaces.ModernHooks <- ::Hooks.register(::PRM.ID, ::PRM.Version, ::PRM.Name);
			return;
		}

		::mods_registerMod(::PRM.ID, ::PRM.Version, ::PRM.Name);
	}

	function updateIntegrationRegistry()
	{
		this.updateMSUState();
		this.updateModernHooksState();
	}

	function updateMSUState()
	{
		::PRM.Internal.MSUFound <- "MSU" in ::getroottable();
	}

	function updateModernHooksState()
	{
		::PRM.Internal.ModernHooksFound <- "Hooks" in ::getroottable();
	}
};