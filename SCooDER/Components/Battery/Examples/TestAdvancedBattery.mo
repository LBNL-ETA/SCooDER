within SCooDER.Components.Battery.Examples;
model TestAdvancedBattery
  extends Modelica.Icons.Example;
  Model.BatteryAdv batteryAdv(
    CapNom=6400,
    PMax=3300,
    TBattInit=300,
    TAvgInit=300,
    batAgeInit=864000,
    TOut(start=300))
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Sources.Pulse R_value(
    amplitude=0.004,
    width=90,
    period=43200,
    offset=0.004,
    startTime=0)
    annotation (Placement(transformation(extent={{-40,22},{-20,42}})));
  Modelica.Blocks.Sources.Sine OutsideTemperature(
    amplitude=10,
    f=1/43200,
    phase=4.7123889803847,
    offset=293.15)
    annotation (Placement(transformation(extent={{-62,-8},{-42,12}})));
  Modelica.Blocks.Sources.Sine PCtrl(
    amplitude=2500,
    f=1/36000,
    offset=500)
    annotation (Placement(transformation(extent={{-64,-42},{-44,-22}})));
equation
  connect(R_value.y, batteryAdv.RFlex)
    annotation (Line(points={{-19,32},{-8,32},{-8,8},{8,8}}, color={0,0,127}));
  connect(OutsideTemperature.y, batteryAdv.TOut)
    annotation (Line(points={{-41,2},{-18,2},{-18,4},{8,4}}, color={0,0,127}));
  connect(PCtrl.y, batteryAdv.PCtrl) annotation (Line(points={{-43,-32},{-18,
          -32},{-18,0},{8,0}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=30000000));
end TestAdvancedBattery;
