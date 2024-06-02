::Core.Integrations.MSU.Builders.Explicit <-
{
	function addPresetChangeCallback( _settingElement )
	{
		_settingElement.addBeforeChangeCallback(function()
		{
			::Core.Integrations.getMSUSettingsAPI().setPreset(this.getName());
			::Core.Integrations.getMSUSettingsAPI().getExplicitBuilder().resetPages();
		});
	}

	function addTitle( _pageObject )
	{
		local titleElement = this.createPresetTitle();
		_pageObject.addElement(titleElement);
	}

	function appendToPresetsPage( _settingElement )
	{
		::Core.Integrations.getMSUSettingsAPI().appendElementToPage(_settingElement, this.getPresetsPageID());
	}

	function build()
	{
		this.buildPages();
		this.buildSettings();
	}

	function buildSettings()
	{
		local elementIDs = this.getElementIDs();
		this.buildPresetSetting(elementIDs.Settings.RPGRPreset);
		this.buildPresetSetting(elementIDs.Settings.VanillaPreset);
	}

	function buildPages()
	{
		local presetsPage = ::Core.Integrations.getMSUSettingsAPI().addPage(this.getPresetsPageID(), this.getPresetsPageName());
		this.addTitle(presetsPage);
	}

	function buildPresetSetting( _settingID )
	{
		local setting = this.createPresetSetting(_settingID);
		this.addPresetChangeCallback(setting);
		this.buildPresetSettingDescription(setting);
		this.appendToPresetsPage(setting);
	}

	function buildPresetSettingDescription( _settingElement )
	{
		::Core.Integrations.getMSUSettingsAPI().buildDescription(_settingElement);
	}

	function createPresetSetting( _settingID )
	{
		return ::MSU.Class.ButtonSetting(_settingID, this.getElementName(_settingID), this.getElementName(_settingID));
	}

	function createPresetTitle()
	{
		return ::Core.Integrations.MSU.CustomSettings.RPGRTitleSetting(this.getPresetTitleID(), "-5rem", this.getPresetTitleName()); // TODO: remember, this needs a description
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

	function getPresetsPage()
	{
		return ::Core.Integrations.getMSUSettingsAPI().getPage(this.getPresetsPageID());
	}

	function getPresetsPageID()
	{
		return this.getPageIDs().Presets;
	}

	function getPresetTitleID()
	{
		return this.getElementIDs().Titles.Presets;
	}

	function getPresetsPageName()
	{
		return this.getElementName(this.getPresetsPageID());
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