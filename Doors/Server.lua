rednet.open("bottom")

function authorise(request,authFile)
  local players = io.open(authFile,"r")
  if players then
    for player in players:lines() do
      if request == player then
        players:close()
        return true
      end
    end
    players:close()
    return false
  else
    error("File Not Found")
  end
end

function receiveRequest()
  id, request, distance = rednet.receive()
  return id, request
end

function allowPlayer(door,state)
  rednet.send(door,state)
end

function main()
  local id, player = receiveRequest()
  local authFile
  if string.sub(player,1,1) == "2" then
    authFile="disk/admins"
  elseif string.sub(player,1,1) == "1" then
    authFile="disk/allowed"
  end
  player = string.sub(player,2)
  allowPlayer(id,authorise(player,authFile))
end

while true do
  main()
end