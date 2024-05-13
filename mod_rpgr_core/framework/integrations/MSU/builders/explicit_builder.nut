::Core.Integrations.MSU.Builders.Explicit <-
{
	function appendToPresetsPage( _settingElement )
	{
		this.getPresetsPage().addElement(_settingElement);
	}

	function addPresetChangeCallbacks( _settingElement )
	{
		_settingElement.addBeforeChangeCallback(this.onBeforePresetChangeCallback);
		_settingElement.addAfterChangeCallback(this.onAfterPresetChangeCallback);
	}

	function build()
	{
		this.buildPresets();
	}

	function buildPresets()
	{
		this.buildPresetSetting("PresetsRPGR", true, "RPGR");
		this.buildPresetSetting("PresetsVanilla", false, "Vanilla");
	}

	function buildPresetSetting( _settingID, _defaultValue )
	{
		local setting = ::MSU.Class.BooleanSetting(_settingID, _defaultValue);
		this.addPresetChangeCallbacks(setting);
		this.setPresetSettingDescription(setting);
		this.appendToPresetsPage(setting);
	}

	function getAllPresetSettings()
	{
		return this.getPresetsPage().getAllElementsAsArray();
	}

	function getPresetsPage()
	{
		return ::Core.Integrations.getMSUAPI().getPage("Presets");
	}

	function onBeforePresetChangeCallback( _newValue )
	{
		local settings = this.getAllPresetSettings();

		foreach( setting in setting )
		{
			setting.set(false);
		}
	}

	function onAfterPresetChangeCallback( _oldValue )
	{
		::Core.Integrations.getMSUAPI().setPreset(this.getID());
	}

	function resetSettings()
	{
		// TODO: this needs to set all other values to their defaults, depending on chosen preset. look at MSU docs
	}

	function setPresetSettingDescription( _settingElement )
	{

	}
};