
function infosotadbUpdatePool()
  sotadbinfoPoolOutput = string.format(" Adv Pool:\t%s\nProd Pool:\t%s",
    comma_value(ShroudGetPooledAdventurerExperience()), comma_value(ShroudGetPooledProducerExperience()))
end

function comma_value(n) -- credit http://richard.warburton.it
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

function ShroudOnStart()
  ShroudRemovePeriodic("infosotadb.UpdatePool")
  infosotadbUpdatePool()
  ShroudRegisterPeriodic("infosotadb.UpdatePool", "infosotadbUpdatePool", 1, true)
  sotadbinfoPoolX = ShroudGetScreenX() - 200
  sotadbinfoPoolY = ShroudGetScreenY() - 50
end

function ShroudOnGUI()
  ShroudGUILabel(sotadbinfoPoolX, sotadbinfoPoolY, 200, 50, sotadbinfoPoolOutput)
end