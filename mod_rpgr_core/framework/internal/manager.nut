::Core.Manager <-
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

		::Core.Interfaces.MSU <- ::MSU.Class.Mod(::Core.ID, ::Core.Version, ::Core.Name);
	}

	function createTables()
	{
		::Core.Interfaces <- {};
		::Core.Strings <- {};
		::Core.Classes <- {};
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

		::Core.Version = this.parseSemVer(::Core.Version);
	}

	function isMSUInstalled()
	{
		return ::Core.Internal.MSUFound;
	}

	function isModernHooksInstalled()
	{
		return ::Core.Internal.ModernHooksFound;
	}

	function initialise()
	{
		this.createMSUInterface();
		this.loadLibraries();
		this.loadStrings();
		this.loadHandlers();
		this.initialiseHandlers();
		this.loadFiles();
	}

	function initialiseHandlers()
	{
		::Core.Database.initialise();
		::Core.Integrations.initialise();
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
		::include("mod_rpgr_core/framework/database/database_handler.nut");
		::include("mod_rpgr_core/framework/integrations/mod_integration.nut");
	}

	function loadStrings()
	{
		this.includeFiles("mod_rpgr_core/framework/strings");
	}

	function loadLibraries()
	{
		::include("mod_rpgr_core/framework/libraries/standard_library.nut");
		::include("mod_rpgr_core/framework/libraries/patcher_library.nut");
	}

	function loadFiles()
	{
		this.includeFiles("mod_rpgr_core/framework/classes");
		this.includeFiles("mod_rpgr_core/hooks");
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
		local queued = @() ::Core.Manager.initialise();

		if (this.isModernHooksInstalled())
		{
			::Core.Interfaces.ModernHooks.queue(">mod_msu", queued);
			return;
		}

		::mods_queue(::Core.ID, ">mod_msu", queued);
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
			::Hooks.registerJS(format("ui/mods/mod_rpgr_core/%s", _path));
			return;
		}

		::mods_registerJS(format("mod_rpgr_core/%s", _path));
	}

	function registerMod()
	{
		if (this.isModernHooksInstalled())
		{
			::Core.Interfaces.ModernHooks <- ::Hooks.register(::Core.ID, ::Core.Version, ::Core.Name);
			return;
		}

		::mods_registerMod(::Core.ID, ::Core.Version, ::Core.Name);
	}

	function updateIntegrationRegistry()
	{
		this.updateMSUState();
		this.updateModernHooksState();
	}

	function updateMSUState()
	{
		::Core.Internal.MSUFound <- "MSU" in ::getroottable();
	}

	function updateModernHooksState()
	{
		::Core.Internal.ModernHooksFound <- "Hooks" in ::getroottable();
	}
};