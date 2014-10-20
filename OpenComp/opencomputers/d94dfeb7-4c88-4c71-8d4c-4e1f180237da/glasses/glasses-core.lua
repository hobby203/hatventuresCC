component = require("component");
glasses = component.openperipheral_glassesbridge;
reactor = component.br_reactor;
colors = require("colors");
file = require("filesystem");
io = require("io");

glasses.clear();

function getCentreOffset(boxWidth, text)
  local textWidth = string.len(text)*3;
  local remainder = (boxWidth - textWidth);
  return (remainder-textWidth)/2;
end

function drawTodoBox(boxHeight)
  glasses.addBox(1,60,112,(boxHeight+2),0x000000,1);
  glasses.addBox(2,61,110,boxHeight,0x0066AA,1);
  local todoHeader = "TODO";
  local offset = getCentreOffset(110,todoHeader);
  glasses.addText(offset,66,todoHeader,colors.black);  
end

function drawReactorBox()
  glasses.addBox(1,1,112,52,0x000000,1);
  glasses.addBox(2,2,110,50,0xBADA55,1);
  local reactorBoxHeader = "REACTOR";
  local offset =getCentreOffset(110,reactorBoxHeader);
  glasses.addText(offset,6,reactorBoxHeader,colors.black);
end

function getReactorData()
  reactorData = {};
  reactorData["energyLevelPerTick"] = reactor.getEnergyProducedLastTick();
  reactorData["controlRodNum"] = reactor.getNumberOfControlRods();
  reactorData["reactorActive"] = reactor.getActive();
  reactorData["fuelTemp"] = reactor.getFuelTemperature();
  reactorData["casingTemp"] = reactor.getCasingTemperature();
  reactorData["energyStored"] = reactor.getEnergyStored();
  reactorData["fuelMax"] = reactor.getFuelAmountMax();
  reactorData["fuelLevel"] = reactor.getFuelAmount();
  return reactorData;
end

function drawReactorData(data)
  glasses.addText(5,20,"Producing: "..(math.floor(data.energyLevelPerTick/1000)).." KiRF/t",0x000000);
  glasses.addText(5,30,"Stored: "..(math.floor(data.energyStored/1000000)).." GiRF",0x000000);
  glasses.addText(5,40,"Fuel: "..(math.floor((data.fuelLevel/data.fuelMax)*100)).."%", 0x000000);
end

function getTodoList()
  local todoList = io.open("todo","r");
  todoListContent = {};
  local count = 1;
  for line in todoList:lines() do
    todoListContent[count] =line;
    count = count + 1;
  end
  io.close(todoList);
  return todoListContent;
end

function drawTodoList(todoList)
  yPos = 76;
  for k,v in pairs(todoList) do
    glasses.addText(5,yPos,v,0x000000);
    yPos = yPos + 10;
  end
end

while true do
  drawReactorBox();
  drawReactorData(getReactorData());
  local todoList = getTodoList();
  drawTodoBox((#todoList*10)+15);
  drawTodoList(todoList);
  os.sleep(5);
  glasses.clear();
end