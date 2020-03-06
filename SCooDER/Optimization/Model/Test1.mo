within SCooDER.Optimization.Model;
model Test1
  parameter Real capctrl=1;
  Modelica.Blocks.Math.Gain gain(k=capctrl)
    annotation (Placement(transformation(extent={{-20,40},{0,60}})));
  Modelica.Blocks.Interfaces.RealInput u
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=1, freqHz=2)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
equation
  connect(add.y, y)
    annotation (Line(points={{41,0},{110,0},{110,0}}, color={0,0,127}));
  connect(add.u1, gain.y)
    annotation (Line(points={{18,6},{10,6},{10,50},{1,50}}, color={0,0,127}));
  connect(add.u2, u) annotation (Line(points={{18,-6},{-44,-6},{-44,0},{-120,0}},
        color={0,0,127}));
  connect(sine.y, gain.u) annotation (Line(points={{-39,50},{-30,50},{-22,
          50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test1;
