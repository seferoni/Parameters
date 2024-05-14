::Core.Integrations.MSU.Builders.Implicit <-
{
	function addSettingImplicitly( _settingID, _dataTable, _pageObject )
	{
		local settingElement = null;

		switch (typeof _dataTable.Default)
		{
			case ("boolean"): settingElement = this.createBooleanSetting(_settingID, _dataTable, _pageObject); break;
			case ("float"):
			case ("integer"): settingElement = this.createNumericalSetting(_settingID, _dataTable, _pageObject); break;
		}

		if (settingElement == null)
		{
			::Core.Standard.log(format("Passed element with ID %s had an unexpected default value type, skipping for implicit construction.", _settingID), true);
			return;
		}

		::Core.Integrations.getMSUAPI().appendElementToPage(settingElement, _pageObject.getName());
	}

	function build()
	{

	}

	function buildImplicitly( _parameterTable, _pageObject )
	{

	}

	function buildSettingsTable()
	{
		// TODO: this needs to add the correct default field to the settings table (make a shallow copy)
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

	}
};