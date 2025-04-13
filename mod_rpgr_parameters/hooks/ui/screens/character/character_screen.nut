::PRM.Patcher.hookBase("scripts/ui/screens/character/character_screen", function( p )
{
	p.PRM_onRemoveItemAfterClick <- function( _data )
	{
		if (!::PRM.Mapper.mapToDatabase("RemovableStashItems"))
		{
			return null;
		}

		local playerStash = ::World.Assets.getStash();
		local item = playerStash.getItemAtIndex(_data[0]);

		if (!::PRM.StashHandler.isItemViableForRemoval(item, true))
		{
			return;
		}

		item.playInventorySound(::Const.Items.InventoryEventType.PlacedOnGround);
		playerStash.remove(item);
		local result =
		{
			stash = ::UIDataHelper.convertStashToUIData(true)
		};
		return result;
	};
});