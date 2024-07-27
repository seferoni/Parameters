::Core.Integrations.MSU.Builders.Explicit <-
{
	function addPresetChangeCallback( _settingElement )
	{
		_settingElement.addBeforeChangeCallback(function()
		{
			::Core.Integrations.MSU.setPreset(this.getID());
			::Core.Integrations.MSU.Builders.Explicit.resetPages();
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
		::Core.Integrations.MSU.appendElementToPage(_settingElement, this.getPresetsPageID());
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
		local elementIDs = this.getElementIDs();
		this.buildPresetSetting(elementIDs.Buttons.Vanilla);
		this.buildDivider();
		this.buildPresetSetting(elementIDs.Buttons.RPGREasy);
		this.buildPresetSetting(elementIDs.Buttons.RPGRStandard);
		this.buildPresetSetting(elementIDs.Buttons.RPGRHard);
	}

	function buildPages()
	{
		local presetsPage = ::Core.Integrations.MSU.addPage(this.getPresetsPageID(), this.getPresetsPageName());
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
		return ::MSU.Class.ButtonSetting(_settingID, this.getElementName(_settingID), "");
	}

	function createPresetTitle()
	{
		return ::Core.Integrations.MSU.CustomSettings.RPGRTitleSetting(this.getPresetTitleID(), "-5rem", this.getPresetTitleName());
	}

	function getElementIDs()
	{
		return ::Core.Integrations.MSU.ElementIDs;
	}

	function getElementName( _settingID )
	{
		return ::Core.Integrations.MSU.getElementName(_settingID);
	}

	function getParameters()
	{
		return ::Core.Integrations.MSU.Parameters;
	}

	function getPageIDs()
	{
		return ::Core.Integrations.MSU.PageIDs;
	}

	function getPagesForReset()
	{
		local pages = clone ::Core.Integrations.MSU.getPages();
		delete pages[this.getPageIDs().Presets];
		return pages;
	}

	function getPresetDescription( _presetValue )
	{
		return ::Core.Integrations.MSU.getElementDescription(format("%sPreset", _presetValue));
	}

	function getPresetsPage()
	{
		return ::Core.Integrations.MSU.getPage(this.getPresetsPageID());
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
		local defaultValue = ::Core.Integrations.MSU.getDefaultValue(_settingElement.getID());
		_settingElement.setBaseValue(defaultValue, true);
	}
};