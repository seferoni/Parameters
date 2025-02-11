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
		ActivePreset = null,
		DefaultPreset = "Standard"
	}

	function addPage( _pageID, _pageName = null )
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

	function createTables()
	{
		this.Builders <- {};
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
		return ::Parameters.Database.getDefaultValue(this.getActivePreset(), _settingKey);
	}

	function getPage( _pageID )
	{
		return ::Parameters.Interfaces.MSU.ModSettings.getPage(_pageID);
	}

	function getPages()
	{
		return ::Parameters.Interfaces.MSU.ModSettings.getPanel().getPages();
	}

	function getElementDescription( _elementKey )
	{
		return ::Parameters.Strings.Settings[format("%sDescription", _elementKey)];
	}

	function getElementName( _elementKey )
	{
		return ::Parameters.Strings.Settings[_elementKey];
	}

	function initialise()
	{
		this.createTables();
		this.loadBuilders();
		this.build();
	}

	function loadBuilders()
	{
		::Parameters.Manager.includeFiles("mod_rpgr_parameters/framework/integrations/msu/builders");
	}

	function setPreset( _buttonID )
	{
		this.Parameters.ActivePreset = ::Parameters.Standard.getKey(_buttonID, this.ElementIDs.Buttons);
	}
};