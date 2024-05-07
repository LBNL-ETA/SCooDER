within SCooDER.Systems.SmartBuilding.Examples;
model Test_smartBuilding
  smartBuilding Building
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Modelica.Blocks.Sources.Trapezoid Pbatt(
    amplitude=1e6,
    rising(displayUnit="d") = 21600,
    width(displayUnit="d") = 21600,
    falling(displayUnit="d") = 21600,
    period(displayUnit="d") = 86400,
    offset=-0.5e6)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Constant Tset(k=0)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
equation
  connect(Pbatt.y, Building.P_set_battery) annotation (Line(points={{-59,0},
          {-40,0},{-40,4},{-22,4}}, color={0,0,127}));
  connect(Building.T_set_cool, Tset.y) annotation (Line(points={{-22,-14},{
          -30,-14},{-30,-40},{-59,-40}}, color={0,0,127}));
  connect(Building.T_set_heat, Tset.y) annotation (Line(points={{-22,-18},{
          -30,-18},{-30,-40},{-59,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_smartBuilding;
