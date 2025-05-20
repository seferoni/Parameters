::PRM.Patcher.hook("scripts/retinue/followers/negotiator_follower", function( p )
{
	::PRM.Patcher.wrap(p, "onUpdate", function()
	{
		local positiveDecayMultiplier = ::PRM.Mapper.mapToDatabase("RelationDecayGoodMult");
		local negativeDecayMultiplier = ::PRM.Mapper.mapToDatabase("RelationDecayBadMult");
		# Prefactor values below are taken verbatim from vanilla.
		::World.Assets.m.RelationDecayGoodMult = positiveDecayMultiplier * 0.85;
		::World.Assets.m.RelationDecayBadMult = negativeDecayMultiplier * 1.15;
	});
});