--[[
MIT License

Copyright (c) 2019 SotADB.info

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
]]

function infosotadbUpdatePool()
  sotadbinfoPoolOutput = string.format(" Adv Pool:\t%s\nProd Pool:\t%s",
    comma_value(ShroudGetPooledAdventurerExperience()), comma_value(ShroudGetPooledProducerExperience()))
end

function comma_value(n) -- credit http://richard.warburton.it
	local left,num,right = string.match(n,'^([^%d]*%d)(%d*)(.-)$')
	return left..(num:reverse():gsub('(%d%d%d)','%1,'):reverse())..right
end

function ShroudOnUpdate()
  --Work around bugs
end

function ShroudOnConsoleInput()
  --Work around bugs
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