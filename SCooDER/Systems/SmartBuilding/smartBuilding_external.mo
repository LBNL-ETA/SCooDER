within SCooDER.Systems.SmartBuilding;
model smartBuilding_external
  parameter Real building_scale = 1 "Building scale";
  parameter Real der_scale = 1 "DER scale";
  parameter Real battery_scale = 1 "Bettery scale";
  parameter Real building_ft2 = 50e3 "Building ft2 scale";
  parameter Real charger_scale = 1 "Charger scale";
  parameter Real use_smartinverter=1 "Flag to use smart inverter";
  parameter String weather_file = "" "Path to weather file";
  // parameter String weather_file = Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos") "Path to weather file";
  parameter Integer n_trans=20 "Number of transport models in system";

  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    relHum=0,
    TDewPoi(displayUnit="K"),
    filNam=weather_file,
    pAtmSou=Buildings.BoundaryConditions.Types.DataSource.File,
    calTSky=Buildings.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
    computeWetBulbTemperature=false)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));

  Components.Photovoltaics.Model.PVModule_simple pv(n=0.004*building_ft2*
        der_scale)
    annotation (Placement(transformation(extent={{0,40},{20,60}})));
  Modelica.Blocks.Sources.Constant ctrl_PV(k=1)
    annotation (Placement(transformation(extent={{-20,40},{-12,48}})));
  Modelica.Blocks.Interfaces.RealOutput P
    annotation (Placement(transformation(extent={{100,20},{120,40}}),
        iconTransformation(extent={{100,20},{120,40}})));
  Components.Battery.Model.Battery battery(
    EMax=battery_scale*5*building_ft2*der_scale,
    Pmax=battery_scale*5/2*building_ft2*der_scale,
    SOC_start=0.1)
    annotation (Placement(transformation(extent={{0,10},{20,30}})));
  Modelica.Blocks.Math.Sum sum1(nin=4)
    annotation (Placement(transformation(extent={{70,40},{90,60}})));
  Modelica.Blocks.Interfaces.RealInput P_set_battery(unit="W", start=0)
    annotation (Placement(transformation(
        origin={-110,20},
        extent={{10,-10},{-10,10}},
        rotation=180), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,70})));
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
    annotation (Placement(transformation(extent={{100,80},{120,100}}),
        iconTransformation(extent={{100,80},{120,100}})));
  Modelica.Blocks.Math.Product costcalc
    annotation (Placement(transformation(extent={{86,76},{94,84}})));
  Modelica.Blocks.Sources.RealExpression P_kW(y=P/1e3)
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Modelica.Blocks.Interfaces.RealInput P_building(unit="W", start=0)
    annotation (Placement(transformation(
        origin={-110,-80},
        extent={{10,-10},{-10,10}},
        rotation=180), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-30})));
  Components.Conversion.Model.PowerOutput building(P=P_building*building_ft2/50e3*
        building_scale)
    annotation (Placement(transformation(extent={{0,-90},{20,-70}})));
  Modelica.Blocks.Interfaces.RealOutput P_pv
    annotation (Placement(transformation(extent={{100,-20},{120,0}}),
        iconTransformation(extent={{100,-20},{120,0}})));
  Components.Conversion.Model.PowerOutput en_vvw(P=use_smartinverter)
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  Modelica.Blocks.Interfaces.RealOutput En_vvw annotation (Placement(
        transformation(extent={{100,-100},{120,-80}}), iconTransformation(
          extent={{100,-100},{120,-80}})));
  Modelica.Blocks.Interfaces.RealInput P_charger[n_trans](each unit="W", each
      start=0) annotation (Placement(transformation(
        origin={-110,-60},
        extent={{10,-10},{-10,10}},
        rotation=180), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-60})));
  Components.Conversion.Model.PowerOutput charger(P=sum(P_charger)*
        charger_scale)
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Blocks.Interfaces.RealOutput P_cha
    annotation (Placement(transformation(extent={{100,-40},{120,-20}}),
        iconTransformation(extent={{100,-40},{120,-20}})));
equation
  connect(pv.weaBus, weaDat.weaBus) annotation (Line(
      points={{0,54},{-30,54},{-30,70},{-80,70}},
      color={255,204,51},
      thickness=0.5));
  connect(ctrl_PV.y,pv. scale) annotation (Line(points={{-11.6,44},{-8,44},{-8,46},
          {-2,46}}, color={0,0,127}));
  connect(sum1.y, P)
    annotation (Line(points={{91,50},{100,50},{100,30},{110,30}},
                                                color={0,0,127}));
  connect(battery.P, sum1.u[2]) annotation (Line(points={{21,20},{60,20},{60,
          49.75},{68,49.75}},
                    color={0,0,127}));
  connect(P_set_battery, battery.PCtrl)
    annotation (Line(points={{-110,20},{-2,20}}, color={0,0,127}));
  connect(pv_inv.y, sum1.u[1]) annotation (Line(points={{40.4,50},{58,50},{58,
          49.25},{68,49.25}},
                         color={0,0,127}));
  connect(pv_inv.u,pv. P)
    annotation (Line(points={{31.2,50},{21,50}}, color={0,0,127}));
  connect(costcalc.u1, tou.y[1]) annotation (Line(points={{85.2,82.4},{72.6,
          82.4},{72.6,90},{61,90}}, color={0,0,127}));
  connect(costcalc.y, cost)
    annotation (Line(points={{94.4,80},{102,80},{102,90},{110,90}},
                                                  color={0,0,127}));
  connect(P_kW.y, costcalc.u2) annotation (Line(points={{61,70},{72.5,70},{
          72.5,77.6},{85.2,77.6}}, color={0,0,127}));
  connect(building.P, sum1.u[3]) annotation (Line(points={{21,-80},{64,-80},{64,
          50.25},{68,50.25}},        color={0,0,127}));
  connect(P_pv, pv_inv.y) annotation (Line(points={{110,-10},{80,-10},{80,32},
          {48,32},{48,50},{40.4,50}},color={0,0,127}));
  connect(en_vvw.P, En_vvw)
    annotation (Line(points={{81,-90},{110,-90}}, color={0,0,127}));
  connect(charger.P, sum1.u[4]) annotation (Line(points={{21,-40},{56,-40},{56,
          52},{62,52},{62,50.75},{68,50.75}},
                      color={0,0,127}));
  connect(charger.P, P_cha) annotation (Line(points={{21,-40},{66,-40},{66,
          -30},{110,-30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
end smartBuilding_external;
