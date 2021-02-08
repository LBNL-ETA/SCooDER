within SCooDER.Development;
model implement_detailed
  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=60, V=120)
    annotation (Placement(transformation(extent={{-16,0},{4,20}})));
  Buildings.Electrical.AC.OnePhase.Sources.PVSimple pv(A=1)
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  Modelica.Blocks.Sources.Constant const(k=1000)
    annotation (Placement(transformation(extent={{104,30},{124,50}})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={46,70})));
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(extent={{36,40},{56,60}})));
  Buildings.Electrical.AC.OnePhase.Sensors.Probe sens(V_nominal=120, perUnit=false)
    annotation (Placement(transformation(extent={{50,20},{30,40}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=sens.V*sin(sens.term.theta[
        1]))
    annotation (Placement(transformation(extent={{124,60},{64,80}})));
  Buildings.Electrical.AC.OnePhase.Sources.Generator gen
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Modelica.Blocks.Math.Mean mean(f=60, x0=0)
    annotation (Placement(transformation(extent={{64,-88},{84,-68}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens2
    annotation (Placement(transformation(extent={{10,0},{30,20}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=0)
    annotation (Placement(transformation(extent={{24,-88},{44,-68}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-64,-56},{-44,-36}})));
  Modelica.Blocks.Math.Product product1
    annotation (Placement(transformation(extent={{-64,-86},{-44,-66}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=sin(sens.term.theta[1]))
    annotation (Placement(transformation(extent={{-102,-50},{-82,-30}})));
  Modelica.Blocks.Sources.RealExpression realExpression3(y=cos(sens.term.theta[1]))
    annotation (Placement(transformation(extent={{-106,-78},{-86,-58}})));
  Modelica.Blocks.Math.Mean mean1(f=60, x0=0)
    annotation (Placement(transformation(extent={{-28,-56},{-8,-36}})));
  Modelica.Blocks.Math.Mean mean2(f=60, x0=0)
    annotation (Placement(transformation(extent={{-28,-86},{-8,-66}})));
  Modelica.Blocks.Sources.RealExpression realExpression4(y=0)
    annotation (Placement(transformation(extent={{62,-24},{82,-4}})));

  Modelica.Electrical.Analog.Basic.VariableResistor variableResistor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-60,80})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=1,
    startTime=1,
    offset=10,
    height=-8.5)
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
  Dynamic.Sensor.Model.dynToPh dynToPh
    annotation (Placement(transformation(extent={{-30,50},{-10,70}})));
  Dynamic.Sensor.Model.dynToPQ dynToPQ
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Modelica.Electrical.Analog.Basic.VariableInductor variableInductor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-60,40})));
  Modelica.Blocks.Sources.Ramp ramp1(
    duration=1,
    startTime=1,
    offset=10,
    height=-8.5)
    annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
equation
  connect(const.y, pv.G)
    annotation (Line(points={{125,40},{90,40},{90,22}},color={0,0,127}));
  connect(gen.P, mean.y) annotation (Line(points={{20,-30},{102,-30},{102,-78},{
          85,-78}}, color={0,0,127}));
  connect(sens2.terminal_n, fixVol.terminal)
    annotation (Line(points={{10,10},{4,10}}, color={0,120,120}));
  connect(sens.term, sens2.terminal_p)
    annotation (Line(points={{40,21},{40,10},{30,10}}, color={0,120,120}));
  connect(gen.terminal, sens2.terminal_p)
    annotation (Line(points={{40,-30},{40,10},{30,10}}, color={0,120,120}));
  connect(pv.terminal, sens2.terminal_p)
    annotation (Line(points={{80,10},{30,10}}, color={0,120,120}));
  connect(realExpression.y, mean.u)
    annotation (Line(points={{45,-78},{62,-78}}, color={0,0,127}));
  connect(product1.u2, product.u2) annotation (Line(points={{-66,-82},{-92,-82},
          {-92,-52},{-66,-52}}, color={0,0,127}));
  connect(product.u1, realExpression1.y)
    annotation (Line(points={{-66,-40},{-81,-40}}, color={0,0,127}));
  connect(product1.u1, realExpression3.y) annotation (Line(points={{-66,-70},{
          -70,-70},{-70,-68},{-85,-68}},
                                     color={0,0,127}));
  connect(mean1.u, product.y) annotation (Line(points={{-30,-46},{-43,-46}},
                           color={0,0,127}));
  connect(mean2.u, product1.y)
    annotation (Line(points={{-30,-76},{-43,-76}}, color={0,0,127}));
  connect(realExpression2.y, signalVoltage.v) annotation (Line(points={{61,70},
          {53,70}},                   color={0,0,127}));
  connect(ramp.y, variableResistor.R)
    annotation (Line(points={{-79,80},{-71,80}}, color={0,0,127}));
  connect(dynToPh.p_v, signalVoltage.p)
    annotation (Line(points={{-20,70},{-20,80},{46,80}}, color={0,0,255}));
  connect(signalVoltage.n, ground1.p)
    annotation (Line(points={{46,60},{46,60}}, color={0,0,255}));
  connect(product.u2, realExpression1.y) annotation (Line(points={{-66,-52},{
          -72,-52},{-72,-40},{-81,-40}}, color={0,0,127}));
  connect(dynToPh.n_i, dynToPQ.p_i)
    annotation (Line(points={{-10,60},{0,60}}, color={0,0,255}));
  connect(dynToPQ.n_i, signalVoltage.n)
    annotation (Line(points={{20,60},{46,60}}, color={0,0,255}));
  connect(dynToPQ.p_v, signalVoltage.p)
    annotation (Line(points={{10,70},{10,80},{46,80}}, color={0,0,255}));
    annotation (Placement(transformation(extent={{-52,30},{-32,50}})),
                       Line(points={{-50,-10},{-54,-10},
          {-54,40},{-54,40}}, color={0,0,127}),
              Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end implement_detailed;
