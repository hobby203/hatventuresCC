rednet.open("bottom")

function authorise(request)
  local players = io.open("disk/allowed","r")
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
  if authorise(player) then
    allowPlayer(id,true)
  else
    allowPlayer(id,false)
  end
end

while true do
  main()
end