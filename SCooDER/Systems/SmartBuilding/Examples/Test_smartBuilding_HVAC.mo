within SCooDER.Systems.SmartBuilding.Examples;
model Test_smartBuilding_HVAC
  extends Modelica.Icons.Example;
  smartBuilding_HVAC Building
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource("modelica://SCooDER/Systems/SmartBuilding/El_Cajon-Gillespie_Field_AP.mos"),
      computeWetBulbTemperature=true) "Weather data reader"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(weaDat.weaBus, Building.weaBus) annotation (Line(
      points={{-60,0},{-20,0}},
      color={255,204,51},
      thickness=0.5));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
    coordinateSystem(preserveAspectRatio=false)), experiment(
      StartTime=15638400,
      StopTime=16848000,
      Interval=299.999808,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end Test_smartBuilding_HVAC;
