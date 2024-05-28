within SCooDER.Components.Controller.Examples;
model Validate_VoltVarControl_param
  extends Modelica.Icons.Example;

  Modelica.Blocks.Sources.Ramp ramp(
    duration=1,
    startTime=0,
    height=0.2,
    offset=0.9)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  SCooDER.Components.Controller.Model.voltVar_param_simple
    voltVar_param
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(voltVar_param.Vpu, ramp.y)
    annotation (Line(points={{-12,0},{-69,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Validate_VoltVarControl_param;
