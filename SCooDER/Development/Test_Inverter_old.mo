within SCooDER.Development;
model Test_Inverter_old

  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage source(f=60, V=240)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_Inverter
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.Constant pf(k=0.9)
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Modelica.Blocks.Sources.Sine PV_generation(amplitude=1e3, freqHz=1/60)
    annotation (Placement(transformation(extent={{60,20},{40,40}})));
  Modelica.Blocks.Sources.Constant Battery(k=0)
    annotation (Placement(transformation(extent={{60,-30},{40,-10}})));
  Buildings.Electrical.AC.OnePhase.Loads.Impedance Z_R(
    R=100,
    RMin=100,
    RMax=10000,
    use_R_in=true)
         "Impedance with variable R"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-26,46})));
  Modelica.Blocks.Sources.Constant test(k=-1)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage source1(
                                                               f=60, V=240)
    annotation (Placement(transformation(extent={{-30,-12},{-10,8}})));
equation
  connect(sens_Inverter.terminal_n, source.terminal)
    annotation (Line(points={{-60,0},{-70,0},{-80,0}}, color={0,120,120}));
  //connect(inverter.Inverter_terminal, sens_Inverter.terminal_p)
  //  annotation (Line(points={{-10,0},{-40,0}}, color={0,120,120}));
  connect(inverter.pf, pf.y) annotation (Line(points={{0,-12.2},{0,-12.2},{0,
          -40},{-19,-40}}, color={0,0,127}));
  connect(PV_generation.y, inverter.P_PV) annotation (Line(points={{39,30},
          {30,30},{30,4},{12,4}}, color={0,0,127}));
  connect(Battery.y, inverter.P_Batt) annotation (Line(points={{39,-20},{30,-20},
          {30,-4},{12,-4}}, color={0,0,127}));
  connect(Z_R.terminal, sens_Inverter.terminal_p) annotation (Line(points={{-36,
          46},{-38,46},{-38,0},{-40,0}}, color={0,120,120}));
  connect(test.y, Z_R.y_R) annotation (Line(points={{-39,70},{-34,70},{-34,56},
          {-30,56}}, color={0,0,127}));
  connect(inverter.term_p, source1.terminal)
    annotation (Line(points={{-10,0},{-10,-2}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_Inverter_old;
