::PRM.Patcher.hook("scripts/ambitions/ambitions/defeat_kraken_ambition", function( p )
{
	::PRM.Patcher.wrap(p, "onUpdateScore", function()
	{
		if (::PRM.Utilities.getKrakenBuiltState())
		{
			return;
		}

		this.m.Score = 0;
	});
});