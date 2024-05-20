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
		local setting = this.createPresetSetting(_settingID, _defaultValue);
		this.addPresetChangeCallback(setting);
		this.buildPresetSettingDescription(setting);
		this.appendToPresetsPage(setting);
	}

	function buildPresetSettingDescription( _settingElement )
	{
		::Core.Integrations.getMSUSettingsAPI().buildDescription(_settingElement);
	}

	function createPresetSetting( _settingID, _defaultValue )
	{
		return ::MSU.Class.EnumSetting(_settingID, _defaultValue, this.getPresetKeys(), ::Core.Integrations.getMSUSettingsAPI().getSettingName(_settingID));
	}

	function getPresetKeys()
	{
		return ::Core.Database.getPresetKeys();
	}

	function getPresetSettings()
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

	function resetSettings()
	{
		local pages = this.getPagesForReset();

		foreach( page in pages )
		{
			page.resetSettings();
		}
	}
};