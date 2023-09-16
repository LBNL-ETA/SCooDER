within SCooDER.Systems.FLEXLAB;
model DigitalTwin_interface

  Components.Inverter.Interfaces.InvCtrlBus invCtrlBus1 annotation (Placement(
        transformation(extent={{-60,90},{-40,110}}),
                                                   iconTransformation(extent={{-60,90},
            {-40,110}})));
  Components.Inverter.Interfaces.InvCtrlBus invCtrlBus2 annotation (Placement(
        transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={
            {-10,90},{10,110}})));
  Components.Inverter.Interfaces.InvCtrlBus invCtrlBus3 annotation (Placement(
        transformation(extent={{40,90},{60,110}}),   iconTransformation(extent={{40,90},
            {60,110}})));
  controlBus extControlBus annotation (Placement(transformation(extent={{-110,
            -30},{-90,-10}}), iconTransformation(extent={{-110,-30},{-90,-10}})));
  powerBus extPowerBus annotation (Placement(transformation(extent={{-110,60},
            {-90,80}}), iconTransformation(extent={{-110,30},{-90,50}})));
  monitoringBus extMonitoringBus annotation (Placement(transformation(extent=
            {{-110,0},{-90,20}}), iconTransformation(extent={{-110,0},{-90,20}})));
  Modelica.Blocks.Interfaces.RealInput usePv annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-110})));
  Modelica.Blocks.Interfaces.RealInput useEv annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,-110})));
  Modelica.Blocks.Interfaces.RealInput useTot annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-110})));
  powerBus outPowerBus annotation (Placement(transformation(extent={{90,64},{
            110,84}}), iconTransformation(extent={{90,30},{110,50}})));
  monitoringBus outMonitoringBus annotation (Placement(transformation(extent=
            {{90,34},{110,54}}), iconTransformation(extent={{90,0},{110,20}})));
  powerBus intPowerBus annotation (Placement(transformation(extent={{90,-50},
            {110,-30}}), iconTransformation(extent={{90,-50},{110,-30}})));
  monitoringBus intMonitoringBus annotation (Placement(transformation(extent={{90,-80},
            {110,-60}}),           iconTransformation(extent={{90,-80},{110,
            -60}})));
  Modelica.Blocks.Logical.GreaterThreshold thrUsePv(threshold=0.5)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-50,-80})));
  Modelica.Blocks.Logical.GreaterThreshold thrUseEv(threshold=0.5)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,-80})));
  Modelica.Blocks.Logical.GreaterThreshold thrUseTot(threshold=0.5)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-80})));
  Modelica.Blocks.Logical.Switch swPv1P
    annotation (Placement(transformation(extent={{-44,52},{-36,60}})));
  Modelica.Blocks.Logical.Switch swPv1Q
    annotation (Placement(transformation(extent={{-44,40},{-36,48}})));
  Modelica.Blocks.Logical.Switch swPv2P
    annotation (Placement(transformation(extent={{6,52},{14,60}})));
  Modelica.Blocks.Logical.Switch swPv2Q
    annotation (Placement(transformation(extent={{6,40},{14,48}})));
  Modelica.Blocks.Logical.Switch swPv3P
    annotation (Placement(transformation(extent={{56,52},{64,60}})));
  Modelica.Blocks.Logical.Switch swPv3Q
    annotation (Placement(transformation(extent={{56,40},{64,48}})));
  Modelica.Blocks.Interfaces.RealInput totP annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,20}), iconTransformation(extent={{-120,80},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput totQ annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,6}), iconTransformation(extent={{-120,60},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput evP annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,0}), iconTransformation(extent={{-120,-60},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput evQ annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,-14}), iconTransformation(extent={{-120,-80},{-100,-60}})));
  Modelica.Blocks.Logical.Switch swTotP
    annotation (Placement(transformation(extent={{40,12},{48,20}})));
  Modelica.Blocks.Logical.Switch swTotQ
    annotation (Placement(transformation(extent={{40,0},{48,8}})));
  Modelica.Blocks.Logical.Switch swEvP
    annotation (Placement(transformation(extent={{0,-8},{8,0}})));
  Modelica.Blocks.Logical.Switch swEvQ
    annotation (Placement(transformation(extent={{0,-20},{8,-12}})));
  Modelica.Blocks.Interfaces.RealOutput evPctrl annotation (Placement(
        transformation(extent={{100,-100},{120,-80}}), iconTransformation(
          extent={{100,-100},{120,-80}})));
  Modelica.Blocks.Interfaces.RealInput evSoc annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-40}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Logical.Switch swBat1Soc
    annotation (Placement(transformation(extent={{-68,12},{-60,20}})));
  Modelica.Blocks.Logical.Switch swBat1Soc1
    annotation (Placement(transformation(extent={{-68,0},{-60,8}})));
  Modelica.Blocks.Logical.Switch swBat1Soc2
    annotation (Placement(transformation(extent={{-68,-12},{-60,-4}})));
  Modelica.Blocks.Logical.Switch swEvSoc
    annotation (Placement(transformation(extent={{-68,-24},{-60,-16}})));
  Modelica.Blocks.Sources.RealExpression plim(y=1.0)
    annotation (Placement(transformation(extent={{-120,88},{-100,108}})));
  Modelica.Blocks.Sources.RealExpression qctrl(y=0.0)
    annotation (Placement(transformation(extent={{-120,74},{-100,94}})));
  Modelica.Blocks.Math.Gain batt_ctrl[3](k=1) annotation (Placement(
        transformation(
        extent={{-5,-5},{5,5}},
        rotation=90,
        origin={-91,51})));
  Modelica.Blocks.Sources.RealExpression battctrl_PLACEHOLDER[3](y=0.0)
    annotation (Placement(transformation(extent={{-130,20},{-110,40}})));
equation
  connect(thrUseTot.u, useTot)
    annotation (Line(points={{30,-92},{30,-110}}, color={0,0,127}));
  connect(thrUseEv.u, useEv)
    annotation (Line(points={{-10,-92},{-10,-110}}, color={0,0,127}));
  connect(thrUsePv.u, usePv)
    annotation (Line(points={{-50,-92},{-50,-110}}, color={0,0,127}));
  connect(swPv1P.u1, invCtrlBus1.p) annotation (Line(points={{-44.8,59.2},{
          -44,59.2},{-44,60},{-49.95,60},{-49.95,100.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(swPv2P.u1, invCtrlBus2.p) annotation (Line(points={{5.2,59.2},{0.05,
          59.2},{0.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swPv3P.u1, invCtrlBus3.p) annotation (Line(points={{55.2,59.2},{56,
          59.2},{56,60},{50.05,60},{50.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(swPv2Q.u1, invCtrlBus2.q) annotation (Line(points={{5.2,47.2},{5.2,
          46.6},{0.05,46.6},{0.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(swPv1Q.u1, invCtrlBus1.q) annotation (Line(points={{-44.8,47.2},{
          -50,47.2},{-50,100.05},{-49.95,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swPv3Q.u1, invCtrlBus3.q) annotation (Line(points={{55.2,47.2},{
          50.05,47.2},{50.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swPv1P.u3, extPowerBus.pv1P) annotation (Line(points={{-44.8,52.8},
          {-56,52.8},{-56,70.05},{-99.95,70.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swPv1Q.u3, extPowerBus.pv1Q) annotation (Line(points={{-44.8,40.8},
          {-56.4,40.8},{-56.4,70.05},{-99.95,70.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swPv2P.u3, extPowerBus.pv2P) annotation (Line(points={{5.2,52.8},{
          -6,52.8},{-6,70.05},{-99.95,70.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swPv2Q.u3, extPowerBus.pv2Q) annotation (Line(points={{5.2,40.8},{
          -6,40.8},{-6,70},{-99.95,70},{-99.95,70.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swPv3P.u3, extPowerBus.pv3P) annotation (Line(points={{55.2,52.8},{
          44,52.8},{44,70.05},{-99.95,70.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swPv3Q.u3, extPowerBus.pv3Q) annotation (Line(points={{55.2,40.8},{
          44,40.8},{44,70.05},{-99.95,70.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swPv1P.y, outPowerBus.pv1P) annotation (Line(points={{-35.6,56},{
          -28,56},{-28,74.05},{100.05,74.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(swPv1Q.y, outPowerBus.pv1Q) annotation (Line(points={{-35.6,44},{
          -28,44},{-28,74.05},{100.05,74.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(swPv2P.y, outPowerBus.pv2P) annotation (Line(points={{14.4,56},{20,
          56},{20,74.05},{100.05,74.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(swPv2Q.y, outPowerBus.pv2Q) annotation (Line(points={{14.4,44},{20,
          44},{20,74.05},{100.05,74.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(swPv3P.y, outPowerBus.pv3P) annotation (Line(points={{64.4,56},{70,
          56},{70,74.05},{100.05,74.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(swPv3Q.y, outPowerBus.pv3Q) annotation (Line(points={{64.4,44},{70,
          44},{70,74.05},{100.05,74.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(thrUsePv.y, swPv1Q.u2) annotation (Line(points={{-50,-69},{-50,44},
          {-44.8,44}}, color={255,0,255}));
  connect(swPv1P.u2, swPv1Q.u2) annotation (Line(points={{-44.8,56},{-48,56},
          {-48,44},{-44.8,44}}, color={255,0,255}));
  connect(swPv2Q.u2, swPv1Q.u2) annotation (Line(points={{5.2,44},{2,44},{2,
          36},{-50,36},{-50,44},{-44.8,44}}, color={255,0,255}));
  connect(swPv2P.u2, swPv1Q.u2) annotation (Line(points={{5.2,56},{2,56},{2,
          36},{-50,36},{-50,44},{-44.8,44}}, color={255,0,255}));
  connect(swPv3P.u2, swPv1Q.u2) annotation (Line(points={{55.2,56},{52,56},{
          52,36},{-50,36},{-50,44},{-44.8,44}}, color={255,0,255}));
  connect(swPv3Q.u2, swPv1Q.u2) annotation (Line(points={{55.2,44},{52,44},{
          52,36},{-50,36},{-50,44},{-44.8,44}}, color={255,0,255}));
  connect(totP, swTotP.u1) annotation (Line(points={{10,20},{28,20},{28,19.2},
          {39.2,19.2}}, color={0,0,127}));
  connect(totQ, swTotQ.u1) annotation (Line(points={{10,6},{28,6},{28,7.2},{
          39.2,7.2}}, color={0,0,127}));
  connect(swTotP.u3, extPowerBus.P) annotation (Line(points={{39.2,12.8},{26,
          12.8},{26,70.05},{-99.95,70.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swTotQ.u3, extPowerBus.Q) annotation (Line(points={{39.2,0.8},{26,
          0.8},{26,70},{-99.95,70},{-99.95,70.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(thrUseTot.y, swTotQ.u2)
    annotation (Line(points={{30,-69},{30,4},{39.2,4}}, color={255,0,255}));
  connect(swTotP.u2, swTotQ.u2) annotation (Line(points={{39.2,16},{30,16},{
          30,4},{39.2,4}}, color={255,0,255}));
  connect(swTotP.y, outPowerBus.P) annotation (Line(points={{48.4,16},{70,16},
          {70,74.05},{100.05,74.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(swTotQ.y, outPowerBus.Q) annotation (Line(points={{48.4,4},{70,4},{
          70,74},{100.05,74},{100.05,74.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(evQ, swEvQ.u1) annotation (Line(points={{-30,-14},{-12,-14},{-12,
          -12.8},{-0.8,-12.8}}, color={0,0,127}));
  connect(evP, swEvP.u1) annotation (Line(points={{-30,0},{-12,0},{-12,-0.8},
          {-0.8,-0.8}}, color={0,0,127}));
  connect(thrUseEv.y, swEvQ.u2) annotation (Line(points={{-10,-69},{-10,-16},
          {-0.8,-16}}, color={255,0,255}));
  connect(swEvP.u2, swEvQ.u2) annotation (Line(points={{-0.8,-4},{-10,-4},{
          -10,-16},{-0.8,-16}}, color={255,0,255}));
  connect(swEvP.u3, extPowerBus.evP) annotation (Line(points={{-0.8,-7.2},{
          -14,-7.2},{-14,70.05},{-99.95,70.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swEvQ.u3, extPowerBus.evQ) annotation (Line(points={{-0.8,-19.2},{
          -14,-19.2},{-14,70.05},{-99.95,70.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swEvP.y, outPowerBus.evP) annotation (Line(points={{8.4,-4},{70,-4},
          {70,74.05},{100.05,74.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(swEvQ.y, outPowerBus.evQ) annotation (Line(points={{8.4,-16},{70,
          -16},{70,74.05},{100.05,74.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(evPctrl, extControlBus.evPctrl) annotation (Line(points={{110,-90},
          {-80,-90},{-80,-19.95},{-99.95,-19.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(totP, intPowerBus.P) annotation (Line(points={{10,20},{34,20},{34,
          82},{80,82},{80,-39.95},{100.05,-39.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(totQ, intPowerBus.Q) annotation (Line(points={{10,6},{34,6},{34,82},
          {80,82},{80,-39.95},{100.05,-39.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(evP, intPowerBus.evP) annotation (Line(points={{-30,0},{-16,0},{-16,
          82},{80,82},{80,-39.95},{100.05,-39.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(evQ, intPowerBus.evQ) annotation (Line(points={{-30,-14},{-16,-14},
          {-16,82},{80,82},{80,-39.95},{100.05,-39.95}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(intPowerBus.pv3P, invCtrlBus3.p) annotation (
    Line(
      points={{100.05,-39.95},{94,-39.95},{94,-40},{80,-40},{80,100.05},{
          50.05,100.05}},
      color={255,204,51},
      thickness=0.5),
    Text(
      string="%first",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right),
    Text(
      string="%second",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(intPowerBus.pv3Q, invCtrlBus3.q) annotation (
    Line(
      points={{100.05,-39.95},{80,-39.95},{80,100.05},{50.05,100.05}},
      color={255,204,51},
      thickness=0.5),
    Text(
      string="%first",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right),
    Text(
      string="%second",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(intPowerBus.pv2P, invCtrlBus2.p) annotation (
    Line(
      points={{100.05,-39.95},{80,-39.95},{80,100.05},{0.05,100.05}},
      color={255,204,51},
      thickness=0.5),
    Text(
      string="%first",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right),
    Text(
      string="%second",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(intPowerBus.pv2Q, invCtrlBus2.q) annotation (
    Line(
      points={{100.05,-39.95},{80,-39.95},{80,100.05},{0.05,100.05}},
      color={255,204,51},
      thickness=0.5),
    Text(
      string="%first",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right),
    Text(
      string="%second",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(intPowerBus.pv1P, invCtrlBus1.p) annotation (
    Line(
      points={{100.05,-39.95},{80,-39.95},{80,100.05},{-49.95,100.05}},
      color={255,204,51},
      thickness=0.5),
    Text(
      string="%first",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right),
    Text(
      string="%second",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(intPowerBus.pv1Q, invCtrlBus1.q) annotation (
    Line(
      points={{100.05,-39.95},{80,-39.95},{80,100.05},{-49.95,100.05}},
      color={255,204,51},
      thickness=0.5),
    Text(
      string="%first",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right),
    Text(
      string="%second",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(swBat1Soc.u1, invCtrlBus1.batt_soc) annotation (Line(points={{-68.8,
          19.2},{-74,19.2},{-74,96},{-50,96},{-50,100.05},{-49.95,100.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swBat1Soc1.u1, invCtrlBus2.batt_soc) annotation (Line(points={{
          -68.8,7.2},{-74,7.2},{-74,96},{0.05,96},{0.05,100.05}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swBat1Soc2.u1, invCtrlBus3.batt_soc) annotation (Line(points={{
          -68.8,-4.8},{-74,-4.8},{-74,96},{50,96},{50,100.05},{50.05,100.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swEvSoc.u1, evSoc) annotation (Line(points={{-68.8,-16.8},{-85.4,
          -16.8},{-85.4,-40},{-110,-40}}, color={0,0,127}));
  connect(swBat1Soc.u3, extMonitoringBus.bess1Soc) annotation (Line(points={{
          -68.8,12.8},{-84,12.8},{-84,10.05},{-99.95,10.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swBat1Soc1.u3, extMonitoringBus.bess2Soc) annotation (Line(points={
          {-68.8,0.8},{-84,0.8},{-84,10},{-99.95,10},{-99.95,10.05}}, color={
          0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swBat1Soc2.u3, extMonitoringBus.bess3Soc) annotation (Line(points={
          {-68.8,-11.2},{-84,-11.2},{-84,10.05},{-99.95,10.05}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swEvSoc.u3, extMonitoringBus.evSoc) annotation (Line(points={{-68.8,
          -23.2},{-84,-23.2},{-84,10},{-99.95,10},{-99.95,10.05}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(thrUsePv.y, swBat1Soc2.u2) annotation (Line(points={{-50,-69},{-50,
          -28},{-76,-28},{-76,-8},{-68.8,-8}}, color={255,0,255}));
  connect(swBat1Soc1.u2, swBat1Soc2.u2) annotation (Line(points={{-68.8,4},{
          -76,4},{-76,-8},{-68.8,-8}}, color={255,0,255}));
  connect(swBat1Soc.u2, swBat1Soc2.u2) annotation (Line(points={{-68.8,16},{
          -76,16},{-76,-8},{-68.8,-8}}, color={255,0,255}));
  connect(swEvSoc.u2, swEvQ.u2) annotation (Line(points={{-68.8,-20},{-72,-20},
          {-72,-40},{-10,-40},{-10,-16},{-0.8,-16}}, color={255,0,255}));
  connect(swBat1Soc.y, outMonitoringBus.bess1Soc) annotation (Line(points={{
          -59.6,16},{-40,16},{-40,30},{88,30},{88,44.05},{100.05,44.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(swBat1Soc1.y, outMonitoringBus.bess2Soc) annotation (Line(points={{
          -59.6,4},{-40,4},{-40,30},{88,30},{88,44},{100.05,44},{100.05,44.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(swBat1Soc2.y, outMonitoringBus.bess3Soc) annotation (Line(points={{
          -59.6,-8},{-54,-8},{-54,-6},{-40,-6},{-40,30},{88,30},{88,44},{
          100.05,44},{100.05,44.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(swEvSoc.y, outMonitoringBus.evSoc) annotation (Line(points={{-59.6,
          -20},{-40,-20},{-40,30},{88,30},{88,44},{100.05,44},{100.05,44.05}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(swBat1Soc.u1, intMonitoringBus.bess1Soc) annotation (Line(points={{-68.8,
          19.2},{-68.8,20},{-72,20},{-72,28},{-34,28},{-34,-60},{80,-60},{80,
          -70},{90,-70},{90,-69.95},{100.05,-69.95}},     color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(swBat1Soc1.u1, intMonitoringBus.bess2Soc) annotation (Line(points={{-68.8,
          7.2},{-72,7.2},{-72,28},{-34,28},{-34,-60},{80,-60},{80,-70},{90,
          -70},{90,-69.95},{100.05,-69.95}},     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swBat1Soc2.u1, intMonitoringBus.bess3Soc) annotation (Line(points={{-68.8,
          -4.8},{-72,-4.8},{-72,28},{-34,28},{-34,-60},{80,-60},{80,-70},{
          100.05,-70},{100.05,-69.95}},       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(swEvSoc.u1, intMonitoringBus.evSoc) annotation (Line(points={{-68.8,
          -16.8},{-72,-16.8},{-72,28},{-34,28},{-34,-60},{80,-60},{80,-70},{
          100.05,-70},{100.05,-69.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(plim.y, invCtrlBus1.plim) annotation (Line(points={{-99,98},{-49.95,
          98},{-49.95,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(plim.y, invCtrlBus2.plim) annotation (Line(points={{-99,98},{0,98},
          {0,100.05},{0.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(plim.y, invCtrlBus3.plim) annotation (Line(points={{-99,98},{50,98},
          {50,100.05},{50.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(qctrl.y, invCtrlBus1.qctrl) annotation (Line(points={{-99,84},{-50,
          84},{-50,100.05},{-49.95,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(qctrl.y, invCtrlBus2.qctrl) annotation (Line(points={{-99,84},{0,84},
          {0,100.05},{0.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(qctrl.y, invCtrlBus3.qctrl) annotation (Line(points={{-99,84},{50,
          84},{50,100.05},{50.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(batt_ctrl[1].y, invCtrlBus1.batt_ctrl) annotation (Line(points={{
          -91,56.5},{-91,92},{-49.95,92},{-49.95,100.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(batt_ctrl[1].y, invCtrlBus2.batt_ctrl) annotation (Line(points={{
          -91,56.5},{-90,56.5},{-90,92},{0.05,92},{0.05,100.05}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(batt_ctrl[3].y, invCtrlBus3.batt_ctrl) annotation (Line(points={{
          -91,56.5},{-91,74},{-92,74},{-92,92},{50,92},{50,100.05},{50.05,
          100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(battctrl_PLACEHOLDER.y, batt_ctrl.u)
    annotation (Line(points={{-109,30},{-91,30},{-91,45}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DigitalTwin_interface;
