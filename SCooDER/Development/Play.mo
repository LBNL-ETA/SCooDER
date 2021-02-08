within SCooDER.Development;
model Play
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage X2A(f=60, V=
        208) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-92,70})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sensors.GeneralizedSensor sens_Bus240V
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sensors.GeneralizedSensor sens_MPZ
    annotation (Placement(transformation(extent={{-70,60},{-50,80}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.TwoPortMatrixRL line2(
    Z11=1*{0.6810,0.6980},
    Z12=1*{0.0600,0.0780},
    Z13=1*{0.0600,0.0500},
    Z22=1*{0.6810,0.6980},
    Z23=1*{0.0600,0.0360},
    Z33=1*{0.6810,0.6980},
    V_nominal=240)                         "Line at primary side"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={20,50})));
  Modelica.Blocks.Sources.Ramp ramp1(
    startTime=0,
    offset=0,
    duration=60,
    height=-3e3)
    annotation (Placement(transformation(extent={{80,-30},{60,-10}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Resistive Inverter(
    V_nominal=240,
    P_nominal=-3e3,
    mode=Buildings.Electrical.Types.Load.VariableZ_P_input,
    loadConn=Buildings.Electrical.Types.LoadConnection.wye_to_wyeg)
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sensors.GeneralizedSensor sens_Inverter
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={20,20})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Conversion.ACACTransformerStepUpYD
    tra(
    XoverR=8/1,
    Zperc=sqrt(0.01^2 + 0.06^2),
    VHigh=120,
    VLow=240,
    VABase=200e3)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
equation
  connect(Inverter.Pow1, ramp1.y) annotation (Line(points={{42,-12},{42,-12},{
          42,-20},{59,-20}}, color={0,0,127}));
  connect(Inverter.Pow2, ramp1.y) annotation (Line(points={{42,-20},{50,-20},{
          50,-10},{56,-10},{56,-20},{59,-20}}, color={0,0,127}));
  connect(Inverter.Pow3, ramp1.y)
    annotation (Line(points={{42,-28},{59,-28},{59,-20}}, color={0,0,127}));
  connect(X2A.terminal, sens_MPZ.terminal_n)
    annotation (Line(points={{-82,70},{-76,70},{-70,70}}, color={0,120,120}));
  connect(line2.terminal_p, sens_Inverter.terminal_n)
    annotation (Line(points={{20,40},{20,36},{20,30}}, color={0,120,120}));
  connect(sens_Inverter.terminal_p, Inverter.terminal)
    annotation (Line(points={{20,10},{20,10},{20,-20}}, color={0,120,120}));
  connect(sens_MPZ.terminal_p, tra.terminal_n)
    annotation (Line(points={{-50,70},{-45,70},{-40,70}}, color={0,120,120}));
  connect(tra.terminal_p, sens_Bus240V.terminal_n)
    annotation (Line(points={{-20,70},{-15,70},{-10,70}}, color={0,120,120}));
  connect(sens_Bus240V.terminal_p, line2.terminal_n)
    annotation (Line(points={{10,70},{20,70},{20,60}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Play;
