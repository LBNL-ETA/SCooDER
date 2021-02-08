within SCooDER.Components.Inverter.Examples;
model Test_SpotLoads
    extends Modelica.Icons.Example;

  Model.SpotLoad_Y_PQ spotLoad_Y_PQ(
    P1=1000,
    P2=500,
    P3=250,
    V_start=120,
    Q1=-250,
    Q2=-500,
    Q3=-1000) annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Model.SpotLoad_D_PQ spotLoad_D_PQ(
    P1=1000,
    Q1=-250,
    P2=500,
    Q2=-500,
    P3=250,
    Q3=-1000,
    V_start=120)
    annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid grid_Y(f=60, V=120)
    annotation (Placement(transformation(extent={{50,60},{70,80}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid grid_D(f=60, V=120)
    annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
  Sensor.Model.Probe3ph sens_Y(V_nominal=120)
    annotation (Placement(transformation(extent={{10,40},{-10,60}})));
  Sensor.Model.Probe3ph sens_D(V_nominal=120)
    annotation (Placement(transformation(extent={{10,-50},{-10,-30}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.Line line_Y(
    l=1000,
    P_nominal=5000,
    V_nominal=120)
    annotation (Placement(transformation(extent={{40,40},{20,60}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.Line line_D(
    l=1000,
    P_nominal=5000,
    V_nominal=120)
    annotation (Placement(transformation(extent={{40,-50},{20,-30}})));
  Model.SpotLoad_Y_PQ spotLoad_Y_PQcap(
    P1=1000,
    P2=500,
    P3=250,
    V_start=120,
    Q1=250,
    Q2=500,
    Q3=1000) annotation (Placement(transformation(extent={{-50,10},{-30,30}})));
  Sensor.Model.Probe3ph sens_Ycap(V_nominal=120)
    annotation (Placement(transformation(extent={{10,10},{-10,30}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.Line line_Ycap(
    l=1000,
    P_nominal=5000,
    V_nominal=120)
    annotation (Placement(transformation(extent={{40,10},{20,30}})));
  Model.SpotLoad_D_PQ spotLoad_D_PQcap(
    P1=1000,
    P2=500,
    P3=250,
    V_start=120,
    Q1=250,
    Q2=500,
    Q3=1000)
    annotation (Placement(transformation(extent={{-50,-80},{-30,-60}})));
  Sensor.Model.Probe3ph sens_Dcap(V_nominal=120)
    annotation (Placement(transformation(extent={{10,-80},{-10,-60}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.Line line_Dcap(
    l=1000,
    P_nominal=5000,
    V_nominal=120)
    annotation (Placement(transformation(extent={{40,-80},{20,-60}})));
equation
  connect(sens_Y.terminal_p, spotLoad_Y_PQ.terminal_n)
    annotation (Line(points={{-10,50},{-10,50},{-30,50}}, color={0,120,120}));
  connect(spotLoad_D_PQ.terminal_n, sens_D.terminal_p) annotation (Line(points={
          {-30,-40},{-24,-40},{-10,-40}}, color={0,120,120}));
  connect(grid_Y.terminal, line_Y.terminal_n)
    annotation (Line(points={{60,60},{60,50},{40,50}}, color={0,120,120}));
  connect(line_Y.terminal_p, sens_Y.terminal_n)
    annotation (Line(points={{20,50},{10,50}}, color={0,120,120}));
  connect(sens_D.terminal_n, line_D.terminal_p)
    annotation (Line(points={{10,-40},{20,-40}}, color={0,120,120}));
  connect(line_D.terminal_n, grid_D.terminal)
    annotation (Line(points={{40,-40},{60,-40},{60,-30}}, color={0,120,120}));
  connect(sens_Ycap.terminal_p, spotLoad_Y_PQcap.terminal_n)
    annotation (Line(points={{-10,20},{-10,20},{-30,20}}, color={0,120,120}));
  connect(grid_Y.terminal, line_Ycap.terminal_n)
    annotation (Line(points={{60,60},{60,20},{40,20}}, color={0,120,120}));
  connect(sens_Ycap.terminal_n, line_Ycap.terminal_p)
    annotation (Line(points={{10,20},{14,20},{20,20}}, color={0,120,120}));
  connect(spotLoad_D_PQcap.terminal_n, sens_Dcap.terminal_p) annotation (Line(
        points={{-30,-70},{-30,-70},{-10,-70}}, color={0,120,120}));
  connect(line_Dcap.terminal_n, grid_D.terminal)
    annotation (Line(points={{40,-70},{60,-70},{60,-30}}, color={0,120,120}));
  connect(sens_Dcap.terminal_n, line_Dcap.terminal_p)
    annotation (Line(points={{10,-70},{20,-70}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_SpotLoads;
