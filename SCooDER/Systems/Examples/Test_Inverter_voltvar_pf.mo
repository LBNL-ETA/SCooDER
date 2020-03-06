within SCooDER.Systems.Examples;
model Test_Inverter_voltvar_pf
  "Example to test the functionality of a volt var control with inverter."
  extends Modelica.Icons.Example;
  Components.Inverter.Model.Inverter_pf
                                     inverter(
    maxIndPf=0.1,
    maxCapPf=0.1,
    Qmax=2000)
    annotation (Placement(transformation(extent={{60,70},{40,90}})));
  Components.Controller.Model.voltvar voltvar
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Sources.Sine Voltage(
    offset=1,
    freqHz=1/5,
    amplitude=0.06)
    annotation (Placement(transformation(extent={{-100,10},{-80,30}})));
  Modelica.Blocks.Sources.Constant PV1(k=1000) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,90})));
  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=60, V=120)
    annotation (Placement(transformation(extent={{100,70},{80,90}})));
  Modelica.Blocks.Sources.Constant Batt1(k=0) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,60})));
  Modelica.Blocks.Sources.Constant Plim1(k=1) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={80,50})));
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
    annotation (Placement(transformation(extent={{-72,12},{-52,32}})));
  Modelica.Blocks.Sources.Constant lower_deadband_voltage(k=0.99)
    annotation (Placement(transformation(extent={{-72,-28},{-52,-8}})));
  Modelica.Blocks.Sources.Ramp ramp(
    duration=1,
    startTime=0,
    height=0.2,
    offset=0.9)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Components.Controller.Utility.QToPf qToPf
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Components.Inverter.Interfaces.InvCtrlBus_pf       invCtrlBus annotation (
      Placement(transformation(extent={{34,54},{44,64}}),    iconTransformation(
          extent={{10,32},{30,52}})));
equation
  connect(inverter.term_p, fixVol.terminal)
    annotation (Line(points={{60,80},{70,80},{80,80}}, color={0,120,120}));
  connect(inverter.P_Batt, inverter.batt_ctrl_inv) annotation (Line(points={{38,
          77},{38,77},{38,72},{39,72}}, color={0,0,127}));
  connect(inverter.P_PV, PV1.y) annotation (Line(points={{38,86},{28,86},{28,90},
          {21,90}}, color={0,0,127}));
  connect(Q_max.y, voltvar.q_maxcap)
    annotation (Line(points={{1,30},{6,30},{6,12}}, color={0,0,127}));
  connect(voltvar.q_maxind, Q_max.y) annotation (Line(points={{12,12},{12,12},{12,
          30},{1,30}}, color={0,0,127}));
  connect(lower_voltage.y, voltvar.v_min) annotation (Line(points={{-51,-58},{-22,
          -58},{-22,-8},{-2,-8}},            color={0,0,127}));
  connect(upper_voltage.y, voltvar.v_max) annotation (Line(points={{-51,62},{-22,
          62},{-22,8},{-2,8}},           color={0,0,127}));
  connect(voltvar.v_mindead,lower_deadband_voltage. y) annotation (Line(
        points={{-2,-4},{-32,-4},{-32,-18},{-51,-18}},  color={0,0,127}));
  connect(upper_deadband_voltage.y, voltvar.v_maxdead) annotation (Line(
        points={{-51,22},{-32,22},{-32,4},{-2,4}},  color={0,0,127}));
  connect(voltvar.q_control, qToPf.q)
    annotation (Line(points={{21,0},{24.5,0},{28,0}}, color={0,0,127}));
  connect(inverter.p, qToPf.p) annotation (Line(points={{61,88},{62,88},{64,88},
          {64,28},{40,28},{40,12}}, color={0,0,127}));
  connect(voltvar.v_pu, Voltage.y) annotation (Line(points={{-2,0},{-76,0},{-76,
          20},{-79,20}}, color={0,0,127}));
  connect(invCtrlBus, inverter.invCtrlBus) annotation (Line(
      points={{39,59},{42,59},{42,70},{48,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(Batt1.y, invCtrlBus.batt_ctrl) annotation (Line(points={{21,60},{
          39.025,60},{39.025,59.025}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(qToPf.pf, invCtrlBus.pf) annotation (Line(points={{51,0},{44,0},{44,
          59.025},{39.025,59.025}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Plim1.y, invCtrlBus.plim) annotation (Line(points={{69,50},{54,50},
          {54,59.025},{39.025,59.025}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
   experiment(StopTime=5), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_Inverter_voltvar_pf;
