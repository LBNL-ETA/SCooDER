within SCooDER.Systems.IntegratedEnergySystems;
model IEEE13_smartBuilding_external_base
  parameter Integer nodes=13 "Number of inputs";
  parameter Integer n_trans=1 "Number of transport models in system";
  parameter Real T_const=30 "Time constant for first order hold";
  //parameter String weather_file="" "Path to weather file" annotation(Evaluate=false);
  SmartBuilding.smartBuilding_external Site[nodes](each n_trans=n_trans)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})), Evaluate=false);
  Modelica.Blocks.Interfaces.RealInput P_set_battery[nodes](each unit="W",
      each start=0) annotation (Placement(transformation(
        origin={-110,70},
        extent={{10,-10},{-10,10}},
        rotation=180), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,70})));
  Modelica.Blocks.Interfaces.RealInput P_building[nodes](each unit="W", each
      start=0) annotation (Placement(transformation(
        origin={-110,-10},
        extent={{10,-10},{-10,10}},
        rotation=180), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-10})));
  Modelica.Blocks.Sources.RealExpression P_charger[nodes,n_trans](each y=0)
    annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  Modelica.Blocks.Discrete.FirstOrderHold firstOrderHold1[nodes](each
      samplePeriod=T_const)
    annotation (Placement(transformation(extent={{-92,64},{-80,76}})));
  Modelica.Blocks.Discrete.FirstOrderHold firstOrderHold2[nodes](each
      samplePeriod=T_const)
    annotation (Placement(transformation(extent={{-92,-16},{-80,-4}})));
equation
  connect(P_charger.y, Site.P_charger) annotation (Line(points={{-49,-20},{
          -46,-20},{-46,-6},{-41,-6}}, color={0,0,127}));
  connect(P_building, firstOrderHold2.u)
    annotation (Line(points={{-110,-10},{-93.2,-10}}, color={0,0,127}));
  connect(P_set_battery, firstOrderHold1.u)
    annotation (Line(points={{-110,70},{-93.2,70}}, color={0,0,127}));
  connect(firstOrderHold1.y, Site.P_set_battery) annotation (Line(points={{-79.4,
          70},{-60,70},{-60,7},{-41,7}}, color={0,0,127}));
  connect(firstOrderHold2.y, Site.P_building) annotation (Line(points={{-79.4,-10},
          {-60,-10},{-60,-3},{-41,-3}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)), Evaluate=false);
end IEEE13_smartBuilding_external_base;
