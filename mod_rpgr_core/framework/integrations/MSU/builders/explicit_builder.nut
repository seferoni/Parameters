::Core.Integrations.MSU.Builders.Explicit <-
{
	function addPresetChangeCallback( _settingElement )
	{
		_settingElement.addCallback(function( _newValue )
		{
			this.setBaseValue(_newValue);
			::Core.Integrations.getMSUSettingsAPI().setPreset(_newValue);
			::Core.getManager().getMSUInterface().ModSettings.resetSettings();
		});
	}

	function appendToPresetsPage( _settingElement )
	{
		::Core.Integrations.getMSUSettingsAPI().appendElementToPage(_settingElement, this.IDs.Pages.Presets);
	}

	function build()
	{
		this.buildPages();
		this.buildPresetSetting();
	}

	function buildPages()
	{
		::Core.Integrations.getMSUSettingsAPI().addPage(this.IDs.Pages.Presets);
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
		::Core.Integrations.getMSUSettingsAPI().buildDescription(_settingElement);
	}

	function createPresetSetting()
	{
		// TODO: fill in settingID and defaultValue
		return ::MSU.Class.EnumSetting(_settingID, _defaultValue, this.getPresetKeys(), ::Core.Integrations.getMSUSettingsAPI().getSettingName(_settingID));
	}

	function getPresetKeys()
	{
		return ::Core.Database.getPresetKeys();
	}

	function getPagesForReset()
	{
		local pages = clone ::Core.Integrations.getMSUSettingsAPI().getPages();
		delete pages[this.IDs.Pages.Presets];
		return pages;
	}

	function getPresetKeyBySettingID( _settingID )
	{
		return ::Core.Standard.getKey(_settingID, this.IDs.Settings);
	}

	function getPresetsPage()
	{
		return ::Core.Integrations.getMSUSettingsAPI().getPage(this.IDs.Pages.Presets);
	}

	function resetSettings()
	{
		local pages = this.getPagesForReset();

		foreach( page in pages )
		{
			page.resetSettings();
		}
	}
};