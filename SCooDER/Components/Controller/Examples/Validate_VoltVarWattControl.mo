within SCooDER.Components.Controller.Examples;
model Validate_VoltVarWattControl
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp ramp(
    duration=1,
    startTime=0,
    height=0.2,
    offset=0.9)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  SCooDER.Components.Controller.Model.voltVarWatt_param_firstorder
    voltVarWatt_param_firstorder(Tfirstorder=0.001)
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
equation
  connect(voltVarWatt_param_firstorder.Vpu, ramp.y)
    annotation (Line(points={{-10,0},{-69,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Validate_VoltVarWattControl;
