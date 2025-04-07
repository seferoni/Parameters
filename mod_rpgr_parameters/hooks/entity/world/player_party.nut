::Parameters.Patcher.hook("scripts/entity/world/player_party", function( p )
{
	::Parameters.Patcher.wrap(p, "getStrength", function( _originalValue )
	{
		local prefactor = ::Parameters.Mapper.get("PartyStrengthMult", true);
		::logInfo("got an original value of " + _originalValue); // TODO: get rid of these
		::logInfo("new value was " + _originalValue * prefactor);
		return _originalValue * prefactor;
	});
});