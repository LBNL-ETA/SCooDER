within SCooDER.Systems.SmartBuilding;
model Building_room_Qmean
  parameter Modelica.Units.SI.Temperature T_init(start=293.15) = 293.15
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
