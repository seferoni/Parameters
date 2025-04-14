::PRM.Database <-
{
	function createTables()
	{
		this.Generic <- {};
		this.Defaults <- {};
		this.Settings <- {};
		this.SettingData <- {};
	}

	function loadFolder( _path )
	{
		::PRM.Manager.includeFiles(format("mod_rpgr_parameters/framework/database/%s", _path));
	}

	function loadFiles()
	{
		this.loadFolder("dictionaries");
		this.loadFolder("parameters/common");
		this.loadFolder("parameters/defaults");
		this.loadFolder("parameters/settings");
	}

	function getExactField( _tableName, _subTableName, _fieldName )
	{
		return this[_tableName][_subTableName][_fieldName];
	}

	function getField( _tableName, _fieldName = "" )
	{
		return this.getTopLevelField(_tableName, _fieldName);
	}

	function getIcon( _iconKey )
	{
		if (!_iconKey in this.Generic.Icons)
		{
			::WFR.Standard.log(format("Could not find image path corresponding to icon key %s.", _iconKey), true);
			return null;
		}

		return this.Generic.Icons[_iconKey];
	}

	function getTopLevelField( _tableName, _fieldName )
	{
		if (!(_tableName) in this)
		{
			::PRM.Standard.log(format("Could not find the specified database %s.", _tableName), true);
			return null;
		}

		if (_fieldName == "")
		{
			return this[_tableName];
		}

		if (!(_fieldName in this[_tableName]))
		{
			::PRM.Standard.log(format("Could not find %s in the specified database %s.", _fieldName, _tableName), true);
			return null;
		}

		return this[_tableName][_fieldName];
	}

	function getSettlementKeys()
	{
		return ::PRM.Standard.getKeys(this.Settings.Settlements);
	}

	function getWorldKeys()
	{
		return ::PRM.Standard.getKeys(this.Settings.World);
	}

	function getDefaultValueByPreset( _defaultKey, _presetKey )
	{
		local defaults = this.getDefaults(_presetKey);

		if (_defaultKey in defaults)
		{
			return defaults[_defaultKey];
		}

		foreach( settingCategory, settingTable in this.Settings )
		{
			if (!(_defaultKey in settingTable))
			{
				continue;
			}

			local settingProperties = settingTable[_defaultKey];

			if (!("Default" in settingProperties))
			{
				::PRM.Standard.log(format("Could not find default value for %s.", _defaultKey), true);
				return null;
			}

			return settingProperties.Default;
		}
	}

	function getDefaults( _presetKey )
	{
		return this.Defaults[_presetKey];
	}

	function initialise()
	{
		this.createTables();
		this.loadFiles();
	}
};