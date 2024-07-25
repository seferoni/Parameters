::Core.Integrations.MSU <-
{
	PageIDs =
	{
		Presets = "PresetsPage"
	},
	ElementIDs =
	{	// TODO: this annoys me to look at
		Buttons =
		{
			RPGREasy = "PresetsRPGREasy",
			RPGRDefault = "PresetsRPGRDefault",
			RPGRHard = "PresetsRPGRHard",
			Vanilla = "PresetsVanilla"
		},
		Dividers =
		{
			Presets = "PresetsDivider"
		},
		Titles =
		{
			Presets = "PresetsTitle"
		}
	},
	Parameters =
	{
		ActivePreset = null,
		DefaultPreset = "RPGRDefault" // TODO: this needs to index the appropriate database key - format this
	}

	function addPage( _pageID, _pageName = null )
	{	// TODO: consider enforcing pageName requirement for implicit builder for consistency
		return ::Core.Interfaces.MSU.ModSettings.addPage(_pageID, _pageName);
	}

	function appendElementToPage( _settingElement, _pageID )
	{
		this.getPage(_pageID).addElement(_settingElement);
	}

	function build()
	{
		this.Builders.Explicit.build();
		this.Builders.Implicit.build();
	}

	function buildDescription( _settingElement )
	{
		local description = this.getElementDescription(_settingElement.getID());
		_settingElement.setDescription(description);
	}

	function createTables()
	{
		this.Builders <- {};
		this.CustomSettings <- {};
	}

	function getActivePreset()
	{
		if (this.Parameters.ActivePreset == null)
		{
			return this.Parameters.DefaultPreset;
		}

		return this.Parameters.ActivePreset;
	}

	function getDefaultValue( _settingKey )
	{
		return ::Core.Database.getDefaultValue(this.getActivePreset(), _settingKey);
	}

	function getPage( _pageID )
	{
		return ::Core.Interfaces.MSU.ModSettings.getPage(_pageID);
	}

	function getPages()
	{
		return ::Core.Interfaces.MSU.ModSettings.getPanel().getPages();
	}

	function getElementDescription( _elementKey )
	{
		return ::Core.Strings.Settings[format("%sDescription", _elementKey)];
	}

	function getElementName( _elementKey )
	{
		return ::Core.Strings.Settings[format("%s", _elementKey)];
	}

	function initialise()
	{
		this.createTables();
		this.loadBuilders();
		this.loadCustomSettings();
		this.build();
	}

	function loadBuilders()
	{
		::Core.Manager.includeFiles("mod_rpgr_core/framework/integrations/msu/builders");
	}

	function loadCustomSettings()
	{
		this.loadCustomSettingClasses();
		this.loadJS();
	}

	function loadCustomSettingClasses()
	{
		::Core.Manager.includeFiles("mod_rpgr_core/framework/integrations/msu/custom_settings");
	}

	function loadJS()
	{
		this.registerJS("rpgr_title_setting/rpgr_title_setting.js");
	}

	function registerJS( _path )
	{
		::Core.Manager.registerJS(format("msu_custom_settings/%s", _path));
	}

	function setPreset( _newValue )
	{
		this.Parameters.ActivePreset = ::Core.Standard.getKey(_newValue, this.ElementIDs.Buttons);
	}
};