within SCooDER.Components.Photovoltaics.Model;
model PVsimple
  parameter Real n(min=0, unit="1") = 14 "Number of PV modules";
  parameter Real A(min=0, unit="m2") = 1.65 "Net surface area per module";
  parameter Real eta(min=0, max=1, unit="1") = 0.15
    "Module conversion efficiency";
  Modelica.Blocks.Interfaces.RealInput G(min=0, unit="W/m2")
    "Total solar irradiation per unit area"
     annotation (Placement(transformation(
        origin={-120,0},
        extent={{20,20},{-20,-20}},
        rotation=180), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0})));
  Modelica.Blocks.Interfaces.RealOutput PV_generation "PV generation"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
equation
  PV_generation = A * n * eta * G;
end PVsimple;
