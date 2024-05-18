::Core.Integrations.MSU.Builders.Explicit <-
{
	IDs =
	{
		PresetsPage = "Presets",
		RPGRPreset = "RPGRPreset",
		VanillaPreset = "VanillaPreset"
	}

	function addPresetChangeCallbacks( _settingElement )
	{
		_settingElement.addBeforeChangeCallback(this.onBeforePresetChangeCallback);
		_settingElement.addAfterChangeCallback(this.onAfterPresetChangeCallback);
	}

	function appendToPresetsPage( _settingElement )
	{
		::Core.Integrations.getMSUSettingsAPI().appendElementToPage(_settingElement, this.IDs.PresetsPage);
	}

	function build()
	{
		this.buildPresets();
	}

	function buildPresets()
	{
		this.buildPresetSetting(this.IDs.RPGRPreset, true);
		this.buildPresetSetting(this.IDs.VanillaPreset, false);
	}

	function buildPresetSetting( _settingID, _defaultValue )
	{
		local setting = ::MSU.Class.BooleanSetting(_settingID, _defaultValue);
		this.addPresetChangeCallbacks(setting);
		this.buildPresetSettingDescription(setting);
		this.appendToPresetsPage(setting);
	}

	function buildPresetSettingDescription( _settingElement )
	{
		::Core.Integrations.getMSUSettingsAPI().buildDescription(_settingElement);
	}

	function createBooleanSetting( _settingID, _defaultValue )
	{
		return ::MSU.Class.BooleanSetting(_settingID, _defaultValue, ::Core.Integrations.getMSUSettingsAPI().getSettingDescription(_settingName));
	}

	function getAllPresetSettings()
	{
		return this.getPresetsPage().getAllElementsAsArray();
	}

	function getPagesForReset()
	{
		local pages = clone ::Core.Integrations.getMSUSettingsAPI().getPages();
		pages.rawdelete(this.IDs.PresetsPage);
		return pages;
	}

	function getPresetKeyBySettingID( _settingID )
	{
		return ::Core.Standard.getKey(_settingID, this.IDs);
	}

	function getPresetsPage()
	{
		return ::Core.Integrations.getMSUSettingsAPI().getPage(this.IDs.PresetsPage);
	}

	function onBeforePresetChangeCallback( _newValue )
	{
		local settings = ::Core.Integrations.getMSUSettingsAPI().getExplicitBuilder().getAllPresetSettings();

		foreach( setting in setting )
		{
			setting.set(false);
		}
	}

	function onAfterPresetChangeCallback( _oldValue )
	{
		::Core.Integrations.getMSUSettingsAPI().setPreset(this.getID());
		::Core.Integrations.getMSUSettingsAPI().getExplicitBuilder().resetSettings();
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