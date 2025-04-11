::PRM.Patcher.hookBase("scripts/ui/screens/tooltip/tooltip_events", function( p )
{
	::PRM.Patcher.wrap(p, "tactical_helper_addHintsToTooltip", function( _result, _activeEntity, _entity, _item, _itemOwner, _ignoreStashLocked = false )
	{
		if (!::PRM.Mapper.mapToDatabase("RemovableStashItems"))
		{
			return;
		}

		if (_itemOwner != "stash" && _itemOwner != "character-screen-inventory-list-module.stash")
		{
			return;
		}

		local entry = ::PRM.Standard.constructEntry
		(
			"LeftClickCTRL",
			::PRM.Utilities.getTooltipString("RemovableStashItemHint")
		);
		entry.type = "hint";
		_result.push(entry);
	});
});