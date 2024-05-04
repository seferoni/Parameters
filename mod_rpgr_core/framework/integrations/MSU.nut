::Core.Integrations.MSU <-
{
	function addSettingByExtrapolation( _settingID, _dataTable, _pageObject )
	{
		switch (typeof _dataTable.Default)
		{
			case ("boolean"): return this.addBooleanSetting(_settingID, _dataTable, _pageObject);
			case ("float"):
			case ("integer"): return this.addNumericalSetting(_settingID, _dataTable, _pageObject);
		}
	}

	function addBooleanSetting( _settingID, _dataTable, _pageObject )
	{
		local properName = this.formatSettingName(_settingID);
		_pageObject.addBooleanSetting(_settingID, _dataTable.Default, properName);
	}

	function addNumericalSetting( _settingID, _dataTable, _pageObject )
	{
		local properName = this.formatSettingName(_settingID);
		_pageObject.addRangeSetting(_settingID, _dataTable.Default, _dataTable.Range[0], _dataTable.Range[1], _dataTable.Interval, properName);
	}

	function addPage( _string )
	{
		return ::Core.Mod.ModSettings.addPage(_string);
	}

	function build()
	{
		# Build all page objects through the MSU API.
		local pages = this.buildPages();

		# Get eligible data tables to be exposed as settings through the MSU settings panel.
		local parameters = this.getSettingsToBeBuiltImplicitly();

		# Loop through the Assets, World, and Settlements parameter tables.
		foreach( parameterType, parameterTable in parameters )
		{
			this.buildImplicitly(parameterTable, pages[category]);
		}
	}

	function buildDescription( _settingObject, _dataKey )
	{
		local description = this.getSettingDescription(_dataKey);
		_settingObject.setDescription(description);
	}

	function buildImplicitly( _parameterTable, _pageObject )
	{
		# Loop through individual data tables within each parameter type. Each data structure corresponds to an individual MSU setting.
		foreach( dataKey, dataTable in _parameterTable )
		{
			local setting = this.addSettingByExtrapolation(dataKey, dataTable, _pageObject);
			this.buildDescription(setting, dataKey);
		}
	}

	function buildPages()
	{
		local pages = {};

		# Internal database structuring for game parameter data is to be reflected in page segregation.
		local parameters = ::Core.Database.Helper.getParameters();

		foreach( category, table in parameters )
		{
			pages.category <- this.addPage(category);
		}

		return pages;
	}

	function createMSUInterface()
	{
		::Core.Interfaces.MSU <- ::MSU.Class.Mod(::Core.ID, ::Core.Version, ::Core.Name);
	}

	function getSettingDescription( _key )
	{
		return ::Core.Localisation.Helper.getSettingString(format("%sDescription", _key));
	}

	function getSettingName( _key )
	{
		return ::Core.Localisation.Helper.getSettingString(_key);
	}

	function getSettingsToBeBuiltImplicitly()
	{
		return ::Core.Database.Helper.getParameters();
	}

	function initialise()
	{
		this.createMSUInterface();
		this.build();
	}
};