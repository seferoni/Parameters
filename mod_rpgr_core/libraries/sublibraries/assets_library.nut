Core = ::RPGR_Core;
Core.Assets <-
{
    Parameters = 
    {
        CombatLootChance = 0.3,
        RenownRate = 0.8,
        RenownLossRate = 1.8
    }
    Settlements = 
    {
        BuyPriceMult = 2.3,
        SellPriceMult = 1.2,
        RecruitsMult = 0.2,
    }
    World =
    { 
        ContractPaymentMult = 0.7,
        DailyWageMult = 1.6,
        FoodConsumptionMult = 1.4,
        RepairSpeedMult = 0.3,
        XPMult = 0.4
    }

    function getBuyPriceMult()
    {
        return this.Settlements.BuyPriceMult;
    }

    function getCombatLootChance()
    {
        return this.Parameters.CombatLootChance;
    }

    function getContractPaymentMult()
    {
        return this.World.ContractPayMult;
    }

    function getDailyWageMult()
    {
        return this.World.DailyWageMult;
    }

    function getFoodConsumptionMult()
    {
        return this.World.FoodConsumptionMult;
    }

    function getRecruitsMult()
    {
        return this.Settlements.RecruitsMult;
    }

    function getRepairSpeedMult()
    {
        return this.World.RepairSpeedMult;
    }

    function getSellPriceMult()
    {
        return this.Settlements.SellPriceMult;
    }

    function getXPMult()
    {
        return this.World.XPMult;
    }

    function initialiseWorldParameters( _world )
    {
        foreach( key, value in this.World )
        {
            _world.m[key] = this[format("get%s", key)()];
        }
    }
}