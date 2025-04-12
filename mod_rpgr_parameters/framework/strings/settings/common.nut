::PRM.Strings.Settings.Common <-
{
	# Pages.
	PagePresetsName = "Presets",
	PageCommonName = "Common",
	PageSettlementsName = "Settlements",
	PageWorldName = "World",
	PageMiscellaneousName = "Miscellaneous",

	# Setting elements.
	TitlePresetsName = "Presets",
	TitlePresetsDescription = "Presets determine the default configuration of Parameters's parameters. They serve as templates from which further changes can be made.",

	ButtonChallengingName = "Challenging",
	ButtonChallengingDescription = "Default configuration. This preset is designed to make the game experience significantly harder and slower-paced by inducing scarcity upon key strategic layer resources.",

	ButtonCasualName = "Casual",
	ButtonCasualDescription = "A slightly tuned configuration based on vanilla parameters. This preset mitigates the potential tedium of other configurations, while still providing a challenge.",

	ButtonUnfairName = "Unfair",
	ButtonUnfairDescription = "A significantly more restrictive variant of the default parameter configuration. This preset makes enemies significantly stronger, resources extremely scarce, and the game experience much slower-paced. Expect defeats to be frequent and costly.",

	ButtonVanillaName = "Vanilla",
	ButtonVanillaDescription = "The default parameter configuration for the vanilla game.",

	LootRemovalChanceName = "Loot Removal Chance",
	LootRemovalChanceDescription = "This setting determines the chance that items that would otherwise be available as combat loot are removed at random. Setting this to 0 retains all items. Legendary items are never eligible for removal.",

	StashSizeName = "Stash Size",
	StashSizeDescription = "Determines the starting stash size. Has no effect on ongoing playthroughs.",

	BeastPartsPriceMultName = "Beast Parts Price Multiplier",
	BeastPartsPriceMultDescription = "Determines the base percentage multiplier for the price of beast parts.",

	BuyPriceMultName = "Buy Price Multiplier",
	BuyPriceMultDescription = "Determines the base percentage multiplier for the purchase prices of goods sold at all settlements.",

	SellPriceMultName = "Sell Price Multiplier",
	SellPriceMultDescription = "Determines the base percentage multiplier for the sale prices of goods at all settlements.",

	RarityMultName = "Item Abundance Multiplier",
	RarityMultDescription = "Determines the base number of items available for sale in settlements. Higher values allow for a greater number of items.",

	RecruitsMultName = "Recruits Multiplier",
	RecruitsMultDescription = "Determines the base percentage multiplier for the number of prospective recruits found across all settlements.",

	ContractPaymentMultName = "Contract Payment Multiplier",
	ContractPaymentMultDescription = "Determines the base percentage multiplier for contract payment.",

	DailyWageMultName = "Daily Wage Multiplier",
	DailyWageMultDescription = "Determines the base percentage multiplier for the daily wages paid out to currently hired brothers.",

	FoodConsumptionMultName = "Food Consumption Multiplier",
	FoodConsumptionMultDescription = "Determines how quickly food is consumed.",

	HitpointsPerHourMultName = "Heal Rate Multiplier",
	HitpointsPerHourMultDescription = "Determines how quickly missing hitpoints are recovered for all hired brothers, if medical supplies are present.",

	RepairSpeedMultName = "Repair Speed Multiplier",
	RepairSpeedMultDescription = "Determines how quickly items are repaired.",

	XPMultName = "XP Multiplier",
	XPMultDescription = "Determines the base percentage multiplier for XP gains.",

	PartyStrengthMultName = "Enemy Strength Scaling Multiplier",
	PartyStrengthMultDescription = "Abstracted percentage scalar that determines how strong the game perceives the player party's strength at any given point. Higher values lead to significantly stronger enemies for a given roster strength.",

	FixBeastSpawnsName = "Despawn Discovered Beasts",
	FixBeastSpawnsDescription = "In the vanilla game, discovered beasts are never despawned, and since a spawn limit is enforced, new spawns are therefore left bottlenecked or entirely prohibited. When enabled, this setting permits the despawning of discovered beasts in accordance with other factions, thereby allowing fresh spawns on a periodic basis.",

	DisableKrakenName = "Remove Kraken Encounter",
	DisableKrakenDescription = "Prevents the legendary Stone Pillars location from generating when starting a new campaign, and adds the Reproach's blade to the loot tables of all undead lairs. Prevents the associated ambition from firing. Does nothing if WotN is not installed. Has no effect on ongoing playthroughs.",

	RemovableStashItemsName = "Removable Stash Items",
	RemovableStashItemsDescription = "The vanilla game does not permit the manual removal of items in the stash while in the inventory screen. When enabled, this setting permits the use of CTRL + Left Click to remove any hovered-over stash items, and modifies the tooltip for each item to indicate the presence of this functionality."
};