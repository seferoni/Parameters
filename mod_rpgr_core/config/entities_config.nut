local Core = ::RPGR_Core;
Core.Config.Entities <-
{
	Attributes =
	{
		Bandits =
		{
			Shared =
			{
				ActionPoints = 
				{
					Offset = 3,
					Cost = 30
				}
			},
			Melee =
			{
				MeleeSkill =
				{
					Offset = 8,
					Cost = 18
				}
			},
			Ranged =
			{
				RangedSkill = 
				{
					Offset = 12,
					Cost = 18
				}
			}
		},
		Barbarians =
		{
			Shared =
			{
				Bravery = 
				{
					Offset = 8,
					Cost = 10
				},
				Hitpoints =
				{
					Offset = 15,
					Cost = 18
				},
				Initiative = 
				{
					Offset = 12,
					Cost = 10
				}
			}
		},
		Goblins =
		{
			Shared =
			{
				Initiative = 
				{
					Offset = 25,
					Cost = 20
				},
				RangedDefense = 
				{
					Offset = 7,
					Cost = 10
				}
			},
			Melee =
			{
				Bravery = 
				{
					Offset = 15,
					Cost = 10
				}
			},
			Ranged =
			{
				MeleeDefense =
				{
					Offset = 8,
					Cost = 10
				}
			}
		},
		Orcs =
		{
			Shared =
			{
				Bravery = 
				{
					Offset = 15,
					Cost = 25
				},
				Hitpoints = 
				{
					Offset = 30,
					Cost = 30
				}
			}
		},
		OrientalBandits =
		{
			Shared =
			{
				Initiative = 
				{
					Offset = 20,
					Cost = 15
				}
			},
			Melee =
			{
				MeleeDefense =
				{
					Offset = 8,
					Cost = 20
				}
			},
			Ranged =
			{
				RangedSkill =
				{
					Offset = 15,
					Cost = 20
				}
			}
		},
		Undead =
		{	// TODO:
			Shared =
			[
				"Bravery",
				"MeleeSkill",
				"Hitpoints"
			]
		},
		Zombies =
		{
			Shared =
			[
				"MeleeSkill",
				"Hitpoints"
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
			Shared =
			[

			],
			Melee =
			[

			],
			Ranged =
			[

			]
		},
		Barbarians =
		{
			Shared =
			[

			],
			Melee = [],
			Ranged = []
		},
		Goblins =
		{
			Shared =
			[

			],
			Melee =
			[

			],
			Ranged =
			[

			]
		},
		Orcs =
		{
			Shared =
			[

			],
			Melee = [],
			Ranged = []
		},
		OrientalBandits =
		{
			Shared =
			[

			],
			Melee =
			[

			],
			Ranged =
			[

			]
		},
		Undead =
		{
			Shared =
			[

			],
			Melee = [],
			Ranged = []
		},
		Zombies =
		{
			Shared =
			[

			],
			Melee = [],
			Ranged = []
		}
	}
};