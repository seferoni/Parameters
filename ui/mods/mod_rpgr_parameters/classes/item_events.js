PRM.Classes.ItemEvents =
{
	fetchIndexFromDataOnDeleteEvent : function( _item, _event )
	{
		var itemData = _item.data("item");

		if (itemData === null || !("index" in itemData))
		{
			PRM.Utilities.log("Could not fetch item index for item deletion.");
			return null;
		}

		return itemData.index;
	}
};