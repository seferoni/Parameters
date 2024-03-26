local Core = ::RPGR_Core;
Core.Config.Troops <-
{
	Excluded =
	[	# These troops are neither eligible for tokenisation nor for token disbursement.
		::Const.EntityType.BarbarianBeastmaster
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