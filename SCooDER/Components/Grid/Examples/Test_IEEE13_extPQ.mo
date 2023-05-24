within SCooDER.Components.Grid.Examples;
model Test_IEEE13_extPQ
  Model.IEEE13_extPQ iEEE13_extPQ(smartinverter=false)
                                               annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={8,90})));
  Modelica.Blocks.Sources.Sine node4(
    amplitude=50e3,
    freqHz=0.1,
    offset=150e3)                                            annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-45,55})));
  Modelica.Blocks.Sources.Sine node3(
    amplitude=50e3,
    freqHz=0.1,
    offset=150e3) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-15,55})));
  Modelica.Blocks.Sources.Sine node5(
    amplitude=50e3,
    freqHz=0.1,
    offset=150e3) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={15,55})));
  Modelica.Blocks.Sources.Sine node6(
    amplitude=50e3,
    freqHz=0.1,
    offset=150e3) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={45,55})));
  Modelica.Blocks.Sources.Sine node2(
    amplitude=50e3,
    freqHz=0.1,
    offset=150e3) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-5,41})));
  Modelica.Blocks.Sources.Sine node9(
    amplitude=50e3,
    freqHz=0.1,
    offset=150e3) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-45,15})));
  Modelica.Blocks.Sources.Sine node8(
    amplitude=50e3,
    freqHz=0.1,
    offset=150e3) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-15,15})));
  Modelica.Blocks.Sources.Sine node10(
    amplitude=50e3,
    freqHz=0.1,
    offset=150e3) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={15,15})));
  Modelica.Blocks.Sources.Sine node11(
    amplitude=50e3,
    freqHz=0.1,
    offset=150e3) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={45,15})));
  Modelica.Blocks.Sources.Sine node7(
    amplitude=50e3,
    freqHz=0.1,
    offset=150e3) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-5,1})));
  Modelica.Blocks.Sources.Sine node12(
    amplitude=50e3,
    freqHz=0.1,
    offset=150e3) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-35,-19})));
  Modelica.Blocks.Sources.Sine node13(
    amplitude=50e3,
    freqHz=0.1,
    offset=150e3) annotation (
      Placement(transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-5,-19})));
  Modelica.Blocks.Sources.Sine node1(freqHz=0) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=0,
        origin={-15,81})));
  Modelica.Blocks.Sources.RealExpression PV[iEEE13_extPQ.nodes](y=50e3)
    annotation (Placement(transformation(extent={{38,70},{28,80}})));
equation
  connect(iEEE13_extPQ.P_load[3], node3.y)
    annotation (Line(points={{0,79},{0,60.5},{-15,60.5}}, color={0,0,127}));
  connect(iEEE13_extPQ.P_load[4], node4.y)
    annotation (Line(points={{0,79},{0,60.5},{-45,60.5}}, color={0,0,127}));
  connect(iEEE13_extPQ.P_load[5], node5.y)
    annotation (Line(points={{0,79},{0,60.5},{15,60.5}}, color={0,0,127}));
  connect(iEEE13_extPQ.P_load[6], node6.y)
    annotation (Line(points={{0,79},{0,60.5},{45,60.5}}, color={0,0,127}));
  connect(iEEE13_extPQ.P_load[2], node2.y)
    annotation (Line(points={{0,79},{0,60},{0,41},{0.5,41}}, color={0,0,127}));
  connect(iEEE13_extPQ.P_load[8], node8.y) annotation (Line(points={{0,79},{0,20},
          {-8,20},{-8,20.5},{-15,20.5}}, color={0,0,127}));
  connect(node9.y, iEEE13_extPQ.P_load[9]) annotation (Line(points={{-45,20.5},{
          -45,20},{0,20},{0,79}}, color={0,0,127}));
  connect(node10.y, iEEE13_extPQ.P_load[10]) annotation (Line(points={{15,20.5},
          {14,20.5},{14,20},{0,20},{0,79}}, color={0,0,127}));
  connect(node11.y, iEEE13_extPQ.P_load[11]) annotation (Line(points={{45,20.5},
          {44,20.5},{44,20},{0,20},{0,79}}, color={0,0,127}));
  connect(node12.y, iEEE13_extPQ.P_load[12]) annotation (Line(points={{-29.5,-19},
          {-29.5,20},{0,20},{0,79}}, color={0,0,127}));
  connect(node13.y, iEEE13_extPQ.P_load[13]) annotation (Line(points={{0.5,-19},
          {0.5,-20},{-4.44089e-16,-20},{-4.44089e-16,79}}, color={0,0,127}));
  connect(node7.y, iEEE13_extPQ.P_load[7]) annotation (Line(points={{0.5,1},{0.5,
          39.5},{0,39.5},{0,79}}, color={0,0,127}));
  connect(node1.y, iEEE13_extPQ.P_load[1]) annotation (Line(points={{-9.5,81},{-4.75,
          81},{-4.75,79},{0,79}}, color={0,0,127}));
  connect(iEEE13_extPQ.P_pv, PV.y) annotation (Line(points={{12,79},{12,76},{20,
          76},{20,75},{27.5,75}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=15, __Dymola_Algorithm="Dassl"));
end Test_IEEE13_extPQ;
