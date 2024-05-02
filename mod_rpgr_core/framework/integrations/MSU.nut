::Core.Integrations.MSU <-
{
	function addSetting( _string, _value, _page )
	{
		switch (typeof _value)
		{
			case ("boolean"): return this.addBooleanSetting(_string, _value, _page);
			case ("float"):
			case ("integer"): return this.addNumericalSetting(_string, _value, _page);
		}
	}

	function addBooleanSetting( _string, _value, _page )
	{

	}

	function addNumericalSetting( _string, _value, _page )
	{

	}

	function addPage( _string )
	{
		return ::Core.Mod.ModSettings.addPage(_string);
	}

	function build()
	{
		# Build all page objects through MSU API.
		local pages = this.buildPages();

		# Get eligible data tables to be exposed as settings through the MSU settings panel.
		local implicitTables = this.getSettingsToBeBuiltImplicitly();

		# Build.
		foreach( category, table in implicitTables )
		{
			this.buildImplicitly(table, category, pages[category]);
		}
	}

	function buildDescription( _setting, _key )
	{
		local description = ::Core.Localisation.getSettingString(_key);
		_setting.setDescription(description);
	}

	function buildImplicitly( _propertyTable, _page )
	{
		foreach( property, propertyValue in _propertyTable )
		{
			local setting = this.addSetting(property, propertyValue, _page);
			this.buildDescription(_setting, property);
		}
	}

	function buildPages()
	{
		local pages = {};

		local parameters = ::Core.Database.Helper.getParameters();

		foreach( category, table in parameters )
		{
			pages.category <- this.addPage(category);
		}

		return pages;
	}

	function createMSUClass()
	{
		::Core.Mod <- ::MSU.Class.Mod(::Core.ID, ::Core.Version, ::Core.Name);
	}

	function getDescription()
	{

	}

	function getSettingsToBeBuiltImplicitly()
	{
		return ::Core.Database.Helper.getParameters();
	}
}