::PRM.Patcher.hookTree("scripts/events/event", function( p )
{
	::PRM.Patcher.wrap(p, "onPrepareVariables", function( _vars )
	{
		if (!::PRM.ScreenTextBuilder.isEventViableForTextAmendment(this.m.ID))
		{
			return;
		}

		::PRM.ScreenTextBuilder.replacePlayerCharacterPlaceholderName(_vars);
	});
});