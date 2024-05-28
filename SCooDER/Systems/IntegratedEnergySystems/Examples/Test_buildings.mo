within SCooDER.Systems.IntegratedEnergySystems.Examples;
model Test_buildings
  extends Modelica.Icons.Example;
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
    f=1/86400,
    offset=2000)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Sources.Sine Building2(
    amplitude=15000,
    f=1/86400,
    offset=2000)
    annotation (Placement(transformation(extent={{-90,-42},{-70,-22}})));
  Modelica.Blocks.Sources.Sine Building3(
    amplitude=20000,
    f=1/86400,
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
    annotation (Line(points={{-69,0},{-40,0},{-40,-1.46154},{19,-1.46154}},
                                                                 color={0,0,127}));
  connect(Building2.y, iEEE13_smartBuilding.P_building[2]) annotation (Line(points={{-69,-32},
          {-40,-32},{-40,-1.38462},{19,-1.38462}},
                                       color={0,0,127}));
  connect(Building3.y, iEEE13_smartBuilding.P_building[3]) annotation (Line(points={{-69,-64},
          {-40,-64},{-40,-1.30769},{19,-1.30769}},
                                       color={0,0,127}));
  connect(BuildingX[1].y, iEEE13_smartBuilding.P_building[4]) annotation (Line(points={{1,-40},
          {8,-40},{8,-1.23077},{19,-1.23077}},
                                        color={0,0,127}));
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
