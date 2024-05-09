::Core.Localisation.Helper <-
{
	function createTables()
	{
		::Core.Localisation.Strings <- {};
	}

	function createLanguageTables()
	{
		::Core.Localisation.Strings.English <- {};
		::Core.Localisation.Strings.Spanish <- {};
		::Core.Localisation.Strings.French <- {};
		::Core.Localisation.Strings.German <- {};
	}

	function getSettingString( _key )
	{	// TODO: revise
		return ::Core.Localisation.Settings[_key];
	}

	function getStrings()
	{
		return ::Core.Localisation.Strings;
	}

	function getLanguage()
	{
		// TODO: retrieve from MSU helper
	}

	function getLanguages()
	{
		return ::Core.Standard.getKeys(this.getStrings());
	}

	function initialise()
	{
		this.createTables();
		this.createLanguageTables();
		this.loadStrings();
	}

	function loadStrings()
	{
		::Core.includeFiles("mod_rpgr_core/framework/localisation/strings");
	}
};