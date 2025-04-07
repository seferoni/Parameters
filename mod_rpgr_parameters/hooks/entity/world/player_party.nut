::Parameters.Patcher.hook("scripts/entity/world/player_party", function( p )
{
	::Parameters.Patcher.wrap(p, "getStrength", function()
	{
		// TODO:
	});
});