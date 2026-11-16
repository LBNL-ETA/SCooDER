within SCooDER.Systems.Microgrid.Examples;
model Test_Grid_monitoring
  SCooDER.Components.Sensor.Model.Grid_monitoring grid_monitoring
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Electrical.AC.OnePhase.Sources.Grid gri(f=60, V=240)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Buildings.Electrical.AC.OnePhase.Loads.Resistive load(mode=Buildings.Electrical.Types.Load.FixedZ_steady_state,
      P_nominal=1000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-70})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0.5)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Sources.Ramp ramp(duration=1)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
equation
  connect(load.terminal, grid_monitoring.terminal_p)
    annotation (Line(points={{0,-60},{0,-10}}, color={0,120,120}));
  connect(grid_monitoring.terminal_n, gri.terminal)
    annotation (Line(points={{0,10},{0,60}}, color={0,120,120}));
  connect(greaterThreshold.y, grid_monitoring.GridConnected) annotation (Line(
        points={{-29,0},{-20,0},{-20,6},{-11,6}}, color={255,0,255}));
  connect(ramp.y, greaterThreshold.u)
    annotation (Line(points={{-59,0},{-52,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_Grid_monitoring;
