within SCooDER.Systems.Microgrid.Examples;
model Test_Load_Shed
  extends Modelica.Icons.Example;
  Microgrid_PI_adv
            microgrid_PI_adv(
    Batt_delayP=0.1,
    Batt_delayQ=0.1,
    Batt_Ppref=true,
    Batt_SOC_start=0.1,
    Gen_SOC_start=1,
    Gen_Conso=0.05)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Buildings.Electrical.AC.OnePhase.Sources.Grid gri(f=60, V=240)
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Sources.Step gridConnected(
    height=1,
    offset=0,
    startTime(displayUnit="h") = 7200)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Modelica.Blocks.Sources.Constant Zero(k=0)
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  Modelica.Blocks.Sources.Trapezoid load_high(
    amplitude=3500,
    rising(displayUnit="h") = 1800,
    width(displayUnit="h") = 360,
    falling(displayUnit="h") = 1800,
    period(displayUnit="h") = 5400)
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.Trapezoid load_low(
    amplitude=3500,
    rising(displayUnit="h") = 1800,
    width(displayUnit="h") = 1800,
    falling(displayUnit="h") = 1800,
    period(displayUnit="h") = 10800)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
equation
  connect(gri.terminal, microgrid_PI_adv.term_p) annotation (Line(points={{30,60},
          {30,40},{30,20},{30,20}},       color={0,120,120}));
  connect(microgrid_PI_adv.Q_Load_low, Zero.y) annotation (Line(points={{39,-1},
          {39,-10},{6,-10},{6,80},{1,80}}, color={0,0,127}));
  connect(microgrid_PI_adv.Q_Load_high, Zero.y) annotation (Line(points={{33,-1},
          {33,-10},{6,-10},{6,80},{1,80}}, color={0,0,127}));
  connect(microgrid_PI_adv.PBattCtrl, Zero.y) annotation (Line(points={{18,15.2},
          {6,15.2},{6,80},{1,80}}, color={0,0,127}));
  connect(microgrid_PI_adv.PGenCtrl, Zero.y)
    annotation (Line(points={{18,12},{6,12},{6,80},{1,80}}, color={0,0,127}));
  connect(microgrid_PI_adv.P_PV, Zero.y)
    annotation (Line(points={{18,6},{6,6},{6,80},{1,80}}, color={0,0,127}));
  connect(load_high.y, microgrid_PI_adv.P_Load_high) annotation (Line(points={{
          -19,10},{0,10},{0,-16},{30,-16},{30,-1},{31,-1}}, color={0,0,127}));
  connect(load_low.y, microgrid_PI_adv.P_Load_low)
    annotation (Line(points={{-19,-20},{37,-20},{37,-1}}, color={0,0,127}));
  connect(microgrid_PI_adv.gridConnected, gridConnected.y) annotation (Line(
        points={{18,18},{0,18},{0,50},{-19,50}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=12240, __Dymola_Algorithm="Dassl"));
end Test_Load_Shed;
