within SCooDER.Systems.IntegratedEnergySystems.Examples;
model Test_MicrogridBuilding
  extends Modelica.Icons.Example;
  MicrogridLarge_SmartBuilding Site
    annotation (Placement(transformation(extent={{0,-20},{40,20}})));
  Modelica.Blocks.Sources.Constant pbatt(k=0)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Constant gridConn(k=1)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Routing.Replicator replicator
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
equation
  connect(gridConn.y, Site.gridConnected) annotation (Line(points={{-59,50},{
          -12,50},{-12,16},{-4,16}}, color={0,0,127}));
  connect(pbatt.y, replicator.u)
    annotation (Line(points={{-59,0},{-42,0}}, color={0,0,127}));
  connect(replicator.y, Site.PBattCtrl) annotation (Line(points={{-19,0},{-12,0},
          {-12,10},{-4,10}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=15552000,
      StopTime=15638400,
      __Dymola_Algorithm="Dassl"));
end Test_MicrogridBuilding;
