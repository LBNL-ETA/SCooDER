within SCooDER.Systems.FLEXGRID;
model FLEXGRID_direct_wye_FMU

  FLEXGRID_direct_wye flexgrid
    annotation (Placement(transformation(extent={{-20,20},{20,60}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon1(
    computeWetBulbTemperature=false, filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader with radiation data obtained from the inputs' connectors"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Blocks.Interfaces.RealInput scale3(start=1,
    min=0,
    max=1,
    unit="1") "Shading of PV module" annotation (Placement(transformation(
        origin={-110,12},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-20})));
  Modelica.Blocks.Interfaces.RealInput scale1(start=1,
    min=0,
    max=1,
    unit="1") "Shading of PV module" annotation (Placement(transformation(
        origin={-110,40},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,20})));
  Modelica.Blocks.Interfaces.RealInput scale2(start=1,
    min=0,
    max=1,
    unit="1") "Shading of PV module" annotation (Placement(transformation(
        origin={-110,26},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,0})));
  Modelica.Blocks.Interfaces.RealInput batt_ctrl3(start=0, unit="W")
    "Battery Power" annotation (Placement(transformation(
        origin={-110,-88},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-88})));
  Modelica.Blocks.Interfaces.RealInput batt_ctrl1(start=0, unit="W")
    "Battery Power" annotation (Placement(transformation(
        origin={-110,-60},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-50})));
  Modelica.Blocks.Interfaces.RealInput batt_ctrl2(start=0, unit="W")
    "Battery Power" annotation (Placement(transformation(
        origin={-110,-74},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-70})));
  Modelica.Blocks.Interfaces.RealInput q_ctrl1(start=0, unit="var") "Reactive power control of inverter." annotation (Placement(transformation(
        origin={12,-110},
        extent={{10,10},{-10,-10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-110})));
  Modelica.Blocks.Interfaces.RealInput q_ctrl2(start=0, unit="var") "Reactive power control of inverter." annotation (Placement(transformation(
        origin={26,-110},
        extent={{10,10},{-10,-10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,-110})));
  Modelica.Blocks.Interfaces.RealInput q_ctrl3(start=0, unit="var") "Reactive power control of inverter." annotation (Placement(
        transformation(
        origin={40,-110},
        extent={{10,10},{-10,-10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-110})));
  Modelica.Blocks.Interfaces.RealInput plim3(
    start=1,
    min=0,
    max=1,
    unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
        origin={94,-110},
        extent={{10,10},{-10,-10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,-110})));
  Modelica.Blocks.Interfaces.RealInput plim2(
    start=1,
    min=0,
    max=1,
    unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
        origin={80,-110},
        extent={{10,10},{-10,-10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,-110})));
  Modelica.Blocks.Interfaces.RealInput plim1(
    start=1,
    min=0,
    max=1,
    unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
        origin={66,-110},
        extent={{10,10},{-10,-10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-110})));
  SCooDER.Systems.Interfaces.FLEXGRID_interface interface
    annotation (Placement(transformation(extent={{-20,-30},{20,10}})));
  Components.uPMU.Model.uPMUSource_3ph source
    annotation (Placement(transformation(extent={{60,48},{40,68}})));
  Modelica.Blocks.Interfaces.RealInput V1(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,80}),  iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,90})));
  Modelica.Blocks.Interfaces.RealInput f1(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,66}),  iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,70})));
  Modelica.Blocks.Interfaces.RealInput V2(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,50}),  iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,50})));
  Modelica.Blocks.Interfaces.RealInput f2(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,30}),  iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,30})));
  Modelica.Blocks.Interfaces.RealInput V3(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,0}),   iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,10})));
  Modelica.Blocks.Interfaces.RealInput f3(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-10}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={110,-10})));
equation
  connect(weaDatInpCon1.weaBus, flexgrid.weaBus) annotation (Line(
      points={{-60,80},{-30,80},{-30,56},{-20,56}},
      color={255,204,51},
      thickness=0.5));
  connect(flexgrid.invCtrlBus1, interface.invCtrlBus1) annotation (Line(
      points={{-10,20},{-10,10}},
      color={255,204,51},
      thickness=0.5));
  connect(flexgrid.invCtrlBus2, interface.invCtrlBus2) annotation (Line(
      points={{0,20},{0,10}},
      color={255,204,51},
      thickness=0.5));
  connect(flexgrid.invCtrlBus3, interface.invCtrlBus3) annotation (Line(
      points={{10,20},{10,10}},
      color={255,204,51},
      thickness=0.5));
  connect(interface.batt_ctrl2, batt_ctrl2) annotation (Line(points={{-22,-24},
          {-80,-24},{-80,-74},{-110,-74}}, color={0,0,127}));
  connect(interface.batt_ctrl3, batt_ctrl3) annotation (Line(points={{-22,-28},
          {-76,-28},{-76,-88},{-110,-88}}, color={0,0,127}));
  connect(plim1, interface.plim1) annotation (Line(points={{66,-110},{66,-86},{
          10,-86},{10,-32}}, color={0,0,127}));
  connect(plim2, interface.plim2) annotation (Line(points={{80,-110},{80,-84},{
          14,-84},{14,-32}}, color={0,0,127}));
  connect(plim3, interface.plim3) annotation (Line(points={{94,-110},{94,-110},
          {94,-82},{18,-82},{18,-32}}, color={0,0,127}));
  connect(scale1, flexgrid.scale1) annotation (Line(points={{-110,40},{-84,40},
          {-84,44},{-22,44}}, color={0,0,127}));
  connect(scale2, flexgrid.scale2) annotation (Line(points={{-110,26},{-80,26},
          {-80,40},{-22,40}}, color={0,0,127}));
  connect(scale3, flexgrid.scale3) annotation (Line(points={{-110,12},{-76,12},
          {-76,36},{-22,36}}, color={0,0,127}));
  connect(batt_ctrl1, interface.batt_ctrl1) annotation (Line(points={{-110,-60},
          {-84,-60},{-84,-20},{-22,-20}}, color={0,0,127}));
  connect(flexgrid.terminal_p, source.terminal)
    annotation (Line(points={{22,58},{31,58},{40,58}}, color={0,120,120}));
  connect(V1, source.V1) annotation (Line(points={{110,80},{80,80},{80,67},{61,
          67}}, color={0,0,127}));
  connect(f1, source.f1)
    annotation (Line(points={{110,66},{61,66},{61,65}}, color={0,0,127}));
  connect(V2, source.V2) annotation (Line(points={{110,50},{86,50},{86,61},{61,
          61}}, color={0,0,127}));
  connect(f2, source.f2) annotation (Line(points={{110,30},{84,30},{84,59},{61,
          59}}, color={0,0,127}));
  connect(V3, source.V3) annotation (Line(points={{110,0},{82,0},{82,55},{61,55}},
        color={0,0,127}));
  connect(f3, source.f3) annotation (Line(points={{110,-10},{80,-10},{80,53},{
          61,53}}, color={0,0,127}));
  connect(interface.q_ctrl1, q_ctrl1) annotation (Line(points={{-6,-32},{-6,-32},
          {-6,-94},{12,-94},{12,-110}},           color={0,0,127}));
  connect(interface.q_ctrl2, q_ctrl2) annotation (Line(points={{-2,-32},{-2,-32},
          {-2,-92},{26,-92},{26,-110}},           color={0,0,127}));
  connect(interface.q_ctrl3, q_ctrl3) annotation (Line(points={{2,-32},{2,-32},
          {2,-34},{2,-90},{40,-90},{40,-110}},                   color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
  experiment(StartTime=2.09952e+07, StopTime=2.22039e+07),
  Diagram(coordinateSystem(preserveAspectRatio=false)));
end FLEXGRID_direct_wye_FMU;
