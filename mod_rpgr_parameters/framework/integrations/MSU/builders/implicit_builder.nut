::Parameters.Integrations.MSU.Builders.Implicit <-
{
	function addSettingsImplicitly( _settingGroup, _pageID )
	{
		local elements = [];
		local booleanSettings = [];

		foreach( settingID, settingValues in _settingGroup )
		{
			if (!("Default" in settingValues))
			{
				settingValues.Default <- ::Parameters.Integrations.MSU.getDefaultValue(settingID);
			}

			local settingElement = this.buildSettingElement(settingID, settingValues);

			if (settingElement == null)
			{
				continue;
			}

			if (settingElement instanceof ::MSU.Class.BooleanSetting)
			{
				booleanSettings.push(settingElement);
				continue;
			}

			elements.push(settingElement);
		}

		elements.push(::Parameters.Integrations.MSU.createDivider(format("%sDivider", _pageID)));
		elements.extend(booleanSettings);

		foreach( element in elements )
		{
			::Parameters.Integrations.MSU.appendElementToPage(element, _pageID);
		}
	}

	function buildSettingElement( _settingID, _settingValues )
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
		return settingElement;
	}

	function build()
	{
		foreach( pageID, settingGroup in ::Parameters.Database.Settings )
		{
			this.buildPage(pageID);
			this.addSettingsImplicitly(settingGroup, pageID);
		}
	}

	function buildPage( _pageID )
	{
		local pageName = ::Parameters.Integrations.MSU.getPageName(_pageID);
		::Parameters.Integrations.MSU.addPage(_pageID, pageName);
	}

	function createBooleanSetting( _settingID, _settingValues )
	{
		return ::MSU.Class.BooleanSetting
		(
			_settingID,
			_settingValues.Default,
			::Parameters.Integrations.MSU.getElementName(_settingID)
		);
	}

	function createNumericalSetting( _settingID, _settingValues )
	{
		return ::MSU.Class.RangeSetting
		(
			_settingID,
			_settingValues.Default,
			_settingValues.Range[0],
			_settingValues.Range[1],
			_settingValues.Interval,
			::Parameters.Integrations.MSU.getElementName(_settingID)
		);
	}
};