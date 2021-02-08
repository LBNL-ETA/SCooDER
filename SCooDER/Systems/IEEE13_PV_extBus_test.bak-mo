within SCooDER.Systems;
model IEEE13_PV_extBus_test
  parameter String weaName = "C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3_CONVERTED.mos" "Path to weather file";

  Components.Grid.Model.Network ieee13(redeclare
      Components.Grid.Records.IEEE_13 grid, V_nominal=4.16e3/sqrt(3))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={0,90})));
  Components.Inverter.Model.SpotLoad_Y_PQ_extBus node3 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,50})));
  Components.Inverter.Model.SpotLoad_D_PQ_extBus node4 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,50})));
  Components.Inverter.Model.SpotLoad_Y_PQ_extBus node2
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  Components.Inverter.Model.SpotLoad_Y_PQ_extBus node6 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,50})));
  Components.Inverter.Model.SpotLoad_Y_PQ_extBus node11 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,-10})));
  Components.Inverter.Model.SpotLoad_D_PQ_extBus node10 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,-10})));
  Components.Inverter.Model.SpotLoad_D_PQ_extBus node7
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Components.Inverter.Model.SpotLoad_Y_PQ_extBus node9 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-90,-10})));
  Components.Inverter.Model.SpotLoad_Y_PQ_extBus node12
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid node1(f=60, V=4.16e3)
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  Components.Inverter.Interfaces.LoadCtrlBus ctrlNode4 annotation (Placement(
        transformation(extent={{-110,4},{-90,24}}), iconTransformation(extent={{
            -140,6},{-120,26}})));
  Components.Inverter.Interfaces.LoadCtrlBus ctrlNode2 annotation (Placement(
        transformation(extent={{-110,24},{-90,44}}), iconTransformation(extent={
            {-140,6},{-120,26}})));
  Components.Inverter.Interfaces.LoadCtrlBus ctrlNode3 annotation (Placement(
        transformation(extent={{-110,14},{-90,34}}), iconTransformation(extent={
            {-140,6},{-120,26}})));
  Components.Inverter.Interfaces.LoadCtrlBus ctrlNode6 annotation (Placement(
        transformation(extent={{-110,-6},{-90,14}}), iconTransformation(extent={
            {-140,6},{-120,26}})));
  Components.Inverter.Interfaces.LoadCtrlBus ctrlNode7 annotation (Placement(
        transformation(extent={{-110,-50},{-90,-30}}), iconTransformation(
          extent={{-140,6},{-120,26}})));
  Components.Inverter.Interfaces.LoadCtrlBus ctrlNode9 annotation (Placement(
        transformation(extent={{-110,-40},{-90,-20}}), iconTransformation(
          extent={{-140,6},{-120,26}})));
  Components.Inverter.Interfaces.LoadCtrlBus ctrlNode10 annotation (Placement(
        transformation(extent={{-110,-60},{-90,-40}}), iconTransformation(
          extent={{-140,6},{-120,26}})));
  Components.Inverter.Interfaces.LoadCtrlBus ctrlNode11 annotation (Placement(
        transformation(extent={{-110,-70},{-90,-50}}), iconTransformation(
          extent={{-140,6},{-120,26}})));
  Components.Inverter.Interfaces.LoadCtrlBus ctrlNode12 annotation (Placement(
        transformation(extent={{-110,-80},{-90,-60}}), iconTransformation(
          extent={{-140,6},{-120,26}})));
  Components.Inverter.Model.SpotLoad_Y_PQ_extBus node13
    annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
  Components.Inverter.Interfaces.LoadCtrlBus ctrlNode13 annotation (Placement(
        transformation(extent={{-110,-90},{-90,-70}}), iconTransformation(
          extent={{-140,6},{-120,26}})));
  generic_wye_voltvar inverter13(weaName=weaName)
    annotation (Placement(transformation(extent={{20,-90},{0,-70}})));
  Components.Inverter.Interfaces.InvCtrlBus ctrlInv13 annotation (Placement(
        transformation(extent={{20,-110},{40,-90}}), iconTransformation(extent={
            {-194,18},{-174,38}})));
equation
  connect(node4.terminal_n, ieee13.terminal[4]) annotation (Line(points={{-90,60},
          {0,60},{0,80},{-1.77636e-015,80}},     color={0,120,120}));
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
  connect(node12.terminal_n, ieee13.terminal[12]) annotation (Line(points={{-40,-80},
          {-40,-80},{-40,0},{0,0},{0,80}},      color={0,120,120}));
  connect(node10.terminal_n, ieee13.terminal[10]) annotation (Line(points={{40,
          0},{0,0},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
  connect(node11.terminal_n, ieee13.terminal[11])
    annotation (Line(points={{90,0},{0,0},{0,80}}, color={0,120,120}));
  connect(node1.terminal, ieee13.terminal[1])
    annotation (Line(points={{50,80},{0,80}},           color={0,120,120}));
  connect(node12.ctrls, ctrlNode12) annotation (Line(
      points={{-60,-80},{-60,-80},{-70,-80},{-70,-70},{-100,-70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(ctrlNode11, node11.ctrls) annotation (Line(
      points={{-100,-60},{90,-60},{90,-20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(ctrlNode10, node10.ctrls) annotation (Line(
      points={{-100,-50},{40,-50},{40,-20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(node9.ctrls, ctrlNode9) annotation (Line(
      points={{-90,-20},{-90,-20},{-90,-30},{-100,-30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(ctrlNode7, node7.ctrls) annotation (Line(
      points={{-100,-40},{-60,-40},{-60,-30},{-20,-30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(ctrlNode6, node6.ctrls) annotation (Line(
      points={{-100,4},{20,4},{20,36},{90,36},{90,40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(ctrlNode2, node2.ctrls) annotation (Line(
      points={{-100,34},{-60,34},{-60,30},{-20,30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(ctrlNode3, node3.ctrls) annotation (Line(
      points={{-100,24},{-50,24},{-50,40},{-50,40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(ctrlNode4, node4.ctrls) annotation (Line(
      points={{-100,14},{-90,14},{-90,40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(node13.terminal_n, ieee13.terminal[13])
    annotation (Line(points={{0,-80},{0,80},{0,80}}, color={0,120,120}));
  connect(node13.ctrls, ctrlNode13) annotation (Line(
      points={{-20,-80},{-28,-80},{-28,-94},{-80,-94},{-80,-80},{-100,-80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(inverter13.terminal_p, ieee13.terminal[13])
    annotation (Line(points={{-1,-80},{0,-80},{0,80},{0,80}},
                                                color={0,120,120}));
  connect(inverter13.invCtrlBus, ctrlInv13) annotation (Line(
      points={{20,-80},{26,-80},{26,-100},{30,-100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end IEEE13_PV_extBus_test;
