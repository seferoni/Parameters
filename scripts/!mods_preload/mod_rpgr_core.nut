::Core <-
{
	ID = "mod_rpgr_core",
	Name = "RPG Rebalance - Core",
	Version = "1.0.0",
	Internal =
	{
		ManagerPath = "mod_rpgr_core/framework/internal/manager.nut",
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

::Core.initialise();