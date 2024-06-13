::Core.Integrations.MSU <-
{
	PageIDs = 
	{
		Presets = "PresetsPage"
	},
	ElementIDs =
	{
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
		return this.getMSUInterface().ModSettings.addPage(_pageID, _pageName);
	}

	function appendElementToPage( _settingElement, _pageID )
	{
		this.getPage(_pageID).addElement(_settingElement);
	}

	function build()
	{
		this.getExplicitBuilder().build();
		this.getImplicitBuilder().build();
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

	function getExplicitBuilder()
	{
		return this.Builders.Explicit;
	}

	function getMSUInterface()
	{
		return ::Core.getManager().getMSUInterface();
	}

	function getImplicitBuilder()
	{
		return this.Builders.Implicit;
	}

	function getPage( _pageID )
	{
		return ::Core.getManager().getMSUInterface().ModSettings.getPage(_pageID);
	}

	function getPages()
	{
		return ::Core.getManager().getMSUInterface().ModSettings.getPanel().getPages();
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
		::Core.getManager().includeFiles("mod_rpgr_core/framework/integrations/msu/builders");
	}

	function loadCustomSettings()
	{
		this.loadCustomSettingClasses();
		this.loadJS();
	}

	function loadCustomSettingClasses()
	{
		::Core.getManager().includeFiles("mod_rpgr_core/framework/integrations/msu/custom_settings");
	}

	function loadJS()
	{
		this.registerJS("rpgr_title_setting/rpgr_title_setting.js");
	}

	function registerJS( _path )
	{
		::Core.getManager().registerJS(format("msu_custom_settings/%s", _path));
	}

	function setPreset( _newValue )
	{
		this.Parameters.ActivePreset = ::Core.Standard.getKey(_newValue, this.ElementIDs.Buttons);
	}
};