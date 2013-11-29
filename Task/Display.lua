

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
    sleep(5)
   else
     print("Disk not found checking again in 5 seconds.")
     sleep(5)
   end
end


function whatFile(type)
  if type == 1 then
    return "disk/Tasks"
  elseif type == 2 then
    return "disk/MTasks"
  elseif type == 3 then 
    return "disk/ATasks"
  end
end

while true do
  display("monitor_10",1)
  display("monitor_11",1)
  display("monitor_12",1)
  display("monitor_13",1)
end