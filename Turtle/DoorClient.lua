function logger(player,logServer,message)
  rednet.send(logServer,os.time().." "..player.." Added '"..message.."' to the message board")
end
 
function pulling()
  local event, name, message = os.pullEvent("chat")
  return name, message
end
 
function direction(message)
  if string.sub(message,1,6) == "!aopen" then
    return 2
  elseif string.sub(message,1,7) == "!aclose" then
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
 
function open(allowed)
  if allowed then
    turtle.digUp()
    turtle.up()
    turtle.digUp()
    print("done")
    turtle.down()
    return true
  else
    return false
  end
end
function close(allowed)
  if allowed then
    turtle.up()
    turtle.placeUp()
    turle.down()
    turtle.placeUp()
    return true
  else
    return false
  end
end

while true do
  local player, message = pulling()
  if direction(message) == 2 then
    allowed = checkingName("allowed",player)
    open(allowed)
  elseif direction(message) == 1 then
    allowed = checkingName("allowed",player)
    close(allowed)
  end
end