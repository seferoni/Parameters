::Core.Integrations.MSU.API <-
{
	Preset = "RPGR",
	Pages = {},

	function addPage( _string )
	{
		return ::Core.Mod.ModSettings.addPage(_string);
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

	function buildDescription( _settingElement, _dataKey )
	{
		local description = this.getSettingDescription(_dataKey);
		_settingElement.setDescription(description);
	}

	function buildPages()
	{
		this.Pages.Preset <- this.addPage("Presets");

		# Internal database structuring for game parameter data is to be reflected in page segregation.
		local parameterCategories = ::Core.Database.Manager.getParameterCategories();

		foreach( category in parameterCategories )
		{
			this.Pages[category] <- this.addPage(category);
		}
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
		return ::Core.Integrations.MSU.Builders.Explicit;
	}

	function getImplicitBuilder()
	{
		return ::Core.Integrations.MSU.Builders.Implicit;
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