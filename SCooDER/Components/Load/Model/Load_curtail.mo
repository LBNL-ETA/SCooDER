within SCooDER.Components.Load.Model;
model Load_curtail
  parameter Real delay_on( unit="s") = 60*60;
  parameter Real delay_cur( unit="s") = 1;
  parameter Real thr( unit="1") = 2;
  Modelica.Blocks.Logical.Greater curtail
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.RealExpression Threshold(y=thr)
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
  Modelica.Blocks.Interfaces.RealInput ctrl
    "Connector of first Real input signal"
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Modelica.Blocks.Interfaces.BooleanOutput cur
    "Connector of Boolean output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.MathBoolean.OnDelay on_delay(delayTime(displayUnit="s")=
      delay_on)
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));
  Modelica.Blocks.MathBoolean.Not not1
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.MathBoolean.And and1
    annotation (Placement(transformation(extent={{-178,48},{-166,60}})));
  Modelica.Blocks.MathBoolean.OnDelay curtail_delay(delayTime(displayUnit="s")=
         delay_cur)
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Modelica.Blocks.MathBoolean.Not not2
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Interfaces.BooleanInput rst "Boolean input signal"
    annotation (Placement(transformation(extent={{-120,-80},{-100,-60}})));
  Modelica.Blocks.MathBoolean.Not not3
    annotation (Placement(transformation(extent={{20,-80},{40,-60}})));
  Modelica.Blocks.Logical.And and2
    annotation (Placement(transformation(extent={{70,-48},{90,-28}})));
equation
  connect(Threshold.y, curtail.u2) annotation (Line(points={{-79,-30},{-70,-30},
          {-70,-8},{-62,-8}}, color={0,0,127}));
  connect(ctrl, curtail.u1)
    annotation (Line(points={{-110,0},{-62,0}}, color={0,0,127}));
  connect(curtail.y, curtail_delay.u)
    annotation (Line(points={{-39,0},{-34,0}}, color={255,0,255}));
  connect(curtail_delay.y, not1.u)
    annotation (Line(points={{-8,0},{-4,0}}, color={255,0,255}));
  connect(not1.y, on_delay.u)
    annotation (Line(points={{22,0},{26,0}}, color={255,0,255}));
  connect(on_delay.y, not2.u)
    annotation (Line(points={{52,0},{56,0}}, color={255,0,255}));
  connect(not3.u, rst)
    annotation (Line(points={{16,-70},{-110,-70}}, color={255,0,255}));
  connect(and2.u2, not3.y) annotation (Line(points={{68,-46},{50,-46},{50,-70},
          {42,-70}}, color={255,0,255}));
  connect(not2.y, and2.u1) annotation (Line(points={{82,0},{84,0},{84,-20},{50,
          -20},{50,-38},{68,-38}}, color={255,0,255}));
  connect(and2.y, cur) annotation (Line(points={{91,-38},{94,-38},{94,0},{110,0}},
        color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Load_curtail;
