--- The tables we're interested in hooking. As a ground rule: any imported
-- file is a table unless there is a 'Class' keyword in it. Classes can not
-- be hooked reliably and require you to adjust the FAF repository on your
-- machine.
TableHooks = { 
    { Identifier = "aiBehaviors", Table = import("/lua/ai/aibehaviors.lua") }
  , { Identifier = "scenarioFramework", Table = import("/lua/ScenarioFramework.lua") }
  , { Identifier = "scenarioUtils", Table = import("/lua/sim/ScenarioUtilities.lua") }
  , { Identifier = "aiUtilities", Table = import("/lua/ai/aiutilities.lua") }
  , { Identifier = "formations", Table = import("/lua/formations.lua") }
  -- , { Identifier = "table", Table = table }
  -- , { Identifier = "math", Table = math }

-- this one crashes atm
--   , { Identifier = "Global" , Table = _G }
}