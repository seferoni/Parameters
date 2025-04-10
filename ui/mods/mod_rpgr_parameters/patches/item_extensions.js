jQuery.fn.PRMassignListItemLeftClick = function( _callback )
{
	if (typeof _callback !== "function")
	{
		return;
	}

	this.mousedown(function( _event )
	{	// TODO: clashes with drag events. need inputs that aren't conventionally used
		// OR bind first
		if (_event.which !== PRM.Enums.MouseButtons.LEFT)
		{
			return;
		}

		_event.stopImmediatePropagation();
		_callback(jQuery(this), _event);
		return false;
	});
};