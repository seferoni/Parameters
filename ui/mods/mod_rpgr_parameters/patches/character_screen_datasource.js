CharacterScreenDatasource.prototype.PRM_notifyBackendRemoveItemAfterClick = function( _itemIndex )
{
	var context = this;
	SQ.call(this.mSQHandle, "PRM_onRemoveItemAfterClick", [_itemIndex], function( _data )
	{
		if (_data == null)
		{
			return;
		}

		context.loadFromData(_data);
	});
};