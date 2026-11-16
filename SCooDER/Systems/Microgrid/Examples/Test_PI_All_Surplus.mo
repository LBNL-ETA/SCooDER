within SCooDER.Systems.Microgrid.Examples;
model Test_PI_All_Surplus
  Microgrid_PI
            microgrid_PI
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Buildings.Electrical.AC.OnePhase.Sources.Grid gri(f=60, V=240)
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=5500,
    duration=10,
    offset=1500,
    startTime=10)
    annotation (Placement(transformation(extent={{-40,-26},{-20,-6}})));
  Modelica.Blocks.Sources.Step step(height=-4000, startTime=30)
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Blocks.Sources.Ramp ramp1(height=-3500,
                                     startTime=50)
    annotation (Placement(transformation(extent={{-40,-92},{-20,-72}})));
  Modelica.Blocks.Math.Add3 add3_1
    annotation (Placement(transformation(extent={{-6,-34},{14,-14}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{20,-68},{40,-48}})));
  Modelica.Blocks.Sources.Constant PV(k=4000)
    annotation (Placement(transformation(extent={{-38,6},{-18,26}})));
  Modelica.Blocks.Sources.Step gridConnected(
    height=-1,
    offset=1,
    startTime=5)
    annotation (Placement(transformation(extent={{-20,42},{0,62}})));
equation
  connect(gri.terminal, microgrid_PI.term_p) annotation (Line(points={{30,60},{
          30,40},{30,20},{30.6,20}}, color={0,120,120}));
  connect(add3_1.y, microgrid_PI.P_Load)
    annotation (Line(points={{15,-24},{32,-24},{32,-2}}, color={0,0,127}));
  connect(add3_1.u1, ramp.y)
    annotation (Line(points={{-8,-16},{-19,-16}}, color={0,0,127}));
  connect(add3_1.u2, step.y) annotation (Line(points={{-8,-24},{-14,-24},{-14,
          -50},{-19,-50}}, color={0,0,127}));
  connect(add3_1.u3, ramp1.y) annotation (Line(points={{-8,-32},{-14,-32},{-14,
          -82},{-19,-82}}, color={0,0,127}));
  connect(const.y, microgrid_PI.Q_Load) annotation (Line(points={{41,-58},{44,-58},
          {44,-2},{38,-2}}, color={0,0,127}));
  connect(PV.y, microgrid_PI.P_PV)
    annotation (Line(points={{-17,16},{0,16},{0,4},{18,4}}, color={0,0,127}));
  connect(gridConnected.y, microgrid_PI.gridConnected) annotation (Line(points={{1,52},{
          10,52},{10,18},{18,18}},                color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=50));
end Test_PI_All_Surplus;
