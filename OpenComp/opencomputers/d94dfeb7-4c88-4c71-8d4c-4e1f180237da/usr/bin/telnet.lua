local component = require("component")
local internet = require("internet")
local term = require("term")
local text = require("text")
local event = require("event")
local shell = require("shell")

if not component.isAvailable("internet") then
  io.stderr:write("telnet requires an Internet Card to run!\n")
  return
end

local args, options = shell.parse(...)
if #args < 1 then
  print("Usage: telnet <server:port>")
  return
end

local host = args[1]

local gpu = component.gpu
local w, h = gpu.getResolution()

local hist = {}

local sock, reason = internet.open(host)
if not sock then
  io.stderr:write(reason .. "\n")
  return
end

sock:setTimeout(0.05)

--Function from the built in IRC program
local function print(message, overwrite)
  local w, h = component.gpu.getResolution()
  local line
  repeat
    line, message = text.wrap(text.trim(message), w, w)
    if not overwrite then
      component.gpu.copy(1, 1, w, h - 1, 0, -1)
    end
    overwrite = false
    component.gpu.fill(1, h - 1, w, 1, " ")
    component.gpu.set(1, h - 1, line)
  until not message or message == ""
end
local function draw()
  if not sock then
    return false
  end
  repeat
    local ok, line = pcall(sock.read, sock)
    if ok then
      if not line then
        print("Connection lost.")
        sock:close()
        sock = nil
        return false
      end
      print(line)
    end
  until not ok
end
local function uin()
  term.setCursor(1,h)
  line = term.read(hist)
  line2 = text.trim(line)
  if line2 == "/exit" then
    return false
  else
    sock:write(line2.."\r\n")
  end
  return true
end

local going = true
local dLoop = event.timer(0.5, draw, math.huge)

repeat
  r = uin()
until not r

if dLoop then
  event.cancel(dLoop)
end

if sock then
  sock:write("QUIT\r\n")
  sock:close()
end