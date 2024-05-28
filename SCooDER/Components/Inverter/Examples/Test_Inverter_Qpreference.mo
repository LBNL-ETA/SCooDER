within SCooDER.Components.Inverter.Examples;
model Test_Inverter_Qpreference
  "Example to test the functionality of the inverter with battery and Pv inputs."
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Sine Powerfactor12(
    f=1,
    phase=0,
    offset=0,
    amplitude=10000)
    annotation (Placement(transformation(extent={{80,20},{60,40}})));
  Modelica.Blocks.Sources.Constant PV123(k=4000)
    annotation (Placement(transformation(extent={{60,80},{40,100}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens1
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-50,0})));
  Modelica.Blocks.Sources.Sine Powerfactor3(
    phase=0,
    offset=0,
    f=0.5,
    amplitude=3000)
    annotation (Placement(transformation(extent={{80,-80},{60,-60}})));
  Model.Inverter inverter1
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Sources.Constant Battery13(k=0)
    annotation (Placement(transformation(extent={{80,60},{60,80}})));
  Modelica.Blocks.Sources.Sine Battery2(
    phase=0,
    offset=0,
    f=0.5,
    amplitude=4500)
    annotation (Placement(transformation(extent={{80,-14},{60,6}})));
  Modelica.Blocks.Sources.Step Plim2(
    height=-0.5,
    offset=1,
    startTime=2)
    annotation (Placement(transformation(extent={{80,-44},{60,-24}})));
  Interfaces.InvCtrlBus invCtrlBus1 annotation (Placement(transformation(extent={{-20,-40},
            {0,-20}}),        iconTransformation(extent={{-142,-2},{-122,18}})));
  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=60, V=240)
    annotation (Placement(transformation(extent={{-102,-10},{-82,10}})));
  Modelica.Blocks.Sources.Constant soc(k=0.25)
    annotation (Placement(transformation(extent={{44,-74},{24,-54}})));
equation
  connect(inverter1.term_p, sens1.terminal_p) annotation (Line(points={{-20,0},
          {-40,0}},              color={0,120,120}));
  connect(inverter1.P_Batt, inverter1.batt_ctrl_inv)
    annotation (Line(points={{2,-3},{2,-8},{1,-8}},    color={0,0,127}));
  connect(inverter1.invCtrlBus, invCtrlBus1) annotation (Line(
      points={{-10,-10},{-10,-30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sens1.terminal_n, fixVol.terminal)
    annotation (Line(points={{-60,0},{-82,0}}, color={0,120,120}));
  connect(Powerfactor12.y, inverter1.P_PV) annotation (Line(points={{59,30},{34,
          30},{34,8},{2,8},{2,6}}, color={0,0,127}));
  connect(Battery13.y, invCtrlBus1.batt_ctrl) annotation (Line(points={{59,70},
          {26,70},{26,-29.95},{-9.95,-29.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(Plim2.y, invCtrlBus1.plim) annotation (Line(points={{59,-34},{26,-34},
          {26,-29.95},{-9.95,-29.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(Battery2.y, invCtrlBus1.qctrl) annotation (Line(points={{59,-4},{24,
          -4},{24,-29.95},{-9.95,-29.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(inverter1.SOC_Batt, soc.y) annotation (Line(points={{2,1.6},{16,1.6},
          {16,-64},{23,-64}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_Inverter_Qpreference;
