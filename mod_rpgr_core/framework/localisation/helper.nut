::Core.Localisation.Helper <-
{
	function getSettingString( _key )
	{
		return ::Core.Localisation.Settings[_key];
	}

	function getLanguage()
	{
		return ::Core.Standard.getParameter("Language");
	}

	function initialise()
	{
		local languageTable = ::Core.Database.Localisation[this.getLanguage()];
		::Core.getManager().includeFiles(format("mod_rpgr_core/framework/localisation/%s", languageTable.Handle));
	}
};