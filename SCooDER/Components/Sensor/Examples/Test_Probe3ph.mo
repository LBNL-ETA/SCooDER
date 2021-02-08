within SCooDER.Components.Sensor.Examples;
model Test_Probe3ph

  Model.Probe3ph sens_resistive
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage source(f=60, V=
        208)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-90,0})));
  Model.Probe3ph sens_inductive
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Model.Probe3ph sens_capacitive
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Model.Probe3ph sens_impedance
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Resistive
    load_resistive(P_nominal=1000, V_nominal=208)
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Inductive
    load_inductive(
    V_nominal=208,
    P_nominal=1000,
    pf=0.1)
    annotation (Placement(transformation(extent={{20,10},{40,30}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Capacitive
    load_capacitive(
    P_nominal=1000,
    V_nominal=208,
    pf=0.1)
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Impedance
    load_impedance
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
equation
  connect(source.terminal, sens_impedance.terminal_n) annotation (Line(
        points={{-80,0},{-60,0},{-60,-60},{-40,-60}}, color={0,120,120}));
  connect(sens_capacitive.terminal_n, source.terminal) annotation (Line(
        points={{-40,-20},{-60,-20},{-60,0},{-80,0}}, color={0,120,120}));
  connect(sens_inductive.terminal_n, source.terminal) annotation (Line(
        points={{-40,20},{-60,20},{-60,0},{-80,0}}, color={0,120,120}));
  connect(sens_resistive.terminal_n, source.terminal) annotation (Line(
        points={{-40,60},{-60,60},{-60,0},{-80,0}}, color={0,120,120}));
  connect(sens_resistive.terminal_p, load_resistive.terminal) annotation (
     Line(points={{-20,60},{0,60},{20,60}}, color={0,120,120}));
  connect(sens_inductive.terminal_p, load_inductive.terminal) annotation (
     Line(points={{-20,20},{0,20},{20,20}}, color={0,120,120}));
  connect(sens_capacitive.terminal_p, load_capacitive.terminal)
    annotation (Line(points={{-20,-20},{0,-20},{20,-20}}, color={0,120,
          120}));
  connect(sens_impedance.terminal_p, load_impedance.terminal) annotation (
     Line(points={{-20,-60},{0,-60},{20,-60}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_Probe3ph;
