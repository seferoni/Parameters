::Core.Integrations.MSU.Builders.Explicit <-
{
	function addPresetChangeCallbacks( _settingElement )
	{
		_settingElement.addBeforeChangeCallback(this.onBeforePresetChangeCallback);
		_settingElement.addAfterChangeCallback(this.onAfterPresetChangeCallback);
	}

	function appendToPresetsPage( _settingElement )
	{
		::Core.Integrations.Manager.getMSUAPI().appendElementToPage(_settingElement, "Presets");
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
		return ::MSU.Class.BooleanSetting(_settingID, _defaultValue, ::Core.Integrations.Manager.getMSUAPI().getSettingDescription(_settingName));
	}

	function getAllPresetSettings()
	{
		return this.getPresetsPage().getAllElementsAsArray();
	}

	function getPagesForReset()
	{
		local pages = clone ::Core.Integrations.Manager.getMSUAPI().getPages();
		pages.rawdelete("Presets");
		return pages;
	}

	function getPresetsPage()
	{
		return ::Core.Integrations.Manager.getMSUAPI().getPage("Presets");
	}

	function onBeforePresetChangeCallback( _newValue )
	{
		local settings = ::Core.Integrations.Manager.getMSUAPI().getExplicitBuilder().getAllPresetSettings();

		foreach( setting in setting )
		{
			setting.set(false);
		}
	}

	function onAfterPresetChangeCallback( _oldValue )
	{
		::Core.Integrations.Manager.getMSUAPI().setPreset(this.getID());
		::Core.Integrations.Manager.getMSUAPI().getExplicitBuilder().resetSettings();
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
		local description = ::Core.Integrations.Manager.getMSUAPI().getSettingDescription(_settingElement.getID());
		_settingElement.setDescription(description);
	}
};