within SCooDER.Components.Battery.Examples;
model Test_Battery

  Model.Battery battery
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Sine BatteryPower(
    phase=0,
    offset=0,
    freqHz=1/(60*60*12),
    amplitude=2500)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(BatteryPower.y, battery.PCtrl)
    annotation (Line(points={{-39,0},{-12,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
  experiment(StopTime=86400),
      Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_Battery;
