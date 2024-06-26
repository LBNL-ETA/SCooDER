within SCooDER.Components.Grid.Examples;
model Test_IEEE13_extPQ
  extends Modelica.Icons.Example;
  Model.IEEE13_extPQ iEEE13_extPQ(smartinverter=true, VoltVarWatt(each QMaxInd=
          50e4, each QMaxCap=50e4))                   annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={8,90})));
  Modelica.Blocks.Sources.Sine node4(
    amplitude=1e5,
    f=0.1,
    offset=-1e5) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-45,55})));
  Modelica.Blocks.Sources.Sine node3(
    amplitude=1e5,
    f=0.1,
    offset=-1e5) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-15,55})));
  Modelica.Blocks.Sources.Sine node5(
    amplitude=1e5,
    f=0.1,
    offset=-1e5) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={15,55})));
  Modelica.Blocks.Sources.Sine node6(
    amplitude=1e5,
    f=0.1,
    offset=-1e5) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={45,55})));
  Modelica.Blocks.Sources.Sine node2(
    amplitude=1e5,
    f=0.1,
    offset=-1e5) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-5,41})));
  Modelica.Blocks.Sources.Sine node9(
    amplitude=1e5,
    f=0.1,
    offset=-1e5) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-45,15})));
  Modelica.Blocks.Sources.Sine node8(
    amplitude=1e5,
    f=0.1,
    offset=-1e5) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-15,15})));
  Modelica.Blocks.Sources.Sine node10(
    amplitude=1e5,
    f=0.1,
    offset=-1e5) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={15,15})));
  Modelica.Blocks.Sources.Sine node11(
    amplitude=1e5,
    f=0.1,
    offset=-1e5) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={45,15})));
  Modelica.Blocks.Sources.Sine node7(
    amplitude=1e5,
    f=0.1,
    offset=-1e5) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-5,1})));
  Modelica.Blocks.Sources.Sine node12(
    amplitude=1e5,
    f=0.1,
    offset=-1e5) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-35,-19})));
  Modelica.Blocks.Sources.Sine node13(
    amplitude=1e5,
    f=0.1,
    offset=-1e5) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-5,-19})));
  Modelica.Blocks.Sources.Sine node1(f=0) annotation (Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-15,81})));
  Modelica.Blocks.Sources.RealExpression PV[iEEE13_extPQ.nodes](y=-1e5*1)
    annotation (Placement(transformation(extent={{38,62},{28,72}})));
  Modelica.Blocks.Sources.RealExpression SmartInv[iEEE13_extPQ.nodes](y=1)
    annotation (Placement(transformation(extent={{38,72},{28,82}})));
  Modelica.Blocks.Sources.RealExpression P_cha[iEEE13_extPQ.nodes](y=0)
    annotation (Placement(transformation(extent={{68,68},{58,78}})));
equation
  connect(iEEE13_extPQ.P_load[3], node3.y)
    annotation (Line(points={{5,79},{5,60.5},{-15,60.5}}, color={0,0,127}));
  connect(iEEE13_extPQ.P_load[4], node4.y)
    annotation (Line(points={{5,79},{5,60.5},{-45,60.5}}, color={0,0,127}));
  connect(iEEE13_extPQ.P_load[5], node5.y)
    annotation (Line(points={{5,79},{5,60.5},{15,60.5}}, color={0,0,127}));
  connect(iEEE13_extPQ.P_load[6], node6.y)
    annotation (Line(points={{5,79},{5,60.5},{45,60.5}}, color={0,0,127}));
  connect(iEEE13_extPQ.P_load[2], node2.y)
    annotation (Line(points={{5,79},{5,60},{5,41},{0.5,41}}, color={0,0,127}));
  connect(iEEE13_extPQ.P_load[8], node8.y) annotation (Line(points={{5,79},{5,20},
          {-8,20},{-8,20.5},{-15,20.5}}, color={0,0,127}));
  connect(node9.y, iEEE13_extPQ.P_load[9]) annotation (Line(points={{-45,20.5},{
          -45,20},{5,20},{5,79}}, color={0,0,127}));
  connect(node10.y, iEEE13_extPQ.P_load[10]) annotation (Line(points={{15,20.5},
          {14,20.5},{14,20},{5,20},{5,79}}, color={0,0,127}));
  connect(node11.y, iEEE13_extPQ.P_load[11]) annotation (Line(points={{45,20.5},
          {44,20.5},{44,20},{5,20},{5,79}}, color={0,0,127}));
  connect(node12.y, iEEE13_extPQ.P_load[12]) annotation (Line(points={{-29.5,-19},
          {-29.5,20},{5,20},{5,79}}, color={0,0,127}));
  connect(node13.y, iEEE13_extPQ.P_load[13]) annotation (Line(points={{0.5,-19},
          {0.5,-20},{5,-20},{5,79}},                       color={0,0,127}));
  connect(node7.y, iEEE13_extPQ.P_load[7]) annotation (Line(points={{0.5,1},{0.5,
          39.5},{5,39.5},{5,79}}, color={0,0,127}));
  connect(node1.y, iEEE13_extPQ.P_load[1]) annotation (Line(points={{-9.5,81},{-4.75,
          81},{-4.75,79},{5,79}}, color={0,0,127}));
  connect(iEEE13_extPQ.P_pv, PV.y) annotation (Line(points={{9,79},{9,76},{8,76},
          {8,66},{18,66},{18,67},{27.5,67}},
                                  color={0,0,127}));
  connect(SmartInv.y, iEEE13_extPQ.En_vvw) annotation (Line(points={{27.5,77},{
          18,77},{18,79},{17,79}}, color={0,0,127}));
  connect(P_cha.y, iEEE13_extPQ.P_cha) annotation (Line(points={{57.5,73},{10.75,
          73},{10.75,79},{11,79}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=15, __Dymola_Algorithm="Dassl"));
end Test_IEEE13_extPQ;
