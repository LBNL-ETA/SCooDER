within SCooDER.Components.Inverter.Examples;
model Test_Inverter_PI
  "Example to test the functionality of the inverter with battery and PV inputs; PI control."
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine Powerfactor12(
    amplitude=1,
    f=1,
    phase=0,
    offset=0) annotation (Placement(transformation(extent={{80,20},{60,40}})));
  Modelica.Blocks.Sources.Constant PV123(k=4000)
    annotation (Placement(transformation(extent={{60,80},{40,100}})));
  Modelica.Blocks.Sources.Sine Powerfactor3(
    amplitude=1,
    phase=0,
    offset=0,
    f=0.5) annotation (Placement(transformation(extent={{80,-80},{60,-60}})));
  Modelica.Blocks.Sources.Constant Battery13(k=0)
    annotation (Placement(transformation(extent={{80,60},{60,80}})));
  Modelica.Blocks.Sources.Sine Battery2(
    phase=0,
    offset=0,
    amplitude=12000,
    f=1/60) annotation (Placement(transformation(extent={{80,-14},{60,6}})));
  Modelica.Blocks.Sources.Constant Q1(k=0)
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  Modelica.Blocks.Sources.Step Plim2(
    height=-0.5,
    offset=1,
    startTime=15)
    annotation (Placement(transformation(extent={{80,-44},{60,-24}})));
  Model.Inverter inverter_PI1
    annotation (Placement(transformation(extent={{-26,76},{-6,96}})));
  Modelica.Blocks.Sources.Sine BattControl1(
    offset=0,
    amplitude=10000,
    f=1/30,
    phase=0) annotation (Placement(transformation(extent={{-78,50},{-58,70}})));
  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=50, V=240)
    annotation (Placement(transformation(extent={{-56,26},{-36,46}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder_batt(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=0,
    T=0.1) "Time delay for battery adjustment" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={12,66})));
  Interfaces.InvCtrlBus invCtrlBus annotation (Placement(transformation(extent=
            {{-30,50},{-10,70}}), iconTransformation(extent={{-142,-2},{-122,18}})));
  Modelica.Blocks.Sources.Constant soc(k=0.25)
    annotation (Placement(transformation(extent={{30,80},{10,100}})));
equation
  connect(fixVol.terminal, inverter_PI1.term_p) annotation (Line(points={{-36,36},
          {-32,36},{-32,86},{-26,86}}, color={0,120,120}));
  connect(Battery2.y, inverter_PI1.P_PV) annotation (Line(points={{59,-4},{28,-4},
          {28,92},{-4,92}}, color={0,0,127}));
  connect(firstOrder_batt.u, inverter_PI1.batt_ctrl_inv)
    annotation (Line(points={{12,54},{4,54},{4,78},{-5,78}}, color={0,0,127}));
  connect(inverter_PI1.batt_ctrl_inv, inverter_PI1.P_Batt)
    annotation (Line(points={{-5,78},{-4,78},{-4,83}}, color={0,0,127}));
  connect(inverter_PI1.invCtrlBus, invCtrlBus) annotation (Line(
      points={{-16,76},{-16,71},{-16,60},{-20,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(BattControl1.y, invCtrlBus.batt_ctrl) annotation (Line(points={{-57,
          60},{-40,60},{-40,60.05},{-19.95,60.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Plim2.y, invCtrlBus.plim) annotation (Line(points={{59,-34},{-20,-34},
          {-20,60.05},{-19.95,60.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(Q1.y, invCtrlBus.qctrl) annotation (Line(points={{-19,-90},{-19.95,
          -90},{-19.95,60.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(soc.y, inverter_PI1.SOC_Batt)
    annotation (Line(points={{9,90},{9,87.6},{-4,87.6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
  experiment(StopTime=60),
  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_Inverter_PI;
