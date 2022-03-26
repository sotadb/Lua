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
  local adv = ShroudGetPooledAdventurerExperience()
  local prod = ShroudGetPooledProducerExperience()
  sotadbinfoAdv.push(adv - sotadbinfoAdvLast)
  sotadbinfoProd.push(prod - sotadbinfoProdLast)
  sotadbinfoAdvLast = adv
  sotadbinfoProdLast = prod

  local AdvAtt = ShroudGetAttenuationAdventurerStatus() and '*' or ' '
  local ProdAtt = ShroudGetAttenuationProducerStatus() and '*' or ' '

  sotadbinfoPoolOutput = string.format("%s Adv Pool: %s @ %s/h\n%sProd Pool: %s @ %s/h",
    AdvAtt, comma_value(adv), comma_value(sotadbinfoAdv.sAve()), 
    ProdAtt, comma_value(prod), comma_value(sotadbinfoProd.sAve()))

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
  sotadbinfoAdv = sotadbinfoXPTnew()
  sotadbinfoProd = sotadbinfoXPTnew()
  sotadbinfoAdvLast = ShroudGetPooledAdventurerExperience()
  sotadbinfoProdLast = ShroudGetPooledProducerExperience()
  infosotadbUpdatePool()
  ShroudRegisterPeriodic("infosotadb.UpdatePool", "infosotadbUpdatePool", 1, true)
  sotadbinfoPoolX = ShroudGetScreenX() - 300
  sotadbinfoPoolY = ShroudGetScreenY() - 50
end

function ShroudOnGUI()
  ShroudGUILabel(sotadbinfoPoolX, sotadbinfoPoolY, 300, 50, sotadbinfoPoolOutput)
end

function sotadbinfoXPTnew ()
  local self = {first = 0, last = -1, tot = 0, list={}}
  local time = 3600

  local push = function (v)
                local last = self.last + 1
                self.last = last
                self.list[last] = v
                local tot = self.tot + v
                self.tot = tot
                if self.last - self.first > time then
                  local tot = self.tot - self.list[self.first]
                  self.tot = tot
                  self.list[self.first] = nil
                  local first = self.first + 1
                  self.first = first
                end
              end

  local sAve = function () return math.floor((self.tot / ( 1 + self.last - self.first ))*3600) end
  local peek = function () return self.list[self.last] end

  return {push = push, sAve = sAve, peek = peek}
end