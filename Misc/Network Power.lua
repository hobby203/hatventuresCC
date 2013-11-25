computerIDs = {}

function args(...)
  if ... = nil or #... == 1 then
    return ...
  else
    return table.insert(computerIDs,1,arg[1])
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

function main(...)
  computers = args(...)
  func = computers[1]
  if computers == nil then
    print("No Computers present, exiting...")
  else
    for computer in computers do
      computer = "computer_"..tostring(computer)
      if _G[func](computer) then
        print(computer.." "..func.." completed succesfully")
      else
        print(computer.." could not be reached, please check it is still on the network")
      end
    end
  end
end

main(...)