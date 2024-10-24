::Core.Strings.Settings <-
{	// TODO: not all page names are present here. since we already sweep out database keys for parameter categories, all we have to do is index that same key within this dictionary
	PagePresets = "Presets",

	TitlePresets = "Presets",
	TitlePresetsDescription = "Presets determine the default configuration of Core's parameters. They serve as templates from which further changes can be made.",

	ButtonStandard = "Standard",
	ButtonStandardDescription = "The default parameter configuration for RPG Rebalance. This preset is designed to make the game experience significantly harder and slower-paced by inducing scarcity upon key strategic layer resources.",

	ButtonCasual = "Casual",
	ButtonCasualDescription = "A less demanding variant of the default parameter configuration. This preset is generally better suited for games that are more fast-paced.",

	ButtonSurvival = "Survival",
	ButtonSurvivalDescription = "A significantly more restrictive variant of the default parameter configuration. This preset is designed to cater to especially long and difficult campaigns, meant to emulate a much slower and more gradual sense of progression.",

	ButtonVanilla = "Vanilla",
	ButtonVanillaDescription = "The default parameter configuration for the vanilla game.",

	LootRemovalChance = "Loot Removal Chance",
	LootRemovalChanceDescription = "This setting determines the chance that items that would otherwise be available as combat loot are removed at random. Setting this to 0 retains all items. Legendary items are never eligible for removal.",

	StashSize = "Stash Size",
	StashSizeDescription = "Determines the starting stash size. Has no effect on ongoing playthroughs.",

	RosterSize = "Roster Size",
	RosterSizeDescription = "Determines the maximum roster size, overriding scenario-specific restrictions. Does nothing if Enable Roster Constraints is disabled. Has no effect on ongoing playthroughs.",

	MaximumBrothersInCombat = "Maximum Brothers in Combat",
	MaximumBrothersInCombatDescription = "Determines the maximum number of brothers that can be taken into a combat encounter. Does nothing if Enable Roster Constraints is disabled. Has no effect on ongoing playthroughs.",

	ConstrainRoster = "Enable Roster Constraints",
	ConstrainRosterDescription = "Determines whether settings to do with roster sizes have any effect for a new playthrough. Keep this setting disabled when scenario-specific roster sizes are desired.",

	BeastPartsPriceMult = "Beast Parts Price Multiplier",
	BeastPartsPriceMultDescription = "Determines the base percentage multiplier for the price of beast parts.",

	BuyPriceMult = "Buy Price Multiplier",
	BuyPriceMultDescription = "Determines the base percentage multiplier for the purchase prices of goods sold at all settlements.",

	SellPriceMult = "Sell Price Multiplier",
	SellPriceMultDescription = "Determines the base percentage multiplier for the sale prices of goods at all settlements.",

	RarityMult = "Item Abundance Multiplier",
	RarityMultDescription = "Determines the base number of items available for sale in settlements. Higher values allow for a greater number of items.",

	RecruitsMult = "Recruits Multiplier",
	RecruitsMultDescription = "Determines the base percentage multiplier for the number of prospective recruits found across all settlements.",

	ContractPaymentMult = "Contract Payment Multiplier",
	ContractPaymentMultDescription = "Determines the base percentage multiplier for contract payment.",

	DailyWageMult = "Daily Wage Multiplier",
	DailyWageMultDescription = "Determines the base percentage multiplier for the daily wages paid out to currently hired brothers.",

	FoodConsumptionMult = "Food Consumption Multiplier",
	FoodConsumptionMultDescription = "Determines how quickly food is consumed.",

	HitpointsPerHourMult = "Heal Rate Multiplier",
	HitpointsPerHourMultDescription = "Determines how quickly missing hitpoints are recovered for all hired brothers, if medical supplies are present.",

	RepairSpeedMult = "Repair Speed Multiplier",
	RepairSpeedMultDescription = "Determines how quickly items are repaired.",

	XPMult = "XP Multiplier",
	XPMultDescription = "Determines the base percentage multiplier for XP gains."
};