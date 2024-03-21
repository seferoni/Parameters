local Core = ::RPGR_Core;
Core.Config.Entities <-
{
	Attributes = 
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
	},
	Equipment =
	{
		Bandits =
		{	// tables need to be sorted from strongest to weakest
			Melee =
			{
				Head =
				[
					{	
						
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
							"basic_mail_shirt",
							"leather_scale_armor",
							"mail_shirt"
						]
					},
					{
						Cost = 18,
						Path = "scripts/items/armor/",
						Strength =
						{
							Minimum = 9,
							Maximum = 12
						},
						Scripts =
						[
							""
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
							""
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