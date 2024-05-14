::Core.Integrations.MSU.API <-
{
	Preset = "RPGR",
	Pages = {},

	function appendElementToPage( _settingElement, _pageString )
	{
		this.getPage(_pageString).addElement(_settingElement);
	}

	function addPage( _string )
	{
		return ::Core.Mod.ModSettings.addPage(_string);
	}

	function build()
	{
		this.buildPages();
		this.getExplicitBuilder().build();
		this.getImplicitBuilder().build();
	}

	function buildDescription( _settingObject, _dataKey )
	{
		local description = this.getSettingDescription(_dataKey);
		_settingObject.setDescription(description);
	}

	function buildPages()
	{
		this.Pages.Preset <- this.addPage("Presets");

		# Internal database structuring for game parameter data is to be reflected in page segregation.
		local parameters = ::Core.Database.Manager.getParameters();

		foreach( category, table in parameters )
		{
			this.Pages[category] <- this.addPage(category);
		}
	}

	function createMSUInterface()
	{
		::Core.Interfaces.MSU <- ::MSU.Class.Mod(::Core.ID, ::Core.Version, ::Core.Name);
	}

	function formatPresetValue( _settingID )
	{
		return _settingID.slice("Presets".len());
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
		this.createMSUInterface();
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