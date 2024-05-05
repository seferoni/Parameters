::Core.Integrations.MSU.Builders.Explicit <-
{
	function addPages()
	{
		local helper = ::Core.Integrations.Helper.getMSUHelper();
		helper.addPage("Presets");
		helper.addPage("Localisation");
	}

	function build()
	{
		this.addPages();
	}

	function buildLocalisationSetting()
	{

	}

	function onLanguageChangeCallback()
	{
		// TODO: this callback resets all other chosen options?
	}

	function onPresetChangeCallback()
	{

	}
};