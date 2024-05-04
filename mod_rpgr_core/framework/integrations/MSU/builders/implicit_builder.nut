::Core.Integrations.MSU.Builders.Implicit <-
{
	function addSettingImplicitly( _settingID, _dataTable, _pageObject )
	{
		switch (typeof _dataTable.Default)
		{
			case ("boolean"): return ::Core.Integrations.MSU.addBooleanSetting(_settingID, _dataTable, _pageObject);
			case ("float"):
			case ("integer"): return ::Core.Integrations.MSU.addNumericalSetting(_settingID, _dataTable, _pageObject);
		}
	}

	function build()
	{
		# Get eligible data tables to be exposed as settings through the MSU settings panel.
		local parameters = this.getSettingsToBeBuiltImplicitly();

		# Loop through the Assets, World, and Settlements parameter tables.
		foreach( parameterType, parameterTable in parameters )
		{
			this.buildImplicitly(parameterTable, pages[category]);
		}
	}

	function buildImplicitly( _parameterTable, _pageObject )
	{
		# Loop through individual data tables within each parameter type. Each data structure corresponds to an individual MSU setting.
		foreach( dataKey, dataTable in _parameterTable )
		{
			local setting = this.addSettingImplicitly(dataKey, dataTable, _pageObject);
			::Core.Integrations.MSU.buildDescription(setting, dataKey);
		}
	}

	function getSettingsToBeBuiltImplicitly()
	{
		return ::Core.Database.Helper.getParameters();
	}
};