PRM.Classes.ItemEvents =
{
	fetchIndexFromDataOnDeleteEvent : function( _item, _event )
	{
		PRM.Utilities.log("isDeleteKeybindPressed called!");
		var itemData = _item.data("item");

		if (itemData === null || !("index" in itemData))
		{
			PRM.Utilities.log("data invalid!");
			return null;
		}

		if (!(KeyModiferConstants.ShiftKey in _event) || _event[KeyModiferConstants.ShiftKey] !== true)
		{
			PRM.Utilities.log("shift key not pressed!");
			return null;
		}

		PRM.Utilities.log("valid!");
		PRM.Utilities.log(PRM.Utilities.format("got index with {0}!", [itemData.index]));
		return itemData.index;
	}
};