within SCooDER.Systems.Examples;
model Test_PVannual
  Components.Photovoltaics.Model.PVModule_simple pv1(
    n=1,
    lat=37.9,
    til=10,
    azi=0,
    A=0.5)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon1(
      computeWetBulbTemperature=false, filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    "Weather data reader with radiation data obtained from the inputs' connectors"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Modelica.Blocks.Sources.Constant const(k=1)
    annotation (Placement(transformation(extent={{-60,-30},{-40,-10}})));
equation
  connect(pv1.scale, const.y) annotation (Line(points={{-10,-4},{-24,-4},{-24,
          -20},{-39,-20}}, color={0,0,127}));
  connect(weaDatInpCon1.weaBus, pv1.weaBus) annotation (Line(
      points={{-40,50},{-24,50},{-24,4},{-8,4}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_PVannual;
