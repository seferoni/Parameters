::Parameters.Integrations.MSU.Builders.Implicit <-
{
	function addSettingImplicitly( _settingID, _settingValues, _pageID )
	{
		local settingElement = null;

		switch (typeof _settingValues.Default)
		{
			case ("bool"): settingElement = this.createBooleanSetting(_settingID, _settingValues); break;
			case ("float"):
			case ("integer"): settingElement = this.createNumericalSetting(_settingID, _settingValues); break;
		}

		if (settingElement == null)
		{
			::Parameters.Standard.log(format("Passed element with ID %s had an unexpected default value type, skipping for implicit construction.", _settingID), true);
			return;
		}

		::Parameters.Integrations.MSU.buildDescription(settingElement);
		::Parameters.Integrations.MSU.appendElementToPage(settingElement, _pageID);
	}

	function build()
	{
		this.buildPages();

		# Loop through the Assets, World, and Settlements parameter tables.
		foreach( pageName, settingGroup in ::Parameters.Database.Settings )
		{
			this.buildImplicitly(pageName, settingGroup);
		}
	}

	function buildPages()
	{
		# Internal database structuring for game parameter data is to be reflected in page segregation.
		local pageNames = ::Parameters.Database.getSettingCategories();

		foreach( pageName in pageNames )
		{
			::Parameters.Integrations.MSU.addPage(pageName);
		}
	}

	function buildImplicitly( _pageName, _settingGroup )
	{
		foreach( settingID, settingValues in _settingGroup )
		{
			settingValues.Default <- ::Parameters.Integrations.MSU.getDefaultValue(settingID);
			this.addSettingImplicitly(settingID, settingValues, _pageName);
		}
	}

	function createBooleanSetting( _settingID, _settingValues )
	{
		return ::MSU.Class.BooleanSetting(_settingID, _settingValues.Default, ::Parameters.Integrations.MSU.getElementName(_settingID));
	}

	function createNumericalSetting( _settingID, _settingValues )
	{
		return ::MSU.Class.RangeSetting(_settingID, _settingValues.Default, _settingValues.Range[0], _settingValues.Range[1], _settingValues.Interval, ::Parameters.Integrations.MSU.getElementName(_settingID));
	}
};