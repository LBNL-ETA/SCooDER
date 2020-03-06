within SCooDER.Dynamic.Interfacing.Examples;
model Test_MBL
  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=60, V=120)
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Buildings.Electrical.AC.OnePhase.Sources.PVSimple pv(A=1)
    annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
  Modelica.Blocks.Sources.Constant const(k=1000)
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  Buildings.Electrical.AC.OnePhase.Sensors.Probe sens(V_nominal=120,
      perUnit=false)
    annotation (Placement(transformation(extent={{30,-30},{10,-10}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens2
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Modelica.Electrical.Analog.Basic.Ground ground1
    annotation (Placement(transformation(extent={{30,40},{50,60}})));
  Modelica.Electrical.Analog.Basic.VariableResistor variableResistor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-60,70})));
  Modelica.Blocks.Sources.Ramp ramp_R(
    duration=1,
    startTime=1,
    offset=10,
    height=-8.5) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-80,30})));
  Model.Interface_MBL interface_MBL1
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Modelica.Electrical.Analog.Basic.VariableInductor variableInductor
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-20,70})));
  Modelica.Blocks.Sources.Ramp ramp_L(
    duration=1,
    startTime=3,
    offset=0.1,
    height=-0.09) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,30})));
  Modelica.Electrical.Analog.Sources.SignalVoltage signalVoltage annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={40,70})));
  Modelica.Blocks.Sources.RealExpression V_sens(y=sens.V*sin(sens.term.theta[
        1])) annotation (Placement(transformation(
        extent={{30,-10},{-30,10}},
        rotation=-90,
        origin={70,48})));
equation
  connect(const.y,pv. G)
    annotation (Line(points={{81,-10},{90,-10},{90,-28}},
                                                       color={0,0,127}));
  connect(sens2.terminal_n,fixVol. terminal)
    annotation (Line(points={{-10,-40},{-20,-40}},
                                              color={0,120,120}));
  connect(sens.term,sens2. terminal_p)
    annotation (Line(points={{20,-29},{20,-40},{10,-40}},
                                                       color={0,120,120}));
  connect(pv.terminal,sens2. terminal_p)
    annotation (Line(points={{80,-40},{10,-40}},
                                               color={0,120,120}));
  connect(variableInductor.L, ramp_L.y) annotation (Line(points={{-30.8,70},
          {-40,70},{-40,41}}, color={0,0,127}));
  connect(ramp_R.y, variableResistor.R) annotation (Line(points={{-80,41},{
          -80,70},{-71,70}}, color={0,0,127}));
  connect(variableInductor.n, interface_MBL1.p_i)
    annotation (Line(points={{-20,60},{0,60}}, color={0,0,255}));
  connect(variableResistor.n, interface_MBL1.p_i)
    annotation (Line(points={{-60,60},{0,60}}, color={0,0,255}));
  connect(V_sens.y, signalVoltage.v) annotation (Line(points={{70,81},{58,
          81},{58,70},{47,70}}, color={0,0,127}));
  connect(ground1.p, signalVoltage.n)
    annotation (Line(points={{40,60},{40,60}}, color={0,0,255}));
  connect(signalVoltage.p, interface_MBL1.p_v)
    annotation (Line(points={{40,80},{10,80},{10,70}}, color={0,0,255}));
  connect(variableInductor.p, signalVoltage.p)
    annotation (Line(points={{-20,80},{40,80}}, color={0,0,255}));
  connect(variableResistor.p, signalVoltage.p)
    annotation (Line(points={{-60,80},{40,80}}, color={0,0,255}));
  connect(interface_MBL1.n_i, signalVoltage.n)
    annotation (Line(points={{20,60},{40,60}}, color={0,0,255}));
  connect(interface_MBL1.term_n, sens2.terminal_p) annotation (Line(points=
          {{10,49},{10,0},{40,0},{40,-40},{10,-40}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_MBL;
