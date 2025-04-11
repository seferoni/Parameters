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

		if (!(KeyModiferConstants.CtrlKey in _event) || _event[KeyModiferConstants.CtrlKey] !== true)
		{
			return;
		}

		var settingState = PRM.Utilities.getMSUSettingIfPresent("RemovableStashItems");

		if (settingState === false)
		{
			return;
		}

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