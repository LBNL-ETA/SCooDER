within SCooDER.Solar;
model TiltedSolarWeabus
  parameter Real lat=37.9 "Latitude [deg]";
  parameter Real til=0 "Surface tilt [deg]";
  parameter Real azi=0 "Surface azimuth [deg] 0-S, 90-W, 180-N, 270-E ";

  Solar.DiffusePerez                               HDifTil(
    azi=Modelica.SIunits.Conversions.from_deg(azi),
    til=Modelica.SIunits.Conversions.from_deg(til),
    lat=Modelica.SIunits.Conversions.from_deg(lat)) "Diffuse irradiation on tilted surface"
    annotation (Placement(transformation(extent={{-20,10},{0,30}})));
  Solar.DirectTiltedSurface                               HDirTil(
    azi=Modelica.SIunits.Conversions.from_deg(azi),
    til=Modelica.SIunits.Conversions.from_deg(til),
    lat=Modelica.SIunits.Conversions.from_deg(lat)) "Direct irradiation on tilted surface"
    annotation (Placement(transformation(extent={{-20,-30},{0,-10}})));
  Modelica.Blocks.Math.Add sum "Total irradiation on tilted surface"
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={50,0})));
  Modelica.Blocks.Interfaces.RealOutput G(final quantity="RadiantEnergyFluenceRate",
      final unit="W/m2") "Tilted Solar Radiation"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Buildings.BoundaryConditions.WeatherData.Bus
                  weaBus "Bus with weather data"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
equation
  connect(sum.u2, HDifTil.H)
    annotation (Line(points={{38,6},{20,6},{20,20},{1,20}}, color={0,0,127}));
  connect(sum.u1, HDirTil.H) annotation (Line(points={{38,-6},{20,-6},{20,-20},{
          1,-20}}, color={0,0,127}));
  connect(sum.y, G) annotation (Line(points={{61,0},{110,0}}, color={0,0,127}));
  connect(HDifTil.weaBus, weaBus) annotation (Line(
      points={{-20,20},{-60,20},{-60,0},{-100,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(HDirTil.weaBus, weaBus) annotation (Line(
      points={{-20,-20},{-60,-20},{-60,0},{-100,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TiltedSolarWeabus;
