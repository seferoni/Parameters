::Core.Integrations.MSU.CustomSettings.VariableWidthTitleSetting <- class extends ::MSU.Class.SettingsElement
{
	static Type = "VariableWidthTitle";

	constructor(_id, _width, _name = null, _description = null)
	{
		base.constructor(_id, _name, _description);
		this.Data.Width <- _width;
	}
};