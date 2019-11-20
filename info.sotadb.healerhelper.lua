function ShroudOnStart()
  ShroudRemovePeriodic("sotadbinfo.UpdateStats")
  sotadbinfoHPRatio = 1
  ShroudRegisterPeriodic("sotadbinfo.UpdateStats", "sotadbinfoUpdateStats", 1, true)
  ConsoleLog("OnStart Finished")
end

function sotadbinfoUpdateStats()
  sotadbinfoHPRatio = ShroudPlayerCurrentHealth/ShroudGetStatValueByNumber(30)
end

function ShroudOnGUI()
  if sotadbinfoHPRatio < 0.5 then
    ShroudGUILabel(800, 80, 300, 100, "<color=red><size=50>Heal thy self!</size></color>")
  end
end