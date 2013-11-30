

function display(monitorID,fileID)
  m = peripheral.wrap(monitorID)
  if fs.exists(whatFile(fileID)) then
    m.clear()
    m.setTextScale(1)
    term.setCursorPos(1,1)
    m.setCursorPos(1,1)
    term.redirect(m)
    f = fs.open(whatFile(fileID), "r")
    print(f.readAll())
    f.close()
    term.restore()
    sleep(1)
   else
     print("Disk not found checking again in 5 seconds.")
     sleep(5)
   end
end


function whatFile(type)
  if type == 1 then
    return "disk/readFiles/Tasks"
  elseif type == 2 then
    return "disk/readFiles/MTasks"
  elseif type == 3 then 
    return "disk/readFiles/ATasks"
  elseif type == 4 then
    return "disk/readFiles/logger"
  end
end

while true do
  display("monitor_10",1)
  display("monitor_11",2)
  display("monitor_12",3)
  display("monitor_13",4)

  display("monitor_14",1)
  display("monitor_15",2)
  display("monitor_16",3)
  display("monitor_17",4)

  display("monitor_18",4)
end