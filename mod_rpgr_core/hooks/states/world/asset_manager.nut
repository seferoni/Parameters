local Core = ::RPGR_Core;
::mods_hookNewObject("states/world/asset_manager", function( _object )
{ // TODO: Consider which additional parameters need changing.
    _object.m.ContractPaymentMult = Core.getContractPayMult();
    _object.m.DailyWageMult = Core.getDailyWageMult();
    _object.m.XPMult = Core.getXPMult();
    _object.m.FoodConsumptionMult = Core.getFoodConsumptionMult();
    _object.m.RepairSpeedMult = Core.getRepairSpeedMult();
    _object.m.BusinessReputationRate = Core.getRenownRate();

    local vanilla_addBusinessReputation = _object.addBusinessReputation;
    _object.addBusinessReputation <- function( _f )
    {
        local renownChange = _f;

        if (renownChange >= 0)
        {
           return vanilla_addBusinessReputation(renownChange);
        }

        if (renownChange == ::Const.World.Assets.ReputationOnLoss)
        {
            renownChange *= Core.getRenownLossOnDefeatMult();
            return vanilla_addBusinessReputation(renownChange);
        }

        local renownLossRate = ::World.Assets.getBusinessReputation() > 0 ? Core.getRenownLossRate() : Core.getRenownLossRate() / 2;
        renownChange *= (renownLossRate / this.m.BusinessReputationRate);
        return vanilla_addBusinessReputation(renownChange);
    }

    local vanilla_resetToDefaults = _object.resetToDefaults;
    _object.resetToDefaults = function()
    {
        local fetch = vanilla_resetToDefaults();
        this.m.ContractPaymentMult = Core.getContractPayMult();
        this.m.DailyWageMult = Core.getDailyWageMult();
        this.m.XPMult = Core.getXPMult();
        this.m.FoodConsumptionMult = Core.getFoodConsumptionMult();
        this.m.RepairSpeedMult = Core.getRepairSpeedMult();
        this.m.BusinessReputationRate = Core.getRenownRate();
        return fetch;
    }
});

