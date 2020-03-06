within SCooDER.Components.Inverter.Examples;
model Test_Inverter_FMU
  "This allows the export of the inverter as FMU for testing purposes."
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
        origin={-90,0})));
  Model.Inverter inverter1
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Model.Inverter inverter2
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Model.Inverter inverter3
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));
  Modelica.Blocks.Interfaces.RealInput P_PV(unit="W")
    "Power generation from PV (pos if produced)" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,50}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,50})));
  Modelica.Blocks.Interfaces.RealInput P_Bat(
                                            unit="W")
    "Power generation from PV (pos if produced)" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,20}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,20})));
  Modelica.Blocks.Interfaces.RealInput Q(unit="var") "Reactive power input"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-50}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-50})));
  Modelica.Blocks.Interfaces.RealInput Plim(unit="W")
    "Power limit of inverter" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-80}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,50})));
  Interfaces.InvCtrlBus invCtrlBus1 annotation (Placement(transformation(extent=
           {{20,20},{40,40}}), iconTransformation(extent={{-142,-2},{-122,18}})));
  Interfaces.InvCtrlBus invCtrlBus2 annotation (Placement(transformation(extent=
           {{20,-30},{40,-10}}), iconTransformation(extent={{-142,-2},{-122,18}})));
  Interfaces.InvCtrlBus invCtrlBus3 annotation (Placement(transformation(extent=
           {{20,-80},{40,-60}}), iconTransformation(extent={{-142,-2},{-122,18}})));
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
  connect(inverter1.term_p, sens1.terminal_p)
    annotation (Line(points={{0,50},{-5,50},{-10,50}}, color={0,120,120}));
  connect(sens2.terminal_p, inverter2.term_p)
    annotation (Line(points={{-10,0},{-5,0},{0,0}}, color={0,120,120}));
  connect(inverter3.term_p, sens3.terminal_p) annotation (Line(points={{0,
          -50},{-5,-50},{-10,-50}}, color={0,120,120}));
  connect(P_PV, inverter1.P_PV) annotation (Line(points={{120,50},{60,50},{60,
          56},{22,56}}, color={0,0,127}));
  connect(P_PV, inverter2.P_PV) annotation (Line(points={{120,50},{60,50},{60,6},
          {22,6}}, color={0,0,127}));
  connect(P_PV, inverter3.P_PV) annotation (Line(points={{120,50},{60,50},{60,
          -44},{22,-44}},     color={0,0,127}));
  connect(inverter2.P_Batt, inverter2.batt_ctrl_inv)
    annotation (Line(points={{22,-3},{22,-8},{21,-8}}, color={0,0,127}));
  connect(inverter1.P_Batt, inverter1.batt_ctrl_inv)
    annotation (Line(points={{22,47},{22,42},{21,42}}, color={0,0,127}));
  connect(inverter3.P_Batt, inverter3.batt_ctrl_inv)
    annotation (Line(points={{22,-53},{22,-58},{21,-58}}, color={0,0,127}));
  connect(invCtrlBus1, inverter1.invCtrlBus) annotation (Line(
      points={{30,30},{12,30},{12,40},{10,40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(invCtrlBus2, inverter2.invCtrlBus) annotation (Line(
      points={{30,-20},{22,-20},{10,-20},{10,-10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(invCtrlBus3, inverter3.invCtrlBus) annotation (Line(
      points={{30,-70},{22,-70},{10,-70},{10,-60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(P_Bat, invCtrlBus1.batt_ctrl) annotation (Line(points={{120,20},{76,
          20},{76,30.05},{30.05,30.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(P_Bat, invCtrlBus2.batt_ctrl) annotation (Line(points={{120,20},{76,
          20},{76,-20},{54,-20},{54,-19.95},{30.05,-19.95}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(P_Bat, invCtrlBus3.batt_ctrl) annotation (Line(points={{120,20},{76,
          20},{76,-69.95},{30.05,-69.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Plim, invCtrlBus1.plim) annotation (Line(points={{120,-80},{76,-80},{
          76,30.05},{30.05,30.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Plim, invCtrlBus3.plim) annotation (Line(points={{120,-80},{76,-80},{
          76,-69.95},{30.05,-69.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Q, invCtrlBus1.qctrl) annotation (Line(points={{120,-50},{76,-50},{76,
          30.05},{30.05,30.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Q, invCtrlBus2.qctrl) annotation (Line(points={{120,-50},{76,-50},{76,
          -19.95},{30.05,-19.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Plim, invCtrlBus2.plim) annotation (Line(points={{120,-80},{76,-80},{
          76,-19.95},{30.05,-19.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Q, invCtrlBus3.qctrl) annotation (Line(points={{120,-50},{76,-50},{76,
          -69.95},{30.05,-69.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_Inverter_FMU;
