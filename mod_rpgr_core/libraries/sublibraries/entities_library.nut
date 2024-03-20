local Core = ::RPGR_Core;
Core.Entities <-
{	// TODO: need to make sure weaker troops get buffs first. figure this out. can't do sorting since we're not looping through an array
	// TODO need to make sure tokens are not spent on any particular subsection of troops, but more equally on many troops
	Descriptors =
	{	// these are placeholders
		Stout = 20,
		Strong = 40,
		Mighty = 60,
		Legendary = 80
	},
	Parameters =
	{

	},
	Thresholds = 
	{
		// TODO: here we decide the threshold by which we decide which troops get buffs, and which do not
	}

	function buyEquipment( _entityObject )
	{
		
	}

	function buyPerks()
	{

	}

	function disburseTokens( _entityObject )
	{
		local worldTroop = _entityObject.getWorldTroop(),
		tokens = Core.Standard.getFlag("Tokens", worldTroop.Party);

		if (!tokens)
		{
			return;
		}

		// TODO: need to decide how to allocate token budget for each particular expenditure (equipment/perks/attributes/etc)
	}

	function getCombatStyle()
	{

	}

	function getFactionNameFromEnum( _factionEnum )
	{
		foreach( factionName, factionEnum in ::Const.Faction )
		{
			if (factionEnum == _factionEnum)
			{
				return factionName;
			}
		}
	}

	function getFaction( _entityObject )
	{
		local worldTroop = _entityObject.getWorldTroop();
		return worldTroop.Faction;
	}

	function getTokens( _entityObject )
	{
		local worldTroop = _entityObject.getWorldTroop();
	}
}