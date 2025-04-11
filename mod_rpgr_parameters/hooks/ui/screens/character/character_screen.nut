::PRM.Patcher.hookBase("scripts/ui/screens/character/character_screen", function( p )
{
	p.PRM_onRemoveItemAfterClick <- function( _data )
	{
		local removedItem = ::World.Assets.getStash().removeByIndex(_data[0]);

		if (removedItem != null)
		{
			removedItem.playInventorySound(::Const.Items.InventoryEventType.PlacedOnGround);
		}

		local result =
		{
			stash = ::UIDataHelper.convertStashToUIData(true)
		};
		return result;
	};
});