within SCooDER.Systems;
package SmartBuilding
  model smartBuilding
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
    Components.Photovoltaics.Model.PVModule_simple PV(n=0.012*building_ft2, lat=
          weaDat.lat)
      annotation (Placement(transformation(extent={{0,40},{20,60}})));
    Modelica.Blocks.Sources.Constant ctrl_PV(k=1)
      annotation (Placement(transformation(extent={{-20,40},{-12,48}})));
    Modelica.Blocks.Sources.RealExpression P_building(y=(intGai.y[2] + intGai.y[3] +
          Q_room.y)/150*building_ft2)
      annotation (Placement(transformation(extent={{30,-80},{50,-60}})));
    Modelica.Blocks.Interfaces.RealOutput P
      annotation (Placement(transformation(extent={{100,40},{120,60}})));
    Components.Battery.Model.Battery battery(
      EMax=2000/150*building_ft2,
      Pmax=1000/150*building_ft2,
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
    connect(PV.weaBus, weaDat.weaBus) annotation (Line(
        points={{0,54},{-30,54},{-30,70},{-80,70}},
        color={255,204,51},
        thickness=0.5));
    connect(ctrl_PV.y, PV.scale) annotation (Line(points={{-11.6,44},{-8,44},{-8,46},
            {-2,46}}, color={0,0,127}));
    connect(sum1.y, P)
      annotation (Line(points={{91,50},{110,50}}, color={0,0,127}));
    connect(battery.P, sum1.u[2]) annotation (Line(points={{21,20},{60,20},{60,50},
            {68,50}}, color={0,0,127}));
    connect(sum1.u[3], P_building.y) annotation (Line(points={{68,51.3333},{60,
            51.3333},{60,-70},{51,-70}},
                                color={0,0,127}));
    connect(P_set_battery, battery.PCtrl)
      annotation (Line(points={{-110,20},{-2,20}}, color={0,0,127}));
    connect(pv_inv.y, sum1.u[1]) annotation (Line(points={{40.4,50},{58,50},{58,
            48.6667},{68,48.6667}},
                           color={0,0,127}));
    connect(pv_inv.u, PV.P)
      annotation (Line(points={{31.2,50},{21,50}}, color={0,0,127}));
    connect(costcalc.u1, tou.y[1]) annotation (Line(points={{85.2,82.4},{72.6,
            82.4},{72.6,90},{61,90}}, color={0,0,127}));
    connect(costcalc.y, cost)
      annotation (Line(points={{94.4,80},{110,80}}, color={0,0,127}));
    connect(P_kW.y, costcalc.u2) annotation (Line(points={{61,70},{72.5,70},{
            72.5,77.6},{85.2,77.6}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
  end smartBuilding;

  model Building_room_Qmean
    parameter Modelica.SIunits.Temperature T_init(start=293.15)=293.15
      "Temperature of element";
    parameter Boolean need_wea_inputs=true;
    parameter Real timestep(unit="s")=5*60
      "Model timestep in seconds";
    Buildings.ThermalZones.Detailed.MixedAir
             roo(
      redeclare package Medium = Modelica.Media.Air.SimpleAir,
      nConExt=0,
      nConExtWin=1,
      nConPar=0,
      nConBou=5,
      nSurBou=0,
      T_start=T_init,
      datConExtWin(
        layers={matExtWal},
        each A=10.22,
        glaSys={glaSys},
        each hWin=3.13,
        each wWin=2.782751,
        each fFra=0.000001,
        each til=Buildings.Types.Tilt.Wall,
        azi={Buildings.Types.Azimuth.S}),
      datConBou(
        layers={matFlo,matCeil,matEWWal,matNWal,matEWWal},
        A={13.94,13.94,15.33,10.22,15.33},
        til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Wall,
            Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),
      AFlo=13.94,
      hRoo=3.37,
      intConMod=Buildings.HeatTransfer.Types.InteriorConvection.Temperature,
      extConMod=Buildings.HeatTransfer.Types.ExteriorConvection.TemperatureWind,
      conBou(opa(T(each start=T_init))),
      lat=0.65484753534827,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                                                 "Room model"
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
      relHum=0,
      TDewPoi(displayUnit="K"),
      filNam=Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"),
      pAtmSou=Buildings.BoundaryConditions.Types.DataSource.File,
      calTSky=Buildings.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
      computeWetBulbTemperature=false) if not need_wea_inputs
      annotation (Placement(transformation(extent={{80,30},{60,50}})));

    Modelica.Blocks.Sources.Constant uSha(k=0)
      "Control signal for the shading device"
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matExtWal(
      nLay=3,
      absIR_a=0.9,
      absIR_b=0.9,
      absSol_a=0.6,
      absSol_b=0.6,
      material={Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.000701,
          k=45.345,
          c=502.416,
          d=7833.028),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.0127,
          k=0.12,
          c=1210,
          d=540),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.133,
          k=0.047,
          c=1006,
          d=93.84)}) "71T: South Wall"
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
    parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matCeil(
      nLay=3,
      absIR_a=0.9,
      absIR_b=0.9,
      absSol_a=0.6,
      absSol_b=0.6,
      material={Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.009525,
          k=0.12,
          c=1210,
          d=540),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.133,
          k=0.047,
          c=1006,
          d=93.84),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.015875,
          k=0.17,
          c=1090,
          d=800)}) "71T: Ceiling"
      annotation (Placement(transformation(extent={{0,60},{20,80}})));
    parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matFlo(
      final nLay=4,
      absIR_a=0.9,
      absIR_b=0.9,
      absSol_a=0.6,
      absSol_b=0.6,
      material={Buildings.HeatTransfer.Data.Solids.Generic(
          x=5.28,
          k=1,
          c=0,
          d=0),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.01905,
          k=0.15,
          c=1630,
          d=608),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.01905,
          k=0.12,
          c=1210,
          d=540),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.22,
          k=1,
          c=0,
          d=0)}) "71T: Floor"
      annotation (Placement(transformation(extent={{30,60},{50,80}})));
    parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matEWWal(
      final nLay=2,
      absIR_a=0.9,
      absIR_b=0.9,
      absSol_a=0.6,
      absSol_b=0.6,
      material={Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.133,
          k=0.047,
          c=1006,
          d=93.84),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.015875,
          k=0.17,
          c=1090,
          d=800)}) "71T: East West Wall"
      annotation (Placement(transformation(extent={{-30,60},{-10,80}})));
    parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matNWal(
      final nLay=4,
      absIR_a=0.9,
      absIR_b=0.9,
      absSol_a=0.6,
      absSol_b=0.6,
      material={Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.015875,
          k=0.17,
          c=1090,
          d=800),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.009525,
          k=0.12,
          c=1210,
          d=540),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.133,
          k=0.047,
          c=1006,
          d=93.84),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.015875,
          k=0.17,
          c=1090,
          d=800)}) "71T: North Wall"
      annotation (Placement(transformation(extent={{60,60},{80,80}})));
    parameter Buildings.HeatTransfer.Data.GlazingSystems.DoubleElectrochromicAir13Clear
                                                                              glaSys(
      UFra=2,
      haveInteriorShade=false,
      haveExteriorShade=false) "Data record for the glazing system"
      annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
    Modelica.Blocks.Routing.Multiplex3 multiplex3_1 "Multiplex"
      annotation (Placement(transformation(extent={{-54,-30},{-34,-10}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea
      "Prescribed heat flow for heating and cooling"
      annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
    Modelica.Blocks.Math.Gain gaiHea(k=1E4) "Gain for heating"
      annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir
      "Room air temperature"
      annotation (Placement(transformation(extent={{60,-10},{80,10}})));
    Modelica.Blocks.Interfaces.RealOutput T_in(unit="K")
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealInput Q_lat(unit="W", start=0) annotation (Placement(
          transformation(
          origin={-110,-40},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Modelica.Blocks.Interfaces.RealInput Q_rad(unit="W", start=0) annotation (
        Placement(transformation(
          origin={-110,0},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Modelica.Blocks.Interfaces.RealInput Q_con(unit="W", start=0) annotation (
        Placement(transformation(
          origin={-110,-20},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Modelica.Blocks.Interfaces.RealInput uWin(unit="1", start=1) annotation (
        Placement(transformation(
          origin={-110,30},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Modelica.Blocks.Interfaces.RealInput T_set_heat(unit="K", start=273.15 + 20.0)
      annotation (Placement(transformation(
          origin={-110,-90},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus"
      annotation (Placement(transformation(extent={{-110,40},{-90,60}})));
    Modelica.Blocks.Math.Product product
      annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
    Modelica.Blocks.Interfaces.RealInput T_ctrl(unit="1", start=0) annotation (
        Placement(transformation(
          origin={-110,-60},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Modelica.Blocks.Math.Gain scale_m2_1(k=1/13.94)
      annotation (Placement(transformation(extent={{-94,-4},{-86,4}})));
    Modelica.Blocks.Math.Gain scale_m2_2(k=1/13.94)
      annotation (Placement(transformation(extent={{-94,-24},{-86,-16}})));
    Modelica.Blocks.Math.Gain scale_m2_3(k=1/13.94)
      annotation (Placement(transformation(extent={{-94,-44},{-86,-36}})));
    Modelica.Blocks.Interfaces.RealOutput Q_hvac(unit="W")
      annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
    ReinforcementLearning.DualSetpoint dualSetpoint
      annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
    Modelica.Blocks.Interfaces.RealInput T_set_cool(unit="K", start=273.15 + 24.0)
      annotation (Placement(transformation(
          origin={-110,-76},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Modelica.Blocks.Math.Mean Qmean(f=1/(timestep - 1e-9))
      annotation (Placement(transformation(extent={{72,-54},{80,-46}})));
  equation
    connect(multiplex3_1.y,roo. qGai_flow) annotation (Line(points={{-33,-20},{
            -26,-20},{-26,8},{-21.6,8}},  color={0,0,127}));
    connect(weaDat.weaBus, roo.weaBus) annotation (Line(
        points={{60,40},{40,40},{40,18},{28,18},{28,17.9},{17.9,17.9}},
        color={255,204,51},
        thickness=0.5));
    connect(roo.uSha[1], uSha.y) annotation (Line(points={{-21.6,18},{-26,18},{-26,
            30},{-39,30}}, color={0,0,127}));
    connect(T_in, TRooAir.T)
      annotation (Line(points={{110,0},{80,0}},          color={0,0,127}));
    connect(roo.uWin[1], uWin) annotation (Line(points={{-21.6,13},{-80,13},{-80,30},
            {-110,30}}, color={0,0,127}));
    connect(weaBus, roo.weaBus) annotation (Line(
        points={{-100,50},{28,50},{28,17.9},{17.9,17.9}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(TRooAir.port, roo.heaPorAir)
      annotation (Line(points={{60,0},{-1,0}}, color={191,0,0}));
    connect(preHea.port, roo.heaPorAir) annotation (Line(points={{60,-70},{60,0},
            {-1,0}},        color={191,0,0}));
    connect(preHea.Q_flow, product.y)
      annotation (Line(points={{40,-70},{21,-70}}, color={0,0,127}));
    connect(gaiHea.y, product.u2) annotation (Line(points={{-19,-70},{-10,-70},{
            -10,-76},{-2,-76}}, color={0,0,127}));
    connect(product.u1, T_ctrl) annotation (Line(points={{-2,-64},{-10,-64},{-10,
            -52},{-90,-52},{-90,-60},{-110,-60}}, color={0,0,127}));
    connect(scale_m2_1.y, multiplex3_1.u1[1]) annotation (Line(points={{-85.6,0},
            {-70,0},{-70,-13},{-56,-13}}, color={0,0,127}));
    connect(scale_m2_1.u, Q_rad)
      annotation (Line(points={{-94.8,0},{-110,0}}, color={0,0,127}));
    connect(Q_con, scale_m2_2.u)
      annotation (Line(points={{-110,-20},{-94.8,-20}}, color={0,0,127}));
    connect(scale_m2_2.y, multiplex3_1.u2[1])
      annotation (Line(points={{-85.6,-20},{-56,-20}}, color={0,0,127}));
    connect(Q_lat, scale_m2_3.u)
      annotation (Line(points={{-110,-40},{-94.8,-40}}, color={0,0,127}));
    connect(scale_m2_3.y, multiplex3_1.u3[1]) annotation (Line(points={{-85.6,-40},
            {-70,-40},{-70,-27},{-56,-27}}, color={0,0,127}));
    connect(dualSetpoint.yHvac, gaiHea.u)
      annotation (Line(points={{-59,-70},{-42,-70}}, color={0,0,127}));
    connect(dualSetpoint.Tzone, TRooAir.T) annotation (Line(points={{-70,-82},{
            -70,-90},{90,-90},{90,0},{80,0}}, color={0,0,127}));
    connect(dualSetpoint.CoolSet, T_set_cool) annotation (Line(points={{-82,-64},
            {-92,-64},{-92,-76},{-110,-76}}, color={0,0,127}));
    connect(dualSetpoint.HeatSet, T_set_heat) annotation (Line(points={{-82,-76},
            {-88,-76},{-88,-90},{-110,-90}}, color={0,0,127}));
    connect(Q_hvac, Qmean.y)
      annotation (Line(points={{110,-50},{80.4,-50}}, color={0,0,127}));
    connect(Qmean.u, product.y) annotation (Line(points={{71.2,-50},{30,-50},{30,-70},
            {21,-70}}, color={0,0,127}));
    annotation (
        experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
  end Building_room_Qmean;

  package Examples
    extends Modelica.Icons.ExamplesPackage;
    model Test_smartBuilding
      smartBuilding Building
        annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
      Modelica.Blocks.Sources.Trapezoid Pbatt(
        amplitude=1e6,
        rising(displayUnit="d") = 21600,
        width(displayUnit="d") = 21600,
        falling(displayUnit="d") = 21600,
        period(displayUnit="d") = 86400,
        offset=-0.5e6)
        annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
      Modelica.Blocks.Sources.Constant Tset(k=0)
        annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
    equation
      connect(Pbatt.y, Building.P_set_battery) annotation (Line(points={{-59,0},
              {-40,0},{-40,4},{-22,4}}, color={0,0,127}));
      connect(Building.T_set_cool, Tset.y) annotation (Line(points={{-22,-14},{
              -30,-14},{-30,-40},{-59,-40}}, color={0,0,127}));
      connect(Building.T_set_heat, Tset.y) annotation (Line(points={{-22,-18},{
              -30,-18},{-30,-40},{-59,-40}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Test_smartBuilding;
  end Examples;

  model Building_room_Qfirstorder
    parameter Modelica.SIunits.Temperature T_init(start=293.15)=293.15
      "Temperature of element";
    parameter Boolean need_wea_inputs=true;
    parameter Real timestep(unit="s")=5*60
      "Model timestep in seconds";
    Buildings.ThermalZones.Detailed.MixedAir
             roo(
      redeclare package Medium = Modelica.Media.Air.SimpleAir,
      nConExt=0,
      nConExtWin=1,
      nConPar=0,
      nConBou=5,
      nSurBou=0,
      T_start=T_init,
      datConExtWin(
        layers={matExtWal},
        each A=10.22,
        glaSys={glaSys},
        each hWin=3.13,
        each wWin=2.782751,
        each fFra=0.000001,
        each til=Buildings.Types.Tilt.Wall,
        azi={Buildings.Types.Azimuth.S}),
      datConBou(
        layers={matFlo,matCeil,matEWWal,matNWal,matEWWal},
        A={13.94,13.94,15.33,10.22,15.33},
        til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Wall,
            Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),
      AFlo=13.94,
      hRoo=3.37,
      intConMod=Buildings.HeatTransfer.Types.InteriorConvection.Temperature,
      extConMod=Buildings.HeatTransfer.Types.ExteriorConvection.TemperatureWind,
      conBou(opa(T(each start=T_init))),
      lat=0.65484753534827,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                                                 "Room model"
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
      relHum=0,
      TDewPoi(displayUnit="K"),
      filNam=Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"),
      pAtmSou=Buildings.BoundaryConditions.Types.DataSource.File,
      calTSky=Buildings.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
      computeWetBulbTemperature=false) if not need_wea_inputs
      annotation (Placement(transformation(extent={{80,30},{60,50}})));

    Modelica.Blocks.Sources.Constant uSha(k=0)
      "Control signal for the shading device"
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matExtWal(
      nLay=3,
      absIR_a=0.9,
      absIR_b=0.9,
      absSol_a=0.6,
      absSol_b=0.6,
      material={Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.000701,
          k=45.345,
          c=502.416,
          d=7833.028),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.0127,
          k=0.12,
          c=1210,
          d=540),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.133,
          k=0.047,
          c=1006,
          d=93.84)}) "71T: South Wall"
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
    parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matCeil(
      nLay=3,
      absIR_a=0.9,
      absIR_b=0.9,
      absSol_a=0.6,
      absSol_b=0.6,
      material={Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.009525,
          k=0.12,
          c=1210,
          d=540),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.133,
          k=0.047,
          c=1006,
          d=93.84),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.015875,
          k=0.17,
          c=1090,
          d=800)}) "71T: Ceiling"
      annotation (Placement(transformation(extent={{0,60},{20,80}})));
    parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matFlo(
      final nLay=4,
      absIR_a=0.9,
      absIR_b=0.9,
      absSol_a=0.6,
      absSol_b=0.6,
      material={Buildings.HeatTransfer.Data.Solids.Generic(
          x=5.28,
          k=1,
          c=0,
          d=0),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.01905,
          k=0.15,
          c=1630,
          d=608),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.01905,
          k=0.12,
          c=1210,
          d=540),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.22,
          k=1,
          c=0,
          d=0)}) "71T: Floor"
      annotation (Placement(transformation(extent={{30,60},{50,80}})));
    parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matEWWal(
      final nLay=2,
      absIR_a=0.9,
      absIR_b=0.9,
      absSol_a=0.6,
      absSol_b=0.6,
      material={Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.133,
          k=0.047,
          c=1006,
          d=93.84),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.015875,
          k=0.17,
          c=1090,
          d=800)}) "71T: East West Wall"
      annotation (Placement(transformation(extent={{-30,60},{-10,80}})));
    parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matNWal(
      final nLay=4,
      absIR_a=0.9,
      absIR_b=0.9,
      absSol_a=0.6,
      absSol_b=0.6,
      material={Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.015875,
          k=0.17,
          c=1090,
          d=800),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.009525,
          k=0.12,
          c=1210,
          d=540),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.133,
          k=0.047,
          c=1006,
          d=93.84),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.015875,
          k=0.17,
          c=1090,
          d=800)}) "71T: North Wall"
      annotation (Placement(transformation(extent={{60,60},{80,80}})));
    parameter Buildings.HeatTransfer.Data.GlazingSystems.DoubleElectrochromicAir13Clear
                                                                              glaSys(
      UFra=2,
      haveInteriorShade=false,
      haveExteriorShade=false) "Data record for the glazing system"
      annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
    Modelica.Blocks.Routing.Multiplex3 multiplex3_1 "Multiplex"
      annotation (Placement(transformation(extent={{-54,-30},{-34,-10}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea
      "Prescribed heat flow for heating and cooling"
      annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
    Modelica.Blocks.Math.Gain gaiHea(k=1E4) "Gain for heating"
      annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir
      "Room air temperature"
      annotation (Placement(transformation(extent={{60,-10},{80,10}})));
    Modelica.Blocks.Interfaces.RealOutput T_in(unit="K")
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealInput Q_lat(unit="W", start=0) annotation (Placement(
          transformation(
          origin={-110,-40},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Modelica.Blocks.Interfaces.RealInput Q_rad(unit="W", start=0) annotation (
        Placement(transformation(
          origin={-110,0},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Modelica.Blocks.Interfaces.RealInput Q_con(unit="W", start=0) annotation (
        Placement(transformation(
          origin={-110,-20},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Modelica.Blocks.Interfaces.RealInput uWin(unit="1", start=1) annotation (
        Placement(transformation(
          origin={-110,30},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Modelica.Blocks.Interfaces.RealInput T_set_heat(unit="K", start=273.15 + 20.0)
      annotation (Placement(transformation(
          origin={-110,-90},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus"
      annotation (Placement(transformation(extent={{-110,40},{-90,60}})));
    Modelica.Blocks.Math.Product product
      annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
    Modelica.Blocks.Interfaces.RealInput T_ctrl(unit="1", start=0) annotation (
        Placement(transformation(
          origin={-110,-60},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Modelica.Blocks.Math.Gain scale_m2_1(k=1/13.94)
      annotation (Placement(transformation(extent={{-94,-4},{-86,4}})));
    Modelica.Blocks.Math.Gain scale_m2_2(k=1/13.94)
      annotation (Placement(transformation(extent={{-94,-24},{-86,-16}})));
    Modelica.Blocks.Math.Gain scale_m2_3(k=1/13.94)
      annotation (Placement(transformation(extent={{-94,-44},{-86,-36}})));
    Modelica.Blocks.Interfaces.RealOutput Q_hvac(unit="W")
      annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
    ReinforcementLearning.DualSetpoint dualSetpoint
      annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
    Modelica.Blocks.Interfaces.RealInput T_set_cool(unit="K", start=273.15 + 24.0)
      annotation (Placement(transformation(
          origin={-110,-76},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Modelica.Blocks.Continuous.FirstOrder
                              Qmean(T=timestep - 1e-9)
      annotation (Placement(transformation(extent={{72,-54},{80,-46}})));
  equation
    connect(multiplex3_1.y,roo. qGai_flow) annotation (Line(points={{-33,-20},{
            -26,-20},{-26,8},{-21.6,8}},  color={0,0,127}));
    connect(weaDat.weaBus, roo.weaBus) annotation (Line(
        points={{60,40},{40,40},{40,18},{28,18},{28,17.9},{17.9,17.9}},
        color={255,204,51},
        thickness=0.5));
    connect(roo.uSha[1], uSha.y) annotation (Line(points={{-21.6,18},{-26,18},{-26,
            30},{-39,30}}, color={0,0,127}));
    connect(T_in, TRooAir.T)
      annotation (Line(points={{110,0},{80,0}},          color={0,0,127}));
    connect(roo.uWin[1], uWin) annotation (Line(points={{-21.6,13},{-80,13},{-80,30},
            {-110,30}}, color={0,0,127}));
    connect(weaBus, roo.weaBus) annotation (Line(
        points={{-100,50},{28,50},{28,17.9},{17.9,17.9}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(TRooAir.port, roo.heaPorAir)
      annotation (Line(points={{60,0},{-1,0}}, color={191,0,0}));
    connect(preHea.port, roo.heaPorAir) annotation (Line(points={{60,-70},{60,0},
            {-1,0}},        color={191,0,0}));
    connect(preHea.Q_flow, product.y)
      annotation (Line(points={{40,-70},{21,-70}}, color={0,0,127}));
    connect(gaiHea.y, product.u2) annotation (Line(points={{-19,-70},{-10,-70},{
            -10,-76},{-2,-76}}, color={0,0,127}));
    connect(product.u1, T_ctrl) annotation (Line(points={{-2,-64},{-10,-64},{-10,
            -52},{-90,-52},{-90,-60},{-110,-60}}, color={0,0,127}));
    connect(scale_m2_1.y, multiplex3_1.u1[1]) annotation (Line(points={{-85.6,0},
            {-70,0},{-70,-13},{-56,-13}}, color={0,0,127}));
    connect(scale_m2_1.u, Q_rad)
      annotation (Line(points={{-94.8,0},{-110,0}}, color={0,0,127}));
    connect(Q_con, scale_m2_2.u)
      annotation (Line(points={{-110,-20},{-94.8,-20}}, color={0,0,127}));
    connect(scale_m2_2.y, multiplex3_1.u2[1])
      annotation (Line(points={{-85.6,-20},{-56,-20}}, color={0,0,127}));
    connect(Q_lat, scale_m2_3.u)
      annotation (Line(points={{-110,-40},{-94.8,-40}}, color={0,0,127}));
    connect(scale_m2_3.y, multiplex3_1.u3[1]) annotation (Line(points={{-85.6,-40},
            {-70,-40},{-70,-27},{-56,-27}}, color={0,0,127}));
    connect(dualSetpoint.yHvac, gaiHea.u)
      annotation (Line(points={{-59,-70},{-42,-70}}, color={0,0,127}));
    connect(dualSetpoint.Tzone, TRooAir.T) annotation (Line(points={{-70,-82},{
            -70,-90},{90,-90},{90,0},{80,0}}, color={0,0,127}));
    connect(dualSetpoint.CoolSet, T_set_cool) annotation (Line(points={{-82,-64},
            {-92,-64},{-92,-76},{-110,-76}}, color={0,0,127}));
    connect(dualSetpoint.HeatSet, T_set_heat) annotation (Line(points={{-82,-76},
            {-88,-76},{-88,-90},{-110,-90}}, color={0,0,127}));
    connect(Q_hvac, Qmean.y)
      annotation (Line(points={{110,-50},{80.4,-50}}, color={0,0,127}));
    connect(Qmean.u, product.y) annotation (Line(points={{71.2,-50},{30,-50},{30,-70},
            {21,-70}}, color={0,0,127}));
    annotation (
        experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
  end Building_room_Qfirstorder;

  model Building_room_Qdirect
    parameter Modelica.SIunits.Temperature T_init(start=293.15)=293.15
      "Temperature of element";
    parameter Boolean need_wea_inputs=true;
    parameter Real timestep(unit="s")=5*60
      "Model timestep in seconds";
    Buildings.ThermalZones.Detailed.MixedAir
             roo(
      redeclare package Medium = Modelica.Media.Air.SimpleAir,
      nConExt=0,
      nConExtWin=1,
      nConPar=0,
      nConBou=5,
      nSurBou=0,
      T_start=T_init,
      datConExtWin(
        layers={matExtWal},
        each A=10.22,
        glaSys={glaSys},
        each hWin=3.13,
        each wWin=2.782751,
        each fFra=0.000001,
        each til=Buildings.Types.Tilt.Wall,
        azi={Buildings.Types.Azimuth.S}),
      datConBou(
        layers={matFlo,matCeil,matEWWal,matNWal,matEWWal},
        A={13.94,13.94,15.33,10.22,15.33},
        til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Ceiling,Buildings.Types.Tilt.Wall,
            Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall}),
      AFlo=13.94,
      hRoo=3.37,
      intConMod=Buildings.HeatTransfer.Types.InteriorConvection.Temperature,
      extConMod=Buildings.HeatTransfer.Types.ExteriorConvection.TemperatureWind,
      conBou(opa(T(each start=T_init))),
      lat=0.65484753534827,
      energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
                                                 "Room model"
      annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
      relHum=0,
      TDewPoi(displayUnit="K"),
      filNam=Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"),
      pAtmSou=Buildings.BoundaryConditions.Types.DataSource.File,
      calTSky=Buildings.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
      computeWetBulbTemperature=false) if not need_wea_inputs
      annotation (Placement(transformation(extent={{80,30},{60,50}})));

    Modelica.Blocks.Sources.Constant uSha(k=0)
      "Control signal for the shading device"
      annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
    parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matExtWal(
      nLay=3,
      absIR_a=0.9,
      absIR_b=0.9,
      absSol_a=0.6,
      absSol_b=0.6,
      material={Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.000701,
          k=45.345,
          c=502.416,
          d=7833.028),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.0127,
          k=0.12,
          c=1210,
          d=540),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.133,
          k=0.047,
          c=1006,
          d=93.84)}) "71T: South Wall"
      annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
    parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matCeil(
      nLay=3,
      absIR_a=0.9,
      absIR_b=0.9,
      absSol_a=0.6,
      absSol_b=0.6,
      material={Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.009525,
          k=0.12,
          c=1210,
          d=540),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.133,
          k=0.047,
          c=1006,
          d=93.84),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.015875,
          k=0.17,
          c=1090,
          d=800)}) "71T: Ceiling"
      annotation (Placement(transformation(extent={{0,60},{20,80}})));
    parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matFlo(
      final nLay=4,
      absIR_a=0.9,
      absIR_b=0.9,
      absSol_a=0.6,
      absSol_b=0.6,
      material={Buildings.HeatTransfer.Data.Solids.Generic(
          x=5.28,
          k=1,
          c=0,
          d=0),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.01905,
          k=0.15,
          c=1630,
          d=608),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.01905,
          k=0.12,
          c=1210,
          d=540),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.22,
          k=1,
          c=0,
          d=0)}) "71T: Floor"
      annotation (Placement(transformation(extent={{30,60},{50,80}})));
    parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matEWWal(
      final nLay=2,
      absIR_a=0.9,
      absIR_b=0.9,
      absSol_a=0.6,
      absSol_b=0.6,
      material={Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.133,
          k=0.047,
          c=1006,
          d=93.84),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.015875,
          k=0.17,
          c=1090,
          d=800)}) "71T: East West Wall"
      annotation (Placement(transformation(extent={{-30,60},{-10,80}})));
    parameter Buildings.HeatTransfer.Data.OpaqueConstructions.Generic matNWal(
      final nLay=4,
      absIR_a=0.9,
      absIR_b=0.9,
      absSol_a=0.6,
      absSol_b=0.6,
      material={Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.015875,
          k=0.17,
          c=1090,
          d=800),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.009525,
          k=0.12,
          c=1210,
          d=540),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.133,
          k=0.047,
          c=1006,
          d=93.84),Buildings.HeatTransfer.Data.Solids.Generic(
          x=0.015875,
          k=0.17,
          c=1090,
          d=800)}) "71T: North Wall"
      annotation (Placement(transformation(extent={{60,60},{80,80}})));
    parameter Buildings.HeatTransfer.Data.GlazingSystems.DoubleElectrochromicAir13Clear
                                                                              glaSys(
      UFra=2,
      haveInteriorShade=false,
      haveExteriorShade=false) "Data record for the glazing system"
      annotation (Placement(transformation(extent={{-90,60},{-70,80}})));
    Modelica.Blocks.Routing.Multiplex3 multiplex3_1 "Multiplex"
      annotation (Placement(transformation(extent={{-54,-30},{-34,-10}})));
    Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea
      "Prescribed heat flow for heating and cooling"
      annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
    Modelica.Blocks.Math.Gain gaiHea(k=1E4) "Gain for heating"
      annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
    Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor TRooAir
      "Room air temperature"
      annotation (Placement(transformation(extent={{60,-10},{80,10}})));
    Modelica.Blocks.Interfaces.RealOutput T_in(unit="K")
      annotation (Placement(transformation(extent={{100,-10},{120,10}})));
    Modelica.Blocks.Interfaces.RealInput Q_lat(unit="W", start=0) annotation (Placement(
          transformation(
          origin={-110,-40},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Modelica.Blocks.Interfaces.RealInput Q_rad(unit="W", start=0) annotation (
        Placement(transformation(
          origin={-110,0},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Modelica.Blocks.Interfaces.RealInput Q_con(unit="W", start=0) annotation (
        Placement(transformation(
          origin={-110,-20},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Modelica.Blocks.Interfaces.RealInput uWin(unit="1", start=1) annotation (
        Placement(transformation(
          origin={-110,30},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Modelica.Blocks.Interfaces.RealInput T_set_heat(unit="K", start=273.15 + 20.0)
      annotation (Placement(transformation(
          origin={-110,-90},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Buildings.BoundaryConditions.WeatherData.Bus weaBus "Weather data bus"
      annotation (Placement(transformation(extent={{-110,40},{-90,60}})));
    Modelica.Blocks.Math.Product product
      annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
    Modelica.Blocks.Interfaces.RealInput T_ctrl(unit="1", start=0) annotation (
        Placement(transformation(
          origin={-110,-60},
          extent={{10,-10},{-10,10}},
          rotation=180)));
    Modelica.Blocks.Math.Gain scale_m2_1(k=1/13.94)
      annotation (Placement(transformation(extent={{-94,-4},{-86,4}})));
    Modelica.Blocks.Math.Gain scale_m2_2(k=1/13.94)
      annotation (Placement(transformation(extent={{-94,-24},{-86,-16}})));
    Modelica.Blocks.Math.Gain scale_m2_3(k=1/13.94)
      annotation (Placement(transformation(extent={{-94,-44},{-86,-36}})));
    Modelica.Blocks.Interfaces.RealOutput Q_hvac(unit="W")
      annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
    ReinforcementLearning.DualSetpoint dualSetpoint
      annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
    Modelica.Blocks.Interfaces.RealInput T_set_cool(unit="K", start=273.15 + 24.0)
      annotation (Placement(transformation(
          origin={-110,-76},
          extent={{10,-10},{-10,10}},
          rotation=180)));
  equation
    connect(multiplex3_1.y,roo. qGai_flow) annotation (Line(points={{-33,-20},{
            -26,-20},{-26,8},{-21.6,8}},  color={0,0,127}));
    connect(weaDat.weaBus, roo.weaBus) annotation (Line(
        points={{60,40},{40,40},{40,18},{28,18},{28,17.9},{17.9,17.9}},
        color={255,204,51},
        thickness=0.5));
    connect(roo.uSha[1], uSha.y) annotation (Line(points={{-21.6,18},{-26,18},{-26,
            30},{-39,30}}, color={0,0,127}));
    connect(T_in, TRooAir.T)
      annotation (Line(points={{110,0},{80,0}},          color={0,0,127}));
    connect(roo.uWin[1], uWin) annotation (Line(points={{-21.6,13},{-80,13},{-80,30},
            {-110,30}}, color={0,0,127}));
    connect(weaBus, roo.weaBus) annotation (Line(
        points={{-100,50},{28,50},{28,17.9},{17.9,17.9}},
        color={255,204,51},
        thickness=0.5), Text(
        string="%first",
        index=-1,
        extent={{-6,3},{-6,3}},
        horizontalAlignment=TextAlignment.Right));
    connect(TRooAir.port, roo.heaPorAir)
      annotation (Line(points={{60,0},{-1,0}}, color={191,0,0}));
    connect(preHea.port, roo.heaPorAir) annotation (Line(points={{60,-70},{60,0},
            {-1,0}},        color={191,0,0}));
    connect(preHea.Q_flow, product.y)
      annotation (Line(points={{40,-70},{21,-70}}, color={0,0,127}));
    connect(gaiHea.y, product.u2) annotation (Line(points={{-19,-70},{-10,-70},{
            -10,-76},{-2,-76}}, color={0,0,127}));
    connect(product.u1, T_ctrl) annotation (Line(points={{-2,-64},{-10,-64},{-10,
            -52},{-90,-52},{-90,-60},{-110,-60}}, color={0,0,127}));
    connect(scale_m2_1.y, multiplex3_1.u1[1]) annotation (Line(points={{-85.6,0},
            {-70,0},{-70,-13},{-56,-13}}, color={0,0,127}));
    connect(scale_m2_1.u, Q_rad)
      annotation (Line(points={{-94.8,0},{-110,0}}, color={0,0,127}));
    connect(Q_con, scale_m2_2.u)
      annotation (Line(points={{-110,-20},{-94.8,-20}}, color={0,0,127}));
    connect(scale_m2_2.y, multiplex3_1.u2[1])
      annotation (Line(points={{-85.6,-20},{-56,-20}}, color={0,0,127}));
    connect(Q_lat, scale_m2_3.u)
      annotation (Line(points={{-110,-40},{-94.8,-40}}, color={0,0,127}));
    connect(scale_m2_3.y, multiplex3_1.u3[1]) annotation (Line(points={{-85.6,-40},
            {-70,-40},{-70,-27},{-56,-27}}, color={0,0,127}));
    connect(dualSetpoint.yHvac, gaiHea.u)
      annotation (Line(points={{-59,-70},{-42,-70}}, color={0,0,127}));
    connect(dualSetpoint.Tzone, TRooAir.T) annotation (Line(points={{-70,-82},{
            -70,-90},{90,-90},{90,0},{80,0}}, color={0,0,127}));
    connect(dualSetpoint.CoolSet, T_set_cool) annotation (Line(points={{-82,-64},
            {-92,-64},{-92,-76},{-110,-76}}, color={0,0,127}));
    connect(dualSetpoint.HeatSet, T_set_heat) annotation (Line(points={{-82,-76},
            {-88,-76},{-88,-90},{-110,-90}}, color={0,0,127}));
    connect(Q_hvac, product.y) annotation (Line(points={{110,-50},{30,-50},{30,
            -70},{21,-70}}, color={0,0,127}));
    annotation (
        experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
  end Building_room_Qdirect;

  model smartBuilding_external
    parameter Real building_ft2 = 50e3 "Building ft2 scale";
    parameter String weather_file = "" "Path to weather file";
    // parameter String weather_file = Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos") "Path to weather file";

    Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
      relHum=0,
      TDewPoi(displayUnit="K"),
      filNam=weather_file,
      pAtmSou=Buildings.BoundaryConditions.Types.DataSource.File,
      calTSky=Buildings.BoundaryConditions.Types.SkyTemperatureCalculation.HorizontalRadiation,
      computeWetBulbTemperature=false)
      annotation (Placement(transformation(extent={{-100,60},{-80,80}})));

    Components.Photovoltaics.Model.PVModule_simple PV(n=0.012*building_ft2, lat=
          weaDat.lat)
      annotation (Placement(transformation(extent={{0,40},{20,60}})));
    Modelica.Blocks.Sources.Constant ctrl_PV(k=1)
      annotation (Placement(transformation(extent={{-20,40},{-12,48}})));
    Modelica.Blocks.Interfaces.RealOutput P
      annotation (Placement(transformation(extent={{100,40},{120,60}})));
    Components.Battery.Model.Battery battery(
      EMax=2000/150*building_ft2,
      Pmax=1000/150*building_ft2,
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
    Modelica.Blocks.Interfaces.RealInput P_building(unit="W", start=0)
      annotation (Placement(transformation(
          origin={-110,-80},
          extent={{10,-10},{-10,10}},
          rotation=180)));
  equation
    connect(PV.weaBus, weaDat.weaBus) annotation (Line(
        points={{0,54},{-30,54},{-30,70},{-80,70}},
        color={255,204,51},
        thickness=0.5));
    connect(ctrl_PV.y, PV.scale) annotation (Line(points={{-11.6,44},{-8,44},{-8,46},
            {-2,46}}, color={0,0,127}));
    connect(sum1.y, P)
      annotation (Line(points={{91,50},{110,50}}, color={0,0,127}));
    connect(battery.P, sum1.u[2]) annotation (Line(points={{21,20},{60,20},{60,50},
            {68,50}}, color={0,0,127}));
    connect(P_set_battery, battery.PCtrl)
      annotation (Line(points={{-110,20},{-2,20}}, color={0,0,127}));
    connect(pv_inv.y, sum1.u[1]) annotation (Line(points={{40.4,50},{58,50},{58,
            48.6667},{68,48.6667}},
                           color={0,0,127}));
    connect(pv_inv.u, PV.P)
      annotation (Line(points={{31.2,50},{21,50}}, color={0,0,127}));
    connect(costcalc.u1, tou.y[1]) annotation (Line(points={{85.2,82.4},{72.6,
            82.4},{72.6,90},{61,90}}, color={0,0,127}));
    connect(costcalc.y, cost)
      annotation (Line(points={{94.4,80},{110,80}}, color={0,0,127}));
    connect(P_kW.y, costcalc.u2) annotation (Line(points={{61,70},{72.5,70},{
            72.5,77.6},{85.2,77.6}}, color={0,0,127}));
    connect(sum1.u[3], P_building) annotation (Line(points={{68,51.3333},{62,
            51.3333},{62,-80},{-110,-80}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)),
      experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
  end smartBuilding_external;
end SmartBuilding;
