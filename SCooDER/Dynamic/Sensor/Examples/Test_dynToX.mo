within SCooDER.Dynamic.Sensor.Examples;
model Test_dynToX
  extends Modelica.Icons.Example;
  Modelica.Electrical.Analog.Sources.SineVoltage SineVoltage(V=120, f=60)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={90,10})));
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(extent={{80,-20},{100,0}})));
  Modelica.Electrical.Analog.Basic.VariableResistor variableResistor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-60,10})));
  Modelica.Blocks.Sources.Ramp ramp_R(
    duration=1,
    startTime=1,
    offset=10,
    height=-8.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,-30})));
  Model.dynToPh dynToPh
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Model.dynToPQ dynToPQ
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Electrical.Analog.Basic.VariableInductor variableInductor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-20,10})));
  Modelica.Blocks.Sources.Ramp ramp_L(
    duration=1,
    startTime=3,
    offset=0.1,
    height=-0.09) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-30})));
equation
  connect(dynToPh.p_v, SineVoltage.p)
    annotation (Line(points={{10,10},{10,20},{90,20}}, color={0,0,255}));
  connect(SineVoltage.n, ground1.p)
    annotation (Line(points={{90,-3.55271e-15},{90,0}},
                                             color={0,0,255}));
  connect(dynToPh.n_i, dynToPQ.p_i)
    annotation (Line(points={{20,0},{40,0}}, color={0,0,255}));
  connect(dynToPQ.n_i, SineVoltage.n)
    annotation (Line(points={{60,0},{90,0}}, color={0,0,255}));
  connect(dynToPQ.p_v, SineVoltage.p)
    annotation (Line(points={{50,10},{50,20},{90,20}}, color={0,0,255}));
  connect(variableInductor.L, ramp_L.y)
    annotation (Line(points={{-32,10},{-40,10},{-40,-19}},   color={0,0,127}));
  connect(ramp_R.y, variableResistor.R)
    annotation (Line(points={{-80,-19},{-80,10},{-72,10}}, color={0,0,127}));
  connect(variableInductor.p, SineVoltage.p)
    annotation (Line(points={{-20,20},{90,20}}, color={0,0,255}));
  connect(variableResistor.p, SineVoltage.p)
    annotation (Line(points={{-60,20},{90,20}}, color={0,0,255}));
  connect(variableInductor.n, dynToPh.p_i)
    annotation (Line(points={{-20,0},{0,0}}, color={0,0,255}));
  connect(variableResistor.n, dynToPh.p_i) annotation (Line(points={{-60,
          3.55271e-15},{-30,3.55271e-15},{-30,0},{0,0}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_dynToX;
