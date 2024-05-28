within SCooDER.Solar.Examples;
model PvOrientated_compareModels
  parameter Real A_PV=1 "Area of PV system";
  parameter Real til=10 "Surface tilt [deg]";
  parameter Real azi=0 "Surface azimuth [deg]";
  parameter String filNam= Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos");

  Buildings.BoundaryConditions.WeatherData.ReaderTMY3
                                            weaDat(
      computeWetBulbTemperature=false, filNam=filNam)
    "Weather data model"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Buildings.Electrical.AC.OnePhase.Sources.PVSimpleOriented pv_buildings(
    pf=1,
    eta_DCAC=1,
    fAct=1,
    eta=0.158,
    V_nominal=120,
    A=A_PV,
    azi=Modelica.Units.Conversions.from_deg(azi),
    til=Modelica.Units.Conversions.from_deg(til))
    annotation (Placement(transformation(extent={{4,-10},{24,10}})));
  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=60, V=120)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Components.Photovoltaics.Model.PVModule_simple pV_smartinverter(
    n=1,
    A=A_PV,
    til=til,
    azi=azi) annotation (Placement(transformation(extent={{40,-30},{60,-10}})));
  Modelica.Blocks.Sources.Constant scale(k=1)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
protected
  Buildings.BoundaryConditions.SolarIrradiation.DiffusePerez HDifTil_buildings(
    final til=Modelica.Units.Conversions.from_deg(til),
    final azi=Modelica.Units.Conversions.from_deg(azi))
    "Diffuse irradiation on tilted surface"
    annotation (Placement(transformation(extent={{40,62},{60,82}})));
  Buildings.BoundaryConditions.SolarIrradiation.DirectTiltedSurface
    HDirTil_buildings(
    final til=Modelica.Units.Conversions.from_deg(til),
    final azi=Modelica.Units.Conversions.from_deg(azi))
    "Direct irradiation on tilted surface"
    annotation (Placement(transformation(extent={{40,35},{60,55}})));
public
  DirectTiltedSurface HDirTil_smartinverter(
    azi=Modelica.Units.Conversions.from_deg(azi),
    til=Modelica.Units.Conversions.from_deg(til),
    lat=weaDat.lat) "Direct irradiation on tilted surface"
    annotation (Placement(transformation(extent={{42,-86},{62,-66}})));
equation
  connect(weaDat.weaBus, pv_buildings.weaBus) annotation (Line(
      points={{-60,50},{14,50},{14,9}},
      color={255,204,51},
      thickness=0.5));
  connect(fixVol.terminal, pv_buildings.terminal)
    annotation (Line(points={{-40,0},{4,0}},   color={0,120,120}));
  connect(pV_smartinverter.weaBus, pv_buildings.weaBus) annotation (Line(
      points={{40,-16},{32,-16},{32,16},{14,16},{14,9}},
      color={255,204,51},
      thickness=0.5));
  connect(HDifTil_buildings.weaBus, pv_buildings.weaBus) annotation (Line(
      points={{40,72},{28,72},{28,50},{14,50},{14,9}},
      color={255,204,51},
      thickness=0.5));
  connect(HDirTil_buildings.weaBus, pv_buildings.weaBus) annotation (Line(
      points={{40,45},{32,45},{32,50},{14,50},{14,9}},
      color={255,204,51},
      thickness=0.5));
  connect(HDirTil_smartinverter.weaBus, pv_buildings.weaBus) annotation (Line(
      points={{42,-76},{6,-76},{6,-30},{-28,-30},{-28,50},{14,50},{14,9}},
      color={255,204,51},
      thickness=0.5));
  connect(scale.y, pV_smartinverter.scale) annotation (Line(points={{-39,-30},{
          -30,-30},{-30,-24},{38,-24}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
end PvOrientated_compareModels;
