::PRM.Utilities <-
{
	function getCurrentRosterSize()
	{
		return ::World.getPlayerRoster().getAll().len();
	}

	function getCommonField( _fieldName )
	{
		return this.getField("Common")[_fieldName];
	}

	function getField( _fieldName )
	{
		return ::PRM.Database.getField("Generic", _fieldName);
	}

	function getItemString( _fieldName )
	{
		return this.getStringField("Items")[_fieldName]
	}

	function getKrakenBuiltState()
	{
		return ::PRM.Standard.getFlag("KrakenBuilt", ::World.Statistics);
	}

	function getPlayerInRoster()
	{
		local playerRoster = ::World.getPlayerRoster().getAll();

		foreach( brother in playerRoster )
		{
			if (this.isActorPlayerCharacter(brother))
			{
				return brother;
			}
		}

		return null;
	}

	function getStringField( _fieldName )
	{
		return ::PRM.Strings.getField("Generic", _fieldName);
	}

	function getTooltipString( _fieldName )
	{
		return this.getStringField("Tooltips")[_fieldName];
	}

	function isActorPlayerCharacter( _actorObject )
	{
		if (!_actorObject.getSkills().hasSkill("trait.player"))
		{
			return false;
		}

		if (!::PRM.Standard.getFlag("IsPlayerCharacter", _actorObject))
		{
			return false;
		}

		return true;
	}

	function setKrakenBuiltState( _newValue = true )
	{
		::PRM.Standard.setFlag("KrakenBuilt", _newValue, ::World.Statistics);
	}
};