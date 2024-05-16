::Core.Integrations.MSU.Builders.Explicit <-
{
	function addPresetChangeCallbacks( _settingElement )
	{
		_settingElement.addBeforeChangeCallback(this.onBeforePresetChangeCallback);
		_settingElement.addAfterChangeCallback(this.onAfterPresetChangeCallback);
	}

	function appendToPresetsPage( _settingElement )
	{
		::Core.Integrations.Manager.getMSUSettingsAPI().appendElementToPage(_settingElement, this.getPresetsKey());
	}

	function build()
	{
		this.buildPresets();
	}

	function buildPresets()
	{
		this.buildPresetSetting("PresetsRPGR", true);
		this.buildPresetSetting("PresetsVanilla", false);
	}

	function buildPresetSetting( _settingID, _defaultValue )
	{
		local setting = ::MSU.Class.BooleanSetting(_settingID, _defaultValue);
		this.addPresetChangeCallbacks(setting);
		this.setPresetSettingDescription(setting);
		this.appendToPresetsPage(setting);
	}

	function createBooleanSetting( _settingID, _defaultValue )
	{
		return ::MSU.Class.BooleanSetting(_settingID, _defaultValue, ::Core.Integrations.Manager.getMSUSettingsAPI().getSettingDescription(_settingName));
	}

	function getAllPresetSettings()
	{
		return this.getPresetsPage().getAllElementsAsArray();
	}

	function getPagesForReset()
	{
		local pages = clone ::Core.Integrations.Manager.getMSUSettingsAPI().getPages();
		pages.rawdelete(this.getPresetsKey());
		return pages;
	}

	function getPresetsKey()
	{
		return "Presets";
	}

	function getPresetsPage()
	{
		return ::Core.Integrations.Manager.getMSUSettingsAPI().getPage(this.getPresetsKey());
	}

	function onBeforePresetChangeCallback( _newValue )
	{
		local settings = ::Core.Integrations.Manager.getMSUSettingsAPI().getExplicitBuilder().getAllPresetSettings();

		foreach( setting in setting )
		{
			setting.set(false);
		}
	}

	function onAfterPresetChangeCallback( _oldValue )
	{
		::Core.Integrations.Manager.getMSUSettingsAPI().setPreset(this.getID());
		::Core.Integrations.Manager.getMSUSettingsAPI().getExplicitBuilder().resetSettings();
	}

	function resetSettings()
	{
		local pages = this.getPagesForReset();

		foreach( page in pages )
		{
			page.resetSettings();
		}
	}

	function setPresetSettingDescription( _settingElement )
	{	// TODO: shouldn't the MSU API handle this?
		local description = ::Core.Integrations.Manager.getMSUSettingsAPI().getSettingDescription(_settingElement.getID());
		_settingElement.setDescription(description);
	}
};