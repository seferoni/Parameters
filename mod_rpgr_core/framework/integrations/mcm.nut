::Core.MCM <-
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

	function assignDescriptions()
	{

	}

	function build()
	{
		local pages = this.buildPages();

		foreach( category, table in ::Core.Defaults )
		{
			this.buildExplicitly(table, category, pages[category]);
		}
	}

	function buildDescription( _setting )
	{
		local description = ""; // TODO:
		_setting.setDescription(description);
	}

	function buildExplicitly( _propertyTable, _page )
	{
		foreach( property, propertyValue in _propertyTable )
		{
			local setting = this.addSetting(property, propertyValue, _page);
			this.buildDescription(_setting);
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

	function getDescription()
	{

	}
}