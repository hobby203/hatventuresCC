rednet.open("bottom")

function authorise(request)
	players = fs.open("disk/allowed","r")
	for player in players:lines() do
		if request == player then
			return true
		end
	end
	return false
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