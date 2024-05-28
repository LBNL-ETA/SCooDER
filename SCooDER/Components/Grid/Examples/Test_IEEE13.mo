within SCooDER.Components.Grid.Examples;
model Test_IEEE13
  extends Modelica.Icons.Example;

  Model.Network ieee13(                  redeclare Records.IEEE_13 grid,
      V_nominal=4.16e3/sqrt(3))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,90})));
  Inverter.Model.SpotLoad_Y_PQ node3(
    P1=0,
    Q1=0,
    P2=170e3,
    Q2=125e3,
    P3=0,
    Q3=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,50})));
  Inverter.Model.SpotLoad_D_PQ node4(
    P1=0,
    Q1=0,
    P2=230e3,
    Q2=132e3,
    P3=0,
    Q3=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,50})));
  Inverter.Model.SpotLoad_Y_PQ node2(
    P1=17e3,
    Q1=10e3,
    P2=66e3,
    Q2=38e3,
    P3=117e3,
    Q3=68e3) annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Inverter.Model.SpotLoad_Y_PQ node6(
    P1=160e3,
    Q1=110e3,
    P2=120e3,
    Q2=90e3,
    P3=120e3,
    Q3=90e3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,50})));
  Inverter.Model.SpotLoad_Y_PQ node11(
    P1=485e3,
    Q1=190e3,
    P2=68e3,
    Q2=60e3,
    P3=290e3,
    Q3=212e3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,-10})));
  Inverter.Model.SpotLoad_D_PQ node10(
    P1=0,
    Q1=0,
    P2=0,
    Q2=0,
    P3=170e3,
    Q3=151e3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,-10})));
  Inverter.Model.SpotLoad_D_PQ node7(
    P1=385e3,
    Q1=220e3,
    P2=385e3,
    Q2=220e3,
    P3=385e3,
    Q3=220e3) annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Inverter.Model.SpotLoad_Y_PQ node9(
    P1=0,
    Q1=0,
    P2=0,
    Q2=0,
    P3=170e3,
    Q3=80e3) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-10})));
  Inverter.Model.SpotLoad_Y_PQ node12(
    P1=128e3,
    Q1=86e3,
    P2=0,
    Q2=0,
    P3=0,
    Q3=0) annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid node1(f=60, V=4.16e3)
    annotation (Placement(transformation(extent={{-60,80},{-40,100}})));
equation
  connect(node4.terminal_n, ieee13.terminal[4]) annotation (Line(points={{-90,
          60},{0,60},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
  connect(node3.terminal_n, ieee13.terminal[3]) annotation (Line(points={{-50,
          60},{0,60},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
  connect(node6.terminal_n, ieee13.terminal[6]) annotation (Line(points={{90,60},
          {46,60},{0,60},{0,80}}, color={0,120,120}));
  connect(node2.terminal_n, ieee13.terminal[2])
    annotation (Line(points={{0,30},{0,30},{0,80}}, color={0,120,120}));
  connect(node7.terminal_n, ieee13.terminal[7])
    annotation (Line(points={{0,-30},{0,-30},{0,80}}, color={0,120,120}));
  connect(node9.terminal_n, ieee13.terminal[9]) annotation (Line(points={{-90,0},
          {0,0},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
  connect(node12.terminal_n, ieee13.terminal[12]) annotation (Line(points={{-40,
          -70},{-40,-70},{-40,0},{0,0},{0,80}}, color={0,120,120}));
  connect(node10.terminal_n, ieee13.terminal[10]) annotation (Line(points={{40,
          0},{0,0},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
  connect(node11.terminal_n, ieee13.terminal[11])
    annotation (Line(points={{90,0},{0,0},{0,80}}, color={0,120,120}));
  connect(node1.terminal, ieee13.terminal[1])
    annotation (Line(points={{-50,80},{-26,80},{0,80}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_IEEE13;
