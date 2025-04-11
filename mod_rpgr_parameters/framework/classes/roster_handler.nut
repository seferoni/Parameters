::PRM.RosterHandler <-
{
	function assignSerialisedRosterSizes()
	{
		if (!::PRM.Mapper.mapToDatabase("ConstrainRoster"))
		{
			return;
		}

		::PRM.Standard.setFlag("MaxBrothersInCombat", ::PRM.Mapper.mapToDatabase("MaxBrothersInCombat"), ::World.Statistics);
		::PRM.Standard.setFlag("RosterSize", ::PRM.Mapper.mapToDatabase("RosterSize"), ::World.Statistics);
	}

	function constrainFormation()
	{
		local serialisedMaxBrothersInCombat = this.getSerialisedMaxBrothersInCombat();

		if (serialisedMaxBrothersInCombat == null)
		{
			return;
		}

		local roster = ::World.getPlayerRoster();
		local targetSize = serialisedMaxBrothersInCombat;

		if (roster.getSize() < targetSize)
		{
			::World.Assets.m.BrothersMax = targetSize;
			return;
		}

		local brothersInFormation = [];
		local filledReserveSlots = [];

		foreach( brother in roster.getAll() )
		{
			local formationSlot = brother.getPlaceInFormation();

			if (!this.isReserveSlot(formationSlot))
			{
				brothersInFormation.push(brother);
				continue;
			}

			filledReserveSlots.push(formationSlot);
		}

		if (brothersInFormation.len() <= targetSize)
		{
			::World.Assets.m.BrothersMaxInCombat = targetSize;
			return;
		}

		local eligibleSlots = ::PRM.Standard.createInclusiveLinearSequence(17, 27);
		::PRM.Standard.removeFromArray(filledReserveSlots, eligibleSlots);

		for( local i = 0; i < brothersInFormation.len() - targetSize; i++ )
		{
			brothersInFormation[i].setPlaceInFormation(eligibleSlots[i]);
		}

		::World.Assets.m.BrothersMaxInCombat = targetSize;
	}

	function getSerialisedMaxBrothersInCombat()
	{
		local maxBrothersInCombat = ::PRM.Standard.getFlag("MaxBrothersInCombat", ::World.Statistics);

		if (maxBrothersInCombat == false)
		{
			return null;
		}

		return maxBrothersInCombat;
	}

	function getSerialisedRosterSize()
	{
		local rosterSize = ::PRM.Standard.getFlag("RosterSize", ::World.Statistics);

		if (rosterSize == false)
		{
			return null;
		}

		return rosterSize;
	}

	function getViableBrothersForRemoval()
	{
		local candidates = [];
		local roster = ::World.getPlayerRoster().getAll();

		foreach( brother in roster )
		{
			if (::PRM.Standard.getFlag("IsPlayerCharacter", brother))
			{
				continue;
			}

			candidates.push(brother);
		}

		return candidates;
	}

	function isReserveSlot( _formationSlot )
	{
		return _formationSlot >= 17;
	}

	function setRosterSize()
	{
		local serialisedRosterSize = this.getSerialisedRosterSize();

		if (serialisedRosterSize == null)
		{
			return;
		}

		local roster = ::World.getPlayerRoster();
		local targetSize = serialisedRosterSize;

		if (roster.getSize() <= targetSize)
		{
			::World.Assets.m.BrothersMax = targetSize;
			return;
		}

		local viableBrothers = this.getViableBrothersForRemoval();

		if (viableBrothers.len() < roster.getSize() - targetSize)
		{
			::World.Assets.m.BrothersMax = roster.getSize();
			return;
		}

		while (roster.getSize() > targetSize)
		{
			roster.remove(viableBrothers[::Math.rand(0, viableBrothers.len() - 1)])
		}

		::World.Assets.m.BrothersMax = targetSize;
	}
};