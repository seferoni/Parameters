CharacterScreenDatasource.prototype.PRMnotifyBackendRemoveItemAfterClick = function( _itemIndex, _callback )
{
	SQ.call(this.mSQHandle, 'onRemoveItemAfterClick', [_itemIndex], _callback);
};

CharacterScreenDatasource.prototype.PRMremoveItemAfterClick = function( _itemIndex )
{
	var self = this;
	this.notifyBackendRemoveItemAfterClick(_itemIndex, function( _data )
	{

	});
};