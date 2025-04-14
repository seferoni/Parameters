::PRM.Patcher.hook("scripts/retinue/followers/bounty_hunter_follower", function( p )
{
	::PRM.Patcher.wrap(p, "onUpdate", function()
	{
		local offset = ::PRM.Mapper.mapToDatabase("ChampionChanceAdditional");
		# Numerical offset value below is taken verbatim from vanilla.
		::World.Assets.m.ChampionChanceAdditional = offset + 3;
	});
});