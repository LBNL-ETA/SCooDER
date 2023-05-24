within SCooDER.Components.Grid.Records;
record IEEE_13_weak
  "Grid model inspired to the IEEE 13 Node test feeder, weak lines"
  extends Buildings.Electrical.Transmission.Grids.PartialGrid(
    nNodes = 13,
    nLinks = 12,
    l = [610;150;90;150;90;610;90;90;90;150;240;300],
    fromTo = [[1,2]; [2,3]; [3,4]; [2,5]; [5,6]; [2,7]; [7,8]; [8,9]; [7,10]; [10,11]; [
              8,12]; [7,13]],
    redeclare Buildings.Electrical.Transmission.LowVoltageCables.Generic cables=
       {Buildings.Electrical.Transmission.LowVoltageCables.PvcAl120(),
        Buildings.Electrical.Transmission.LowVoltageCables.PvcAl35(),
        Buildings.Electrical.Transmission.LowVoltageCables.PvcAl16(),
        Buildings.Electrical.Transmission.LowVoltageCables.PvcAl35(),
        Buildings.Electrical.Transmission.LowVoltageCables.PvcAl16(),
        Buildings.Electrical.Transmission.LowVoltageCables.PvcAl95(),
        Buildings.Electrical.Transmission.LowVoltageCables.PvcAl35(),
        Buildings.Electrical.Transmission.LowVoltageCables.PvcAl16(),
        Buildings.Electrical.Transmission.LowVoltageCables.PvcAl35(),
        Buildings.Electrical.Transmission.LowVoltageCables.PvcAl16(),
        Buildings.Electrical.Transmission.LowVoltageCables.PvcAl16(),
        Buildings.Electrical.Transmission.LowVoltageCables.PvcAl16()});

  annotation (Documentation);
end IEEE_13_weak;
