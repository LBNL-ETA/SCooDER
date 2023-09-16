within SCooDER.Systems.FLEXLAB;
model DigitalTwin
  FLEXGRID.FLEXGRID flexgrid
    annotation (Placement(transformation(extent={{-20,20},{20,60}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon1(
      computeWetBulbTemperature=false, filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader with radiation data obtained from the inputs' connectors"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Blocks.Sources.RealExpression pvCtrl(y=1)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Components.Grid.Model.VariableGrid
               grid(f=60, V=208)
    annotation (Placement(transformation(extent={{40,70},{60,90}})));
  Modelica.Blocks.Sources.RealExpression voltCtrl[3](each y=120)
    annotation (Placement(transformation(extent={{0,74},{20,94}})));
  Components.Sensor.Model.Probe3ph sens_FLEXLAB(V_nominal=208) annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={38,58})));
  Modelica.Blocks.Math.Sum sumP(nin=3)
    annotation (Placement(transformation(extent={{44,34},{50,40}})));
  Modelica.Blocks.Math.Sum sumQ(nin=3)
    annotation (Placement(transformation(extent={{44,26},{50,32}})));
  DigitalTwin_interface interface
    annotation (Placement(transformation(extent={{-20,-40},{20,0}})));
  controlBus extControlBus annotation (Placement(transformation(extent={{-120,
            -50},{-100,-30}}),iconTransformation(extent={{-120,-50},{-100,-30}})));
  powerBus extPowerBus annotation (Placement(transformation(extent={{-120,0},
            {-100,20}}),iconTransformation(extent={{-110,30},{-90,50}})));
  monitoringBus extMonitoringBus annotation (Placement(transformation(extent={{-160,
            -30},{-140,-10}}),    iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealInput usePv annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-110})));
  Modelica.Blocks.Interfaces.RealInput useEv annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,-110})));
  Modelica.Blocks.Interfaces.RealInput useTot annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-110})));
  powerBus outPowerBus annotation (Placement(transformation(extent={{90,-10},{110,
            10}}),     iconTransformation(extent={{90,52},{110,72}})));
  monitoringBus outMonitoringBus annotation (Placement(transformation(extent={{90,-30},
            {110,-10}}),         iconTransformation(extent={{90,10},{110,30}})));
  powerBus intPowerBus annotation (Placement(transformation(extent={{90,-50},{110,
            -30}}),      iconTransformation(extent={{90,-30},{110,-10}})));
  monitoringBus intMonitoringBus annotation (Placement(transformation(extent={{90,-70},
            {110,-50}}),           iconTransformation(extent={{90,-70},{110,-50}})));
  Components.Battery.Model.Battery ev(
    EMax=24000,
    Pmax=10000,
    SOC_start=0.5)
    annotation (Placement(transformation(extent={{40,-70},{20,-50}})));
  Modelica.Blocks.Sources.RealExpression evQ_int(y=0)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Interfaces.RealInput P annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,132}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput Q annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,118}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput pv1P annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,104}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput pv1Q annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,90}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput pv2P annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,76}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput pv2Q annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,62}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput pv3P annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,48}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput pv3Q annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,34}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput evP annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,20}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput evQ annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,6}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput bess1Soc annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-180,18}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput bess2Soc annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-180,4}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput bess3Soc annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-180,-10}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput evSoc annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-180,-24}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput bess1Pctrl annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,-40}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput bess2Pctrl annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,-54}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput bess3Pctrl annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,-68}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Modelica.Blocks.Interfaces.RealInput evPctrl annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-140,-82}), iconTransformation(extent={{-120,-100},{-100,-80}})));
  Components.Inverter.Model.SpotLoad_Y_PQ_ext evCharger
    annotation (Placement(transformation(extent={{-50,-70},{-70,-50}})));
equation
  connect(weaDatInpCon1.weaBus, flexgrid.weaBus) annotation (Line(
      points={{-60,80},{-40,80},{-40,56},{-20,56}},
      color={255,204,51},
      thickness=0.5));
  connect(pvCtrl.y, flexgrid.scale2)
    annotation (Line(points={{-39,40},{-22,40}}, color={0,0,127}));
  connect(pvCtrl.y, flexgrid.scale1) annotation (Line(points={{-39,40},{-32,
          40},{-32,44},{-22,44}}, color={0,0,127}));
  connect(pvCtrl.y, flexgrid.scale3) annotation (Line(points={{-39,40},{-32,
          40},{-32,36},{-22,36}}, color={0,0,127}));
  connect(voltCtrl.y, grid.V_ext) annotation (Line(points={{21,84},{30,84},{
          30,83},{39,83}}, color={0,0,127}));
  connect(sens_FLEXLAB.Q, sumQ.u) annotation (Line(points={{39,49},{39,38},{
          38,38},{38,28},{43.4,28},{43.4,29}},
                               color={0,0,127}));
  connect(sumP.u, sens_FLEXLAB.P)
    annotation (Line(points={{43.4,37},{41,37},{41,49}},
                                                       color={0,0,127}));
  connect(flexgrid.invCtrlBus1, interface.invCtrlBus1) annotation (Line(
      points={{-10,20},{-10,0}},
      color={255,204,51},
      thickness=0.5));
  connect(flexgrid.invCtrlBus2, interface.invCtrlBus2) annotation (Line(
      points={{0,20},{0,0}},
      color={255,204,51},
      thickness=0.5));
  connect(flexgrid.invCtrlBus3, interface.invCtrlBus3) annotation (Line(
      points={{10,20},{10,0}},
      color={255,204,51},
      thickness=0.5));
  connect(interface.usePv, usePv) annotation (Line(points={{-10,-42},{-10,-80},{
          -30,-80},{-30,-110}}, color={0,0,127}));
  connect(interface.useEv, useEv) annotation (Line(points={{-2,-42},{-2,-88},{-10,
          -88},{-10,-110}}, color={0,0,127}));
  connect(interface.useTot, useTot) annotation (Line(points={{6,-42},{6,-88},{10,
          -88},{10,-110}}, color={0,0,127}));
  connect(extPowerBus, interface.extPowerBus) annotation (Line(
      points={{-110,10},{-80,10},{-80,-12},{-20,-12}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(extMonitoringBus, interface.extMonitoringBus) annotation (Line(
      points={{-150,-20},{-80,-20},{-80,-18},{-20,-18}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(extControlBus, interface.extControlBus) annotation (Line(
      points={{-110,-40},{-80,-40},{-80,-24},{-20,-24}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(interface.outPowerBus, outPowerBus) annotation (Line(
      points={{20,-12},{80,-12},{80,0},{100,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(interface.outMonitoringBus, outMonitoringBus) annotation (Line(
      points={{20,-18},{80,-18},{80,-20},{100,-20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(interface.intPowerBus, intPowerBus) annotation (Line(
      points={{20,-28},{80,-28},{80,-40},{100,-40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(interface.intMonitoringBus, intMonitoringBus) annotation (Line(
      points={{20,-34},{76,-34},{76,-60},{100,-60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(interface.evPctrl, ev.PCtrl) annotation (Line(points={{22,-38},{50,-38},
          {50,-60},{42,-60}}, color={0,0,127}));
  connect(ev.SOC, interface.evSoc) annotation (Line(points={{19,-52},{-30,-52},{
          -30,-38},{-22,-38}}, color={0,0,127}));
  connect(ev.P, interface.evP) annotation (Line(points={{19,-60},{-34,-60},{-34,
          -30},{-22,-30}}, color={0,0,127}));
  connect(evQ_int.y, interface.evQ) annotation (Line(points={{-39,-40},{-32,-40},
          {-32,-34},{-22,-34}}, color={0,0,127}));
  connect(sumP.y, interface.totP) annotation (Line(points={{50.3,37},{54,37},
          {54,12},{-28,12},{-28,-2},{-22,-2}},
                                           color={0,0,127}));
  connect(sumQ.y, interface.totQ) annotation (Line(points={{50.3,29},{52,29},
          {52,14},{-32,14},{-32,-6},{-22,-6}},
                                           color={0,0,127}));
  connect(P, extPowerBus.P) annotation (Line(points={{-140,132},{-120,132},{
          -120,10.05},{-109.95,10.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Q, extPowerBus.Q) annotation (Line(points={{-140,118},{-120,118},{
          -120,10.05},{-109.95,10.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(pv1P, extPowerBus.pv1P) annotation (Line(points={{-140,104},{-120,
          104},{-120,10.05},{-109.95,10.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(pv1Q, extPowerBus.pv1Q) annotation (Line(points={{-140,90},{-120,90},
          {-120,10.05},{-109.95,10.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(pv2P, extPowerBus.pv2P) annotation (Line(points={{-140,76},{-120,76},
          {-120,10.05},{-109.95,10.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(pv2Q, extPowerBus.pv2Q) annotation (Line(points={{-140,62},{-120,62},
          {-120,10.05},{-109.95,10.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(pv3P, extPowerBus.pv3P) annotation (Line(points={{-140,48},{-120,48},
          {-120,10.05},{-109.95,10.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(pv3Q, extPowerBus.pv3Q) annotation (Line(points={{-140,34},{-120,34},
          {-120,10.05},{-109.95,10.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(evP, extPowerBus.evP) annotation (Line(points={{-140,20},{-120,20},
          {-120,10.05},{-109.95,10.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(evQ, extPowerBus.evQ) annotation (Line(points={{-140,6},{-120,6},{
          -120,10.05},{-109.95,10.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bess1Soc, extMonitoringBus.bess1Soc) annotation (Line(points={{-180,
          18},{-160,18},{-160,-19.95},{-149.95,-19.95}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bess2Soc, extMonitoringBus.bess2Soc) annotation (Line(points={{-180,
          4},{-160,4},{-160,-19.95},{-149.95,-19.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bess3Soc, extMonitoringBus.bess3Soc) annotation (Line(points={{-180,
          -10},{-160,-10},{-160,-19.95},{-149.95,-19.95}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(evSoc, extMonitoringBus.evSoc) annotation (Line(points={{-180,-24},
          {-160,-24},{-160,-19.95},{-149.95,-19.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bess1Pctrl, extControlBus.bess1Pctrl) annotation (Line(points={{
          -140,-40},{-124,-40},{-124,-39.95},{-109.95,-39.95}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bess2Pctrl, extControlBus.bess2Pctrl) annotation (Line(points={{
          -140,-54},{-120,-54},{-120,-39.95},{-109.95,-39.95}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bess3Pctrl, extControlBus.bess3Pctrl) annotation (Line(points={{
          -140,-68},{-120,-68},{-120,-39.95},{-109.95,-39.95}}, color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(evPctrl, extControlBus.evPctrl) annotation (Line(points={{-140,-82},
          {-120,-82},{-120,-39.95},{-109.95,-39.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(evQ_int.y, evCharger.Q1) annotation (Line(points={{-39,-40},{-38,
          -40},{-38,-55},{-49,-55}}, color={0,0,127}));
  connect(evQ_int.y, evCharger.P2) annotation (Line(points={{-39,-40},{-38,
          -40},{-38,-55},{-40,-55},{-40,-59},{-49,-59}}, color={0,0,127}));
  connect(evQ_int.y, evCharger.P3) annotation (Line(points={{-39,-40},{-38,
          -40},{-38,-55},{-40,-55},{-40,-66},{-49,-66}}, color={0,0,127}));
  connect(evQ_int.y, evCharger.Q3) annotation (Line(points={{-39,-40},{-38,
          -40},{-38,-55},{-40,-55},{-40,-69},{-49,-69}}, color={0,0,127}));
  connect(evQ_int.y, evCharger.Q2) annotation (Line(points={{-39,-40},{-38,
          -40},{-38,-55},{-40,-55},{-40,-62},{-49,-62}}, color={0,0,127}));
  connect(evCharger.P1, interface.evP) annotation (Line(points={{-49,-52},{
          -34,-52},{-34,-30},{-22,-30}}, color={0,0,127}));
  connect(grid.terminal, sens_FLEXLAB.terminal_n) annotation (Line(points={{
          50,70},{50,64},{50,58},{48,58}}, color={0,120,120}));
  connect(sens_FLEXLAB.terminal_p, flexgrid.terminal_p)
    annotation (Line(points={{28,58},{22,58}}, color={0,120,120}));
  connect(evCharger.terminal_n, flexgrid.terminal_p) annotation (Line(points=
          {{-70,-60},{-76,-60},{-76,64},{22,64},{22,58}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DigitalTwin;
