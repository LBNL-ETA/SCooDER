within SCooDER.Systems.SmartBuilding;
model smartBuilding
  parameter Real building_scale = 1 "Building scale";
  parameter Real der_scale = 1 "DER scale";
  parameter Real battery_scale = 1 "Bettery scale";
  parameter Real building_ft2 = 50e3 "Building ft2 scale";
  parameter String weather_file = "" "Path to weather file";
  // parameter String weather_file = Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos") "Path to weather file";

  Building_room_Qdirect Building
    annotation (Placement(transformation(extent={{-20,-60},{20,-20}})));
  Modelica.Blocks.Sources.CombiTimeTable intGai(
    table=[0,0,0,60; 3600,0,0,60; 7200,0,0,60; 10800,0,0,60; 14400,0,0,60;
        18000,0,10,70; 21600,10,10,70; 25200,10,30,90; 28800,60,100,240;
        32400,60,100,240; 36000,60,100,240; 39600,60,100,240; 43200,30,90,210;
        46800,60,100,240; 50400,60,100,240; 54000,60,100,240; 57600,60,100,
        240; 61200,40,80,200; 64800,20,50,140; 68400,20,50,140; 72000,10,30,
        100; 75600,10,30,100; 79200,0,10,70; 82800,0,10,70],
    columns={2,3,4},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Table with profiles for lat, rad, conv"
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Sources.CombiTimeTable tint(
    table=[0,0; 3600,0; 7200,0; 10800,0; 14400,0; 18000,0; 21600,0; 25200,0.5;
        28800,0.5; 32400,0.5; 36000,0.5; 39600,1; 43200,1; 46800,1; 50400,0.5;
        54000,0.5; 57600,0.5; 61200,0.5; 64800,0; 72000,0; 75600,0; 79200,0;
        82800,0; 86400,0],
    columns={2},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Table with profiles for EC tinting"
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Blocks.Interfaces.RealInput T_set_heat(unit="K", start=273.15 + 10.0)
    annotation (Placement(transformation(
        origin={-110,-90},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Blocks.Interfaces.RealInput T_set_cool(unit="K", start=273.15 + 30.0)
    annotation (Placement(transformation(
        origin={-110,-70},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    relHum=0,
    TDewPoi(displayUnit="K"),
    filNam=weather_file,
    pAtmSou=Buildings.BoundaryConditions.Types.DataSource.File,
    calTSky=Buildings.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));

  Modelica.Blocks.Sources.CombiTimeTable tset(
    table=[0,26 + 273.15,18 + 273.15; 3600,26 + 273.15,18 + 273.15; 7200,26 + 273.15,
        18 + 273.15; 10800,26 + 273.15,18 + 273.15; 14400,26 + 273.15,18 + 273.15;
        18000,26 + 273.15,18 + 273.15; 21600,26 + 273.15,18 + 273.15; 25200,26 +
        273.15,18 + 273.15; 25200,24 + 273.15,20 + 273.15; 28800,24 + 273.15,20 +
        273.15; 32400,24 + 273.15,20 + 273.15; 36000,24 + 273.15,20 + 273.15; 39600,
        24 + 273.15,20 + 273.15; 43200,24 + 273.15,20 + 273.15; 46800,24 + 273.15,
        20 + 273.15; 50400,24 + 273.15,20 + 273.15; 54000,24 + 273.15,20 + 273.15;
        57600,24 + 273.15,20 + 273.15; 61200,24 + 273.15,20 + 273.15; 61200,26 +
        273.15,18 + 273.15; 64800,26 + 273.15,18 + 273.15; 72000,26 + 273.15,18 +
        273.15; 75600,26 + 273.15,18 + 273.15; 79200,26 + 273.15,18 + 273.15; 82800,
        26 + 273.15,18 + 273.15; 86400,26 + 273.15,18 + 273.15],
    columns={2,3},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Table with profiles for tcool, theat"
    annotation (Placement(transformation(extent={{-92,-90},{-72,-70}})));
  Modelica.Blocks.Sources.RealExpression cool_set(y=if (T_set_cool < tset.y[1])
         and (T_set_cool > tset.y[2]) then T_set_cool else tset.y[1])
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Modelica.Blocks.Sources.Constant Thermostat(k=1)
    annotation (Placement(transformation(extent={{-80,-60},{-72,-52}})));
  Modelica.Blocks.Sources.RealExpression heat_set(y=if (T_set_heat > tset.y[2])
         and (T_set_heat < tset.y[1]) then T_set_heat else tset.y[2])
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
  Modelica.Blocks.Sources.RealExpression Q_room(y=if Building.Q_hvac > 0 then
        Building.Q_hvac/3.5 else -1*Building.Q_hvac/4.0)
    annotation (Placement(transformation(extent={{30,-60},{50,-40}})));
  Components.Photovoltaics.Model.PVModule_simple pv(n=0.012*building_ft2*
        der_scale)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Sources.Constant ctrl_PV(k=1)
    annotation (Placement(transformation(extent={{-20,40},{-12,48}})));
  Modelica.Blocks.Interfaces.RealOutput P
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Components.Battery.Model.Battery battery(
    EMax=battery_scale*2000/150*building_ft2*der_scale,
    Pmax=battery_scale*1000/150*building_ft2*der_scale,
    SOC_start=0.5)
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Modelica.Blocks.Math.Sum sum1(nin=3)
    annotation (Placement(transformation(extent={{70,40},{90,60}})));
  Modelica.Blocks.Interfaces.RealInput P_set_battery(unit="W", start=0)
    annotation (Placement(transformation(
        origin={-110,20},
        extent={{10,-10},{-10,10}},
        rotation=180)));
  Modelica.Blocks.Math.Gain pv_inv(k=-1)
    annotation (Placement(transformation(extent={{32,46},{40,54}})));
  Modelica.Blocks.Sources.CombiTimeTable tou(
    table=[0,0.09496; 3600,0.09496; 7200,0.09496; 10800,0.09496; 14400,
        0.09496; 18000,0.09496; 21600,0.09496; 25200,0.09496; 28800,0.09496;
        28800,0.12656; 32400,0.12656; 36000,0.12656; 39600,0.12656; 43200,
        0.12656; 43200,0.17427; 46800,0.17427; 50400,0.17427; 54000,0.17427;
        57600,0.17427; 61200,0.17427; 61200,0.17427; 64800,0.17427; 64800,
        0.12656; 72000,0.12656; 75600,0.12656; 79200,0.12656; 79200,0.09496;
        82800,0.09496],
    columns={2},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Table with profiles for tou tariff [$/kWh]"
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  Modelica.Blocks.Interfaces.RealOutput cost
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Math.Product costcalc
    annotation (Placement(transformation(extent={{86,76},{94,84}})));
  Modelica.Blocks.Sources.RealExpression P_kW(y=P/1e3)
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Components.Conversion.Model.PowerOutput building(P=(intGai.y[2] + intGai.y[3] +
        Q_room.y)/150*building_ft2*building_scale)
    annotation (Placement(transformation(extent={{30,-80},{50,-60}})));
  Modelica.Blocks.Interfaces.RealOutput P_pv
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
equation
  connect(Building.Q_con, intGai.y[2]) annotation (Line(points={{-22,-44},{-40,-44},
          {-40,-40},{-59,-40}}, color={0,0,127}));
  connect(Building.Q_rad, intGai.y[3])
    annotation (Line(points={{-22,-40},{-59,-40}}, color={0,0,127}));
  connect(Building.Q_lat, intGai.y[1]) annotation (Line(points={{-22,-48},{-40,-48},
          {-40,-40},{-59,-40}}, color={0,0,127}));
  connect(Building.uWin, tint.y[1]) annotation (Line(points={{-22,-34},{-40,-34},
          {-40,-10},{-59,-10}}, color={0,0,127}));
  connect(weaDat.weaBus, Building.weaBus) annotation (Line(
      points={{-80,70},{-30,70},{-30,-30},{-20,-30}},
      color={255,204,51},
      thickness=0.5));
  connect(Building.T_ctrl, Thermostat.y) annotation (Line(points={{-22,-52},{-40,
          -52},{-40,-56},{-71.6,-56}}, color={0,0,127}));
  connect(Building.T_set_cool, cool_set.y) annotation (Line(points={{-22,-55.2},
          {-30,-55.2},{-30,-70},{-39,-70}}, color={0,0,127}));
  connect(Building.T_set_heat, heat_set.y) annotation (Line(points={{-22,-58},{-22,
          -72.6},{-39,-72.6},{-39,-90}}, color={0,0,127}));
  connect(pv.weaBus, weaDat.weaBus) annotation (Line(
      points={{0,54},{-30,54},{-30,70},{-80,70}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrl_PV.y,pv. scale) annotation (Line(points={{-11.6,44},{-8,44},{-8,46},
          {-2,46}}, color={0,0,127}));
  connect(sum1.y, P)
    annotation (Line(points={{91,50},{110,50}}, color={0,0,127}));
  connect(battery.P, sum1.u[2]) annotation (Line(points={{21,20},{60,20},{60,50},
          {68,50}}, color={0,0,127}));
  connect(P_set_battery, battery.PCtrl)
    annotation (Line(points={{-110,20},{-2,20}}, color={0,0,127}));
  connect(pv_inv.y, sum1.u[1]) annotation (Line(points={{40.4,50},{58,50},{58,
          49.3333},{68,49.3333}},
                         color={0,0,127}));
  connect(pv_inv.u,pv. P)
    annotation (Line(points={{31.2,50},{21,50}}, color={0,0,127}));
  connect(costcalc.u1, tou.y[1]) annotation (Line(points={{85.2,82.4},{72.6,
          82.4},{72.6,90},{61,90}}, color={0,0,127}));
  connect(costcalc.y, cost)
    annotation (Line(points={{94.4,80},{110,80}}, color={0,0,127}));
  connect(P_kW.y, costcalc.u2) annotation (Line(points={{61,70},{72.5,70},{
          72.5,77.6},{85.2,77.6}}, color={0,0,127}));
  connect(building.P, sum1.u[3]) annotation (Line(points={{51,-70},{60,-70},{60,
          50.6667},{68,50.6667}},    color={0,0,127}));
  connect(P_pv, pv_inv.y) annotation (Line(points={{110,20},{80,20},{80,30},{
          50,30},{50,50},{40.4,50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
end smartBuilding;
