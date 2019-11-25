-- I sware, this was requested--
function ShroudOnStart()
  sotadbinfoClockX = (ShroudGetScreenX()/2) - 39
  sotadbinfoClockY = 90
end

function ShroudOnGUI()
  ShroudGUILabel(sotadbinfoClockX, sotadbinfoClockY, 200, 50, os.date("<size=20>%H:%M:%S</size>"))
end