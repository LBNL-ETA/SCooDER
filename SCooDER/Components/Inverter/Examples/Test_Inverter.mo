within SCooDER.Components.Inverter.Examples;
model Test_Inverter
  "Example to test the functionality of the inverter with battery and Pv inputs."
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine Powerfactor12(
    freqHz=1,
    phase=0,
    offset=0,
    amplitude=3000)
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
  Modelica.Blocks.Sources.Constant PV123(k=4000)
    annotation (Placement(transformation(extent={{60,80},{40,100}})));
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
        origin={-90,0})));
  Modelica.Blocks.Sources.Sine Powerfactor3(
    phase=0,
    offset=0,
    freqHz=0.5,
    amplitude=3000)
    annotation (Placement(transformation(extent={{80,-80},{60,-60}})));
  Model.Inverter inverter1(QIndmax=1000)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Model.Inverter inverter2
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Model.Inverter inverter3
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Blocks.Sources.Constant Battery13(k=0)
    annotation (Placement(transformation(extent={{80,60},{60,80}})));
  Modelica.Blocks.Sources.Sine Battery2(
    phase=0,
    offset=0,
    freqHz=0.5,
    amplitude=12000)
    annotation (Placement(transformation(extent={{80,-14},{60,6}})));
  Modelica.Blocks.Sources.Constant Plim13(k=1)
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  Modelica.Blocks.Sources.Step Plim2(
    height=-0.5,
    offset=1,
    startTime=10.4)
    annotation (Placement(transformation(extent={{80,-44},{60,-24}})));
  Interfaces.InvCtrlBus invCtrlBus1 annotation (Placement(transformation(extent=
           {{0,20},{20,40}}), iconTransformation(extent={{-142,-2},{-122,18}})));
  Interfaces.InvCtrlBus invCtrlBus2 annotation (Placement(transformation(extent=
           {{0,-30},{20,-10}}), iconTransformation(extent={{-142,-2},{-122,18}})));
  Interfaces.InvCtrlBus invCtrlBus3 annotation (Placement(transformation(extent=
           {{0,-80},{20,-60}}), iconTransformation(extent={{-142,-2},{-122,18}})));
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
  connect(sens_all.terminal_n, source.terminal) annotation (Line(points={
          {-80,0},{-80,-1.33227e-015}}, color={0,120,120}));
  connect(inverter1.term_p, sens1.terminal_p) annotation (Line(points={{0,
          50},{-5,50},{-10,50}}, color={0,120,120}));
  connect(sens2.terminal_p, inverter2.term_p)
    annotation (Line(points={{-10,0},{-5,0},{0,0}}, color={0,120,120}));
  connect(inverter3.term_p, sens3.terminal_p) annotation (Line(points={{0,
          -50},{-5,-50},{-10,-50}}, color={0,120,120}));
  connect(PV123.y, inverter1.P_PV) annotation (Line(points={{39,90},{32,90},{32,
          56},{22,56}}, color={0,0,127}));
  connect(PV123.y, inverter2.P_PV)
    annotation (Line(points={{39,90},{32,90},{32,6},{22,6}}, color={0,0,127}));
  connect(PV123.y, inverter3.P_PV) annotation (Line(points={{39,90},{32,90},{32,
          -44},{22,-44}}, color={0,0,127}));
  connect(inverter1.P_Batt, inverter1.batt_ctrl_inv)
    annotation (Line(points={{22,47},{22,42},{21,42}}, color={0,0,127}));
  connect(inverter2.batt_ctrl_inv, inverter2.P_Batt)
    annotation (Line(points={{21,-8},{22,-8},{22,-3}}, color={0,0,127}));
  connect(inverter3.P_Batt, inverter3.batt_ctrl_inv) annotation (Line(points={{
          22,-53},{22,-53},{22,-58},{21,-58}}, color={0,0,127}));
  connect(inverter1.invCtrlBus, invCtrlBus1) annotation (Line(
      points={{10,40},{10,35},{10,30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(inverter2.invCtrlBus, invCtrlBus2) annotation (Line(
      points={{10,-10},{10,-15},{10,-20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(inverter3.invCtrlBus, invCtrlBus3) annotation (Line(
      points={{10,-60},{10,-65},{10,-65},{10,-70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Plim13.y, invCtrlBus1.plim) annotation (Line(points={{-19,-90},{-8,
          -90},{-8,30.05},{10.05,30.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Plim13.y, invCtrlBus3.plim) annotation (Line(points={{-19,-90},{-8,
          -90},{-8,-70},{2,-70},{2,-69.95},{10.05,-69.95}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Powerfactor12.y, invCtrlBus1.qctrl) annotation (Line(points={{59,30},
          {10.05,30},{10.05,30.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Powerfactor12.y, invCtrlBus2.qctrl) annotation (Line(points={{59,30},
          {40,30},{40,-20},{40,-19.95},{26,-19.95},{10.05,-19.95}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Plim2.y, invCtrlBus2.plim) annotation (Line(points={{59,-34},{50,-34},
          {50,-20},{30,-20},{30,-19.95},{10.05,-19.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Battery2.y, invCtrlBus2.batt_ctrl) annotation (Line(points={{59,-4},{
          44,-4},{44,-20},{42,-20},{42,-19.95},{26,-19.95},{10.05,-19.95}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Battery13.y, invCtrlBus1.batt_ctrl) annotation (Line(points={{59,70},
          {36,70},{36,30.05},{10.05,30.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Battery13.y, invCtrlBus3.batt_ctrl) annotation (Line(points={{59,70},
          {36,70},{36,-69.95},{10.05,-69.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Powerfactor3.y, invCtrlBus3.qctrl) annotation (Line(points={{59,-70},
          {10.05,-70},{10.05,-69.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_Inverter;
