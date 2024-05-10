::Core.Integrations.MSU.API <-
{
	Pages = {},

	function addBooleanSetting( _settingID, _dataTable, _pageString )
	{
		local properName = this.formatSettingName(_settingID);
		this.getPage(_pageString).addBooleanSetting(_settingID, _dataTable.Default, properName);
	}

	function addNumericalSetting( _settingID, _dataTable, _pageString )
	{
		local properName = this.formatSettingName(_settingID);
		this.getPage(_pageString).addRangeSetting(_settingID, _dataTable.Default, _dataTable.Range[0], _dataTable.Range[1], _dataTable.Interval, properName);
	}

	function addPage( _string )
	{
		return ::Core.Mod.ModSettings.addPage(_string);
	}

	function build()
	{
		this.buildPages();
		this.Builders.Explicit.build();
		this.Builders.Implicit.build();
	}

	function buildDescription( _settingObject, _dataKey )
	{
		local description = this.getSettingDescription(_dataKey);
		_settingObject.setDescription(description);
	}

	function buildPages()
	{
		this.Pages.Preset <- this.addPage("Presets");
		this.Pages.Languages <- this.addPage("Localisation");

		# Internal database structuring for game parameter data is to be reflected in page segregation.
		local parameters = ::Core.Database.Helper.getParameters();

		foreach( category, table in parameters )
		{
			this.Pages[category] <- this.addPage(category);
		}
	}

	function createMSUInterface()
	{
		::Core.Interfaces.MSU <- ::MSU.Class.Mod(::Core.ID, ::Core.Version, ::Core.Name);
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
		return ::Core.Localisation.Helper.getSettingString(format("%sDescription", _key));
	}

	function getSettingName( _key )
	{
		return ::Core.Localisation.Helper.getSettingString(_key);
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
};