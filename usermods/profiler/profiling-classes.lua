
----------------------------------------------------------------------------------------------------------------------------
-- Step 0: Make a backup of the file you are converting. You should not change the file with all of this in it, as it can
-- be hard to get rid of it all again. Especially what we add to the functions.

----------------------------------------------------------------------------------------------------------------------------
-- Step 1: Paste this snippet at top of class file and fill in placeholders

-- Profiling moho (engine) functions template

-- identifier
local identifier = "ReplaceMeForClassName"                                          -- TODO: replace with actual moho methods

-- prepare tracker
local simModel = import("/mods/profiler/modules/sim/model.lua")
simModel.ClassCounters[identifier] = simModel.ClassCounters[identifier] or { }
local tracker = simModel.ClassCounters[identifier]
tracker.LuaFunctions = { }
tracker.EngineFunctions = { }

-- moho (engine) methods
local methods = {
    "PutTemplateHere", "DoNotForget",                                               -- TODO: replace with actual moho methods
}

-- replace moho (engine) methods before the class is made
local mohoMethods = _G.moho.unit_methods                                            -- TODO: replace with actual moho methods
for k, id in methods do 

    -- uplift the for loop iterator values
    local localID = id

    -- keep track of the original function
    local old = mohoMethods[localID]
    mohoMethods[localID] = function(...)
        -- keep track how often we called this function
        tracker.EngineFunctions[localID] = tracker.EngineFunctions[localID] or 0
        tracker.EngineFunctions[localID] = tracker.EngineFunctions[localID] + 1

        -- call the old function
        return old(unpack(arg))
    end
end

-- deallocate
methods = nil

----------------------------------------------------------------------------------------------------------------------------
-- Step 2: Place the right (moho) engine functions in the methods table.

-- Moho functions of unit_methods

local methods = {
    "AddCommandCap", "AddToggleCap", "AddUnitToStorage", "AlterArmor", "CalculateWorldPositionFromRelative", "CanBuild", "CanPathTo", "CanPathToRect", "ClearFocusEntity", "EnableManipulators", "GetArmorMult", "GetAttacker", "GetBlip", "GetBuildRate", "GetCargo", "GetCommandQueue", "GetConsumptionPerSecondEnergy", "GetConsumptionPerSecondMass", "GetCurrentLayer", "GetCurrentMoveLocation", "GetFireState", "GetFocusUnit", "GetFuelRatio", "GetFuelUseTime", "GetGuardedUnit", "GetGuards", "GetHealth", "GetNavigator", "GetNukeSiloAmmoCount", "GetNumBuildOrders", "GetProductionPerSecondEnergy", "GetProductionPerSecondMass", "GetRallyPoint", "GetResourceConsumed", "GetScriptBit", "GetShieldRatio", "GetStat", "GetTacticalSiloAmmoCount", "GetTargetEntity", "GetTransportFerryBeacon", "GetUnitId", "GetVelocity", "GetWeapon", "GetWeaponCount", "GetWorkProgress", "GiveNukeSiloAmmo", "GiveTacticalSiloAmmo", "HasMeleeSpaceAroundTarget", "HasValidTeleportDest", "HideBone", "IsBeingBuilt", "IsCapturable", "IsIdleState", "IsMobile", "IsMoving", "IsOverchargePaused", "IsPaused", "IsStunned", "IsUnitState", "IsValidTarget", "KillManipulator", "KillManipulators", "MeleeWarpAdjacentToTarget", "PrintCommandQueue", "RecoilImpulse", "RemoveBuildRestriction", "RemoveCommandCap", "RemoveNukeSiloAmmo", "RemoveTacticalSiloAmmo", "RemoveToggleCap", "RestoreBuildRestrictions", "RestoreCommandCaps", "RestoreToggleCaps", "RevertCollisionShape", "RevertElevation", "RevertRegenRate", "ScaleGetBuiltEmitter", "SetAccMult", "SetAutoMode", "SetBlockCommandQueue", "SetBreakOffDistanceMult", "SetBreakOffTriggerMult", "SetBuildRate", "SetBusy", "SetCapturable", "SetConsumptionActive", "SetConsumptionPerSecondEnergy", "SetConsumptionPerSecondMass", "SetCreator", "SetCustomName", "SetDoNotTarget", "SetElevation", "SetFireState", "SetFocusEntity", "SetFuelRatio", "SetFuelUseTime", "SetImmobile", "SetIsValidTarget", "SetOverchargePaused", "SetPaused", "SetProductionActive", "SetProductionPerSecondEnergy", "SetProductionPerSecondMass", "SetReclaimable", "SetRegenRate", "SetScriptBit", "SetShieldRatio", "SetSpeedMult", "SetStat", "SetStrategicUnderlay", "SetStunned", "SetTurnMult", "SetUnSelectable", "SetUnitState", "SetWorkProgress", "ShowBone", "StopSiloBuild", "TestCommandCaps", "TestToggleCaps", "ToggleFireState", "ToggleScriptBit", "TransportDetachAllUnits", "TransportHasAvailableStorage", "TransportHasSpaceFor", 
}

-- Moho functions of entity_methods

local methods = {
    "AddManualScroller", "AddPingPongScroller", "AddShooter", "AddThreadScroller", "AddWorldImpulse", "AdjustHealth", "AttachBoneTo", "AttachBoneToEntityBone", "AttachTo", "BeenDestroyed", "CreateProjectile", "CreateProjectileAtBone", "CreatePropAtBone", "Destroy", "DetachAll", "DetachFrom", "DisableIntel", "EnableIntel", "FallDown", "GetAIBrain", "GetArmy", "GetBlueprint", "GetBoneCount", "GetBoneDirection", "GetBoneName", "GetCollisionExtents", "GetEntityId", "GetFractionComplete", "GetHeading", "GetHealth", "GetIntelRadius", "GetMaxHealth", "GetOrientation", "GetParent", "GetPosition", "GetPositionXYZ", "GetScale", "InitIntel", "IsIntelEnabled", "IsValidBone", "Kill", "PlaySound", "PushOver", "ReachedMaxShooters", "RemoveScroller", "RemoveShooter", "RequestRefreshUI", "SetAmbientSound", "SetCollisionShape", "SetDrawScale", "SetHealth", "SetIntelRadius", "SetMaxHealth", "SetMesh", "SetOrientation", "SetParentOffset", "SetPosition", "SetScale", "SetVizToAllies", "SetVizToEnemies", "SetVizToFocusPlayer", "SetVizToNeutrals", "ShakeCamera", 
}

-- Moho functions of weapon_methods

local methods = {
    "CanFire", "ChangeDamage", "ChangeDamageRadius", "ChangeDamageType", "ChangeFiringTolerance", "ChangeMaxHeightDiff", "ChangeMaxRadius", "ChangeMinRadius", "ChangeProjectileBlueprint", "ChangeRateOfFire", "CreateProjectile", "DoInstaHit", "FireWeapon", "GetBlueprint", "GetCurrentTarget", "GetCurrentTargetPos", "GetFireClockPct", "GetFiringRandomness", "GetProjectileBlueprint", "IsFireControl", "PlaySound", "ResetTarget", "SetEnabled", "SetFireControl", "SetFireTargetLayerCaps", "SetFiringRandomness", "SetTargetEntity", "SetTargetGround", "SetTargetingPriorities", "TransferTarget", "WeaponHasTarget", 
}

-- Moho functions of projectile_methods

local methods = { 
    "ChangeDetonateBelowHeight", "ChangeMaxZigZag", "ChangeZigZagFrequency", "CreateChildProjectile", "GetCurrentSpeed", "GetCurrentTargetPosition", "GetLauncher", "GetTrackingTarget", "GetVelocity", "SetAcceleration", "SetBallisticAcceleration", "SetCollideEntity", "SetCollideSurface", "SetCollision", "SetDamage", "SetDestroyOnWater", "SetLifetime", "SetLocalAngularVelocity", "SetMaxSpeed", "SetNewTarget", "SetNewTargetGround", "SetScaleVelocity", "SetStayUpright", "SetTurnRate", "SetVelocity", "SetVelocityAlign", "SetVelocityRandomUpVector", "StayUnderwater", "TrackTarget", 
}

----------------------------------------------------------------------------------------------------------------------------
-- Step 3: Use the regular expression (tested in Visual Studio Code) to add the snippet to all functions of the class

-- Add in counters to each function in a class

-- PATTERN / REGULAR EXPRESSION
(\w*) = function\((.*)\)

-- REPLACE WITH
    $1 = function($2)
    
            -- PROFILER START
            if not tracker.LuaFunctions["$1"] then 
                tracker.LuaFunctions["$1"]  = 0 
            end
            tracker.LuaFunctions["$1"] = tracker.LuaFunctions["$1"] + 1
            -- PROFILER END
