local Core = ::RPGR_Core;
Core.Troops <-
{
	function addTroops( _troopsArray, _partyObject, _count )
	{
		local troops = _troopsArray.map(@(_troop) {Type = _troop});

		for( local i = 0; i < _count; i++ )
		{
			local troop = troops[::Math.rand(0, troops.len() - 1)];
			::logInfo("adding " + troop.Type.Script)
			::Const.World.Common.addTroop(_partyObject, troop, true);
		}
	}

	function compress( _partyObject, _factionType )
	{

	}

	function getFactionNameFromType( _factionType )
	{
		foreach( factionName, factionEnum in ::Const.FactionType )
		{
			if (factionEnum == _factionType)
			{
				return factionName;
			}
		}
	}

	function isFactionViable( _factionType )
	{
		local factionName = this.getFactionNameFromType(_factionType),
		viableFactions = Core.Standard.getKeys(Core.Config.Troops.Types);

		if (viableFactions.find(factionName) != null)
		{
			return true;
		}

		return false;
	}

	function removeTroops( _culledTroops, _partyObject, _count )
	{
		::logInfo("removing culledTroops for " + _partyObject.getName())
		local targetTroops = _partyObject.getTroops();
		_culledTroops.resize(_count);

		foreach( troop in _culledTroops )
		{
			if (troop == null)
			{
				continue;
			}
			local index = targetTroops.find(troop);

			if (index != null)
			{
				::logInfo("removing " + troop.Script)
				targetTroops.remove(index);
			}
		}
	}

	function setName( _partyObject )
	{
		local name = _partyObject.getName();
		_partyObject.setName(format("Compressed %s", name));
	}
};