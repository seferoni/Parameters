PRM.Wrappers.assignListItemRightClick = function( _item, _event, _originalMethod )
{
	var data = _item.data('item');

	if (data === null)
	{
		_originalMethod.call(this, _item, _event);
		return;
	}

	if (!('index' in data))
	{
		_originalMethod.call(this, _item, _event); // TODO: lambda-ify this
		return;
	}

	if (!('itemId' in data))
	{
		_originalMethod.call(this, _item, _event);
		return;
	}

	if (!(KeyModifierConstants.ShiftKey in _event))
	{
		_originalMethod.call(this, _item, _event);
		return;
	}

	this.mDataSource.deleteItemAfterClick(data.itemId, data.index, false); // TODO: pseudo-code
}

PRM.Wrappers.createItemSlot = function( _originalMethod )
{
	PRM.HookCache.createItemSlot = _originalMethod;
	var wrapper = function(_owner, _index, _parentDiv, _screenDiv)
	{
		var originalValue = PRM.HookCache.createItemSlot.call(this, _owner, _index, _parentDiv, _screenDiv);


		return originalValue;
	};
};