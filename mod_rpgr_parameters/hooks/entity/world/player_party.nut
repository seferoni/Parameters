::PRM.Patcher.hook("scripts/entity/world/player_party", function( p )
{
	::PRM.Patcher.wrap(p, "getStrength", function( _originalValue )
	{
		local prefactor = ::PRM.Mapper.mapToDatabase("PartyStrengthMult", true);
		return _originalValue * prefactor;
	});
});