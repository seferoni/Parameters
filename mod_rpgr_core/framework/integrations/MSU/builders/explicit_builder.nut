::Core.Integrations.MSU.Builders.Explicit <-
{
	function addPresetChangeCallback( _settingElement )
	{	// TODO: enum setting needs to update description after every change!
		_settingElement.addCallback(function( _newValue )
		{
			this.setBaseValue(_newValue);
			::Core.Integrations.getMSUSettingsAPI().setPreset(_newValue);
			::Core.getManager().getMSUInterface().ModSettings.resetSettings(); // TODO: this will cause a stack overflow
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
		::Core.Integrations.getMSUSettingsAPI().addPage(this.getPresetsPageID());
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
		return ::MSU.Class.EnumSetting(this.getPresetSettingID(), this.getDefaultPreset(), this.getPresetKeys(), this.getPresetSettingName());
	}

	function getDefaultPreset()
	{
		return ::Core.Integrations.getMSUSettingsAPI().Parameters.DefaultPreset;
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
		return ::Core.Integrations.getMSUSettingsAPI().ElementIDs.Pages.Presets;
	}

	function getPresetSettingID()
	{
		return ::Core.Integrations.getMSUSettingsAPI().ElementIDs.Settings.Presets;
	}

	function getPresetSettingName()
	{
		return ::Core.Integrations.getMSUSettingsAPI().getSettingName(this.getPresetSettingID());
	}
};