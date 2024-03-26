local Core = ::RPGR_Core;
Core.Config.Troops <-
{
	Excluded = // TODO: get rid of noble, settlement, and mercos
	[	# These troops are neither eligible for tokenisation nor for token disbursement.
		::Const.EntityType.BarbarianBeastmaster,
		::Const.EntityType.BountyHunter,
		::Const.EntityType.CaravanDonkey,
		::Const.EntityType.CaravanGuard,
		::Const.EntityType.CaravanHand,
		::Const.EntityType.Cultist,
		::Const.EntityType.Engineer,
		::Const.EntityType.Mercenary,
		::Const.EntityType.Militia,
		::Const.EntityType.MilitiaCaptain,
		::Const.EntityType.MilitiaRanged,
		::Const.EntityType.MilitiaVeteran,
		::Const.EntityType.MilitaryDonkey,
		::Const.EntityType.Mortar,
		::Const.EntityType.Peasant,
		::Const.EntityType.PeasantSouthern
	],
	Thresholds =
	{	# These thresholds inform the troop cost value by which individual troop types are designated to be culled.
		Bandits = 20,
		Barbarians = 25,
		Goblins = 20,
		Orcs = 14,
		OrientalBandits = 30,
		Undead = 20,
		Zombies = 10
	}
}