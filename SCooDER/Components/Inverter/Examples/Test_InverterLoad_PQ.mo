within SCooDER.Components.Inverter.Examples;
model Test_InverterLoad_PQ
  "Example to test the functionality of the load model."
  extends Modelica.Icons.Example;

  Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada_1
    annotation (Placement(transformation(extent={{-40,-10},{-60,10}})));
  Sensor.Model.Probe3ph sens_all
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens1
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-20,50})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens2
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-20,0})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens3
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-20,-50})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage source(f=60, V=
        208)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-90,60})));
  Modelica.Blocks.Sources.Sine Qsine1(
    phase=0,
    offset=0,
    freqHz=1,
    amplitude=250)
    annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
  Modelica.Blocks.Sources.Sine Psine1(
    phase=0,
    offset=0,
    freqHz=0.5,
    amplitude=1000)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Model.InverterLoad_PQ Load1(V_nominal=120)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Model.InverterLoad_PQ Load2(V_nominal=120)
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Model.InverterLoad_PQ Load3(V_nominal=120)
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Blocks.Sources.Constant Qfixed2(k=250)
    annotation (Placement(transformation(extent={{60,20},{40,40}})));
  Modelica.Blocks.Sources.Constant Pfixed(k=1000)
    annotation (Placement(transformation(extent={{80,40},{60,60}})));
  Modelica.Blocks.Sources.Constant Qfixed1(k=-250)
    annotation (Placement(transformation(extent={{60,60},{40,80}})));
  Modelica.Blocks.Sources.Constant Pfixed1(k=-1000)
    annotation (Placement(transformation(extent={{80,-60},{60,-40}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.TwoPortMatrixRL FL_feed(
    Z12=20*(1.0/5280.0)*{0.0953,0.8515},
    Z13=20*(1.0/5280.0)*{0.0953,0.7266},
    Z23=20*(1.0/5280.0)*{0.0953,0.7802},
    V_nominal=208,
    Z11=20*(1.0/5280.0)*{0.4013,1.4133},
    Z22=20*(1.0/5280.0)*{0.4013,1.4133},
    Z33=20*(1.0/5280.0)*{0.4013,1.4133}) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={-80,30})));
equation
  connect(ada_1.terminal, sens_all.terminal_p)
    annotation (Line(points={{-60,0},{-60,0}}, color={0,120,120}));
  connect(sens1.terminal_n, ada_1.terminals[1]) annotation (Line(points={
          {-30,50},{-34,50},{-34,0.53333},{-40.2,0.53333}}, color={0,120,
          120}));
  connect(sens2.terminal_n, ada_1.terminals[2])
    annotation (Line(points={{-30,0},{-40.2,0}}, color={0,120,120}));
  connect(sens3.terminal_n, ada_1.terminals[3]) annotation (Line(points={
          {-30,-50},{-34,-50},{-34,-0.53333},{-40.2,-0.53333}}, color={0,
          120,120}));
  connect(Load1.terminal, sens1.terminal_p)
    annotation (Line(points={{0,50},{-10,50}}, color={0,120,120}));
  connect(sens2.terminal_p, Load2.terminal)
    annotation (Line(points={{-10,0},{-5,0},{0,0}}, color={0,120,120}));
  connect(sens3.terminal_p, Load3.terminal)
    annotation (Line(points={{-10,-50},{-5,-50},{0,-50}}, color={0,120,120}));
  connect(Pfixed.y, Load1.Pow)
    annotation (Line(points={{59,50},{40.5,50},{22,50}}, color={0,0,127}));
  connect(Load3.Q, Qsine1.y) annotation (Line(points={{22,-44},{30,-44},{30,-30},
          {39,-30}}, color={0,0,127}));
  connect(Qfixed2.y, Load2.Q)
    annotation (Line(points={{39,30},{32,30},{32,6},{22,6}}, color={0,0,127}));
  connect(Qfixed1.y, Load1.Q) annotation (Line(points={{39,70},{32,70},{32,56},
          {22,56}}, color={0,0,127}));
  connect(sens_all.terminal_n, FL_feed.terminal_p)
    annotation (Line(points={{-80,0},{-80,20}}, color={0,120,120}));
  connect(FL_feed.terminal_n, source.terminal)
    annotation (Line(points={{-80,40},{-80,60}}, color={0,120,120}));
  connect(Pfixed1.y, Load3.Pow)
    annotation (Line(points={{59,-50},{22,-50},{22,-50}}, color={0,0,127}));
  connect(Qfixed2.y, Load2.Pow)
    annotation (Line(points={{39,30},{32,30},{32,0},{22,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_InverterLoad_PQ;
