within SCooDER.Systems.FLEXLAB;
package Examples
  extends Modelica.Icons.ExamplesPackage;

  model Test_FLEXLAB

    Modelica.Blocks.Sources.Constant Temperature(k=22)
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    Modelica.Blocks.Sources.Sine DHI(
      freqHz=1/(60*60*12),
      offset=100,
      amplitude=1000,
      phase=-1.5707963267949)
      annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
    Modelica.Blocks.Sources.Sine DNI(
      amplitude=500,
      offset=500,
      freqHz=1/(60*60*12),
      phase=-1.5707963267949)
      annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon(
      computeWetBulbTemperature=false,
      HSou=Buildings.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HDifHor,
      TDryBulSou=Buildings.BoundaryConditions.Types.DataSource.Input,
      filNam=Modelica.Utilities.Files.loadResource(
          "modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
      "Weather data reader with radiation data obtained from the inputs' connectors"
      annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
    Modelica.Blocks.Math.UnitConversions.From_degC from_degC
      annotation (Placement(transformation(extent={{-76,84},{-64,96}})));
    DigitalTwin digitalTwin
      annotation (Placement(transformation(extent={{-20,-40},{20,0}})));
    Modelica.Blocks.Sources.RealExpression ev_pset(y=0)
      annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
    Modelica.Blocks.Sources.RealExpression batt_pset(y=0)
      annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
    Buildings.BoundaryConditions.WeatherData.Bus controlBus annotation (
        Placement(transformation(extent={{-70,-30},{-50,-10}}),
          iconTransformation(extent={{-110,-10},{-90,10}})));
  equation
    connect(Temperature.y, from_degC.u)
      annotation (Line(points={{-79,90},{-77.2,90}}, color={0,0,127}));
    connect(weaDatInpCon.TDryBul_in, from_degC.y) annotation (Line(points={{-51,
            59},{-51,74.5},{-63.4,74.5},{-63.4,90}}, color={0,0,127}));
    connect(weaDatInpCon.HDifHor_in, DHI.y) annotation (Line(points={{-51,42.4},{
            -59.5,42.4},{-59.5,60},{-79,60}}, color={0,0,127}));
    connect(weaDatInpCon.HDirNor_in, DNI.y) annotation (Line(points={{-51,39},{
            -56,39},{-56,40},{-60,40},{-60,30},{-79,30}}, color={0,0,127}));
    connect(controlBus, digitalTwin.controlBus) annotation (Line(
        points={{-60,-20},{-20,-20}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(ev_pset.y, controlBus.evCtrl) annotation (Line(points={{-79,-10},
            {-70,-10},{-70,-20},{-60,-20}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(batt_pset.y, controlBus.bess1Ctrl) annotation (Line(points={{-79,
            -30},{-70,-30},{-70,-20},{-60,-20}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(batt_pset.y, controlBus.bess2Ctrl) annotation (Line(points={{-79,
            -30},{-70,-30},{-70,-20},{-60,-20}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(batt_pset.y, controlBus.bess3Ctrl) annotation (Line(points={{-79,
            -30},{-70,-30},{-70,-20},{-60,-20}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
    experiment(StartTime=2.09952e+07, StopTime=2.22039e+07),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
  end Test_FLEXLAB;

  model Test_FLEXLAB_ext

    Modelica.Blocks.Sources.Constant Temperature(k=22)
      annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
    Modelica.Blocks.Sources.Sine DHI(
      freqHz=1/(60*60*12),
      offset=100,
      amplitude=1000,
      phase=-1.5707963267949)
      annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
    Modelica.Blocks.Sources.Sine DNI(
      amplitude=500,
      offset=500,
      freqHz=1/(60*60*12),
      phase=-1.5707963267949)
      annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon(
      computeWetBulbTemperature=false,
      HSou=Buildings.BoundaryConditions.Types.RadiationDataSource.Input_HDirNor_HDifHor,
      TDryBulSou=Buildings.BoundaryConditions.Types.DataSource.Input,
      filNam=Modelica.Utilities.Files.loadResource(
          "modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
      "Weather data reader with radiation data obtained from the inputs' connectors"
      annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
    Modelica.Blocks.Math.UnitConversions.From_degC from_degC
      annotation (Placement(transformation(extent={{-76,84},{-64,96}})));
    DigitalTwin digitalTwin
      annotation (Placement(transformation(extent={{40,-40},{80,0}})));
    Modelica.Blocks.Sources.Step use_int(
      height=-1,
      offset=1,
      startTime(displayUnit="h") = 43200)
      annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
    Modelica.Blocks.Sources.RealExpression ext_power(y=5000)
      annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
    powerBus extPowerBus annotation (Placement(transformation(extent={{-20,
              -20},{0,0}}), iconTransformation(extent={{-164,-16},{-144,4}})));
    monitoringBus extMonitoringBus annotation (Placement(transformation(
            extent={{-20,-40},{0,-20}}), iconTransformation(extent={{-162,-28},
              {-142,-8}})));
    SCooDER.Systems.FLEXLAB.controlBus extControlBus annotation (Placement(
          transformation(extent={{-20,-60},{0,-40}}), iconTransformation(
            extent={{-162,-36},{-142,-16}})));
    Modelica.Blocks.Sources.RealExpression ext_monitoring(y=0.55)
      annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
    Modelica.Blocks.Sources.RealExpression ext_control(y=0)
      annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  equation
    connect(Temperature.y, from_degC.u)
      annotation (Line(points={{-79,90},{-77.2,90}}, color={0,0,127}));
    connect(weaDatInpCon.TDryBul_in, from_degC.y) annotation (Line(points={{-51,
            59},{-51,74.5},{-63.4,74.5},{-63.4,90}}, color={0,0,127}));
    connect(weaDatInpCon.HDifHor_in, DHI.y) annotation (Line(points={{-51,42.4},{
            -59.5,42.4},{-59.5,60},{-79,60}}, color={0,0,127}));
    connect(weaDatInpCon.HDirNor_in, DNI.y) annotation (Line(points={{-51,39},{
            -56,39},{-56,40},{-60,40},{-60,30},{-79,30}}, color={0,0,127}));
    connect(use_int.y, digitalTwin.usePv) annotation (Line(points={{41,-60},{
            54,-60},{54,-42}}, color={0,0,127}));
    connect(digitalTwin.useEv, use_int.y) annotation (Line(points={{58,-42},{
            58,-60},{41,-60}}, color={0,0,127}));
    connect(digitalTwin.useTot, use_int.y) annotation (Line(points={{62,-42},
            {62,-60},{41,-60}}, color={0,0,127}));
    connect(extPowerBus, digitalTwin.extPowerBus) annotation (Line(
        points={{-10,-10},{0,-10},{0,-12},{40,-12}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(extMonitoringBus, digitalTwin.extMonitoringBus) annotation (Line(
        points={{-10,-30},{0,-30},{0,-20},{40,-20}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(extControlBus, digitalTwin.extControlBus) annotation (Line(
        points={{-10,-50},{4,-50},{4,-28},{38,-28}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(ext_power.y, extPowerBus.P) annotation (Line(points={{-59,-10},{
            -34,-10},{-34,-9.95},{-9.95,-9.95}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ext_power.y, extPowerBus.Q) annotation (Line(points={{-59,-10},{
            -34,-10},{-34,-9.95},{-9.95,-9.95}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ext_power.y, extPowerBus.pv1P) annotation (Line(points={{-59,-10},
            {-34,-10},{-34,-9.95},{-9.95,-9.95}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ext_power.y, extPowerBus.pv1Q) annotation (Line(points={{-59,-10},
            {-34,-10},{-34,-9.95},{-9.95,-9.95}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ext_power.y, extPowerBus.pv2P) annotation (Line(points={{-59,-10},
            {-34,-10},{-34,-9.95},{-9.95,-9.95}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ext_power.y, extPowerBus.pv2Q) annotation (Line(points={{-59,-10},
            {-34,-10},{-34,-9.95},{-9.95,-9.95}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ext_power.y, extPowerBus.pv3P) annotation (Line(points={{-59,-10},
            {-34,-10},{-34,-9.95},{-9.95,-9.95}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ext_power.y, extPowerBus.pv3Q) annotation (Line(points={{-59,-10},
            {-34,-10},{-34,-9.95},{-9.95,-9.95}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ext_power.y, extPowerBus.evP) annotation (Line(points={{-59,-10},
            {-34,-10},{-34,-9.95},{-9.95,-9.95}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ext_power.y, extPowerBus.evQ) annotation (Line(points={{-59,-10},
            {-34,-10},{-34,-9.95},{-9.95,-9.95}}, color={0,0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ext_monitoring.y, extMonitoringBus.bess1Soc) annotation (Line(
          points={{-59,-30},{-34,-30},{-34,-29.95},{-9.95,-29.95}}, color={0,
            0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ext_monitoring.y, extMonitoringBus.bess2Soc) annotation (Line(
          points={{-59,-30},{-34,-30},{-34,-29.95},{-9.95,-29.95}}, color={0,
            0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ext_monitoring.y, extMonitoringBus.bess3Soc) annotation (Line(
          points={{-59,-30},{-34,-30},{-34,-29.95},{-9.95,-29.95}}, color={0,
            0,127}), Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ext_monitoring.y, extMonitoringBus.evSoc) annotation (Line(points=
           {{-59,-30},{-34,-30},{-34,-29.95},{-9.95,-29.95}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ext_control.y, extControlBus.bess1Pctrl) annotation (Line(points=
            {{-59,-50},{-34,-50},{-34,-49.95},{-9.95,-49.95}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ext_control.y, extControlBus.bess2Pctrl) annotation (Line(points=
            {{-59,-50},{-34,-50},{-34,-49.95},{-9.95,-49.95}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ext_control.y, extControlBus.bess3Pctrl) annotation (Line(points=
            {{-59,-50},{-34,-50},{-34,-49.95},{-9.95,-49.95}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    connect(ext_control.y, extControlBus.evPctrl) annotation (Line(points={{
            -59,-50},{-34,-50},{-34,-49.95},{-9.95,-49.95}}, color={0,0,127}),
        Text(
        string="%second",
        index=1,
        extent={{6,3},{6,3}},
        horizontalAlignment=TextAlignment.Left));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, __Dymola_Algorithm="Dassl"),
    Diagram(coordinateSystem(preserveAspectRatio=false)));
  end Test_FLEXLAB_ext;
end Examples;
