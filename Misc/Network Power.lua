computerIDs = {1,2,3}
functions = {}
 
function args(arguments,computers)
  print(arguments)
  print(computers[3])
  print(type(computers))
  if arguments == nil or type(arguments) ~= "string" then
    return arguments
  else
    table.insert(computers,1,arguments)
    return computers
  end
end
 
functions['reboot'] = function(computer)
  print("computer is "..computer)
  print("trying to rebooot")
  local device = peripheral.wrap(tostring(computer))
  print("i got the device")
  if device.getID() then
    device.reboot()
    return true
  else
    return false
  end
end
 
functions['shutdown'] = function(computer)
  local device = peripheral.wrap(computer)
  if device.shutdown() then
    return true
  else
    return false
  end
end
 
functions['boot'] = function(computer)
  local device = peripheral.wrap(computer)
  if device.shutdown() then
    return true
  else
    return false
  end
end
 
function main(arguments,computerIDs)
  computers = args(arguments,computerIDs)
  if computers == nil then
    print("No Computers present, exiting...")
  else
    if type(computers) == "string" then
      command = computers
    else
      command = computers[1]
      table.remove(computers,1)
      print("command is "..command)
    end
    for key,computer in pairs(computers) do
      print("gonna set the computer")
      computer = "computer_"..tostring(computer)
      print("worked, it's "..computer)
      print(command)
      if functions[command](computer) then
        print(computer.." "..func.." completed succesfully")
      else
        print(computer.." could not be reached, please check it is still on the network")
      end
    end
  end
end
 
main(...,computerIDs)