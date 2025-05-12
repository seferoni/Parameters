::PRM.ScreenTextBuilder <-
{
	function getPlayerCharacterReplacementName()
	{
		return ::PRM.Standard.getParameter("PlayerCharacterScreenNameReplacement");
	}

	function isContractViableForTextAmendment( _contractID )
	{
		if (!this.isNaivelyViableForTextAmendment())
		{
			return false;
		}

		local ineligibleContracts = ::PRM.Utilities.getField("TextReplacementParameters").IneligibleContractIDs;

		if (ineligibleContracts.find(_contractID) != null)
		{
			return false;
		}

		return true;
	}

	function isEventViableForTextAmendment( _eventID )
	{
		if (!this.isNaivelyViableForTextAmendment())
		{
			return false;
		}

		local ineligibleEvents = ::PRM.Utilities.getField("TextReplacementParameters").IneligibleEventIDs;

		if (ineligibleEvents.find(_eventID) != null)
		{
			return false;
		}

		return true;
	}

	function isNaivelyViableForTextAmendment()
	{
		if (::PRM.Utilities.getCurrentRosterSize() > 1)
		{
			return false;
		}

		if (!::PRM.Standard.getParameter("ReplacePlayerCharacterNameInScreens"))
		{
			return false;
		}

		return true;
	}

	function replacePlayerCharacterPlaceholderName( _placeholderArray )
	{
		local playerCharacter = ::PRM.Utilities.getPlayerInRoster();

		if (playerCharacter == null)
		{
			return;
		}

		local playerCharacterName = playerCharacter.getName();

		foreach( index, nestedArray in _placeholderArray )
		{
			if (nestedArray.len() != 2)
			{
				continue;
			}

			if (nestedArray[1] != playerCharacterName)
			{
				continue;
			}

			nestedArray[1] = this.getPlayerCharacterReplacementName();
		}
	}
};