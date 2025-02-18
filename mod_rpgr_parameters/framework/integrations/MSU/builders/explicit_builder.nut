::Parameters.Integrations.MSU.Builders.Explicit <-
{
	function addPresetChangeCallback( _settingElement )
	{
		_settingElement.addCallback(function()
		{
			::Parameters.Integrations.MSU.setPreset(this.getID());
			::Parameters.Integrations.MSU.Builders.Explicit.resetPages();
			::Parameters.Interfaces.MSU.ModSettings.resetSettings();
		});
	}

	function addTitle( _pageObject )
	{
		local titleElement = this.createPresetTitle();
		::Parameters.Integrations.MSU.buildDescription(titleElement);
		_pageObject.addElement(titleElement);
	}

	function appendToPresetsPage( _settingElement )
	{
		::Parameters.Integrations.MSU.appendElementToPage(_settingElement, this.getPageIDs().Presets);
	}

	function build()
	{
		this.buildPages();
		this.buildSettings();
	}

	function buildDivider()
	{
		local divider = this.createDivider(this.getElementIDs().Dividers.Presets);
		this.appendToPresetsPage(divider);
	}

	function buildSettings()
	{
		local buttonIDs = this.getElementIDs().Buttons;
		this.buildPresetSetting(buttonIDs.Vanilla);
		this.buildPresetSetting(buttonIDs.Casual);
		this.buildPresetSetting(buttonIDs.Standard);
		this.buildPresetSetting(buttonIDs.Survival);
		this.buildDivider();
	}

	function buildPages()
	{
		local presetsPage = ::Parameters.Integrations.MSU.addPage(this.getPageIDs().Presets, this.getPresetsPageName());
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
		::Parameters.Integrations.MSU.buildDescription(_settingElement);
	}

	function createDivider( _elementID )
	{
		return ::MSU.Class.SettingsDivider(_elementID);
	}

	function createPresetSetting( _settingID )
	{
		return ::MSU.Class.ButtonSetting(_settingID, null, ::Parameters.Integrations.MSU.getElementName(_settingID));
	}

	function createPresetTitle()
	{
		return ::MSU.Class.SettingsTitle(this.getElementIDs().Titles.Presets, this.getPresetTitleName());
	}

	function getElementIDs()
	{
		return ::Parameters.Integrations.MSU.ElementIDs;
	}

	function getPageIDs()
	{
		return ::Parameters.Integrations.MSU.PageIDs;
	}

	function getPagesForReset()
	{
		local pages = clone ::Parameters.Integrations.MSU.getPages();
		delete pages[::Parameters.Integrations.MSU.PageIDs.Presets];
		return pages;
	}

	function getPresetDescription( _presetValue )
	{
		return ::Parameters.Integrations.MSU.getElementDescription(format("%sPreset", _presetValue));
	}

	function getPresetsPage()
	{
		return ::Parameters.Integrations.MSU.getPage(this.getPageIDs().Presets);
	}

	function getPresetsPageName()
	{
		return ::Parameters.Integrations.MSU.getElementName(this.getPageIDs().Presets);
	}

	function getPresetTitleName()
	{
		return ::Parameters.Integrations.MSU.getElementName(this.getElementIDs().Titles.Presets);
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
		local defaultValue = ::Parameters.Integrations.MSU.getDefaultValue(_settingElement.getID());
		_settingElement.setBaseValue(defaultValue);
	}
};