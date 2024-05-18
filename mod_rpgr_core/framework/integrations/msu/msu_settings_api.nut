::Core.Integrations.MSU <-
{
	Preset = "RPGR",

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
		return this.Preset;
	}

	function getDefaultValue( _settingKey )
	{
		return ::Core.Database.getDefaults(this.getActivePreset())[_settingKey];
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

	function getSettingDescription( _key )
	{
		return ::Core.Strings.Settings[format("%sDescription", _key)];
	}

	function getSettingName( _key )
	{
		return ::Core.Standard.getKey(_key, ::Core.Strings.Settings);
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

	function setPreset( _newValue )
	{
		this.Preset = this.getExplicitBuilder().getPresetKeyBySettingID(_newValue);
	}
};