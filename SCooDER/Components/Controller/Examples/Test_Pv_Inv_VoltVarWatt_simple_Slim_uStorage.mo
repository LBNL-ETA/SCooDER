within SCooDER.Components.Controller.Examples;
model Test_Pv_Inv_VoltVarWatt_simple_Slim_uStorage
  extends Modelica.Icons.Example;
  SCooDER.Components.Controller.Model.Pv_Inv_VoltVarWatt_simple_Slim_uStoarge
    VVW(
    thrP=1,
    hysP=1,
    n=75,
    weather_file=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"),
    P_discharge=1.5,
    EMax=10)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Modelica.Blocks.Sources.Ramp ramp(
    height=0.5,
    offset=1,
    startTime=43200,
    duration=3600*2)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(ramp.y, VVW.Vpu)
    annotation (Line(points={{-39,0},{-12,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
    experiment(StartTime=0, StopTime=86400),
    Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_Pv_Inv_VoltVarWatt_simple_Slim_uStorage;
