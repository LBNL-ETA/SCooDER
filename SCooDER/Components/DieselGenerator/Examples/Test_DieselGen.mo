within SCooDER.Components.DieselGenerator.Examples;
model Test_DieselGen
  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=60, V=240)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Constant Qctrl(k=3000)
    annotation (Placement(transformation(extent={{80,-30},{60,-10}})));
  Modelica.Blocks.Sources.Step Pctrl(
    height=3500,
    offset=4000,
    startTime=20)
    annotation (Placement(transformation(extent={{80,10},{60,30}})));
  Model.GenCtrlBus genCtrlBus annotation (Placement(transformation(extent={{10,
            -30},{30,-10}}), iconTransformation(extent={{-206,24},{-186,44}})));
  Model.DieselGen dieselGen
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(fixVol.terminal, dieselGen.term_p)
    annotation (Line(points={{-60,0},{-10,0}}, color={0,120,120}));
  connect(Qctrl.y, genCtrlBus.qctrl) annotation (Line(points={{59,-20},{40,-20},
          {40,-19.95},{20.05,-19.95}},
                                    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(Pctrl.y, genCtrlBus.pctrl) annotation (Line(points={{59,20},{20.05,20},
          {20.05,-19.95}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(genCtrlBus, dieselGen.genCtrlBus) annotation (Line(
      points={{20,-20},{0,-20},{0,-10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100));
end Test_DieselGen;
