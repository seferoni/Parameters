local Core = ::RPGR_Core;
::mods_hookBaseClass("entity/tactical/human", function( _object )
{
	Core.Standard.wrap(_object, "assignRandomEquipment", function()
	{
		local worldTroop = this.getWorldTroop();

		if (worldTroop == null || troop.Party == null)
		{
			::logInfo("world troop empty - how?")
			return;
		}

		Core.Entities.disburseTokens(this, troop.Party);
	});
});