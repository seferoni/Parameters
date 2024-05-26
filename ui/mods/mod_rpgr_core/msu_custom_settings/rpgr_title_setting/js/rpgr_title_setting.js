var RPGRTitleSetting = function( _mod, _page, _setting, _parentDiv )
{
	this.data = _setting;
	this.layout = $('<div class="title-container"/>')
		.css("left", _setting.data.LeftOffset)
		.appendTo(_parentDiv);
	this.title = $('<div class="title title-font-big font-bold font-color-title">' + _setting.name + '</div>')
		.appendTo(this.layout);
	this.title.bindTooltip(
	{	// TODO: not sure i fully understand this
		contentType: 'msu-generic',
		modId: MSU.ID,
		elementId: "ModSettings.Element.Tooltip",
		elementModId: _mod.id,
		settingsElementId: _setting.id
	});
};

RPGRTitleSetting.prototype.unbindTooltip = function()
{
	this.title.unbindTooltip();
};
