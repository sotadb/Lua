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

sotadbinfoCommand = { }

function sotadbinfoCommand.ShowStats()
  for i=0, ShroudGetStatCount(), 1 do
    ConsoleLog(string.format('%d: %s', i, ShroudGetStatNameByNumber(i)))
  end
  ConsoleLog(string.format("total stats: %d", ShroudGetStatCount()))
end

function sotadbinfoCommand.ShowStat(args)
  i = tonumber(args)
  ConsoleLog(string.format('(%d)%s: %f', i, ShroudGetStatNameByNumber(i), ShroudGetStatValueByNumber(i)))
end

function sotadbinfoCommand.findStat(args)
  for i=0, ShroudGetStatCount(), 1 do
    if string.match(string.lower(ShroudGetStatNameByNumber(i)), string.lower(args)) then
      ConsoleLog(string.format('(%d) %s: %s', i, ShroudGetStatNameByNumber(i), ShroudGetStatDescriptionByNumber(i)))
    end
  end
end

function sotadbinfoCommand.PartyMembers()
  ConsoleLog("start PartyMembers()")
  for v in ShroudGetPartyMemberNamesInScene() do
    ConsoleLog(string.format("%s", v))
  end
  ConsoleLog("end PartyMembers()")
end

function sotadbinfoCommand.MessageWatch(args)
  if string.match(args, 'enable') then
    sotadbinfoMessageWatch = true
  elseif string.match(args, 'disable') then
    sotadbinfoMessageWatch = false
  else
    ConsoleLog("Usage: \\MessageWatch [enable|disable]")
  end
end

function ShroudOnStart()
  sotadbinfoMessageWatch = false
  sotadbinfoPlayerName = ShroudGetPlayerName()
end

function ShroudOnUpdate()
  --Work around bugs
end

function ShroudOnGUI()
  --Work around bugs
end

-- watch for commands
function ShroudOnConsoleInput(type, src, msg)
  if sotadbinfoMessageWatch then
    ConsoleLog(string.format("Type: '%s' Src: '%s' Msg: '%s[-]'", type, src, msg))
  end

  if type == 'Local' and src == sotadbinfoPlayerName and string.find(msg, '\\%w') then
    local cmd, arg = string.match(msg, '\\(%w+)%s*(%w*)')
    if not pcall(sotadbinfoCommand[cmd], arg) then
      ConsoleLog("Command Not Found")
    end
  end
end