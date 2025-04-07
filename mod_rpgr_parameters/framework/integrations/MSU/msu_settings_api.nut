::Parameters.Integrations.MSU <-
{
	PageIDs =
	{
		Presets = "PagePresets"
	},
	ElementIDs =
	{
		Buttons =
		{
			Casual = "ButtonCasual",
			Standard = "ButtonStandard",
			Survival = "ButtonSurvival",
			Vanilla = "ButtonVanilla"
		},
		Dividers =
		{
			Presets = "DividerPresets"
		},
		Titles =
		{
			Presets = "TitlePresets"
		}
	},
	Parameters =
	{
		DefaultPreset = "Survival"
	},
	RuntimeVariables =
	{
		ActivePreset = null,
	}

	function addPage( _pageID, _pageName )
	{
		return ::Parameters.Interfaces.MSU.ModSettings.addPage(_pageID, _pageName);
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

	function createDivider( _elementID )
	{
		return ::MSU.Class.SettingsDivider(_elementID);
	}

	function createTables()
	{
		this.Builders <- {};
	}

	function getActivePreset()
	{
		if (this.RuntimeVariables.ActivePreset == null)
		{
			return this.Parameters.DefaultPreset;
		}

		return this.RuntimeVariables.ActivePreset;
	}

	function getDefaultValue( _settingKey )
	{
		return ::Parameters.Database.getDefaultValue(this.getActivePreset(), _settingKey);
	}

	function getElementDescription( _elementKey )
	{
		return this.getStringField(format("%sDescription", _elementKey));
	}

	function getElementName( _elementKey )
	{
		return this.getStringField(format("%sName", _elementKey));
	}

	function getPageName( _pageKey )
	{
		return this.getElementName(format("Page%s", _pageKey));
	}

	function getStringField( _fieldName )
	{
		return ::Parameters.Strings.getField("Settings", "Common")[_fieldName];
	}

	function getPage( _pageID )
	{
		return ::Parameters.Interfaces.MSU.ModSettings.getPage(_pageID);
	}

	function getPages()
	{
		return ::Parameters.Interfaces.MSU.ModSettings.getPanel().getPages();
	}

	function initialise()
	{
		this.createTables();
		this.loadBuilders();
		this.build();
	}

	function loadBuilders()
	{
		::Parameters.Manager.includeFiles("mod_rpgr_parameters/framework/integrations/MSU/builders");
	}

	function setPreset( _buttonID )
	{
		this.RuntimeVariables.ActivePreset = ::Parameters.Standard.getKey(_buttonID, this.ElementIDs.Buttons);
	}
};