local Core = ::RPGR_Core;
Core.Config.Troops <-
{
	Tokens =
	{
		Bandits =
		{
			Low =
			{
				Medium = 2,
				High = 6
			},
			Medium =
			{
				High = 4
			}
		},
		Barbarians =
		{
			Low =
			{
				Medium = 3,
				High = 6
			},
			Medium =
			{
				High = 4
			}
		},
		NobleHouse =
		{
			Low =
			{
				Medium = 6,
				High = 9
			},
			Medium =
			{
				High = 6
			}
		},
		OrientalBandits =
		{
			Low =
			{
				Medium = 2,
				High = 6
			},
			Medium =
			{
				High = 4
			}
		},
	},
	Types =
	{
		Bandits =
		{
			Low =
			[
				"BanditThug",
				"BanditMarksmanLOW",
				"Wardog"
			],
			Medium =
			[
				"BanditRaider",
				"BanditMarksman"
			],
			High =
			[
				"BanditLeader",
				"Mercenary",
				"MercenaryRanged"
			]
		},
		Barbarians =
		{	// TODO: bugged for some reason. keeps picking out bandits
			Low =
			[
				"BarbarianThrall",
				"Warhound"
			],
			Medium =
			[
				"BarbarianMarauder"
			],
			High =
			[
				"BarbarianChosen"
			]
		},
		NobleHouse =
		{
			Low =
			[
				"Footman",
				"Billman",
				"ArmoredWardog"
			],
			Medium =
			[
				"Arbalester",
				"Sergeant"
			],
			High =
			[
				"Knight",
				"Greatsword"
			]
		},
		OrientalBandits =
		{
			Low =
			[
				"NomadCutthroat",
				"NomadSlinger"
			],
			Medium =
			[
				"NomadArcher",
				"NomadOutlaw"
			],
			High =
			[
				"NomadLeader"
			]
		},
	}
};