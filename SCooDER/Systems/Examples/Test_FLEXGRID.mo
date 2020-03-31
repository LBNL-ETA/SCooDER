within SCooDER.Systems.Examples;
model Test_FLEXGRID

  FLEXGRID.FLEXGRID flexgrid
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Modelica.Blocks.Sources.Constant Zero(k=0)
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Sources.Constant One(k=1)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
        rotation=0,
        origin={50,-90})));
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
  Modelica.Blocks.Sources.Constant One1(
                                       k=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,-20})));
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
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon1(
    computeWetBulbTemperature=false, filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader with radiation data obtained from the inputs' connectors"
    annotation (Placement(transformation(extent={{-50,80},{-30,100}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage grid(f=
        60, V=208)
    annotation (Placement(transformation(extent={{80,8},{60,28}})));
  Interfaces.FLEXGRID_interface interface
    annotation (Placement(transformation(extent={{-20,-72},{20,-32}})));
equation
  connect(flexgrid.scale1, One1.y) annotation (Line(points={{-22,4},{-52,4},{
          -52,-20},{-59,-20}}, color={0,0,127}));
  connect(flexgrid.scale2, One1.y) annotation (Line(points={{-22,0},{-52,0},{
          -52,-20},{-59,-20}}, color={0,0,127}));
  connect(flexgrid.scale3, One1.y) annotation (Line(points={{-22,-4},{-52,-4},{
          -52,-20},{-59,-20}}, color={0,0,127}));
  connect(Temperature.y, from_degC.u)
    annotation (Line(points={{-79,90},{-77.2,90}}, color={0,0,127}));
  connect(weaDatInpCon.TDryBul_in, from_degC.y) annotation (Line(points={{-51,
          59},{-51,74.5},{-63.4,74.5},{-63.4,90}}, color={0,0,127}));
  connect(weaDatInpCon.HDifHor_in, DHI.y) annotation (Line(points={{-51,42.4},{
          -59.5,42.4},{-59.5,60},{-79,60}}, color={0,0,127}));
  connect(weaDatInpCon.HDirNor_in, DNI.y) annotation (Line(points={{-51,39},{
          -56,39},{-56,40},{-60,40},{-60,30},{-79,30}}, color={0,0,127}));
  connect(weaDatInpCon1.weaBus, flexgrid.weaBus) annotation (Line(
      points={{-30,90},{-24,90},{-24,16},{-20,16}},
      color={255,204,51},
      thickness=0.5));
  connect(grid.terminal, flexgrid.terminal_p)
    annotation (Line(points={{60,18},{60,18},{22,18}}, color={0,120,120}));
  connect(flexgrid.invCtrlBus1, interface.invCtrlBus1) annotation (Line(
      points={{-10,-20},{-10,-26},{-10,-32}},
      color={255,204,51},
      thickness=0.5));
  connect(flexgrid.invCtrlBus2, interface.invCtrlBus2) annotation (Line(
      points={{0,-20},{0,-26},{0,-32}},
      color={255,204,51},
      thickness=0.5));
  connect(flexgrid.invCtrlBus3, interface.invCtrlBus3) annotation (Line(
      points={{10,-20},{10,-32}},
      color={255,204,51},
      thickness=0.5));
  connect(interface.batt_ctrl1, Zero.y) annotation (Line(points={{-22,-62},{
          -42,-62},{-42,-70},{-59,-70}}, color={0,0,127}));
  connect(interface.batt_ctrl2, Zero.y) annotation (Line(points={{-22,-66},{
          -42,-66},{-42,-70},{-59,-70}}, color={0,0,127}));
  connect(interface.batt_ctrl3, Zero.y)
    annotation (Line(points={{-22,-70},{-59,-70}}, color={0,0,127}));
  connect(One.y, interface.plim3)
    annotation (Line(points={{39,-90},{18,-90},{18,-74}}, color={0,0,127}));
  connect(interface.plim2, One.y) annotation (Line(points={{14,-74},{14,-74},
          {14,-90},{39,-90}}, color={0,0,127}));
  connect(interface.plim1, One.y) annotation (Line(points={{10,-74},{10,-74},
          {10,-90},{39,-90}}, color={0,0,127}));
  connect(interface.q_ctrl1, Zero.y) annotation (Line(points={{-6,-74},{-6,
          -74},{-6,-84},{-42,-84},{-42,-70},{-59,-70}}, color={0,0,127}));
  connect(interface.q_ctrl2, Zero.y) annotation (Line(points={{-2,-74},{-2,
          -74},{-2,-84},{-42,-84},{-42,-70},{-59,-70}}, color={0,0,127}));
  connect(interface.q_ctrl3, Zero.y) annotation (Line(points={{2,-74},{2,-74},
          {2,-84},{-42,-84},{-42,-70},{-59,-70}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
  experiment(StartTime=2.09952e+07, StopTime=2.22039e+07),
  Diagram(coordinateSystem(preserveAspectRatio=false)));
end Test_FLEXGRID;
