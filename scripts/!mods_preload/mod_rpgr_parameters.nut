::PRM <-
{
	ID = "mod_rpgr_parameters",
	Name = "RPG Rebalance - Parameters",
	Version = "1.1.0",
	Internal =
	{
		DefaultPreset = "Vanilla",
		ManagerPath = "mod_rpgr_parameters/framework/internal/manager.nut",
		TERMINATE = "__end"
	}

	function loadManager()
	{
		::include(this.Internal.ManagerPath);
	}

	function initialise()
	{
		this.loadManager();
		this.Manager.awake();
		this.Manager.queue();
	}
};

::PRM.initialise();