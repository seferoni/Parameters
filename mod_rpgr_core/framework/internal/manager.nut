::Core.Internal.Manager <-
{
	function createTables()
	{
		::Core.Database <- {};
		::Core.Integrations <- {};
		::Core.Interfaces <- {};
		::Core.Strings <- {};
		::Core.Classes <- {};
	}

	function createInterfaces()
	{
		::Core.Interfaces.MSU <- null;
		::Core.Interfaces.ModernHooks <- null;
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

	function getModernHooksInterface()
	{
		return ::Core.Interfaces.ModernHooks;
	}

	function getMSUInterface()
	{
		return ::Core.Interfaces.MSU;
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
		this.createTables();
		this.createInterfaces();
		this.loadHelpers();
		this.loadFiles();
		this.initialiseBackend();
	}

	function initialiseBackend()
	{
		::Core.Database.Manager.initialise();
		::Core.Integrations.Manager.initialise();
	}

	function includeFiles( _path )
	{
		local filePaths = ::IO.enumerateFiles(_path);

		foreach( file in filePaths )
		{
			::include(file);
		}
	}

	function loadHelpers()
	{
		::include("mod_rpgr_core/framework/database/helper.nut");
		::include("mod_rpgr_core/framework/integrations/helper.nut");
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
		local queued = @() ::Core.getManager().initialise();

		if (this.isModernHooksInstalled())
		{
			::Core.getModernHooksInterface().queue(">mod_msu", queued);
			return;
		}

		::Core.Integrations.Manager.getModdingScriptHooksAPI().queue(">mod_msu", queued);
	}

	function register()
	{
		this.updateModernHooksState();
		this.updateMSUState();
		this.formatVersion();
		this.registerMod();
	}

	function registerMod()
	{
		if (this.isModernHooksInstalled())
		{
			::Core.Interfaces.ModernHooks = ::Hooks.register(::Core.ID, ::Core.Version, ::Core.Name);
			return;
		}

		::Core.Integrations.Manager.getModdingScriptHooksAPI().register();
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