::Core.Integrations.MSU <-
{
	Preset = "RPGR",
	Pages = {},

	function addPage( _pageID )
	{
		return this.getMSUInterface().ModSettings.addPage(_pageID);
	}

	function appendElementToPage( _settingElement, _pageString )
	{
		this.getPage(_pageString).addElement(_settingElement);
	}

	function build()
	{
		this.buildPages();
		this.getExplicitBuilder().build();
		this.getImplicitBuilder().build();
	}

	function buildDescription( _settingElement )
	{
		local description = this.getSettingDescription(_settingElement.getID());
		_settingElement.setDescription(description);
	}

	# This method is to be handled explicitly.
	function buildPages()
	{
		this.Pages.Preset <- this.addPage(this.getExplicitBuilder().Parameters.PresetsPageID);

		# Internal database structuring for game parameter data is to be reflected in page segregation.
		local parameterCategories = ::Core.Database.getParameterCategories();

		foreach( category in parameterCategories )
		{
			this.Pages[category] <- this.addPage(category);
		}
	}

	function createTables()
	{
		this.Builders <- {};
	}

	function formatPresetValue( _settingID )
	{
		return _settingID.slice(this.getExplicitBuilder().getPresetsKey().len());
	}

	function getActivePreset()
	{
		return this.Preset;
	}

	function getDefaultValue( _settingKey )
	{
		return ::Core.Database.getDefaults(this.getActivePreset())[_settingKey];
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

	function getPage( _pageString )
	{
		return this.Pages[_pageString];
	}

	function getPages()
	{
		return this.Pages;
	}

	function getSettingDescription( _key )
	{
		return ::Core.Strings[format("%sDescription", _key)];
	}

	function getSettingName( _key )
	{
		return ::Core.Standard.getKey(_key, ::Core.Strings.Settings);
	}

	function initialise()
	{
		this.createTables();
		this.loadBuilders();
		this.build();
	}

	function loadBuilders()
	{
		::Core.getManager().includeFiles("mod_rpgr_core/framework/integrations/MSU/builders");
	}

	function setPreset( _newValue )
	{
		this.Preset = this.formatPresetValue(_newValue);
	}
};