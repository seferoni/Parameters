::PRM.Patcher.hook("scripts/items/special/legendary_sword_blade_item", function( p )
{
	::PRM.Patcher.wrap(p, "create", function()
	{
		if (::PRM.Utilities.getKrakenBuiltState())
		{
			return;
		}

		this.m.Description = ::PRM.Utilities.getItemString("ReproachBladeDescription");
	});
});