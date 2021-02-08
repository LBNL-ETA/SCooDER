within SCooDER.Development;
model Develop_Inverter1
  Development.CapacitiveLoad load2(V_nominal=120)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Sources.Sine Powerfactor(
    amplitude=1,
    freqHz=1,
    phase=0,
    offset=0)
    annotation (Placement(transformation(extent={{100,20},{80,40}})));
  Modelica.Blocks.Sources.Constant Load(k=100)
    annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  Modelica.Blocks.Nonlinear.Limiter limiter(uMax=1, uMin=0.1)
    annotation (Placement(transformation(extent={{70,20},{50,40}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada_1
    annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
  Components.Sensor.Model.Probe3ph sens_all
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens1
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-20,30})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens2
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-20,0})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens3
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-20,-30})));
  Development.CapacitiveLoad load1(V_nominal=120)
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  Development.CapacitiveLoad load3(V_nominal=120)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage source(f=60, V=
        208)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-90,0})));
  Modelica.Blocks.Sources.Sine Powerfactor1(
    amplitude=1,
    phase=0,
    offset=0,
    freqHz=0.5)
    annotation (Placement(transformation(extent={{100,-40},{80,-20}})));
  Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=1, uMin=0.1)
    annotation (Placement(transformation(extent={{70,-40},{50,-20}})));
equation
  connect(Powerfactor.y, limiter.u)
    annotation (Line(points={{79,30},{72,30}}, color={0,0,127}));
  connect(ada_1.terminal, sens_all.terminal_p)
    annotation (Line(points={{-60,0},{-60,0}}, color={0,120,120}));
  connect(sens1.terminal_n, ada_1.terminals[1]) annotation (Line(points={
          {-30,30},{-34,30},{-34,0.53333},{-40.2,0.53333}}, color={0,120,
          120}));
  connect(sens2.terminal_n, ada_1.terminals[2])
    annotation (Line(points={{-30,0},{-40.2,0}}, color={0,120,120}));
  connect(sens3.terminal_n, ada_1.terminals[3]) annotation (Line(points={
          {-30,-30},{-34,-30},{-34,-0.53333},{-40.2,-0.53333}}, color={0,
          120,120}));
  connect(load2.terminal, sens2.terminal_p)
    annotation (Line(points={{0,0},{0,0},{-10,0}}, color={0,120,120}));
  connect(sens1.terminal_p, load1.terminal) annotation (Line(points={{-10,
          30},{-6,30},{0,30}}, color={0,120,120}));
  connect(sens3.terminal_p, load3.terminal) annotation (Line(points={{-10,
          -30},{-5,-30},{0,-30}}, color={0,120,120}));
  connect(limiter.y, load1.pf_in) annotation (Line(points={{49,30},{40,30},
          {40,36},{20,36}}, color={0,0,127}));
  connect(Load.y, load1.Pow) annotation (Line(points={{49,0},{34,0},{34,
          30},{20,30}}, color={0,0,127}));
  connect(Load.y, load2.Pow)
    annotation (Line(points={{49,0},{34,0},{20,0}}, color={0,0,127}));
  connect(Load.y, load3.Pow) annotation (Line(points={{49,0},{34,0},{34,
          -30},{20,-30}}, color={0,0,127}));
  connect(limiter.y, load2.pf_in) annotation (Line(points={{49,30},{40,30},
          {40,6},{20,6}}, color={0,0,127}));
  connect(sens_all.terminal_n, source.terminal) annotation (Line(points={
          {-80,0},{-80,-1.33227e-015}}, color={0,120,120}));
  connect(limiter1.y, load3.pf_in) annotation (Line(points={{49,-30},{36,
          -30},{36,-24},{20,-24}}, color={0,0,127}));
  connect(Powerfactor1.y, limiter1.u)
    annotation (Line(points={{79,-30},{72,-30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Develop_Inverter1;
