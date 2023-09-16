within SCooDER.Components.Grid.Examples;
model Test_LTC_ctrl
  Model.LTC_ctrl LTC_ctrl
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant const(k=120)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Sources.Sine sine(
    amplitude=30,
    freqHz(displayUnit="Hz") = 1/60/60,
    offset=120)
    annotation (Placement(transformation(extent={{-40,-40},{-20,-20}})));
equation
  connect(const.y, LTC_ctrl.set)
    annotation (Line(points={{-29,0},{-12,0}}, color={0,0,127}));
  connect(sine.y, LTC_ctrl.mea)
    annotation (Line(points={{-19,-30},{0,-30},{0,-12}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=3600, __Dymola_Algorithm="Dassl"));
end Test_LTC_ctrl;
