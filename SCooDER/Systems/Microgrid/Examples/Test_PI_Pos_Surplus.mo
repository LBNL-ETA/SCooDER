within SCooDER.Systems.Microgrid.Examples;
model Test_PI_Pos_Surplus
  Microgrid_PI
            microgrid_PI
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Buildings.Electrical.AC.OnePhase.Sources.Grid gri(f=60, V=240)
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=5500,
    duration=20,
    offset=4500,
    startTime=10)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Blocks.Sources.Step step(height=-6000, startTime=40)
    annotation (Placement(transformation(extent={{-40,-62},{-20,-42}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=5000,
    duration=30,
    startTime=60)
    annotation (Placement(transformation(extent={{-40,-94},{-20,-74}})));
  Modelica.Blocks.Math.Add3 add3_1
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{20,-68},{40,-48}})));
  Modelica.Blocks.Sources.Constant PV(k=4000)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.Step gridConnected(
    height=-1,
    offset=1,
    startTime=5)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
equation
  connect(gri.terminal, microgrid_PI.term_p) annotation (Line(points={{30,60},{
          30,40},{30,20},{30.6,20}}, color={0,120,120}));
  connect(add3_1.y, microgrid_PI.P_Load)
    annotation (Line(points={{21,-30},{32,-30},{32,-2}}, color={0,0,127}));
  connect(add3_1.u1, ramp.y)
    annotation (Line(points={{-2,-22},{-12,-22},{-12,-20},{-19,-20}},
                                                  color={0,0,127}));
  connect(add3_1.u2, step.y) annotation (Line(points={{-2,-30},{-14,-30},{-14,
          -52},{-19,-52}}, color={0,0,127}));
  connect(add3_1.u3, ramp1.y) annotation (Line(points={{-2,-38},{-10,-38},{-10,
          -84},{-19,-84}}, color={0,0,127}));
  connect(const.y, microgrid_PI.Q_Load) annotation (Line(points={{41,-58},{44,-58},
          {44,-2},{38,-2}}, color={0,0,127}));
  connect(PV.y, microgrid_PI.P_PV) annotation (Line(points={{-19,10},{-2,10},{-2,
          4},{18,4}}, color={0,0,127}));
  connect(gridConnected.y, microgrid_PI.gridConnected) annotation (Line(points={{-19,50},
          {0,50},{0,18},{18,18}},                 color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100));
end Test_PI_Pos_Surplus;
