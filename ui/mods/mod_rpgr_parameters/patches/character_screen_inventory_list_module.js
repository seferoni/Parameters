PRM.Patcher.wrap(CharacterScreenInventoryListModule.prototype, "createItemSlot", function( _result, _owner, _index, _parentDiv, _screenDiv )
{
	var context = this;
	_result.PRM_assignListItemLeftClick(function( _item, _event )
	{
		var itemIndex = PRM.Classes.ItemEvents.fetchIndexFromDataOnDeleteEvent(_item, _event);

		if (itemIndex === null)
		{
			return null;
		}

		context.mDataSource.PRM_notifyBackendRemoveItemAfterClick(itemIndex);
	});
}, "overrideReturn");