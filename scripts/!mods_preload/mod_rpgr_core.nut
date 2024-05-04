::Core <-
{
	ID = "mod_rpgr_core",
	Name = "RPG Rebalance - Core",
	Version = "1.0.0",
	Internal =
	{
		ManagerPath = "mod_rpgr_core/internal/manager.nut",
		TERMINATE = "__end"
	},
	Interfaces = 
	{
		MSU = null,
		ModernHooks = null
	}

	function loadManager()
	{
		::include(this.Internal.ManagerPath);
	}

	function getManager()
	{
		return this.Internal.Manager;
	}

	function getModernHooksInterface()
	{
		return this.Interfaces.ModernHooks;
	}

	function getMSUInterface()
	{
		return this.Interfaces.MSU;
	}
};

::Core.loadManager();
::Core.getManager().register();
::Core.getManager().queue();