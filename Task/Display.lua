m = peripheral.wrap("monitor_7")

local type = 1

function display(taskFile)
  if fs.exists(taskFile) then
    m.clear()
    m.setTextScale(1)
    term.setCursorPos(1,1)
    m.setCursorPos(1,1)
    term.redirect(m)
    f = fs.open(taskFile, "r")
    print(f.readAll())
    f.close()
    term.restore()
    sleep(5)
   else
     print("Disk not found checking again in 5 seconds.")
     sleep(5)
   end
end


while true do
  if type == 1 then
    display("disk/Tasks")
    print("Main task file")
  elseif type == 2 then
    display("disk/MTasks")
  elseif type == 3 then 
    display("disk/ATasks")
  end
end

