within SCooDER.Components.Photovoltaics.Model;
model PVModule_simple_ZeroOrder
  parameter Real n(min=0, unit="1") = 14 "Number of PV modules";
  parameter Modelica.SIunits.Area A(min=0) = 1.65 "Net surface area per module [m2]";
  parameter Real eta(min=0, max=1, unit="1") = 0.158
    "Module conversion efficiency";
  parameter Real lat(unit="deg") = 37.9 "Latitude [deg]";
  parameter Real til(unit="deg") = 10 "Surface tilt [deg]";
  parameter Real azi(unit="deg") = 0 "Surface azimuth [deg] 0-S, 90-W, 180-N, 270-E ";
  parameter Real Ts(unit="s") = 60 "Time constant of zero order hold";
  Modelica.Blocks.Interfaces.RealInput scale(
    min=0,
    max=1,
    unit="1",
    start=1) "Shading of PV module" annotation (Placement(transformation(
        origin={-120,-40},
        extent={{20,20},{-20,-20}},
        rotation=180), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-40})));
  Buildings.BoundaryConditions.WeatherData.Bus
                  weaBus "Bus with weather data"
    annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
  Modelica.Blocks.Interfaces.RealOutput P "PV generation in Watt"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Solar.TiltedSolarWeabus tilted_Solar_TMY(
    til=til,
    lat=lat,
    azi=azi)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Model.PVsimple pV_simple(
    A=A,
    eta=eta,
    n=n) annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Math.Product product
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold_Pv(samplePeriod=Ts)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-40,20})));
equation
  connect(weaBus, tilted_Solar_TMY.weaBus) annotation (Line(
      points={{-100,40},{-70,40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(product.u2, scale) annotation (Line(points={{-22,-6},{-40,-6},{-40,-40},
          {-120,-40}}, color={0,0,127}));
  connect(product.y, pV_simple.G)
    annotation (Line(points={{1,0},{18,0}}, color={0,0,127}));
  connect(pV_simple.P, P)
    annotation (Line(points={{41,0},{110,0}}, color={0,0,127}));
  connect(product.u1, zeroOrderHold_Pv.y)
    annotation (Line(points={{-22,6},{-40,6},{-40,9}}, color={0,0,127}));
  connect(zeroOrderHold_Pv.u, tilted_Solar_TMY.G)
    annotation (Line(points={{-40,32},{-40,40},{-49,40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PVModule_simple_ZeroOrder;
