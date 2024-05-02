::Core.Integrations.MCM <-
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

	function addNumericalSetting()
	{

	}

	function addPage( _string )
	{
		return ::Core.Mod.ModSettings.addPage(_string);
	}

	function build()
	{	// TODO: incorrect impl. could get a database helper that collects only settings that should be built implicitly
		local pages = this.buildPages();

		foreach( category, table in ::Core.Defaults )
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

		foreach( category, table in ::Core.Defaults )
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
}