::Core.Database <-
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
		this.loadFolder("parameters/defaults");
		this.loadFolder("parameters/settings");
	}

	function getDefaultValue( _presetKey, _defaultKey )
	{
		return this.getDefaults(_presetKey)[_defaultKey];
	}

	function getDefaults( _presetKey = "RPGR" )
	{
		return ::Core.Database.Parameters.Defaults[_presetKey];
	}

	function getParameterCategories()
	{
		return ::Core.Standard.getKeys(::Core.Database.Parameters);
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