::Parameters.Database <-
{
	function createTables()
	{
		this.Defaults <- {};
		this.Settings <- {};
	}

	function createDefaultsTables()
	{
		this.Defaults.RPGR <- {};
		this.Defaults.Vanilla <- {};
	}

	function loadFolder( _path )
	{
		::Parameters.Manager.includeFiles(format("mod_rpgr_parameters/framework/database/%s", _path));
	}

	function loadFiles()
	{
		this.loadFolder("parameters/defaults");
		this.loadFolder("parameters/settings");
	}

	function getSettlementKeys()
	{
		return ::Parameters.Standard.getKeys(this.Settings.Settlements);
	}

	function getWorldKeys()
	{
		return ::Parameters.Standard.getKeys(this.Settings.World);
	}

	function getDefaultValue( _presetKey, _defaultKey )
	{
		return this.getDefaults(_presetKey)[_defaultKey];
	}

	function getDefaults( _presetKey = "RPGR" )
	{
		return this.Defaults[_presetKey];
	}

	function getPresetKeys()
	{
		return ::Parameters.Standard.getKeys(this.Defaults);
	}

	function getSettingCategories()
	{
		return ::Parameters.Standard.getKeys(this.Settings);
	}

	function initialise()
	{
		this.createTables();
		this.createDefaultsTables();
		this.loadFiles();
	}
};