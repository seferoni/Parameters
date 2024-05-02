::Core.Database.Helper <-
{
	function getParameters()
	{
		return ::Core.Database.Parameters;
	}

	function initialise()
	{
		::Core.Standard.includeFiles("mod_rpgr_core/framework/database/settings/implicit");
		::Core.Standard.includeFiles("mod_rpgr_core/framework/database/settings/expicit");
	}
};