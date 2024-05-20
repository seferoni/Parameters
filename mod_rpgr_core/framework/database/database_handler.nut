::Core.Database <-
{
	function createTables()
	{
		this.Parameters <- {};
		this.Parameters.Defaults <- {};
		this.Parameters.Settings <- {};
	}

	function createDefaultsTables()
	{
		this.Parameters.Defaults.RPGR <- {};
		this.Parameters.Defaults.Vanilla <- {};
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
		return this.Parameters.Defaults[_presetKey];
	}

	function getPresetKeys()
	{
		return ::Core.Standard.getKeys(this.Parameters.Defaults);
	}

	function getParameterCategories()
	{
		return ::Core.Standard.getKeys(this.Parameters.Settings);
	}

	function getSettingTables()
	{
		return this.Parameters.Settings;
	}

	function initialise()
	{
		this.createTables();
		this.createDefaultsTables();
		this.loadFiles();
	}
};