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