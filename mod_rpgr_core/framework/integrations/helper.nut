::Core.Integrations.Helper <-
{
	function createMSUTables()
	{
		::Core.Integrations.MSU <- {};
		::Core.Integrations.MSU.Builders <- {};
	}

	function initialise()
	{
		if (!::Core.getManager().isMSUInstalled())
		{
			return;
		}

		this.loadMSU();
	}

	function initialiseMSUHelper()
	{
		::Core.Integrations.MSU.initialise();
	}

	function loadMSU()
	{
		this.createMSUTables();
		this.loadMSUHelper();
		this.initialiseMSUHelper();
	}

	function loadHelpers()
	{
		::include("mod_rpgr_core/framework/integrations/MSU/MSU.nut");
	}
};