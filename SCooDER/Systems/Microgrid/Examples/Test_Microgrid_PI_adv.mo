within SCooDER.Systems.Microgrid.Examples;
model Test_Microgrid_PI_adv
  extends Modelica.Icons.Example;
  Microgrid_PI_adv microgrid_PI_adv(
    Batt_delayP=0.1,
    Batt_EMax=50,
    Batt_Pmax=3500,
    Batt_SOC_start=0.95,
    Gen_Capacity=0.01)
    annotation (Placement(transformation(extent={{20,2},{60,42}})));
  Buildings.Electrical.AC.OnePhase.Sources.Grid grid(f=60, V=240)
    annotation (Placement(transformation(extent={{30,70},{50,90}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=5500,
    duration=10,
    offset=2000,
    startTime=10)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Blocks.Sources.Step step(height=-4000, startTime=40)
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=-3500,
    duration=20,
    startTime=55)
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Modelica.Blocks.Math.Add3 pload
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Modelica.Blocks.Sources.Constant qload(k=0)
    annotation (Placement(transformation(extent={{30,-70},{50,-50}})));
  Modelica.Blocks.Sources.Constant PV(k=3000)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.Blocks.Sources.Step gridConnected(
    height=-1,
    offset=1,
    startTime=5)
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Modelica.Blocks.Sources.Constant Battery(k=0)
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
equation
  connect(grid.terminal, microgrid_PI_adv.term_p)
    annotation (Line(points={{40,70},{40,42}}, color={0,120,120}));
  connect(pload.y, microgrid_PI_adv.P_Load_low)
    annotation (Line(points={{41,-30},{54,-30},{54,0}}, color={0,0,127}));
  connect(pload.u1, ramp.y) annotation (Line(points={{18,-22},{-14,-22},{-14,-20},
          {-19,-20}}, color={0,0,127}));
  connect(pload.u2, step.y) annotation (Line(points={{18,-30},{-14,-30},{-14,-50},
          {-19,-50}}, color={0,0,127}));
  connect(pload.u3, ramp1.y) annotation (Line(points={{18,-38},{-10,-38},{-10,-80},
          {-19,-80}}, color={0,0,127}));
  connect(qload.y, microgrid_PI_adv.Q_Load_low)
    annotation (Line(points={{51,-60},{58,-60},{58,0}}, color={0,0,127}));
  connect(PV.y, microgrid_PI_adv.P_PV) annotation (Line(points={{-39,10},{0,10},
          {0,14},{16,14}}, color={0,0,127}));
  connect(gridConnected.y, microgrid_PI_adv.gridConnected) annotation (Line(
        points={{-39,80},{8,80},{8,38},{16,38}}, color={0,0,127}));
  connect(microgrid_PI_adv.Q_Load_high, microgrid_PI_adv.Q_Load_low)
    annotation (Line(points={{46,0},{46,-12},{58,-12},{58,0}}, color={0,0,127}));
  connect(microgrid_PI_adv.P_Load_high, microgrid_PI_adv.Q_Load_low)
    annotation (Line(points={{42,0},{42,-12},{58,-12},{58,0}}, color={0,0,127}));
  connect(Battery.y, microgrid_PI_adv.PBattCtrl) annotation (Line(points={{-39,
          50},{0,50},{0,30},{8,30},{8,32.4},{16,32.4}}, color={0,0,127}));
  connect(microgrid_PI_adv.PGenCtrl, microgrid_PI_adv.Q_Load_low) annotation (
      Line(points={{16,26},{4,26},{4,-12},{58,-12},{58,0}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=120, __Dymola_Algorithm="Dassl"));
end Test_Microgrid_PI_adv;
