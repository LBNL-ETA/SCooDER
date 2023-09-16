within SCooDER.Systems;
package IntegratedEnergySystems
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

  model IEEE13_smartBuilding_external
    extends IEEE13_smartBuilding_external_base
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)), Evaluate=false);
    Components.Grid.Model.IEEE13_extPQ Grid(nodes=nodes)
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  equation
    connect(Site.En_vvw, Grid.En_vvw) annotation (Line(points={{-19,-9},{0.5,-9},
            {0.5,-9},{19,-9}}, color={0,0,127}));
    connect(Site.P_cha, Grid.P_cha) annotation (Line(points={{-19,-3},{-0.5,-3},
            {-0.5,-3},{19,-3}}, color={0,0,127}));
    connect(Site.P_pv, Grid.P_pv) annotation (Line(points={{-19,-1},{-0.5,-1},{
            -0.5,-1},{19,-1}}, color={0,0,127}));
    connect(Site.P, Grid.P_load) annotation (Line(points={{-19,3},{-0.5,3},{-0.5,
            3},{19,3}}, color={0,0,127}));
  end IEEE13_smartBuilding_external;

  model IEEE13_smartBuilding_ev_external
    extends IEEE13_smartBuilding_ev_external_base
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)), Evaluate=false);
    Components.Grid.Model.IEEE13_extPQ Grid(nodes=nodes)
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  equation
    connect(Site.En_vvw, Grid.En_vvw) annotation (Line(points={{-19,-9},{0.5,-9},
            {0.5,-9},{19,-9}}, color={0,0,127}));
    connect(Site.P_cha, Grid.P_cha) annotation (Line(points={{-19,-3},{-0.5,-3},
            {-0.5,-3},{19,-3}}, color={0,0,127}));
    connect(Site.P_pv, Grid.P_pv) annotation (Line(points={{-19,-1},{-0.5,-1},{
            -0.5,-1},{19,-1}}, color={0,0,127}));
    connect(Site.P, Grid.P_load) annotation (Line(points={{-19,3},{-0.5,3},{-0.5,
            3},{19,3}}, color={0,0,127}));
  end IEEE13_smartBuilding_ev_external;

  model IEEE13_smartBuilding_external_ltcN2
    extends IEEE13_smartBuilding_external_base
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)), Evaluate=false);
    Components.Grid.Model.IEEE13_extPQ_ltc Grid(nodes=nodes, sensLoc=2)
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
  end IEEE13_smartBuilding_external_ltcN2;

  model IEEE13_smartBuilding_ev_external_ltcN2
    extends IEEE13_smartBuilding_ev_external_base
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)), Evaluate=false);
    Components.Grid.Model.IEEE13_extPQ_ltc Grid(nodes=nodes, sensLoc=2)
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  equation
    connect(Site.En_vvw, Grid.En_vvw) annotation (Line(points={{-19,-9},{0.5,-9},
            {0.5,-9},{19,-9}}, color={0,0,127}));
    connect(Site.P_cha, Grid.P_cha) annotation (Line(points={{-19,-3},{-0.5,-3},
            {-0.5,-3},{19,-3}}, color={0,0,127}));
    connect(Site.P_pv, Grid.P_pv) annotation (Line(points={{-19,-1},{-0.5,-1},{
            -0.5,-1},{19,-1}}, color={0,0,127}));
    connect(Site.P, Grid.P_load) annotation (Line(points={{-19,3},{-0.5,3},{-0.5,
            3},{19,3}}, color={0,0,127}));
  end IEEE13_smartBuilding_ev_external_ltcN2;

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

  model IEEE13_smartBuilding_ev_external_ltcN7
    extends IEEE13_smartBuilding_ev_external_base
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
    connect(Site.P, Grid.P_load) annotation (Line(points={{-19,3},{-0.5,3},{-0.5,
            3},{19,3}}, color={0,0,127}));
  end IEEE13_smartBuilding_ev_external_ltcN7;

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    model Test_IES_with_transport_10evs
      parameter Integer nodes=13;
      parameter Integer n_evs=10;
      parameter Integer n_cha=24;
      parameter Integer n_trans=1;
      parameter String fileName="C:/Users/Christoph/Documents/PrivateRepos/ies/resources/transportation/test_10-24-13-1.txt";
      parameter String weather_file=Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos") "Path to weather file";
      IEEE13_smartBuilding_ev_external IEEE13_smartBuilding(
        nodes=nodes,
        n_trans=n_trans,
        Site(use_smartinverter=1, weather_file=weather_file))
        annotation (Placement(transformation(extent={{60,-10},{80,10}})));
      Components.ElectricVehicle.EV_transport_extTable EVtransport[n_trans](
        n_evs=n_evs,
        n_cha=n_cha,                                                        n_site=
            nodes, fileName=fileName)
        annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
      Modelica.Blocks.Sources.RealExpression charger_Pset[n_trans,n_cha](y=
            ChargerSine.y*ones(n_trans, n_cha))
        annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
      Modelica.Blocks.Sources.Sine ChargerSine(
        amplitude=1000,
        freqHz=1/86400,
        offset=2000)
        annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
      Modelica.Blocks.Sources.RealExpression battery_Pset[nodes](y=0*ones(nodes))
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      Modelica.Blocks.Sources.RealExpression building_P[nodes](y=0*ones(nodes))
        annotation (Placement(transformation(extent={{-60,-18},{-40,2}})));
    equation
      connect(charger_Pset.y, EVtransport.PPlugCtrl) annotation (Line(points={{-39,-30},
              {-26,-30},{-26,-23},{-12,-23}}, color={0,0,127}));
      connect(battery_Pset.y,IEEE13_smartBuilding. P_set_battery) annotation (Line(
            points={{-39,10},{10,10},{10,7},{59,7}}, color={0,0,127}));
      connect(building_P.y,IEEE13_smartBuilding. P_building) annotation (Line(
            points={{-39,-8},{10,-8},{10,-1},{59,-1}}, color={0,0,127}));
      connect(IEEE13_smartBuilding.P_charger, EVtransport.P_site) annotation (Line(
            points={{59,-5},{35.5,-5},{35.5,-30},{11,-30}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
    end Test_IES_with_transport_10evs;

    model Test_IES_with_transport_200evs
      parameter Integer nodes=13;
      parameter Integer n_evs=200;
      parameter Integer n_cha=512;
      parameter Integer n_trans=1;
      parameter String fileName="C:/Users/Christoph/Documents/PrivateRepos/ies/resources/transportation/test_200-512-13-2.txt";
      parameter String weather_file=Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos") "Path to weather file";
      IEEE13_smartBuilding_ev_external IEEE13_smartBuilding(
        nodes=nodes,
        n_trans=n_trans,
        Site(use_smartinverter=1, weather_file=weather_file))
        annotation (Placement(transformation(extent={{60,-10},{80,10}})));
      Components.ElectricVehicle.EV_transport_extTable EVtransport[n_trans](
        n_evs=n_evs,
        n_cha=n_cha,                                                        n_site=
            nodes, fileName=fileName)
        annotation (Placement(transformation(extent={{-10,-40},{10,-20}})));
      Modelica.Blocks.Sources.RealExpression charger_Pset[n_trans,n_cha](y=
            ChargerSine.y*ones(n_trans, n_cha))
        annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
      Modelica.Blocks.Sources.Sine ChargerSine(
        amplitude=1000,
        freqHz=1/86400,
        offset=2000)
        annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));
      Modelica.Blocks.Sources.RealExpression battery_Pset[nodes](y=0*ones(nodes))
        annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
      Modelica.Blocks.Sources.RealExpression building_P[nodes](y=0*ones(nodes))
        annotation (Placement(transformation(extent={{-60,-18},{-40,2}})));
    equation
      connect(charger_Pset.y, EVtransport.PPlugCtrl) annotation (Line(points={{-39,-30},
              {-26,-30},{-26,-23},{-12,-23}}, color={0,0,127}));
      connect(battery_Pset.y,IEEE13_smartBuilding. P_set_battery) annotation (Line(
            points={{-39,10},{10,10},{10,7},{59,7}}, color={0,0,127}));
      connect(building_P.y,IEEE13_smartBuilding. P_building) annotation (Line(
            points={{-39,-8},{10,-8},{10,-1},{59,-1}}, color={0,0,127}));
      connect(IEEE13_smartBuilding.P_charger, EVtransport.P_site) annotation (Line(
            points={{59,-5},{35.5,-5},{35.5,-30},{11,-30}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
    end Test_IES_with_transport_200evs;

    model Test_buildings
      parameter Integer nodes=13;
      //parameter Integer n_evs=200;
      //parameter Integer n_cha=512;
      //parameter Integer n_trans=1;
      //parameter String fileName="C:/Users/Christoph/Documents/PrivateRepos/ies/resources/transportation/test_200-512-13-2.txt";
      parameter String weather_file=Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos") "Path to weather file";
      IEEE13_smartBuilding_ev_external_ltcN7
                                          iEEE13_smartBuilding(
        nodes=nodes,
        n_trans=1,
        Site(use_smartinverter=0, weather_file=weather_file))
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      Modelica.Blocks.Sources.RealExpression battery_Pset[nodes](y=0*ones(nodes))
        annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
      Modelica.Blocks.Sources.Sine Building1(
        amplitude=10000,
        freqHz=1/86400,
        offset=2000)
        annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
      Modelica.Blocks.Sources.Sine Building2(
        amplitude=15000,
        freqHz=1/86400,
        offset=2000)
        annotation (Placement(transformation(extent={{-90,-42},{-70,-22}})));
      Modelica.Blocks.Sources.Sine Building3(
        amplitude=20000,
        freqHz=1/86400,
        offset=2000)
        annotation (Placement(transformation(extent={{-90,-74},{-70,-54}})));
      Modelica.Blocks.Sources.RealExpression BuildingX[nodes - 3](y=0*ones(nodes - 3))
        annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));
      Modelica.Blocks.Sources.RealExpression charger_Pset[1,nodes](y=0)
        annotation (Placement(transformation(extent={{-10,-70},{10,-50}})));
    equation
      connect(battery_Pset.y, iEEE13_smartBuilding.P_set_battery)
        annotation (Line(points={{-39,20},{-26,20},{-26,7},{19,7}},  color={0,0,127}));
      connect(Building1.y, iEEE13_smartBuilding.P_building[1])
        annotation (Line(points={{-69,0},{-40,0},{-40,-1},{19,-1}},  color={0,0,127}));
      connect(Building2.y, iEEE13_smartBuilding.P_building[2]) annotation (Line(points={{-69,-32},
              {-40,-32},{-40,-1},{19,-1}}, color={0,0,127}));
      connect(Building3.y, iEEE13_smartBuilding.P_building[3]) annotation (Line(points={{-69,-64},
              {-40,-64},{-40,-1},{19,-1}}, color={0,0,127}));
      connect(BuildingX[1].y, iEEE13_smartBuilding.P_building[4]) annotation (Line(points={{1,-40},
              {8,-40},{8,-1},{19,-1}},      color={0,0,127}));
      connect(BuildingX[2].y, iEEE13_smartBuilding.P_building[5]);
      connect(BuildingX[3].y, iEEE13_smartBuilding.P_building[6]);
      connect(BuildingX[4].y, iEEE13_smartBuilding.P_building[7]);
      connect(BuildingX[5].y, iEEE13_smartBuilding.P_building[8]);
      connect(BuildingX[6].y, iEEE13_smartBuilding.P_building[9]);
      connect(BuildingX[7].y, iEEE13_smartBuilding.P_building[10]);
      connect(BuildingX[8].y, iEEE13_smartBuilding.P_building[11]);
      connect(BuildingX[9].y, iEEE13_smartBuilding.P_building[12]);
      connect(BuildingX[10].y, iEEE13_smartBuilding.P_building[13]);
      connect(charger_Pset.y, iEEE13_smartBuilding.P_charger) annotation (Line(
            points={{11,-60},{14,-60},{14,-5},{19,-5}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
    end Test_buildings;
  end Examples;
end IntegratedEnergySystems;
