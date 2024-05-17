::Core.Integrations.MSU.Builders.Implicit <-
{
	function addSettingImplicitly( _settingID, _dataTable, _pageID )
	{
		local settingElement = null;

		switch (typeof _dataTable.Default)
		{
			case ("boolean"): settingElement = this.createBooleanSetting(_settingID, _dataTable, _pageID); break;
			case ("float"):
			case ("integer"): settingElement = this.createNumericalSetting(_settingID, _dataTable, _pageID); break;
		}

		if (settingElement == null)
		{
			::Core.Standard.log(format("Passed element with ID %s had an unexpected default value type, skipping for implicit construction.", _settingID), true);
			return;
		}

		::Core.Integrations.getMSUSettingsAPI().buildDescription(settingElement, dataKey);
		::Core.Integrations.getMSUSettingsAPI().appendElementToPage(settingElement, _pageID);
	}

	function build()
	{
		# Get eligible data tables to be exposed as settings through the MSU settings panel.
		local parameters = this.getSettingsToBeBuiltImplicitly();

		# Loop through the Assets, World, and Settlements parameter tables.
		foreach( parameterType, parameterTable in parameters )
		{
			this.buildImplicitly(parameterTable, parameterType);
		}
	}

	function buildImplicitly( _parameterTable, _pageName )
	{
		# Loop through individual data tables within each parameter type. Each data structure corresponds to an individual MSU setting.
		foreach( dataKey, dataTable in _parameterTable )
		{
			dataTable.Default <- ::Core.Integrations.getMSUSettingsAPI().getDefaultValue(dataKey);
			this.addSettingImplicitly(dataKey, dataTable, _pageName);
		}
	}

	function createBooleanSetting( _settingID, _dataTable )
	{
		return ::MSU.Class.BooleanSetting(_settingID, _dataTable.Default, this.getSettingName(_settingID));
	}

	function createNumericalSetting( _settingID, _dataTable )
	{
		return ::MSU.Class.RangeSetting(_settingID, _dataTable.Default, _dataTable.Range[0], _dataTable.Range[1], _dataTable.Interval, this.getSettingName(_settingID));
	}

	function getSettingsToBeBuiltImplicitly()
	{
		return ::Core.Database.getSettingTables();
	}
};