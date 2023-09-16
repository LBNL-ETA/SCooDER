within SCooDER.Components.Grid.Model;
model IEEE13_extPQ
  extends IEEE13_extPQ_base(
   redeclare Modelica.Blocks.Sources.RealExpression P_head_W(y=grid.P[1].real + grid.P[2].real + grid.P[3].real));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid grid(f=60, V=V_nominal)
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
equation
  connect(grid.terminal, ieee13.terminal[1])
    annotation (Line(points={{70,40},{70,20},{82,20}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end IEEE13_extPQ;
