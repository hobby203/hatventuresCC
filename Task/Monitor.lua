rednet.open("back")

function logger(player,logServer,message)
  rednet.send(logServer,os.time().." "..player.." Added '"..message.."' to the message board")
end

function pulling()
  local event, name, message = os.pullEvent("chat")
  return name, message
end

function isAdmin(message)
  if string.sub(message,1,6) == "!mtask" then
    return 3
  elseif string.sub(message,1,6) == "!atask" then
    return 2
  elseif string.sub(message,1,5) == "!task" then
    return 1
  else
    return 0
  end
end

function checkingName(userFile,name)
  print("got here")
  file = io.open(userFile,"r")
  print("opened file")
  for line in file:lines() do
    if name == line then
      file:close()
      print("found them")
      return true
    end
  end
  print("DENIED "..name)
  file:close()
  return false
end

function main(allowed,taskFile,pos,task)
  if allowed then
    file = fs.open(taskFile,"a")
    task = string.sub(task,pos)
    file.writeLine("-"..task)
    file:close()
    return true
  else
    return false
  end
end

while true do
  local logServer = 331
  local player, message = pulling()
  if isAdmin(message) == 2 then
    allowed = checkingName("disk/admins",player)
    main(allowed,"disk/AdminT",7,message)
    logger(player,logServer,message)
  elseif isAdmin(message) == 1 then
    print("isn't a admin hello")
    allowed = checkingName("disk/allowed",player) 
    main(allowed,"disk/Tasks",6,message)
    logger(player,logServer,message)
  elseif isAdmin(message) == 3 then
      allowed = checkingName("disk/allowed",player)
      main(allowed,"disk/MTasks",7,message)
      logger(player,logServer,message)
  end
end
