within SCooDER.Systems.IntegratedEnergySystems;
model IEEE13_smartBuilding_ev_external_base
  parameter Integer nodes=13 "Number of inputs";
  parameter Integer n_trans=5 "Number of transport models in system";
  parameter Real T_const=30 "Time constant for first order hold";
  //parameter String weather_file="" "Path to weather file" annotation(Evaluate=false);
  SmartBuilding.smartBuilding_external Site[nodes](each n_trans=n_trans)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})), Evaluate=true);
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
  Modelica.Blocks.Interfaces.RealInput P_charger[n_trans,nodes](each unit="W",
      each start=0) annotation (Placement(transformation(
        origin={-110,-50},
        extent={{10,-10},{-10,10}},
        rotation=180), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-50})));
  Modelica.Blocks.Discrete.FirstOrderHold firstOrderHold1[nodes](each
      samplePeriod=T_const)
    annotation (Placement(transformation(extent={{-92,64},{-80,76}})));
  Modelica.Blocks.Discrete.FirstOrderHold firstOrderHold2[nodes](each
      samplePeriod=T_const)
    annotation (Placement(transformation(extent={{-92,-16},{-80,-4}})));
  Modelica.Blocks.Discrete.FirstOrderHold firstOrderHold3[n_trans,nodes](each
      samplePeriod=T_const)
    annotation (Placement(transformation(extent={{-92,-56},{-80,-44}})));
equation
  for t in 1:n_trans loop
    for n in 1:nodes loop
      connect(firstOrderHold3[t, n].y, Site[n].P_charger[t]);
    end for;
  end for;
  connect(P_set_battery, firstOrderHold1.u)
    annotation (Line(points={{-110,70},{-93.2,70}}, color={0,0,127}));
  connect(P_building, firstOrderHold2.u)
    annotation (Line(points={{-110,-10},{-93.2,-10}}, color={0,0,127}));
  connect(firstOrderHold2.y, Site.P_building) annotation (Line(points={{-79.4,-10},
          {-60,-10},{-60,-3},{-41,-3}}, color={0,0,127}));
  connect(firstOrderHold1.y, Site.P_set_battery) annotation (Line(points={{-79.4,
          70},{-60,70},{-60,7},{-41,7}}, color={0,0,127}));
  connect(P_charger, firstOrderHold3.u)
    annotation (Line(points={{-110,-50},{-93.2,-50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)), Evaluate=false);
end IEEE13_smartBuilding_ev_external_base;
