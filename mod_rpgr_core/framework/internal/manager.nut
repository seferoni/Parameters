::Core.Internal.Manager <-
{
	function createTables()
	{
		::Core.Database <- {};
		::Core.Integrations <- {};
		::Core.Localisation <- {};
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
		this.createTables();
		this.loadHelpers();
		this.loadFiles();
		this.initialiseHelpers();

		if (!this.isMSUInstalled())
		{
			return;
		}

		::Core.Integrations.MSU.initialise();
	}

	function initialiseHelpers()
	{
		::Core.Localisation.Helper.initialise();
		::Core.Database.Helper.initialise();
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
		::include("mod_rpgr_core/framework/localisation/helper.nut");
		::include("mod_rpgr_core/framework/database/helper.nut");
	}

	function loadFiles()
	{
		this.includeFiles("mod_rpgr_core/framework/integrations");
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

		::mods_queue(::Core.ID, ">mod_msu", queued);
	}

	function register()
	{
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

		::mods_registerMod(::Core.ID, ::Core.Version, ::Core.Name);
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