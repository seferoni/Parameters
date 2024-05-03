::Core <-
{
	ID = "mod_rpgr_core",
	Name = "RPG Rebalance - Core",
	Version = "1.0.0",
	Internal =
	{
		ManagerPath = "mod_rpgr_core/internal/manager.nut",
		TERMINATE = "__end"
	}

	function loadManager()
	{
		::include(this.Internal.ManagerPath);
	}

	function getManager()
	{
		return this.Internal.Manager;
	}
};

::Core.loadManager();
::Core.getManager().register();
::mods_queue(::Core.ID, ">mod_msu", function()
{
	::Core.getManager().initialise();
});