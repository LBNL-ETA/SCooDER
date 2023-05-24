within SCooDER.Components.Grid.Model;
model EplusCsvReader
  parameter String fileName="" "name of the csv file to read";
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    fileName=fileName,
    columns={5,10,14,18,22,26,30,34,38,42,46,50,54,58,62,66},
    tableName="csv",
    startTime=-5*60) "E+ reader"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

  Modelica.Blocks.Interfaces.RealOutput P
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealInput T_set_cool(unit="C", start=24.0) annotation (
      Placement(transformation(
        origin={-120,80},
        extent={{20,20},{-20,-20}},
        rotation=180), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0})));
  Modelica.Blocks.Interfaces.RealInput T_set_heat(unit="C", start=20.0) annotation (
      Placement(transformation(
        origin={-120,50},
        extent={{20,20},{-20,-20}},
        rotation=180), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0})));
  Modelica.Blocks.Interfaces.RealOutput T_0_0(unit="C", start=20.0)
    annotation (Placement(transformation(extent={{40,-10},{50,0}})));
  Modelica.Blocks.Interfaces.RealOutput T_0_1(unit="C", start=20.0)
    annotation (Placement(transformation(extent={{40,-16},{50,-6}})));
  Modelica.Blocks.Interfaces.RealOutput T_0_2(unit="C", start=20.0)
    annotation (Placement(transformation(extent={{40,-22},{50,-12}})));
  Modelica.Blocks.Interfaces.RealOutput T_0_3(unit="C", start=20.0)
    annotation (Placement(transformation(extent={{40,-28},{50,-18}})));
  Modelica.Blocks.Interfaces.RealOutput T_0_4(unit="C", start=20.0)
    annotation (Placement(transformation(extent={{40,-34},{50,-24}})));
  Modelica.Blocks.Interfaces.RealOutput T_1_0(unit="C", start=20.0)
    annotation (Placement(transformation(extent={{60,-10},{70,0}})));
  Modelica.Blocks.Interfaces.RealOutput T_1_1(unit="C", start=20.0)
    annotation (Placement(transformation(extent={{60,-16},{70,-6}})));
  Modelica.Blocks.Interfaces.RealOutput T_1_2(unit="C", start=20.0)
    annotation (Placement(transformation(extent={{60,-22},{70,-12}})));
  Modelica.Blocks.Interfaces.RealOutput T_1_3(unit="C", start=20.0)
    annotation (Placement(transformation(extent={{60,-28},{70,-18}})));
  Modelica.Blocks.Interfaces.RealOutput T_1_4(unit="C", start=20.0)
    annotation (Placement(transformation(extent={{60,-34},{70,-24}})));
  Modelica.Blocks.Interfaces.RealOutput T_2_0(unit="C", start=20.0)
    annotation (Placement(transformation(extent={{80,-10},{90,0}})));
  Modelica.Blocks.Interfaces.RealOutput T_2_1(unit="C", start=20.0)
    annotation (Placement(transformation(extent={{80,-16},{90,-6}})));
  Modelica.Blocks.Interfaces.RealOutput T_2_2(unit="C", start=20.0)
    annotation (Placement(transformation(extent={{80,-22},{90,-12}})));
  Modelica.Blocks.Interfaces.RealOutput T_2_3(unit="C", start=20.0)
    annotation (Placement(transformation(extent={{80,-28},{90,-18}})));
  Modelica.Blocks.Interfaces.RealOutput T_2_4(unit="C", start=20.0)
    annotation (Placement(transformation(extent={{80,-34},{90,-24}})));
  Modelica.Blocks.Interfaces.RealOutput T_cool
    annotation (Placement(transformation(extent={{100,80},{120,100}})));
  Modelica.Blocks.Interfaces.RealOutput T_heat
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
equation
  connect(combiTimeTable.y[1], P)
    annotation (Line(points={{-39,0},{0,0},{0,40},{110,40}}, color={0,0,127}));
  connect(combiTimeTable.y[2], T_0_0) annotation (Line(points={{-39,0},{34,0},{
          34,-5},{45,-5}}, color={0,0,127}));
  connect(combiTimeTable.y[3], T_0_1) annotation (Line(points={{-39,0},{34,0},{
          34,-11},{45,-11}}, color={0,0,127}));
  connect(combiTimeTable.y[4], T_0_2) annotation (Line(points={{-39,0},{34,0},{
          34,-17},{45,-17}}, color={0,0,127}));
  connect(combiTimeTable.y[5], T_0_3) annotation (Line(points={{-39,0},{34,0},{
          34,-23},{45,-23}}, color={0,0,127}));
  connect(combiTimeTable.y[6], T_0_4) annotation (Line(points={{-39,0},{34,0},{
          34,-29},{45,-29}}, color={0,0,127}));
  connect(combiTimeTable.y[7], T_1_0) annotation (Line(points={{-39,0},{54,0},{
          54,-5},{65,-5}}, color={0,0,127}));
  connect(combiTimeTable.y[8], T_1_1) annotation (Line(points={{-39,0},{54,0},{
          54,-11},{65,-11}}, color={0,0,127}));
  connect(combiTimeTable.y[9], T_1_2) annotation (Line(points={{-39,0},{54,0},{
          54,-17},{65,-17}}, color={0,0,127}));
  connect(combiTimeTable.y[10], T_1_3) annotation (Line(points={{-39,0},{54,0},
          {54,-23},{65,-23}}, color={0,0,127}));
  connect(combiTimeTable.y[11], T_1_4) annotation (Line(points={{-39,0},{54,0},
          {54,-29},{65,-29}}, color={0,0,127}));
  connect(combiTimeTable.y[12], T_2_0) annotation (Line(points={{-39,0},{74,0},
          {74,-5},{85,-5}}, color={0,0,127}));
  connect(combiTimeTable.y[13], T_2_1) annotation (Line(points={{-39,0},{74,0},
          {74,-11},{85,-11}}, color={0,0,127}));
  connect(combiTimeTable.y[14], T_2_2) annotation (Line(points={{-39,0},{74,0},
          {74,-17},{85,-17}}, color={0,0,127}));
  connect(combiTimeTable.y[15], T_2_3) annotation (Line(points={{-39,0},{74,0},
          {74,-23},{85,-23}}, color={0,0,127}));
  connect(combiTimeTable.y[16], T_2_4) annotation (Line(points={{-39,0},{74,0},
          {74,-29},{85,-29}}, color={0,0,127}));
  connect(T_set_cool, T_cool) annotation (Line(points={{-120,80},{0,80},{0,90},
          {110,90}}, color={0,0,127}));
  connect(T_set_heat, T_heat) annotation (Line(points={{-120,50},{0,50},{0,70},
          {110,70}}, color={0,0,127}));
  annotation (experiment(StopTime=604800, __Dymola_Algorithm="Dassl"));
end EplusCsvReader;
