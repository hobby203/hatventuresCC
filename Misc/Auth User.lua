computer = peripheral.wrap("computer_6")

function startup()
print("Make sure candadate is stood infront of door one")
sleep(2)
print("Stopping door opener...")
sleep(1)
computer.shutdown()
print("Terminal now offline")
end

function reading()
  print("Get the player to hit the PD")
  event, player = os.pullEvent("player")
    print("Username Pulled: "..player)
end

function writing()
  print("Adding name to file")
  file = fs.open("disk/allowed","a")
    file.writeLine(player)
  file.close()
  print(player.." Was added.")
end

function reset()
  print("Restarting door terminal...")
  computer.turnOn()
  print("Successful reboot.")
end

        
startup()
reading()
writing()
reset()
