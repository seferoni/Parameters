local Core = ::RPGR_Core;
Core.Troops <-
{
	Template =
	{
		Low = [],
		Medium = [],
		High = []
	},

	function addTroop( _party, _troopType, _troopCount )
	{

	}

	function compress( _party, _factionType )
	{
		local troops = _party.getTroops(),
		factionName = this.getFactionNameFromType(_factionType);

		local ledger = clone this.Template,
		tokens = Core.Config.Tokens[factionName],
		types = Core.Config.Types[factionName];

		troops.apply(function(entity)
		{
			foreach( ledgerKey, tally in ledger )
			{
				local list = types[ledgerKey];

				if (list.find(entity)) tally.push(entity);
			}
		});

		foreach( ledgerKey, tally in ledger )
		{
			local token = tokens[ledgerKey];

			if (tally.len() >= token.Medium)
			{
				// TODO: this is obviously not going to work. revise token table structure in config
			}
		}
	}

	function getFactionNameFromType( _factionType )
	{
		foreach( factionName, factionEnum in ::Const.FactionType )
		{
			if (factionEnum == _factionType)
			{
				return factionName;
			}
		}
	}
};