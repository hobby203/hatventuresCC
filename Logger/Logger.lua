rednet.open("back")

function writeFile(message)
  local logfile = io.open("disk/logs","a")
  if logfile then
    logfile.writeLine(message)
    logfile:close()
    return true
  else
    logfile:close()
    return false
  end
end

function receiveMessage()
  id, message, distance = rednet.receive()
  return message
end

function main()
  log = receiveMessage()
  if writeFile(log)
    print("Log Added!")
  else
    print("Log failed, fix it")
  end
end

while true do
  main()
end
