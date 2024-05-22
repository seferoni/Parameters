var VariableWidthTitleSetting = function( _mod, _page, _setting, _parentDiv )
{
	this.data = _setting;
	this.layout = $('<div class="title-container"/>');
	_parentDiv.append(this.layout);
	this.title = $('<div class="title title-font-big font-bold font-color-title">' + _setting.name + '</div>');
	this.layout.css("width", this.data.data.Width);
	this.layout.append(this.title);
	this.title.bindTooltip({ contentType: 'msu-generic', modId: MSU.ID, elementId: "ModSettings.Element.Tooltip", elementModId: _mod.id, settingsElementId: _setting.id });
};

TitleSetting.prototype.unbindTooltip = function()
{
	this.title.unbindTooltip();
};
