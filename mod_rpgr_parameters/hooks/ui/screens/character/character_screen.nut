::PRM.Patcher.hookBase("scripts/ui/screens/character/character_screen", function( p )
{
	p.PRM_onRemoveItemAfterClick <- function( _data )
	{
		::World.Assets.getStash().removeByIndex(_data[0]);
		local result =
		{
			stash = ::UIDataHelper.convertStashToUIData(true)
		};
		return result;
	};
});