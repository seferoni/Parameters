::Core.Integrations.MSU <-
{
	Preset = null,

	function addPage( _pageID )
	{
		return this.getMSUInterface().ModSettings.addPage(_pageID);
	}

	function appendElementToPage( _settingElement, _pageID )
	{
		this.getPage(_pageID).addElement(_settingElement);
	}

	function build()
	{
		this.getExplicitBuilder().build();
		this.getImplicitBuilder().build();
	}

	function buildDescription( _settingElement )
	{
		local description = this.getSettingDescription(_settingElement.getID());
		_settingElement.setDescription(description);
	}

	function createTables()
	{
		this.Builders <- {};
	}

	function getActivePreset()
	{
		if (this.Preset == null)
		{
			return "RPGR";
		}

		return this.Preset;
	}

	function getDefaultValue( _settingKey )
	{
		return ::Core.Database.getDefaultValue(this.getActivePreset(), _settingKey);
	}

	function getExplicitBuilder()
	{
		return this.Builders.Explicit;
	}

	function getMSUInterface()
	{
		return ::Core.getManager().getMSUInterface();
	}

	function getImplicitBuilder()
	{
		return this.Builders.Implicit;
	}

	function getPage( _pageID )
	{
		return ::Core.getManager().getMSUInterface().ModSettings.getPage(_pageID);
	}

	function getPages()
	{
		return ::Core.getManager().getMSUInterface().ModSettings.getPanel().getPages();
	}

	function getSettingDescription( _settingID )
	{
		return ::Core.Strings.Settings[format("%sDescription", _settingID)];
	}

	function getSettingName( _settingID )
	{
		return ::Core.Strings.Settings[format("%s", _settingID)];
	}

	function initialise()
	{
		this.createTables();
		this.loadBuilders();
		this.build();
	}

	function loadBuilders()
	{
		::Core.getManager().includeFiles("mod_rpgr_core/framework/integrations/msu/builders");
	}

	function setPreset( _settingID )
	{
		this.Preset = this.getExplicitBuilder().getPresetKeyBySettingID(_settingID);
	}
};