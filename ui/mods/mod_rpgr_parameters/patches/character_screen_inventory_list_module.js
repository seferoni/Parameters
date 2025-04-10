PRM.Patcher.wrap($.fn, "assignListItemRightClick", function( _result, _callback )
{
	if (typeof _callback !== 'function')
	{
		return null;
	}

	this.mousedown(function( _event )
	{
		if (_event.which !== PRM.Enums.MouseButtons.LEFT)
		{
			return null;
		}

		_callback($(this), _event);
		return false;
	});

}, "overrideMethod");