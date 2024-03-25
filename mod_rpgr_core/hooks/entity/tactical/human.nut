local Core = ::RPGR_Core;
::mods_hookBaseClass("entity/tactical/human", function( _object )
{
	Core.Standard.wrap(_object, "assignRandomEquipment", function()
	{
		local worldTroop = this.getWorldTroop();

		if (worldTroop == null || worldTroop.Party == null)
		{
			return;
		}

		if (!Core.Entities.isPartyViable(worldTroop.Party))
		{
			return;
		}

		::logInfo("disbursing tokens for " + this.getName())
		Core.Entities.disburseTokens(this);
	});
});