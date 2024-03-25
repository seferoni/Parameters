local Core = ::RPGR_Core;
Core.Config.Entities <-
{	// TODO: add mercs here
	Attributes =
	{
		Bandits =
		{
			Melee =
			[
				"ActionPoints",
				"MeleeSkill"
			],
			Ranged =
			[
				"ActionPoints",
				"RangedSkill"
			]
		},
		Barbarians =
		{	// TODO: lots of barbos are hybrids
			Melee =
			[
				"Bravery",
				"Hitpoints"
			],
			Ranged =
			[
				"Bravery",
				"Initiative"
			]
		},
		OrientalBandits =
		{
			Melee =
			[
				"MeleeDefense",
				"Initiative"
			],
			Ranged =
			[
				"RangedSkill",
				"Initiative"
			]
		}
	},
	Equipment =
	{
		Bandits =
		{
			Melee =
			{
				Head =
				[
					{
						Cost = 18,
						Path = "scripts/items/helmets/",
						Strength =
						{
							Minimum = 15,
							Maximum = 20
						},
						Scripts =
						[
							"ancient/ancient_household_helmet",
							"ancient/ancient_legionary_helmet",
							"masked_kettle_helmet",
							"nordic_helmet"
						]
					},
					{
						Cost = 9,
						Path = "scripts/items/helmets/",
						Strength =
						{
							Minimum = 9,
							Maximum = 12
						},
						Scripts =
						[
							"aketon_cap",
							"barbarians/bear_headpiece"
							"cultist_leather_hood",
							"jesters_hat",
							"barbarians/leather_headband",
							"full_aketon_cap"
						]
					},
				],
				Armor =
				[
					{
						Cost = 54,
						Path = "scripts/items/armor/",
						Strength =
						{
							Minimum = 25,
							Maximum = 30
						},
						Scripts =
						[
							"ancient/ancient_scale_coat",
							"ancient/ancient_plate_harness",
							"decayed_coat_of_scales",
							"decayed_coat_of_plates",
						]
					},
					{
						Cost = 45,
						Path = "scripts/items/armor/",
						Strength =
						{
							Minimum = 15,
							Maximum = 20
						},
						Scripts =
						[
							"noble_mail_armor",
							"mail_hauberk",
							"light_scale_armor",
							"decayed_reinforced_mail_hauberk",
							"footman_armor"
						]
					},
					{
						Cost = 18,
						Path = "scripts/items/armor/",
						Strength =
						{
							Minimum = 15,
							Maximum = 20
						},
						Scripts =
						[
							"ancient/ancient_double_layer_mail",
							"ancient/ancient_scale_harness",
							"basic_mail_shirt",
							"leather_scale_armor",
							"mail_shirt"
						]
					},
					{
						Cost = 9,
						Path = "scripts/items/armor/",
						Strength =
						{
							Minimum = 9,
							Maximum = 12
						},
						Scripts =
						[
							"ancient/ancient_mail"
							"ragged_dark_surcoat",
							"reinforced_leather_tunic",
							"oriental/linothorax",
							"cultist_leather_robe"
						]
					}
				],
			},
			Ranged =
			{
				Head =
				[

				],
				Armor =
				[

				],
			}
		}
	},
	Perks =
	{
		Bandits =
		{
			Melee =
			[

			],
			Ranged =
			[

			]
		}
	}
};