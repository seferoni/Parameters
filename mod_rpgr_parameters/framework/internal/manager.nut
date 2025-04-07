::Parameters.Manager <-
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

		::Parameters.Interfaces.MSU <- ::MSU.Class.Mod(::Parameters.ID, ::Parameters.Version, ::Parameters.Name);
	}

	function createTables()
	{
		::Parameters.Interfaces <- {};
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

		::Parameters.Version = this.parseSemVer(::Parameters.Version);
	}

	function isMSUInstalled()
	{
		return ::Parameters.Internal.MSUFound;
	}

	function isModernHooksInstalled()
	{
		return ::Parameters.Internal.ModernHooksFound;
	}

	function initialise()
	{
		this.createMSUInterface();
		this.loadLibraries();
		this.loadHandlers();
		this.initialiseHandlers();
		this.loadFiles();
	}

	function initialiseHandlers()
	{
		::Parameters.Database.initialise();
		::Parameters.Strings.initialise();
		::Parameters.Integrations.initialise();
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
		local queued = @() ::Parameters.Manager.initialise();

		if (this.isModernHooksInstalled())
		{
			::Parameters.Interfaces.ModernHooks.queue(">mod_msu", queued);
			return;
		}

		::mods_queue(::Parameters.ID, ">mod_msu", queued);
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
			::Parameters.Interfaces.ModernHooks <- ::Hooks.register(::Parameters.ID, ::Parameters.Version, ::Parameters.Name);
			return;
		}

		::mods_registerMod(::Parameters.ID, ::Parameters.Version, ::Parameters.Name);
	}

	function updateIntegrationRegistry()
	{
		this.updateMSUState();
		this.updateModernHooksState();
	}

	function updateMSUState()
	{
		::Parameters.Internal.MSUFound <- "MSU" in ::getroottable();
	}

	function updateModernHooksState()
	{
		::Parameters.Internal.ModernHooksFound <- "Hooks" in ::getroottable();
	}
};