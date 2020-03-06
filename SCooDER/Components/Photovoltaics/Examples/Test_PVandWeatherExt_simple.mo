within SCooDER.Components.Photovoltaics.Examples;
model Test_PVandWeatherExt_simple
  extends Modelica.Icons.Example;

  Model.PVandWeatherExt_simple PV(weather_file=
        "C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos")
    annotation (Placement(transformation(extent={{40,-8},{60,12}})));
  Modelica.Blocks.Sources.Constant curtail(k=1)
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Modelica.Blocks.Sources.Sine ghi(amplitude=900, freqHz=1/(60*60*24))
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Math.Gain dhi(k=0.2)
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
equation
  connect(PV.scale, curtail.y) annotation (Line(points={{38,2},{-30,2},
          {-30,-10},{-39,-10}}, color={0,0,127}));
  connect(dhi.u, ghi.y)
    annotation (Line(points={{-22,30},{-39,30}}, color={0,0,127}));
  connect(PV.GHI, ghi.y) annotation (Line(points={{38,7},{-30,7},{-30,
          30},{-39,30}}, color={0,0,127}));
  connect(dhi.y, PV.DHI) annotation (Line(points={{1,30},{18,30},{18,10},
          {38,10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_PVandWeatherExt_simple;
