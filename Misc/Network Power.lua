computerIDs = {1,2,3}

function args(...,computers)
  print(...)
  if ... == nil or #... > 1 then
    return ...
  else
    return table.insert(computers,1,...)
  end
end

function reboot(computer)
  local device = peripheral.wrap(computer)
  if device.reboot() then
    return device
  else
    return false
  end
end

function shutdown(computer)
  local device = peripheral.wrap(computer)
  if device.shutdown() then
    return true
  else
    return false
  end
end

function boot(computer)
  local device = peripheral.wrap(computer)
  if device.shutdown() then
    return true
  else
    return false
  end
end

function main(...,computers)
  computers = args(...,computers)
  print(computers)
  print(type(computers))
  
  if computers == nil then
    print("No Computers present, exiting...")
  else
    if type(computers) == "string" then
      command = computers
    else
      command = computers[1]
    end
    for computer in computers do
      computer = "computer_"..tostring(computer)
      if _G[command](computer) then
        print(computer.." "..func.." completed succesfully")
      else
        print(computer.." could not be reached, please check it is still on the network")
      end
    end
  end
end

main(...,computerIDs)