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
			BeastPartsPriceMult = 150,
			BuyPriceMult = 230,
			SellPriceMult = 120,
			RecruitsMult = 20,
		},
		World =
		{
			ContractPaymentMult = 140,
			DailyWageMult = 160,
			FoodConsumptionMult = 140,
			RepairSpeedMult = 30,
			XPMult = 40
		}
	}
}

local Core = ::RPGR_Core;
Core.Internal.MSUFound <- "MSU" in ::getroottable();
::include("mod_rpgr_core/libraries/standard_library.nut");

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
	local lootRemovalChance = pageAssets.addRangeSetting("LootRemovalChance", Defaults.Assets.LootRemovalChance, 0, 100, 1, "Loot Removal Chance");
	lootRemovalChance.setDescription("Determines the percentage chance for loot removal on combat end. Legendary items are not affected.");

	local stashSize = pageAssets.addRangeSetting("StashSize", Defaults.Assets.StashSize, 10, 99, 1, "Stash Size");
	stashSize.setDescription("Determines the starting stash size. Has no effect on ongoing playthroughs.");

	local rosterSize = pageAssets.addRangeSetting("RosterSize", Defaults.Assets.RosterSize, 3, 25, 1, "Roster Size");
	rosterSize.setDescription("Determines the starting roster size. Has no effect on ongoing playthroughs.");

	# Assign settlements settings.
	local beastPartsPriceMult = pageSettlements.addRangeSetting("BeastPartsPriceMult", Defaults.Settlements.BeastPartsPriceMult, 25, 200, 1, "Beast Parts Price Multiplier");
	beastPartsPriceMult.setDescription("Determines the percentage multiplier for the price of beast parts.");

	local buyPriceMult = pageSettlements.addRangeSetting("BuyPriceMult", Defaults.Settlements.BuyPriceMult, 25, 250, 1, "Buy Price Multiplier");
	buyPriceMult.setDescription("Determines the percentage multiplier for the purchase prices of goods sold at settlements.");

	local sellPriceMult = pageSettlements.addRangeSetting("SellPriceMult", Defaults.Settlements.SellPriceMult, 25, 250, 1, "Sell Price Multiplier");
	sellPriceMult.setDescription("Determines the percentage multiplier for the purchase prices of goods sold at settlements.");

	local recruitsMult = pageSettlements.addRangeSetting("RecruitsMult", Defaults.Settlements.RecruitsMult, 25, 150, 1, "Recruits Multiplier");
	recruitsMult.setDescription("Determines the percentage multiplier for the number of prospective recruits found at settlements.");

	# Assign world settings.
	local contractPaymentMult = pageWorld.addRangeSetting("ContractPaymentMult", Defaults.World.ContractPaymentMult, 25, 200, 1, "Contract Payment Multiplier");
	contractPaymentMult.setDescription("Determines the percentage multiplier for contract payment.");

	local dailyWageMult = pageWorld.addRangeSetting("DailyWageMult", Defaults.World.DailyWageMult, 25, 250, 1, "Daily Wage Multiplier");
	dailyWageMult.setDescription("Determines the percentage multiplier for the daily wages paid out to currently hired brothers.");

	local foodConsumptionMult = pageWorld.addRangeSetting("FoodConsumptionMult", Defaults.World.FoodConsumptionMult, 25, 250, 1, "Food Consumption Multiplier");
	foodConsumptionMult.setDescription("Determines how quickly food is consumed.");

	local repairSpeedMult = pageWorld.addRangeSetting("RepairSpeedMult", Defaults.World.RepairSpeedMult, 25, 150, 1, "Repair Speed Multiplier");
	repairSpeedMult.setDescription("Determines how quickly damaged equipment is repaired.");

	local XPMult = pageWorld.addRangeSetting("XPMult", Defaults.World.XPMult, 25, 150, 1, "XP Multiplier");
	XPMult.setDescription("Determines how quickly damaged equipment is repaired.");
});