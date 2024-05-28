within SCooDER.Components.Battery.Examples;
model TestAdvancedBattery_Wang
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.RealExpression temp1(y=10 + 273.15)
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Sources.RealExpression power1(y=0)
    annotation (Placement(transformation(extent={{-60,54},{-40,74}})));
  Modelica.Blocks.Sources.RealExpression power2
    annotation (Placement(transformation(extent={{-60,22},{-40,42}})));
  Modelica.Blocks.Sources.RealExpression temp2(y=46 + 273.15)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Model.Submodels.BatteryDegradation Calendar1
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Model.Submodels.BatteryDegradation Calendar2
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Modelica.Blocks.Sources.RealExpression temp3(y=34 + 273.15)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.Blocks.Sources.RealExpression power3(y=2000)
    annotation (Placement(transformation(extent={{-60,-14},{-40,6}})));
  Modelica.Blocks.Sources.RealExpression power4(y=6500)
    annotation (Placement(transformation(extent={{-60,-46},{-40,-26}})));
  Modelica.Blocks.Sources.RealExpression temp4(y=10 + 273.15)
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Model.Submodels.BatteryDegradation Cycle1(V=1000, Capacity=1000)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Model.Submodels.BatteryDegradation Cycle2
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
equation
  connect(Calendar1.TBatt, temp1.y) annotation (Line(points={{-2,70},{-32,70},{
          -32,80},{-39,80}}, color={0,0,127}));
  connect(power1.y, Calendar1.P) annotation (Line(points={{-39,64},{-20,64},{
          -20,66},{-2,66}}, color={0,0,127}));
  connect(temp2.y, Calendar2.TBatt) annotation (Line(points={{-39,50},{-28,50},
          {-28,40},{-2,40}}, color={0,0,127}));
  connect(power2.y, Calendar2.P) annotation (Line(points={{-39,32},{-20,32},{
          -20,36},{-2,36}}, color={0,0,127}));
  connect(Cycle1.TBatt, temp3.y) annotation (Line(points={{-2,0},{-32,0},{-32,
          10},{-39,10}}, color={0,0,127}));
  connect(power3.y, Cycle1.P)
    annotation (Line(points={{-39,-4},{-2,-4}}, color={0,0,127}));
  connect(temp4.y, Cycle2.TBatt) annotation (Line(points={{-39,-20},{-28,-20},{
          -28,-30},{-2,-30}}, color={0,0,127}));
  connect(power4.y, Cycle2.P) annotation (Line(points={{-39,-36},{-20,-36},{-20,
          -34},{-2,-34}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{32,70},{80,60}},
          lineColor={28,108,200},
          fontSize=14,
          textString="10.0 percent after 500 days"),
        Text(
          extent={{32,42},{80,32}},
          lineColor={28,108,200},
          fontSize=14,
          textString="25.0 percent after 300 days"),
        Text(
          extent={{32,6},{80,-4}},
          lineColor={28,108,200},
          fontSize=14,
          textString="23.0 percent after 83 days"),
        Text(
          extent={{32,-30},{80,-40}},
          lineColor={28,108,200},
          fontSize=14,
          textString="21.0 percent after 5 days")}),
    experiment(StopTime=432000, __Dymola_Algorithm="Dassl"));
end TestAdvancedBattery_Wang;
