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

	function getMSUInterface()
	{
		return ::Core.Interfaces.MSU;
	}

	function getModernHooksInterface()
	{
		return ::Core.Interfaces.ModernHooks;
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
		this.loadManagers();
		this.initialiseBackend();
		this.loadFiles();
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

	function loadManagers()
	{
		::include("mod_rpgr_core/framework/database/manager.nut");
		::include("mod_rpgr_core/framework/integrations/manager.nut");
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
			this.getModernHooksInterface().queue(">mod_msu", queued);
			return;
		}

		::mods_queue(::Core.ID, ">mod_msu", queued);
	}

	function register()
	{
		this.updateIntegrationRegistry();
		this.formatVersion();
		this.registerMod();
	}

	function registerMod()
	{
		if (this.isMSUInstalled())
		{
			::Core.Interfaces.MSU <- ::MSU.Class.Mod(::Core.ID, ::Core.Version, ::Core.Name);
		}

		if (this.isModernHooksInstalled())
		{
			::Core.Interfaces.ModernHooks = ::Hooks.register(::Core.ID, ::Core.Version, ::Core.Name);
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