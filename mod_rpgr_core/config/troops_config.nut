local Core = ::RPGR_Core;
Core.Config.Troops <-
{	//TODO: need some way to prevent assigning stuff to eg wardogs
	Excluded =
	[
		::Const.EntityType.CaravanDonkey,
		::Const.EntityType.MilitaryDonkey,
		::Const.EntityType.Mortar,
		::Const.EntityType.Wardog,
		::Const.EntityType.Warhound
	],
	Equipment =
	{
		Bandits =
		{	// tables need to be sorted from strongest to weakest
			Melee =
			{
				Head =
				[

				],
				Armor =
				[
					{
						Cost = 0,
						Path = "scripts/items/armor/"
						Strength = 20,
						Scripts =
						[
							"decayed_coat_of_plates",
							"decayed_coat_of_scales",
							"decayed_reinforced_mail_hauberk",
							"footman_armor",
						]
					},
					{
						Cost = 0,
						Strength = 9,
						Scripts =
						[
							""
						]
					}
				],
				Weapons =
				[
					{

					},
					{

					},
					{

					}
				],
			},
			Ranged =
			{
				Armor =
				[

				]
				Weapons =
				[

				],
			}
		}
	},
	Thresholds =
	{
		Bandits = 20,
		Barbarians = 25,
		OrientalBandits = 25
	}
};