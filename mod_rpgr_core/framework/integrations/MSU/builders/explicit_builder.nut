::Core.Integrations.MSU.Builders.Explicit <-
{
	IDs =
	{
		Pages = 
		{
			Presets = "PresetsPage",
		},
		Settings = 
		{
			RPGR = "RPGRPreset",
			Vanilla = "VanillaPreset"
		}
	}

	function addPresetChangeCallbacks( _settingElement )
	{
		_settingElement.addBeforeChangeCallback(this.onBeforePresetChangeCallback);
		_settingElement.addAfterChangeCallback(this.onAfterPresetChangeCallback);
	}

	function appendToPresetsPage( _settingElement )
	{
		::Core.Integrations.getMSUSettingsAPI().appendElementToPage(_settingElement, this.IDs.Pages.Presets);
	}

	function build()
	{
		this.buildPages();
		this.buildPresets();
	}

	function buildPages()
	{
		::Core.Integrations.getMSUSettingsAPI().addPage(this.IDs.Pages.Presets);
	}

	function buildPresets()
	{
		this.buildPresetSetting(this.IDs.Settings.RPGR, true);
		this.buildPresetSetting(this.IDs.Settings.Vanilla, false);
	}

	function buildPresetSetting( _settingID, _defaultValue )
	{
		local setting = ::MSU.Class.BooleanSetting(_settingID, _defaultValue, ::Core.Integrations.getMSUSettingsAPI().getSettingName(_settingID));
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