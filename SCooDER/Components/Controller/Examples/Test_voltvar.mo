within SCooDER.Components.Controller.Examples;
model Test_voltvar

  Modelica.Blocks.Sources.Ramp ramp(
    duration=1,
    startTime=0,
    height=0.2,
    offset=0.9)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Sources.Constant upper_voltage(k=1.05)
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  Modelica.Blocks.Sources.Constant lower_voltage(k=0.95)
    annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Model.voltvar voltvar
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant upper_deadband_voltage(k=1.01)
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Blocks.Sources.Constant lower_deadband_voltage(k=0.99)
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
  Modelica.Blocks.Sources.Constant qmax_inductive(k=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,60})));
  Modelica.Blocks.Sources.Constant qmax_capacitive(k=0.2) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,60})));
equation
  connect(ramp.y, voltvar.v_pu)
    annotation (Line(points={{-69,0},{-12,0}}, color={0,0,127}));
  connect(lower_voltage.y, voltvar.v_min) annotation (Line(points={{-39,
          -60},{-20,-60},{-20,-8},{-12,-8}}, color={0,0,127}));
  connect(upper_voltage.y, voltvar.v_max) annotation (Line(points={{-39,
          60},{-20,60},{-20,8},{-12,8}}, color={0,0,127}));
  connect(voltvar.v_mindead, lower_deadband_voltage.y) annotation (Line(
        points={{-12,-4},{-30,-4},{-30,-20},{-39,-20}}, color={0,0,127}));
  connect(upper_deadband_voltage.y, voltvar.v_maxdead) annotation (Line(
        points={{-39,20},{-30,20},{-30,4},{-12,4}}, color={0,0,127}));
  connect(qmax_capacitive.y, voltvar.q_maxcap) annotation (Line(points={{-1.9984e-015,
          49},{0,49},{0,30},{-4,30},{-4,12}}, color={0,0,127}));
  connect(qmax_inductive.y, voltvar.q_maxind) annotation (Line(points={{40,49},{40,
          49},{40,40},{12,40},{12,20},{2,20},{2,12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_voltvar;
