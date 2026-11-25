within SCooDER.Systems.SmartBuilding;
model DualSetpoint
  Modelica.Blocks.Interfaces.RealInput Tzone
    annotation (Placement(transformation(extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
  Modelica.Blocks.Interfaces.RealInput CoolSet
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput HeatSet
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}),
        iconTransformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.Continuous.LimPID conPID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,                                          k=1,
    Ti=30,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-70,-70},{-50,-50}})));
  Buildings.Controls.Continuous.LimPID conPID1(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=30,
    yMax=0,
    yMin=-1,
    k=1,
    initType=Modelica.Blocks.Types.Init.NoInit)
    annotation (Placement(transformation(extent={{-90,50},{-70,70}})));
  Modelica.Blocks.Interfaces.RealOutput yHeat "Heating output signal"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Modelica.Blocks.Interfaces.RealOutput yCool "Cooling output signal"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealOutput yHvac "Cooling output signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
equation
  connect(HeatSet, conPID.u_s) annotation (Line(points={{-120,-60},{-72,
          -60}},                   color={0,0,127}));
  connect(CoolSet, conPID1.u_s) annotation (Line(points={{-120,60},{-92,
          60}},                   color={0,0,127}));
  connect(Tzone, conPID1.u_m) annotation (Line(points={{0,-120},{0,0},{-80,0},{
          -80,48}}, color={0,0,127}));
  connect(conPID.y, yHeat)
    annotation (Line(points={{-49,-60},{30,-60},{30,-80},{110,-80}},
                                                 color={0,0,127}));
  connect(conPID1.y, yCool) annotation (Line(points={{-69,60},{40,60},{40,-60},
          {110,-60}},    color={0,0,127}));
  connect(Tzone, conPID.u_m) annotation (Line(points={{0,-120},{0,-80},{-60,-80},
          {-60,-72}},
                    color={0,0,127}));
  connect(add.y, yHvac)
    annotation (Line(points={{81,0},{110,0}}, color={0,0,127}));
  connect(add.u2, conPID.y) annotation (Line(points={{58,-6},{30,-6},{30,-60},{
          -49,-60}}, color={0,0,127}));
  connect(conPID1.y, add.u1) annotation (Line(points={{-69,60},{40,60},{40,6},{
          58,6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,98},{100,-100}},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,0}),
        Rectangle(
          extent={{60,100},{100,60}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-100,100},{-60,60}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-60,100},{60,60}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-60,60},{60,60},{40,40},{-40,40},{-60,60}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,60},{-60,60},{-40,40},{40,40},{60,60},{100,60}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Rectangle(
          extent={{-60,-60},{60,-100}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{-100,-60},{-60,-100}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Rectangle(
          extent={{60,-60},{100,-100}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Polygon(
          points={{-60,-60},{60,-60},{40,-40},{-40,-40},{-60,-60}},
          fillColor={215,215,215},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
        Line(
          points={{-100,-60},{-60,-60},{-40,-40},{40,-40},{60,-60},{100,
              -60}},
          color={0,0,0},
          pattern=LinePattern.Dash),
        Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
        Text(
          extent={{-150,140},{150,100}},
          textString="%name",
          lineColor={0,0,255})}),           Diagram(coordinateSystem(
          preserveAspectRatio=false)));
end DualSetpoint;
