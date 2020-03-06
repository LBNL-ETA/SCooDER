within SCooDER.Systems.Examples;
model Test_Inverter_voltvar
  "Example to test the functionality of a volt var control with inverter."
  extends Modelica.Icons.Example;
  Components.Inverter.Model.Inverter inverter(QIndmax=2500, QCapmax=1500)
    annotation (Placement(transformation(extent={{50,70},{30,90}})));
  Components.Controller.Model.voltvar voltvar
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Sources.Sine Voltage(
    offset=1,
    freqHz=1/5,
    amplitude=0.06)
    annotation (Placement(transformation(extent={{-100,12},{-80,32}})));
  Modelica.Blocks.Sources.Constant PV1(k=1000) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,90})));
  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=60, V=120,
    definiteReference=true)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=-90,
        origin={90,-90})));
  Modelica.Blocks.Sources.Constant Batt1(k=0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,60})));
  Modelica.Blocks.Sources.Constant Plim1(k=1) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={60,30})));
  Modelica.Blocks.Sources.Constant Q_max(k=2500) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,30})));
  Modelica.Blocks.Sources.Constant upper_voltage(k=1.05)
    annotation (Placement(transformation(extent={{-72,52},{-52,72}})));
  Modelica.Blocks.Sources.Constant lower_voltage(k=0.95)
    annotation (Placement(transformation(extent={{-72,-68},{-52,-48}})));
  Modelica.Blocks.Sources.Constant upper_deadband_voltage(k=1.01)
    annotation (Placement(transformation(extent={{-60,12},{-40,32}})));
  Modelica.Blocks.Sources.Constant lower_deadband_voltage(k=0.99)
    annotation (Placement(transformation(extent={{-60,-28},{-40,-8}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=1,
    startTime=0,
    height=0.2,
    offset=0.9)
    annotation (Placement(transformation(extent={{-100,-28},{-80,-8}})));
  Components.Inverter.Interfaces.InvCtrlBus          invCtrlBus annotation (
      Placement(transformation(extent={{30,40},{50,60}}),    iconTransformation(
          extent={{10,32},{30,52}})));
  Buildings.Electrical.AC.OnePhase.Lines.TwoPortRL RL1(R=1, L=1/(2*Modelica.Constants.pi
        *60)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=270,
        origin={90,-56})));
  Buildings.Electrical.AC.OnePhase.Loads.Resistive load1(mode=Buildings.Electrical.Types.Load.VariableZ_P_input)
    annotation (Placement(transformation(extent={{80,-30},{60,-10}})));
  Modelica.Blocks.Sources.Sine Voltage1(
    freqHz=1/5,
    offset=-1500,
    amplitude=1500)
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens annotation (
     Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={90,18})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=sens.V/120)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Buildings.Electrical.AC.OnePhase.Lines.TwoPortRL RL2(R=1, L=1/(2*Modelica.Constants.pi
        *60)) annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={70,-68})));
  Buildings.Electrical.AC.OnePhase.Loads.Resistive load2(mode=Buildings.Electrical.Types.Load.VariableZ_P_input)
    annotation (Placement(transformation(extent={{22,-70},{2,-50}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_ref
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={40,-70})));
  Buildings.Electrical.AC.OnePhase.Loads.Resistive load3(mode=Buildings.Electrical.Types.Load.VariableZ_P_input)
    annotation (Placement(transformation(extent={{22,-90},{2,-70}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=PV1.y)
    annotation (Placement(transformation(extent={{-30,-90},{-10,-70}})));
equation
  connect(inverter.P_Batt, inverter.batt_ctrl_inv) annotation (Line(points={{28,77},
          {28,77},{28,72},{29,72}},     color={0,0,127}));
  connect(inverter.P_PV, PV1.y) annotation (Line(points={{28,86},{18,86},{18,
          90},{11,90}},
                    color={0,0,127}));
  connect(Q_max.y, voltvar.q_maxcap)
    annotation (Line(points={{1,30},{6,30},{6,12}}, color={0,0,127}));
  connect(lower_voltage.y, voltvar.v_min) annotation (Line(points={{-51,-58},
          {-26,-58},{-26,-8},{-2,-8}},       color={0,0,127}));
  connect(upper_voltage.y, voltvar.v_max) annotation (Line(points={{-51,62},{
          -26,62},{-26,8},{-2,8}},       color={0,0,127}));
  connect(voltvar.v_mindead,lower_deadband_voltage. y) annotation (Line(
        points={{-2,-4},{-32,-4},{-32,-18},{-39,-18}},  color={0,0,127}));
  connect(upper_deadband_voltage.y, voltvar.v_maxdead) annotation (Line(
        points={{-39,22},{-32,22},{-32,4},{-2,4}},  color={0,0,127}));
  connect(invCtrlBus, inverter.invCtrlBus) annotation (Line(
      points={{40,50},{40,50},{40,60},{40,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(Batt1.y, invCtrlBus.batt_ctrl) annotation (Line(points={{11,60},{26,
          60},{26,50.05},{40.05,50.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Plim1.y, invCtrlBus.plim) annotation (Line(points={{49,30},{40.05,
          30},{40.05,50.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(voltvar.q_control, invCtrlBus.qctrl) annotation (Line(points={{21,0},{
          40.05,0},{40.05,50.05}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(voltvar.q_maxind, Q_max.y)
    annotation (Line(points={{12,12},{12,30},{1,30}}, color={0,0,127}));
  connect(fixVol.terminal, RL1.terminal_n) annotation (Line(points={{90,-80},
          {90,-73},{90,-66}}, color={0,120,120}));
  connect(Voltage1.y, load1.Pow) annotation (Line(points={{41,-30},{50,-30},{
          50,-20},{60,-20}}, color={0,0,127}));
  connect(sens.terminal_n, RL1.terminal_p)
    annotation (Line(points={{90,8},{90,8},{90,-46}}, color={0,120,120}));
  connect(load1.terminal, RL1.terminal_p) annotation (Line(points={{80,-20},{
          90,-20},{90,-46}}, color={0,120,120}));
  connect(realExpression.y, voltvar.v_pu)
    annotation (Line(points={{-59,0},{-30.5,0},{-2,0}}, color={0,0,127}));
  connect(sens.terminal_p, inverter.term_p) annotation (Line(points={{90,28},
          {90,28},{90,80},{50,80}}, color={0,120,120}));
  connect(RL2.terminal_n, RL1.terminal_n) annotation (Line(points={{80,-68},{
          86,-68},{86,-66},{90,-66}}, color={0,120,120}));
  connect(load2.Pow, Voltage1.y) annotation (Line(points={{2,-60},{2,-60},{2,
          -30},{41,-30}}, color={0,0,127}));
  connect(RL2.terminal_p, sens_ref.terminal_n) annotation (Line(points={{60,
          -68},{58,-68},{58,-70},{50,-70}}, color={0,120,120}));
  connect(sens_ref.terminal_p, load2.terminal) annotation (Line(points={{30,
          -70},{28,-70},{28,-60},{22,-60}}, color={0,120,120}));
  connect(load3.terminal, sens_ref.terminal_p) annotation (Line(points={{22,
          -80},{28,-80},{28,-70},{30,-70}}, color={0,120,120}));
  connect(realExpression1.y, load3.Pow)
    annotation (Line(points={{-9,-80},{-4,-80},{2,-80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
   experiment(StopTime=5), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_Inverter_voltvar;
