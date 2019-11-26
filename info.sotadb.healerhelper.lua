function ShroudOnStart()
  ShroudRemovePeriodic("sotadbinfo.UpdateStats")
  infosotadbHPRatio = 1
  ShroudRegisterPeriodic("sotadbinfo.UpdateStats", "sotadbinfoUpdateStats", 1, true)
end

function infosotadbUpdateStats()
  infosotadbHPRatio = ShroudPlayerCurrentHealth/ShroudGetStatValueByNumber(30)
end

function ShroudOnUpdate()
  --Work around bugs
end

function ShroudOnGUI()
  if infosotadbHPRatio < 0.5 then
    ShroudGUILabel(800, 80, 300, 100, "<color=red><size=50>Heal thy self!</size></color>")
  end
end