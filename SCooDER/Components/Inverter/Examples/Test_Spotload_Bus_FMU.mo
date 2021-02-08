within SCooDER.Components.Inverter.Examples;
model Test_Spotload_Bus_FMU
  Model.SpotLoad_Y_PQ_extBus spotLoad_Y_PQ_ext
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid grid_Y(f=60, V=120)
    annotation (Placement(transformation(extent={{50,60},{70,80}})));
  Sensor.Model.Probe3ph sens_Y(V_nominal=120)
    annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.Line line_Y(
    V_nominal=120,
    P_nominal=50000,
    l=10000)
    annotation (Placement(transformation(extent={{40,-10},{20,10}})));
  Interfaces.LoadCtrlBus loadCtrlBus annotation (Placement(transformation(
          extent={{-120,-20},{-80,20}}), iconTransformation(extent={{-114,-30},
            {-94,-10}})));
equation
  connect(grid_Y.terminal,line_Y. terminal_n)
    annotation (Line(points={{60,60},{60,0},{40,0}},   color={0,120,120}));
  connect(line_Y.terminal_p,sens_Y. terminal_n)
    annotation (Line(points={{20,0},{10,0}},   color={0,120,120}));
  connect(sens_Y.terminal_p, spotLoad_Y_PQ_ext.terminal_n)
    annotation (Line(points={{-10,0},{-16,0},{-20,0}}, color={0,120,120}));
  connect(loadCtrlBus, spotLoad_Y_PQ_ext.ctrls) annotation (Line(
      points={{-100,0},{-70,0},{-40,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_Spotload_Bus_FMU;
