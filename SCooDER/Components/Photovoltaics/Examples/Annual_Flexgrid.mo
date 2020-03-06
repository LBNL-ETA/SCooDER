within SCooDER.Components.Photovoltaics.Examples;
model Annual_Flexgrid
    extends Modelica.Icons.Example;
  Model.PVModule_simple Single_flexgrid
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon1(
      computeWetBulbTemperature=false, filNam="C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos")
    "Weather data reader with radiation data obtained from the inputs' connectors"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Sources.Constant shade(k=1)
    annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Modelica.Blocks.Math.Gain Full_Flexgrid(k=3)
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
equation
  connect(weaDatInpCon1.weaBus, Single_flexgrid.weaBus) annotation (Line(
      points={{-60,70},{-40,70},{-40,4},{-10,4}},
      color={255,204,51},
      thickness=0.5));
  connect(Single_flexgrid.scale, shade.y) annotation (Line(points={{-12,-4},{
          -40,-4},{-40,-20},{-59,-20}},
                                    color={0,0,127}));
  connect(Full_Flexgrid.u, Single_flexgrid.P)
    annotation (Line(points={{38,30},{20,30},{20,0},{11,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Annual_Flexgrid;
