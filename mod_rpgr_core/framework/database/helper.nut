::Core.Database.Helper <-
{
	function getParameters()
	{
		return ::Core.Database.Parameters;
	}

	function getParameter()
	{
		// TODO: remember, we have a presets based system. figure it out
	}

	function getParametersAggregated()
	{
		local aggregate = {};

		# Get all stored parameter tables in the database.
		local parameters = this.getParameters();

		foreach( parameterType, parameterTable in parameters )
		{
			::Core.Standard.extendTable(parameterTable, aggregate);
		}

		return aggregate;
	}

	function initialise()
	{
		::Core.getManager().includeFiles("mod_rpgr_core/framework/database/parameters");
	}
};