::PRM.Patcher.hookBase("scripts/ui/screens/character/character_screen", function( p )
{
	::PRM.Patcher.wrap(p, "PRMonRemoveItemAfterClick", function( _data )
	{
		local itemIndex = _data[0];
		local removedItem = ::World.Assets.getStash().removeByIndex(itemIndex);

		if (removedItem == null)
		{
			return null;
		}

		local result = {};
		result.stash <- ::UIDataHelper.convertStashToUIData(true);
		return result;
	});
});