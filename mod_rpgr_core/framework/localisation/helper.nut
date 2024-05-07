::Core.Localisation.Helper <-
{
	function getSettingString( _key )
	{
		return ::Core.Localisation.Settings[_key];
	}

	function getLanguage()
	{

	}

	function initialise()
	{
		this.loadLanguageTables();
	}

	function loadLanguageTables()
	{

	}
};