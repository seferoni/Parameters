local Core = ::RPGR_Core;
Core.Config.Attributes <-
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
	{
		Shared =
		{
			Bravery =
			{
				Offset = 30,
				Cost = 25
			},

		}
	},
	Zombies =
	{
		Shared =
		{
			MeleeSkill =
			{
				Offset = 8,
				Cost = 10
			},
			Hitpoints =
			{
				Offset = 15,
				Cost = 10
			}
		}
	}
};