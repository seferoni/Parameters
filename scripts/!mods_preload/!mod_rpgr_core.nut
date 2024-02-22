::RPGR_Core <-
{
	ID = "mod_rpgr_core",
	Name = "RPG Rebalance - Core",
	Version = "1.0.0",
	Internal =
	{
		TERMINATE = "__end"
	},
	Defaults =
	{
		Assets =
		{
			LootRemovalChance = 60,
			StashSize = 30,
			RosterSize = 9
		},
		Settlements =
		{
			BeastPartsPriceMult = 1.5,
			BuyPriceMult = 2.3,
			SellPriceMult = 1.2,
			RecruitsMult = 0.2,
		},
		World =
		{
			ContractPaymentMult = 0.7,
			DailyWageMult = 1.6,
			FoodConsumptionMult = 1.4,
			RepairSpeedMult = 0.3,
			XPMult = 0.4
		}
	}
}

local Core = ::RPGR_Core;
Core.Internal.MSUFound <- "MSU" in ::getroottable();
::include("mod_RPGR_Core/libraries/standard_library.nut");

if (!Core.Internal.MSUFound)
{
	Core.Version = Core.Standard.parseSemVer(Core.Version);
}

::mods_registerMod(Core.ID, Core.Version, Core.Name);
::mods_queue(Core.ID, ">mod_msu", function()
{
	if (!Core.Internal.MSUFound)
	{
		return;
	}

	Core.Mod <- ::MSU.Class.Mod(Core.ID, Core.Version, Core.Name);
	local Defaults = Core.Defaults;

	# Create pages.
	local pageAssets = Core.Mod.ModSettings.addPage("Assets"),
	pageWorld = Core.Mod.ModSettings.addPage("World"),
	pageSettlements = Core.Mod.ModSettings.addPage("Settlements");


	# Assign assets settings.
	local combatLootChance = pageAssets.addRangeSetting("LootRemovalChance", Defaults.Assets.LootRemovalChance, 0, 100, 1, "Loot Removal Chance");
	combatLootChance.setDescription("Determines the percentage chance for loot removal on combat end. Legendary items are not affected.");
});