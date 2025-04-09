PRM.Patcher.wrap(CharacterScreenInventoryListModule.prototype, "createItemSlot", function( _result, _owner, _index, _parentDiv, _screenDiv )
{
	var context = this;
	PRM.Patcher.wrap(_result, "assignListItemRightClick", function( _item, _event )
	{
		var data = _item.data('item');

		if (data === null || !('index' in data))
		{
			return null;
		}
	
		if (!(KeyModiferConstants.ShiftKey in _event))
		{
			return null;
		}
	
		context.mDataSource.PRMremoveItemAfterClick(data.index);
	}, "overrideMethod");
});