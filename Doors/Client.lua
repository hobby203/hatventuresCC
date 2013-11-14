rednet.open("bottom")

function allowed(player,authServer)
	rednet.send(authServer,player)
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
		rednet.send(logServer,player.." was granted access "..os.time.." via computer "..os.getComputerID())
	else
		rednet.send(logServer,player.." tried to get in at "..os.time.." via computer "..os.getComputerID())
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