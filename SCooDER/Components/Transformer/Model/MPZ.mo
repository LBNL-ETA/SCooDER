within SCooDER.Components.Transformer.Model;
model MPZ
  parameter Modelica.SIunits.Voltage VHigh=208
    "Rms voltage on side 1 of the transformer (primary side)";
  parameter Modelica.SIunits.Voltage VLow=240
    "Rms voltage on side 2 of the transformer (secondary side)";
  parameter Modelica.SIunits.ApparentPower VABase=10e3
    "Nominal power of the transformer";
  parameter Real XoverR=3.01
    "Ratio between the complex and real components of the impedance (XL/R)";
  parameter Real Zperc=0.03 "Short circuit impedance";
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_n mpz_head
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.WyeToDelta delta_to_wye1
    "Delta to wye connection" annotation (Placement(transformation(extent={{-80,-10},
            {-60,10}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada_1
    annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
  Buildings.Electrical.AC.OnePhase.Conversion.ACACTransformer MPZ1(
    VHigh=VHigh,
    VLow=VLow,
    VABase=VABase,
    XoverR=XoverR,
    Zperc=Zperc)
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Buildings.Electrical.AC.OnePhase.Conversion.ACACTransformer MPZ2(
    VHigh=VHigh,
    VLow=VLow,
    VABase=VABase,
    XoverR=XoverR,
    Zperc=Zperc)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Buildings.Electrical.AC.OnePhase.Conversion.ACACTransformer MPZ3(
    VHigh=VHigh,
    VLow=VLow,
    VABase=VABase,
    XoverR=XoverR,
    Zperc=Zperc)
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_p inv_1
    annotation (Placement(transformation(extent={{110,50},{90,70}}),
        iconTransformation(extent={{110,50},{90,70}})));
  Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_p inv_2
    annotation (Placement(transformation(extent={{110,-10},{90,10}}),
        iconTransformation(extent={{110,-10},{90,10}})));
  Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_p inv_3
    annotation (Placement(transformation(extent={{110,-70},{90,-50}}),
        iconTransformation(extent={{110,-70},{90,-50}})));
  Sensor.Model.Probe3ph sens_dist_y
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Sensor.Model.Probe3ph sens_dist_d
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_inv1
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={70,60})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_inv2
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={70,0})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_inv3
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={70,-60})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_mpz1
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,60})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_mpz2
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,0})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_mpz3
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,-60})));
equation
  connect(MPZ1.terminal_p, sens_inv1.terminal_n)
    annotation (Line(points={{40,60},{60,60}}, color={0,120,120}));
  connect(inv_1, sens_inv1.terminal_p)
    annotation (Line(points={{100,60},{100,60},{80,60}},color={0,120,120}));
  connect(inv_2, sens_inv2.terminal_p)
    annotation (Line(points={{100,0},{80,0},{80,0}}, color={0,120,120}));
  connect(inv_3, sens_inv3.terminal_p)
    annotation (Line(points={{100,-60},{100,-60},{80,-60}},color={0,120,120}));
  connect(sens_inv2.terminal_n, MPZ2.terminal_p)
    annotation (Line(points={{60,0},{40,0}}, color={0,120,120}));
  connect(sens_inv3.terminal_n, MPZ3.terminal_p)
    annotation (Line(points={{60,-60},{60,-60},{40,-60}}, color={0,120,120}));
  connect(sens_dist_y.terminal_n, mpz_head)
    annotation (Line(points={{-100,0},{-100,0}}, color={0,120,120}));
  connect(delta_to_wye1.wye, sens_dist_y.terminal_p)
    annotation (Line(points={{-80,0},{-80,0}}, color={0,120,120}));
  connect(delta_to_wye1.delta, sens_dist_d.terminal_n)
    annotation (Line(points={{-60,0},{-60,0}}, color={0,120,120}));
  connect(ada_1.terminal, sens_dist_d.terminal_p)
    annotation (Line(points={{-40,0},{-40,0}}, color={0,120,120}));
  connect(MPZ3.terminal_n, sens_mpz3.terminal_p)
    annotation (Line(points={{20,-60},{15,-60},{10,-60}}, color={0,120,120}));
  connect(MPZ2.terminal_n, sens_mpz2.terminal_p) annotation (Line(points={{20,0},
          {14,0},{14,-1.33227e-015},{10,-1.33227e-015}}, color={0,120,120}));
  connect(MPZ1.terminal_n, sens_mpz1.terminal_p)
    annotation (Line(points={{20,60},{10,60}}, color={0,120,120}));
  connect(sens_mpz1.terminal_n, ada_1.terminals[1]) annotation (Line(points={{-10,60},
          {-14,60},{-14,0.533333},{-20.2,0.533333}},     color={0,120,120}));
  connect(sens_mpz2.terminal_n, ada_1.terminals[2])
    annotation (Line(points={{-10,0},{-20.2,0}}, color={0,120,120}));
  connect(sens_mpz3.terminal_n, ada_1.terminals[3]) annotation (Line(points={{-10,-60},
          {-14,-60},{-14,-0.533333},{-20.2,-0.533333}},      color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MPZ;
