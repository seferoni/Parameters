jQuery.fn.PRM_assignListItemLeftClick = function( _callback )
{
	if (typeof _callback !== "function")
	{
		return;
	}

	this.mousedown(function( _event )
	{
		if (_event.which !== PRM.Enums.MouseButtons.LEFT)
		{
			return;
		}

		if (!(KeyModiferConstants.ShiftKey in _event) || _event[KeyModiferConstants.ShiftKey] !== true)
		{
			return;
		}

		_event.stopImmediatePropagation();
		_callback(jQuery(this), _event);
		return false;
	});

	this.each(function() 
	{
		var grossHandlers = jQuery._data(this, "events")["mousedown"];
		var currentHandler = grossHandlers.pop();
		grossHandlers.unshift(currentHandler);
	});
};