within SCooDER.Systems.IEEE13;
model IEEE13_PV_extBus_simple_oldinv9
  //parameter String weaName = "C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3_CONVERTED.mos" "Path to weather file";
  parameter String weaName = "/home/sim/Documents/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos" "Path to weather file";
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
  Components.Inverter.Model.SpotLoad_Y_PQ_extBus node4 annotation (Placement(
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
        origin={70,46})));
  Components.Inverter.Model.SpotLoad_Y_PQ_extBus node11 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,-10})));
  Components.Inverter.Model.SpotLoad_Y_PQ_extBus node10 annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={42,-16})));
  Components.Inverter.Model.SpotLoad_Y_PQ_extBus node7
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
  Components.Inverter.Model.SpotLoad_Y_PQ_extBus node13 annotation (Placement(transformation(extent={{-20,-90},{0,-70}})));
  Components.Inverter.Interfaces.LoadCtrlBus ctrlNode13 annotation (Placement(
        transformation(extent={{-110,-90},{-90,-70}}), iconTransformation(
          extent={{-140,6},{-120,26}})));
  generic_wye_voltvarwatt_simple inverter13(weaName=weaName)
                                                            annotation (Placement(transformation(extent={{32,-90},{12,-70}})));
  generic_wye_voltvarwatt_simple inverter11(weaName=weaName)
                                                            annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,16})));
  generic_wye_voltvarwatt_simple inverter9(weaName=weaName)
                                                           annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-74,18})));
  generic_wye_voltvarwatt_simple
                      inverter6(weaName=weaName)
                                annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,78})));
  generic_wye_voltvarwatt_simple
                      inverter3(weaName=weaName)
                                annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-50,78})));
  Components.Inverter.Interfaces.InvCtrlBus ctrlInv3 annotation (Placement(
        transformation(extent={{-60,90},{-40,110}}), iconTransformation(extent={
            {-194,18},{-174,38}})));
  Components.Inverter.Interfaces.InvCtrlBus ctrlInv6 annotation (Placement(
        transformation(extent={{80,90},{100,110}}), iconTransformation(extent={{
            -194,18},{-174,38}})));
  Components.Inverter.Interfaces.InvCtrlBus ctrlInv9 annotation (Placement(
        transformation(extent={{-58,8},{-38,28}}), iconTransformation(extent={{-194,
            18},{-174,38}})));
  Components.Inverter.Interfaces.InvCtrlBus ctrlInv11 annotation (Placement(
        transformation(extent={{92,10},{112,30}}), iconTransformation(extent={{-194,
            18},{-174,38}})));
  Components.Inverter.Interfaces.InvCtrlBus ctrlInv13 annotation (Placement(
        transformation(extent={{20,-110},{40,-90}}), iconTransformation(extent={
            {-194,18},{-174,38}})));
equation
  connect(node4.terminal_n, ieee13.terminal[4]) annotation (Line(points={{-90,60},
          {0,60},{0,80},{-1.77636e-015,80}},     color={0,120,120}));
  connect(node3.terminal_n, ieee13.terminal[3]) annotation (Line(points={{-50,
          60},{0,60},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
  connect(node6.terminal_n, ieee13.terminal[6]) annotation (Line(points={{70,56},
          {0,56},{0,80}},         color={0,120,120}));
  connect(node2.terminal_n, ieee13.terminal[2])
    annotation (Line(points={{0,30},{0,30},{0,80}}, color={0,120,120}));
  connect(node7.terminal_n, ieee13.terminal[7])
    annotation (Line(points={{0,-30},{0,-30},{0,80}}, color={0,120,120}));
  connect(node9.terminal_n, ieee13.terminal[9]) annotation (Line(points={{-90,0},
          {0,0},{0,80},{-1.77636e-015,80}}, color={0,120,120}));
  connect(node12.terminal_n, ieee13.terminal[12]) annotation (Line(points={{-40,-80},
          {-40,-80},{-40,0},{0,0},{0,80}},      color={0,120,120}));
  connect(node10.terminal_n, ieee13.terminal[10]) annotation (Line(points={{42,-6},
          {0,-6},{0,80},{-1.77636e-15,80}},    color={0,120,120}));
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
      points={{-100,-50},{42,-50},{42,-26}},
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
      points={{-100,4},{20,4},{20,36},{70,36}},
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
  connect(inverter9.terminal_p, ieee13.terminal[9])
    annotation (Line(points={{-74,7},{8,7},{8,80},{0,80}}, color={0,120,120}));
  connect(inverter6.terminal_p, ieee13.terminal[6])
    annotation (Line(points={{90,67},{90,69},{2,69},{2,80},{-1.77636e-15,80}},
                                               color={0,120,120}));
  connect(inverter3.terminal_p, ieee13.terminal[3])
    annotation (Line(points={{-50,67},{-50,70},{-1.77636e-15,70},{-1.77636e-15,80}},
                                                 color={0,120,120}));
  connect(inverter3.invCtrlBus, ctrlInv3) annotation (Line(
      points={{-50,88},{-50,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(inverter6.invCtrlBus, ctrlInv6) annotation (Line(
      points={{90,88},{90,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(inverter11.invCtrlBus, ctrlInv11) annotation (Line(
      points={{90,26},{96,26},{96,20},{102,20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(inverter13.invCtrlBus, ctrlInv13) annotation (Line(
      points={{32,-80},{26,-80},{26,-100},{30,-100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(inverter11.terminal_p, ieee13.terminal[11])
    annotation (Line(points={{90,5},{90,4},{56,4},{56,80},{-1.77636e-15,80}},
                                              color={0,120,120}));
  connect(inverter13.terminal_p, ieee13.terminal[13])
    annotation (Line(points={{11,-80},{6,-80},{6,80},{0,80}},
                                                color={0,120,120}));
  connect(inverter9.invCtrlBus, ctrlInv9) annotation (Line(
      points={{-74,28},{-62,28},{-62,18},{-48,18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end IEEE13_PV_extBus_simple_oldinv9;
