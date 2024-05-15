::Core.Database.Manager <-
{
	function createTables()
	{
		::Core.Database.Parameters <- {};
		::Core.Database.Parameters.Defaults <- {};
		::Core.Database.Parameters.Settings <- {};
	}

	function createDefaultsTables()
	{
		::Core.Database.Parameters.Defaults.RPGR <- {};
		::Core.Database.Parameters.Defaults.Vanilla <- {};
	}

	function loadFolder( _path )
	{
		::Core.getManager().includeFiles(format("mod_rpgr_core/framework/database/%s", _path));
	}

	function loadFiles()
	{
		this.loadFolder("parameters/defaults/rpgr");
		this.loadFolder("parameters/defaults/vanilla");
		this.loadFolder("parameters/settings");
	}

	function getDefaults( _presetKey )
	{
		return ::Core.Database.Parameters.Defaults[_presetKey];
	}

	function getParameter( _key )
	{

	}

	function getParameterCategories()
	{
		return ::Core.Standard.getKeys(::Core.Database.Parameters);
	}

	function getParametersAggregated()
	{

	}

	function getSettingTables()
	{
		return ::Core.Database.Parameters.Settings;
	}

	function initialise()
	{
		this.createTables();
		this.createDefaultsTables();
		this.loadFiles();
	}
};