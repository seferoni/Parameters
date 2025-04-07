::Parameters.Database <-
{
	function createTables()
	{
		this.Defaults <- {};
		this.Settings <- {};
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
		local defaults = this.getDefaults(_presetKey);

		if (_defaultKey in defaults)
		{
			return defaults[_defaultKey];
		}

		return null;
	}

	function getDefaults( _presetKey = "Standard" )
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
		this.loadFiles();
	}
};