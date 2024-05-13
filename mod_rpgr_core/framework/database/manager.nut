::Core.Database.Manager <-
{
	function createTables()
	{
		::Core.Database.Parameters <- {};
		::Core.Database.Parameters.Defaults <- {};
		::Core.Database.Parameters.Settings <- {};
	}

	function createDefaultsTables()
	{
		::Core.Database.Parameters.Defaults.RPGR <- {};
		::Core.Database.Parameters.Defaults.Vanilla <- {};
	}

	function load( _path )
	{
		::Core.getManager().includeFiles(format("mod_rpgr_core/framework/database/%s", _path));
	}

	function loadFiles()
	{
		this.load("parameters/defaults/rpgr");
		this.load("parameters/defaults/vanilla");
		this.load("parameters/settings");
	}

	function getParameters()
	{

	}

	function getParameter()
	{

	}

	function getParametersAggregated()
	{

	}

	function initialise()
	{
		this.createTables();
		this.createDefaultsTables();
		this.loadFiles();
	}
};