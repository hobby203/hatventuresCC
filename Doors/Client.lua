rednet.open("bottom")
doorType = "2"

function allowed(player,authServer)
  rednet.send(authServer,doorType..player)
  id, message, distance = rednet.receive()
  return message
end

function door(player,authServer)
  if allowed(player,authServer) then
    redstone.setOutput("top",true)
    sleep(4)
    redstone.setOutput("top",false)
    return true
  else
    return false
  end
end

function logger(player,logServer,state)
  if state then
    rednet.send(logServer,os.time().." "..player.." was granted access via computer "..os.getComputerID())
  else
    rednet.send(logServer,os.time().." "..player.." tried to get in at via computer "..os.getComputerID())
  end
end

function getPlayer()
  event, name = os.pullEvent("player")
  return name
end

function main()
  local authServer = 330
  local logServer = 331
  local player = getPlayer()
  if door(player,authServer) then
    logger(player,logServer,true)
  else
    logger(player,logServer,false)
  end
end

while true do
  main()
end