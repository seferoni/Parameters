CharacterScreenDatasource.prototype.PRMnotifyBackendRemoveItemAfterClick = function( _itemIndex )
{
	var context = this;
	SQ.call(this.mSQHandle, 'PRMonRemoveItemAfterClick', [_itemIndex], function( _data )
	{
		context.loadFromData(_data);
	});
};

CharacterScreenDatasource.prototype.PRMremoveItemAfterClick = function( _itemIndex )
{
	this.PRMnotifyBackendRemoveItemAfterClick(_itemIndex);
};