::Core.Integrations.MSU.Builders.Explicit <-
{
	function addLanguageChangeCallbacks( _settingElement )
	{
		_settingElement.addBeforeChangeCallback(this.onBeforeLanguageChangeCallback);
		_settingElement.addAfterChangeCallback(this.onAfterLanguageChangeCallback);
	}

	function addLanguageSetting( _settingElement )
	{
		this.getLocalisationPage().addElement(_settingElement);
	}

	function build()
	{
		this.buildPresets();
		this.buildLocalisation();
	}

	function buildLanguageSetting( _settingID )
	{
		local setting = ::MSU.Class.BooleanSetting(_settingID, false);
		this.addLanguageChangeCallbacks(setting);
		this.addLanguageSetting(setting);
	}

	function buildLocalisation()
	{

	}

	function buildPresets()
	{

	}

	function getAllLanguageSettings()
	{
		return this.getLocalisationPage().getAllElementsAsArray();
	}

	function getLocalisationPage()
	{
		return ::Core.Integrations.getMSUHelper().getPage("Localisation");
	}

	function onBeforeLanguageChangeCallback( _newValue )
	{
		local settings = this.getAllLanguageSettings();

		foreach( setting in settings )
		{
			setting.set(false);
		}
	}

	function onAfterLanguageChangeCallback( _newValue )
	{
		// TODO: this should change whatever references the language folder
	}

	function onPresetChangeCallback()
	{

	}
};