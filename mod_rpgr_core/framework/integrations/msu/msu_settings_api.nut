::Core.Integrations.MSU <-
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
		return ::Core.Strings.Settings[_elementKey];
	}

	function initialise()
	{
		this.createTables();
		this.loadBuilders();
		this.build();
	}

	function loadBuilders()
	{
		::Core.Manager.includeFiles("mod_rpgr_core/framework/integrations/msu/builders");
	}

	function setPreset( _buttonID )
	{
		this.Parameters.ActivePreset = ::Core.Standard.getKey(_buttonID, this.ElementIDs.Buttons);
	}
};