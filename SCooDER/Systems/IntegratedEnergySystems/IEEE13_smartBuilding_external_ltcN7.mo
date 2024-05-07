within SCooDER.Systems.IntegratedEnergySystems;
model IEEE13_smartBuilding_external_ltcN7
  extends IEEE13_smartBuilding_external_base
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)), Evaluate=false);
  Components.Grid.Model.IEEE13_extPQ_ltc Grid(nodes=nodes, sensLoc=7)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
equation
  connect(Site.En_vvw, Grid.En_vvw) annotation (Line(points={{-19,-9},{0.5,-9},
          {0.5,-9},{19,-9}}, color={0,0,127}));
  connect(Site.P_cha, Grid.P_cha) annotation (Line(points={{-19,-3},{-0.5,-3},
          {-0.5,-3},{19,-3}}, color={0,0,127}));
  connect(Site.P_pv, Grid.P_pv) annotation (Line(points={{-19,-1},{-0.5,-1},{
          -0.5,-1},{19,-1}}, color={0,0,127}));
  connect(Site.P, Grid.P_load) annotation (Line(points={{-19,3},{-0.5,3},{
          -0.5,3},{19,3}}, color={0,0,127}));
end IEEE13_smartBuilding_external_ltcN7;
