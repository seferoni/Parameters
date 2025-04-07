::Parameters.RosterHandler <-
{
	function constrainFormation()
	{
		if (!::Parameters.Mapper.mapToDatabase("ConstrainRoster"))
		{
			return;
		}

		local roster = ::World.getPlayerRoster();
		local targetSize = ::Parameters.Mapper.mapToDatabase("MaximumBrothersInCombat");

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

		local eligibleSlots = ::Parameters.Standard.createInclusiveLinearSequence(17, 27);
		::Parameters.Standard.removeFromArray(filledReserveSlots, eligibleSlots);

		for( local i = 0; i < brothersInFormation.len() - targetSize; i++ )
		{
			brothersInFormation[i].setPlaceInFormation(eligibleSlots[i]);
		}

		::World.Assets.m.BrothersMaxInCombat = targetSize;
	}

	function getViableBrothersForRemoval()
	{
		local candidates = [];
		local roster = ::World.getPlayerRoster().getAll();

		foreach( brother in roster )
		{
			if (::Parameters.Standard.getFlag("IsPlayerCharacter", brother))
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
		if (!::Parameters.Mapper.mapToDatabase("ConstrainRoster"))
		{
			return;
		}

		local roster = ::World.getPlayerRoster();
		local targetSize = ::Parameters.Mapper.mapToDatabase("RosterSize");

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