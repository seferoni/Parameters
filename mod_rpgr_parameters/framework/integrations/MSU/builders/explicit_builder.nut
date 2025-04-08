::PRM.Integrations.MSU.Builders.Explicit <-
{
	function addPresetChangeCallback( _settingElement )
	{
		_settingElement.addCallback(function()
		{
			::PRM.Integrations.MSU.setPreset(this.getID());
			::PRM.Integrations.MSU.Builders.Explicit.resetPages();
			::PRM.Interfaces.MSU.ModSettings.resetSettings();
		});
	}

	function addTitle( _pageObject )
	{
		local titleElement = this.createPresetTitle();
		::PRM.Integrations.MSU.buildDescription(titleElement);
		_pageObject.addElement(titleElement);
	}

	function appendToPresetsPage( _settingElement )
	{
		::PRM.Integrations.MSU.appendElementToPage(_settingElement, this.getPageIDs().Presets);
	}

	function build()
	{
		this.buildPages();
		this.buildSettings();
	}

	function buildDivider()
	{
		local divider = ::PRM.Integrations.MSU.createDivider(this.getElementIDs().Dividers.Presets);
		this.appendToPresetsPage(divider);
	}

	function buildSettings()
	{
		local buttonIDs = this.getElementIDs().Buttons;
		# Execution order reflects the order of the buttons within the screen.
		this.buildPresetSetting(buttonIDs.Vanilla);
		this.buildPresetSetting(buttonIDs.Casual);
		this.buildPresetSetting(buttonIDs.Challenging);
		this.buildPresetSetting(buttonIDs.Unfair);
		this.buildDivider();
	}

	function buildPages()
	{
		local presetsPage = ::PRM.Integrations.MSU.addPage(this.getPageIDs().Presets, this.getPresetsPageName());
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
		::PRM.Integrations.MSU.buildDescription(_settingElement);
	}

	function createPresetSetting( _settingID )
	{
		return ::MSU.Class.ButtonSetting(_settingID, null, ::PRM.Integrations.MSU.getElementName(_settingID));
	}

	function createPresetTitle()
	{
		return ::MSU.Class.SettingsTitle(this.getElementIDs().Titles.Presets, this.getPresetTitleName());
	}

	function getElementIDs()
	{
		return ::PRM.Integrations.MSU.ElementIDs;
	}

	function getPageIDs()
	{
		return ::PRM.Integrations.MSU.PageIDs;
	}

	function getPagesForReset()
	{
		local pages = clone ::PRM.Integrations.MSU.getPages();
		delete pages[::PRM.Integrations.MSU.PageIDs.Presets];
		return pages;
	}

	function getPresetDescription( _presetValue )
	{
		return ::PRM.Integrations.MSU.getElementDescription(format("%sPreset", _presetValue));
	}

	function getPresetsPage()
	{
		return ::PRM.Integrations.MSU.getPage(this.getPageIDs().Presets);
	}

	function getPresetsPageName()
	{
		return ::PRM.Integrations.MSU.getElementName(this.getPageIDs().Presets);
	}

	function getPresetTitleName()
	{
		return ::PRM.Integrations.MSU.getElementName(this.getElementIDs().Titles.Presets);
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
		local defaultValue = ::PRM.Integrations.MSU.getDefaultValue(_settingElement.getID());

		if (defaultValue == null)
		{
			return;
		}

		_settingElement.setBaseValue(defaultValue);
	}
};