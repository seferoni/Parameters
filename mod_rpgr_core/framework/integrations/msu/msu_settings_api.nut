::Core.Integrations.MSU <-
{
	PageIDs = 
	{
		Presets = "PresetsPage"
	},
	ElementIDs =
	{
		Settings =
		{
			RPGRPreset = "RPGRPreset",
			VanillaPreset = "VanillaPreset"
		},
		Titles = 
		{
			Presets = "PresetsTitle"
		}
	},
	Parameters = 
	{
		ActivePreset = null,
		DefaultPreset = "RPGR"
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

	function buildTooltips()
	{
		::Core.getManager().getMSUInterface().setTooltips(
		{
			CustomSettings = 
			{	// TODO: investigate how this should work
				Title = ::Core.Strings.Title
			}
		});
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
		this.buildTooltips();
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
		this.registerJS("variable_width_title_setting/js/variable_width_title_setting.js");
	}

	function registerJS( _path )
	{
		::Core.getManager().registerJS(format("mod_rpgr_core/msu_custom_settings/%s", _path)); // TODO: prepend "ui/mods" back to this
	}

	function setPreset( _newValue )
	{
		this.Parameters.ActivePreset = _newValue;
	}
};