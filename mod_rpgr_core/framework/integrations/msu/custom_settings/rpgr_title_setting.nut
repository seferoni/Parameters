::Core.Integrations.MSU.CustomSettings.RPGRTitleSetting <- class extends ::MSU.Class.SettingsElement
{
	static Type = "RPGRTitle";
	constructor(_id, _leftOffset, _name = null, _description = null)
	{
		base.constructor(_id, _name, _description);
		this.Data.LeftOffset <- _leftOffset;
	};
};