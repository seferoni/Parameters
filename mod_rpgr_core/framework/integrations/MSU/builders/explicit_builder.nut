::Core.Integrations.MSU.Builders.Explicit <-
{
	function addPresetChangeCallback( _settingElement )
	{	// TODO: enum setting needs to update description after every change!
		_settingElement.addBeforeChangeCallback(function( _newValue )
		{
			this.setBaseValue(_newValue);
			::Core.Integrations.getMSUSettingsAPI().setPreset(_newValue);
			::Core.Integrations.getMSUSettingsAPI().getExplicitBuilder().buildPresetSettingDescription(this); // TODO: settings are not being updated appropriately
			::Core.Integrations.getMSUSettingsAPI().getExplicitBuilder().resetPages();
		});
	}

	function appendToPresetsPage( _settingElement )
	{
		::Core.Integrations.getMSUSettingsAPI().appendElementToPage(_settingElement, this.getPresetsPageID());
	}

	function build()
	{
		this.buildPages();
		this.buildPresetSetting();
	}

	function buildPages()
	{
		local presetsPage = ::Core.Integrations.getMSUSettingsAPI().addPage(this.getPresetsPageID(), this.getPresetsPageName());
		presetsPage.addTitle(this.getPresetTitleID(), this.getPresetTitleName());
	}

	function buildPresetSetting()
	{
		local setting = this.createPresetSetting();
		this.addPresetChangeCallback(setting);
		this.buildPresetSettingDescription(setting);
		this.appendToPresetsPage(setting);
	}

	function buildPresetSettingDescription( _settingElement )
	{
		local currentValue = _settingElement.getValue();
		_settingElement.setDescription(this.getPresetDescription(currentValue));
	}

	function createPresetSetting()
	{
		return ::MSU.Class.EnumSetting(this.getPresetSettingID(), this.getDefaultPreset(), this.getPresetKeys(), this.getPresetSettingName());
	}

	function getDefaultPreset()
	{
		return this.getParameters().DefaultPreset;
	}

	function getElementIDs()
	{
		return ::Core.Integrations.getMSUSettingsAPI().ElementIDs;
	}

	function getElementName( _settingID )
	{
		return ::Core.Integrations.getMSUSettingsAPI().getElementName(_settingID);
	}

	function getParameters()
	{
		return ::Core.Integrations.getMSUSettingsAPI().Parameters;
	}

	function getPageIDs()
	{
		return ::Core.Integrations.getMSUSettingsAPI().PageIDs;
	}

	function getPagesForReset()
	{
		local pages = clone ::Core.Integrations.getMSUSettingsAPI().getPages();
		delete pages[this.getPageIDs().Presets];
		return pages;
	}

	function getPresetDescription( _presetValue )
	{
		return ::Core.Integrations.getMSUSettingsAPI().getElementDescription(format("%sPreset", _presetValue));
	}

	function getPresetKeys()
	{
		return ::Core.Database.getPresetKeys();
	}

	function getPresetsPage()
	{
		return ::Core.Integrations.getMSUSettingsAPI().getPage(this.getPresetsPageID());
	}

	function getPresetsPageID()
	{
		return this.getPageIDs().Presets;
	}

	function getPresetSettingID()
	{
		return this.getElementIDs().Settings.Presets;
	}

	function getPresetTitleID()
	{
		return this.getElementIDs().Titles.Presets;
	}

	function getPresetsPageName()
	{
		return this.getElementName(this.getPresetsPageID());
	}

	function getPresetSettingName()
	{
		return this.getElementName(this.getPresetSettingID());
	}

	function getPresetTitleName()
	{
		return this.getElementName(this.getPresetTitleID());
	}

	function resetPages()
	{
		local pages = this.getPagesForReset();

		foreach( page in pages )
		{
			page.getAllElementsAsArray(::MSU.Class.AbstractSetting).apply(this.updateSettingBaseValue);
		}
	}

	function updateSettingBaseValue( _settingElement )
	{
		local defaultValue = ::Core.Integrations.getMSUSettingsAPI().getDefaultValue(_settingElement.getID());
		_settingElement.setBaseValue(defaultValue, true);
	}
};