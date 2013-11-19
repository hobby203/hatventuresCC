m = peripheral.wrap("monitor_2")
m.setTextScale(1)

while true do 
  if fs.exists("disk/Tasks") then
    m.clear()
    term.setCursorPos(1,1)
    m.setCursorPos(1,1)
    term.redirect(m)
    f = fs.open("disk/Tasks", "r")
    print(f.readAll())
    f.close()
    term.restore()
    sleep(5)
   else
     print("Disk not found checking again in 5 seconds.")
     sleep(5)
   end
end
