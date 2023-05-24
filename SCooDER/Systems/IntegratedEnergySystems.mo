within SCooDER.Systems;
package IntegratedEnergySystems
  model IEEE13_smartBuilding_external
    parameter Integer nodes=13 "Number of inputs";
    parameter Integer n_trans=1 "Number of transport models in system";
    //parameter String weather_file="" "Path to weather file" annotation(Evaluate=false);
    Components.Grid.Model.IEEE13_extPQ Grid(nodes=nodes)
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    SmartBuilding.smartBuilding_external Site[nodes](n_trans=n_trans)
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
    Modelica.Blocks.Sources.RealExpression P_charger[nodes,n_trans](y=0)
      annotation (Placement(transformation(extent={{-70,-30},{-50,-10}})));
  equation
    connect(Site.P, Grid.P_load) annotation (Line(points={{-19,3},{-0.5,3},{-0.5,3},
            {19,3}}, color={0,0,127}));
    connect(Site.P_pv, Grid.P_pv) annotation (Line(points={{-19,-3},{-0.5,-3},{-0.5,
            -3},{19,-3}}, color={0,0,127}));
    connect(P_set_battery, Site.P_set_battery) annotation (Line(points={{-110,70},
            {-80,70},{-80,7},{-41,7}}, color={0,0,127}));
    connect(Site.P_building, P_building) annotation (Line(points={{-41,-3},{-80,-3},
            {-80,-10},{-110,-10}}, color={0,0,127}));
    connect(Site.En_vvw, Grid.En_vvw) annotation (Line(points={{-19,-9},{0.5,-9},
            {0.5,-9},{19,-9}}, color={0,0,127}));
    connect(P_charger.y, Site.P_charger) annotation (Line(points={{-49,-20},{
            -46,-20},{-46,-6},{-41,-6}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)), Evaluate=false);
  end IEEE13_smartBuilding_external;

  model IEEE13_smartBuilding_ev_external
    parameter Integer nodes=13 "Number of inputs";
    parameter Integer n_trans=1 "Number of transport models in system";
    //parameter String weather_file="" "Path to weather file" annotation(Evaluate=false);
    Components.Grid.Model.IEEE13_extPQ Grid(nodes=nodes)
      annotation (Placement(transformation(extent={{20,-10},{40,10}})));
    SmartBuilding.smartBuilding_external Site[nodes](n_trans=n_trans)
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
  equation
    for t in 1:n_trans loop
      for n in 1:nodes loop
        connect(P_charger[t, n], Site[n].P_charger[t]);
      end for;
    end for;
    connect(Site.P, Grid.P_load) annotation (Line(points={{-19,3},{-0.5,3},{-0.5,3},
            {19,3}}, color={0,0,127}));
    connect(Site.P_pv, Grid.P_pv) annotation (Line(points={{-19,-3},{-0.5,-3},{-0.5,
            -3},{19,-3}}, color={0,0,127}));
    connect(P_set_battery, Site.P_set_battery) annotation (Line(points={{-110,70},
            {-80,70},{-80,7},{-41,7}}, color={0,0,127}));
    connect(Site.P_building, P_building) annotation (Line(points={{-41,-3},{-80,-3},
            {-80,-10},{-110,-10}}, color={0,0,127}));
    connect(Site.En_vvw, Grid.En_vvw) annotation (Line(points={{-19,-9},{0.5,-9},
            {0.5,-9},{19,-9}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)), Evaluate=false);
  end IEEE13_smartBuilding_ev_external;

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
  end Examples;
end IntegratedEnergySystems;
