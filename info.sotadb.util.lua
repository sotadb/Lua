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
  local PartyList = GetPartyMemberNamesInScene()
  ConsoleLog("mid PartyMembers()")
  for k, v in pairs(PartyList) do
    ConsoleLog(string.format("PartyMember: $d, $s", k, v))
  end
  ConsoleLog("end PartyMembers()")
end

function ShroudOnStart()
  sotadbinfoPlayerName = ShroudGetPlayerName()
end

-- watch for commands
function ShroudOnConsoleInput(type, src, msg)
  if type == 'Local' and src == sotadbinfoPlayerName then
    local cmd, arg = string.match(msg, '\\(%w+)%s*(%w*)')
    if not pcall(sotadbinfoCommand[cmd], arg) then
      ConsoleLog("Command Not Found")
    end
  end
end