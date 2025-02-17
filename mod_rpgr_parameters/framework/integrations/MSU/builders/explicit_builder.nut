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
		::Parameters.Integrations.MSU.appendElementToPage(_settingElement, ::Parameters.Integrations.MSU.PageIDs.Presets);
	}

	function build()
	{
		this.buildPages();
		this.buildSettings();
	}

	function buildDivider()
	{
		local divider = this.createDivider(::Parameters.Integrations.MSU.ElementIDs.Dividers.Presets);
		this.appendToPresetsPage(divider);
	}

	function buildSettings()
	{
		local buttonIDs = ::Parameters.Integrations.MSU.ElementIDs.Buttons;
		this.buildPresetSetting(buttonIDs.Vanilla);
		this.buildDivider();
		this.buildPresetSetting(buttonIDs.Casual);
		this.buildPresetSetting(buttonIDs.Standard);
		this.buildPresetSetting(buttonIDs.Survival);
	}

	function buildPages()
	{
		local presetsPage = ::Parameters.Integrations.MSU.addPage(::Parameters.Integrations.MSU.PageIDs.Presets, this.getPresetsPageName());
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
		return ::MSU.Class.SettingsTitle(::Parameters.Integrations.MSU.ElementIDs.Titles.Presets, this.getPresetTitleName());
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
		return ::Parameters.Integrations.MSU.getPage(::Parameters.Integrations.MSU.PageIDs.Presets);
	}

	function getPresetsPageName()
	{	// TODO: this confuses me. why do it this way?
		return ::Parameters.Integrations.MSU.getElementName(::Parameters.Integrations.MSU.PageIDs.Presets);
	}

	function getPresetTitleName()
	{
		return ::Parameters.Integrations.MSU.getElementName(::Parameters.Integrations.MSU.ElementIDs.Titles.Presets);
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