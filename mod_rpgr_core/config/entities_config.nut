local Core = ::RPGR_Core;
Core.Config.Entities <-
{
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
						Cost = 45,
						Path = "scripts/items/armor/",
						Strength =
						{
							Minimimum =	15,
							Maximum = 20
						},
						Scripts =
						[
							"noble_mail_armor",
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
							Minimimum =	15,
							Maximum = 20
						},
						Scripts =
						[
							"basic_mail_shirt",
							"leather_scale_armor",
							"mail_shirt"
						]
					},
					{
						Cost = 20,
						Path = "scripts/items/armor/",
						Strength =
						{
							Minimimum = 9,
							Maximum = 12
						},
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
};