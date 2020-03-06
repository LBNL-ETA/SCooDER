within SCooDER.Components.Inverter.Examples;
model Test_Spotload_FMU
  Model.SpotLoad_Y_PQ_ext spotLoad_Y_PQ_ext
    annotation (Placement(transformation(extent={{-40,-20},{-20,20}})));
  Modelica.Blocks.Interfaces.RealInput P1(start=0, unit="W") "Positive = load; Negative = source" annotation (
      Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,80}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,80})));
  Modelica.Blocks.Interfaces.RealInput Q1(start=0, unit="var") "Positive = capacitive; Negative = inductive" annotation (
      Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,50}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,50})));
  Modelica.Blocks.Interfaces.RealInput P2(start=0, unit="W") "Positive = load; Negative = source" annotation (
      Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,10}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,10})));
  Modelica.Blocks.Interfaces.RealInput Q2(start=0, unit="var") "Positive = capacitive; Negative = inductive" annotation (
      Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-20}),iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-20})));
  Modelica.Blocks.Interfaces.RealInput P3(start=0, unit="W") "Positive = load; Negative = source" annotation (
      Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-60}),iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-60})));
  Modelica.Blocks.Interfaces.RealInput Q3(start=0, unit="var") "Positive = capacitive; Negative = inductive" annotation (
      Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-90}),iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-90})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid grid_Y(f=60, V=120)
    annotation (Placement(transformation(extent={{50,60},{70,80}})));
  Sensor.Model.Probe3ph sens_Y(V_nominal=120)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.Line line_Y(
    l=1000,
    P_nominal=5000,
    V_nominal=120)
    annotation (Placement(transformation(extent={{40,-10},{20,10}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(T=0.1)
    annotation (Placement(transformation(extent={{-94,76},{-86,84}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(T=0.1)
    annotation (Placement(transformation(extent={{-94,46},{-86,54}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder3(T=0.1)
    annotation (Placement(transformation(extent={{-94,6},{-86,14}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder4(T=0.1)
    annotation (Placement(transformation(extent={{-94,-24},{-86,-16}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder5(T=0.1)
    annotation (Placement(transformation(extent={{-94,-64},{-86,-56}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder6(T=0.1)
    annotation (Placement(transformation(extent={{-94,-94},{-86,-86}})));
equation
  connect(grid_Y.terminal,line_Y. terminal_n)
    annotation (Line(points={{60,60},{60,0},{40,0}},   color={0,120,120}));
  connect(line_Y.terminal_p,sens_Y. terminal_n)
    annotation (Line(points={{20,0},{10,0}},   color={0,120,120}));
  connect(sens_Y.terminal_p, spotLoad_Y_PQ_ext.terminal_n)
    annotation (Line(points={{-10,0},{-20,0}}, color={0,120,120}));
  connect(spotLoad_Y_PQ_ext.P1, firstOrder1.y) annotation (Line(points={{-41,16},
          {-60,16},{-60,80},{-85.6,80}}, color={0,0,127}));
  connect(firstOrder1.u, P1)
    annotation (Line(points={{-94.8,80},{-120,80}}, color={0,0,127}));
  connect(Q1, firstOrder2.u)
    annotation (Line(points={{-120,50},{-94.8,50}}, color={0,0,127}));
  connect(firstOrder2.y, spotLoad_Y_PQ_ext.Q1) annotation (Line(points={{-85.6,
          50},{-70,50},{-70,10},{-41,10}}, color={0,0,127}));
  connect(P2, firstOrder3.u)
    annotation (Line(points={{-120,10},{-94.8,10}}, color={0,0,127}));
  connect(firstOrder3.y, spotLoad_Y_PQ_ext.P2) annotation (Line(points={{-85.6,
          10},{-80,10},{-80,2},{-41,2}}, color={0,0,127}));
  connect(Q2, firstOrder4.u)
    annotation (Line(points={{-120,-20},{-94.8,-20}}, color={0,0,127}));
  connect(firstOrder4.y, spotLoad_Y_PQ_ext.Q2) annotation (Line(points={{-85.6,
          -20},{-80,-20},{-80,-4},{-41,-4}}, color={0,0,127}));
  connect(spotLoad_Y_PQ_ext.P3, firstOrder5.y) annotation (Line(points={{-41,
          -12},{-70,-12},{-70,-60},{-85.6,-60}}, color={0,0,127}));
  connect(firstOrder5.u, P3)
    annotation (Line(points={{-94.8,-60},{-120,-60}}, color={0,0,127}));
  connect(spotLoad_Y_PQ_ext.Q3, firstOrder6.y) annotation (Line(points={{-41,
          -18},{-60,-18},{-60,-90},{-85.6,-90}}, color={0,0,127}));
  connect(firstOrder6.u, Q3)
    annotation (Line(points={{-94.8,-90},{-120,-90}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_Spotload_FMU;
