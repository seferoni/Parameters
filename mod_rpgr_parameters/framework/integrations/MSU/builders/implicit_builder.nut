::PRM.Integrations.MSU.Builders.Implicit <-
{
	function addSettingsImplicitly( _settingGroup, _pageID )
	{
		local elements = [];
		local booleanSettings = [];
		local sortedKeys = ::PRM.Standard.sortArrayAlphabetically(::PRM.Standard.getKeys(_settingGroup)); // TODO: should not be sorting by setting IDs, but rather by their user-facing string names.

		foreach( settingID in sortedKeys )
		{
			local settingValues = _settingGroup[settingID];

			if (!("Default" in settingValues))
			{
				settingValues.Default <- ::PRM.Integrations.MSU.getDefaultValue(settingID);
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

		elements.push(::PRM.Integrations.MSU.createDivider(format("%sDivider", _pageID)));
		elements.extend(booleanSettings);

		foreach( element in elements )
		{
			::PRM.Integrations.MSU.appendElementToPage(element, _pageID);
		}
	}

	function buildSettingElement( _settingID, _settingValues )
	{
		local settingElement = null;

		switch (typeof _settingValues.Default)
		{
			case ("bool"): settingElement = this.createBooleanSetting(_settingID, _settingValues); break;
			case ("string"): settingElement = this.createStringSetting(_settingID, _settingValues); break;
			case ("float"):
			case ("integer"): settingElement = this.createNumericalSetting(_settingID, _settingValues); break;
		}

		if (settingElement == null)
		{
			::PRM.Standard.log(format("Passed element with ID %s had an unexpected default value type, skipping for implicit construction.", _settingID), true);
			return;
		}

		::PRM.Integrations.MSU.buildDescription(settingElement);
		return settingElement;
	}

	function build()
	{
		local pageOrder = ::PRM.Integrations.MSU.getPageOrder();

		foreach( pageKey in pageOrder )
		{
			this.buildPage(pageKey);
			this.addSettingsImplicitly(::PRM.Database.Settings[pageKey], pageKey);
		}
	}

	function buildSettingOrderedMap( _settingGroup )
	{
		local orderedMap =
		{
			table = _settingGroup
		};

	}

	function buildPage( _pageID )
	{
		local pageName = ::PRM.Integrations.MSU.getPageName(_pageID);
		::PRM.Integrations.MSU.addPage(_pageID, pageName);
	}

	function createBooleanSetting( _settingID, _settingValues )
	{
		return ::MSU.Class.BooleanSetting
		(
			_settingID,
			_settingValues.Default,
			::PRM.Integrations.MSU.getElementName(_settingID)
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
			::PRM.Integrations.MSU.getElementName(_settingID)
		);
	}

	function createStringSetting( _settingID, _settingValues )
	{
		return ::MSU.Class.StringSetting
		(
			_settingID,
			_settingValues.Default,
			::PRM.Integrations.MSU.getElementName(_settingID)
		);
	}

	function sortSettingIDsByName( _settingIDArray )
	{
		// TODO: figure this out.
	}
};