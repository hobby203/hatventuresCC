component = require("component");
os = require("os");
reactor = component.br_reactor;
while true do
  low = 1000000;
  high = 9000000;

  if reactor.getEnergyStored() <= low then
    reactor.setAllControlRodLevels(0);
  end

  if reactor.getEnergyStored() >= high then
    reactor.setAllControlRodLevels(100);
  end

  os.sleep(5);

end