::PRM.Patcher.hookTree("scripts/contracts/contract", function( p )
{
	::PRM.Patcher.wrap(p, "onPrepareVariables", function( _vars )
	{
		if (!::PRM.ScreenTextBuilder.isContractViableForTextAmendment(this.m.ID))
		{
			return;
		}

		::PRM.ScreenTextBuilder.replacePlayerCharacterPlaceholderName(_vars);
	});
});