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

function ShroudOnStart()
  infosotadbLTitem = nil
  infosotadbLTWinner = {}
  infosotadbLTCount = {}
  infosotadbLTshow = true
  infosotadbLToutput = ""
end

function ShroudOnConsoleInput(type, src, msg)
  if type == 'Loot' then
    if string.match(msg, 'Roll results for .+ %(') then
      infosotadbLTitem = string.match(msg, 'Roll results for (.+) %(')
      ConsoleLog('Item: '..infosotadbLTitem)
    end
    if string.match(msg, ': .+ WON') then
      local temp = string.format('%s: %s', string.match(msg, ': (.+) WON'), infosotadbLTitem)
      local i
      for i=0, #infosotadbLTWinner, 1 do
        if infosotadbLTWinner[i] == temp then
          infosotadbLTCount[i] = infosotadbLTCount[i] + 1
          return
        end
      end
      infosotadbLTWinner[#infosotadbLTWinner+1] = temp
      infosotadbLTCount[#infosotadbLTWinner] = 1
    end
  end
end

function ShroudOnUpdate()
  if ShroudGetOnKeyDown('P') then
    infosotadbLTshow = not infosotadbLTshow
  end
  if infosotadbLTshow then
    if ShroudGetOnKeyDown('Tab') then
      infosotadbLTWinner = {}
      infosotadbLTCount = {}
    end
    infosotadbLToutput = "             Loot Rolls\n('P' to toggle, 'Tab' to clear)\n"
    for i, k in ipairs(infosotadbLTWinner) do
      infosotadbLToutput = string.format("%s%s: %d\n", infosotadbLToutput, k, infosotadbLTCount[i])
    end
  else
    infosotadbLToutput = ""
  end
end

function ShroudOnGUI()
  ShroudGUILabel(240, 80, 300, 600, infosotadbLToutput)
end