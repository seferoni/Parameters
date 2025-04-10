CharacterScreenDatasource.prototype.PRM_notifyBackendRemoveItemAfterClick = function( _itemIndex )
{
	var context = this;
	SQ.call(this.mSQHandle, "PRM_onRemoveItemAfterClick", [_itemIndex], function( _data )
	{
		context.loadFromData(_data);
	});
};