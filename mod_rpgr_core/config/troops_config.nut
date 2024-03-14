local Core = ::RPGR_Core;
Core.Config <-
{
	Tokens =
	{	// TODO: we're gonna need new troop types lol
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
				Medium = 4,
				High = 7
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
		}
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
		{
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
		}
	}
};