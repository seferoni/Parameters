::Core.Integrations.MSU.Builders.Explicit <-
{
	function addPresetChangeCallback( _settingElement )
	{
		_settingElement.addBeforeChangeCallback(function()
		{
			::Core.Integrations.MSU.setPreset(this.getID());
			::Core.Integrations.MSU.Builders.Explicit.resetPages();
			::Core.Interfaces.MSU.ModSettings.resetSettings();
		});
	}

	function addTitle( _pageObject )
	{
		local titleElement = this.createPresetTitle();
		::Core.Integrations.MSU.buildDescription(titleElement);
		_pageObject.addElement(titleElement);
	}

	function appendToPresetsPage( _settingElement )
	{
		::Core.Integrations.MSU.appendElementToPage(_settingElement, ::Core.Integrations.MSU.PageIDs.Presets);
	}

	function build()
	{
		this.buildPages();
		this.buildSettings();
	}

	function buildDivider()
	{
		local divider = this.createDivider(::Core.Integrations.MSU.ElementIDs.Dividers.Presets);
		this.appendToPresetsPage(divider);
	}

	function buildSettings()
	{
		local buttonIDs = ::Core.Integrations.MSU.ElementIDs.Buttons;
		this.buildPresetSetting(buttonIDs.Vanilla);
		this.buildDivider();
		this.buildPresetSetting(buttonIDs.Easy);
		this.buildPresetSetting(buttonIDs.Standard);
		this.buildPresetSetting(buttonIDs.Hard);
	}

	function buildPages()
	{
		local presetsPage = ::Core.Integrations.MSU.addPage(::Core.Integrations.MSU.PageIDs.Presets, this.getPresetsPageName());
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
		::Core.Integrations.MSU.buildDescription(_settingElement);
	}

	function createDivider( _elementID )
	{
		return ::MSU.Class.SettingsDivider(_elementID);
	}

	function createPresetSetting( _settingID )
	{
		return ::MSU.Class.ButtonSetting(_settingID, null, ::Core.Integrations.MSU.getElementName(_settingID));
	}

	function createPresetTitle()
	{
		return ::MSU.Class.SettingsTitle(::Core.Integrations.MSU.ElementIDs.Titles.Presets, this.getPresetTitleName());
	}

	function getPagesForReset()
	{
		local pages = clone ::Core.Integrations.MSU.getPages();
		delete pages[::Core.Integrations.MSU.PageIDs.Presets];
		return pages;
	}

	function getPresetDescription( _presetValue )
	{
		return ::Core.Integrations.MSU.getElementDescription(format("%sPreset", _presetValue));
	}

	function getPresetsPage()
	{
		return ::Core.Integrations.MSU.getPage(::Core.Integrations.MSU.PageIDs.Presets);
	}

	function getPresetsPageName()
	{
		return ::Core.Integrations.MSU.getElementName(::Core.Integrations.MSU.PageIDs.Presets);
	}

	function getPresetTitleName()
	{
		return ::Core.Integrations.MSU.getElementName(::Core.Integrations.MSU.ElementIDs.Titles.Presets);
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
		local defaultValue = ::Core.Integrations.MSU.getDefaultValue(_settingElement.getID());
		_settingElement.setBaseValue(defaultValue);
	}
};