::PRM.Database <-
{
	function createTables()
	{
		this.Generic <- {};
		this.Defaults <- {};
		this.Settings <- {};
	}

	function loadFolder( _path )
	{
		::PRM.Manager.includeFiles(format("mod_rpgr_parameters/framework/database/%s", _path));
	}

	function loadFiles()
	{
		this.loadFolder("dictionaries");
		this.loadFolder("parameters/defaults");
		this.loadFolder("parameters/settings");
	}

	function getExactField( _tableName, _subTableName, _fieldName )
	{
		return this[_tableName][_subTableName][_fieldName];
	}

	function getField( _tableName, _fieldName )
	{
		local field = this.getTopLevelField(_tableName, _fieldName);

		if (field == null)
		{
			::PRM.Standard.log(format("Could not find %s in the specified database %s.", _fieldName, _tableName), true);
		}

		return field;
	}

	function getTopLevelField( _tableName, _fieldName )
	{
		if (!(_fieldName in this[_tableName]))
		{
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

	function getDefaultValue( _presetKey, _defaultKey )
	{
		local defaults = this.getDefaults(_presetKey);

		if (_defaultKey in defaults)
		{
			return defaults[_defaultKey];
		}

		return null;
	}

	function getDefaults( _presetKey = "Challenging" )
	{
		return this.Defaults[_presetKey];
	}

	function getPresetKeys()
	{
		return ::PRM.Standard.getKeys(this.Defaults);
	}

	function getSettingCategories()
	{
		return ::PRM.Standard.getKeys(this.Settings);
	}

	function initialise()
	{
		this.createTables();
		this.loadFiles();
	}
};