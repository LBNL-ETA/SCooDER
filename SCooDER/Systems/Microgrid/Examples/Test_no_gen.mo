within SCooDER.Systems.Microgrid.Examples;
model Test_no_gen
  Microgrid_PI_adv
            microgrid_PI_adv(
    p_gen_max=0,
    p_pv_max=6000,
    Batt_delayP=0.1,
    Batt_delayQ=0.1,
    Batt_Ppref=true,
    Batt_SOC_start=0.5,
    Gen_Conso=0.05)
    annotation (Placement(transformation(extent={{20,0},{40,20}})));
  Buildings.Electrical.AC.OnePhase.Sources.Grid gri(f=60, V=240)
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=5500,
    duration=10,
    offset=0,
    startTime=60)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Sources.Step step(height=1000, startTime=2)
    annotation (Placement(transformation(extent={{-70,-80},{-50,-60}})));
  Modelica.Blocks.Sources.Ramp ramp1(height=-3500,
    duration=30,                     startTime=50)
    annotation (Placement(transformation(extent={{-40,-100},{-20,-80}})));
  Modelica.Blocks.Math.Add3 add3_1
    annotation (Placement(transformation(extent={{-10,-68},{10,-48}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{20,-68},{40,-48}})));
  Modelica.Blocks.Sources.Constant PV(k=500)
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Blocks.Sources.Step gridConnected(
    height=-1,
    offset=1,
    startTime=5)
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Modelica.Blocks.Sources.Constant PGenCtrl(k=0)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Blocks.Sources.Constant PBattCtrl(k=0)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
equation
  connect(gri.terminal, microgrid_PI_adv.term_p) annotation (Line(points={{30,60},
          {30,40},{30,20},{30,20}},       color={0,120,120}));
  connect(add3_1.y, microgrid_PI_adv.P_Load_low) annotation (Line(points={{11,-58},
          {16,-58},{16,-24},{37,-24},{37,-1}}, color={0,0,127}));
  connect(add3_1.u1, ramp.y)
    annotation (Line(points={{-12,-50},{-79,-50}},color={0,0,127}));
  connect(add3_1.u2, step.y) annotation (Line(points={{-12,-58},{-30,-58},{-30,
          -70},{-49,-70}}, color={0,0,127}));
  connect(add3_1.u3, ramp1.y) annotation (Line(points={{-12,-66},{-12,-90},{-19,
          -90}},           color={0,0,127}));
  connect(const.y, microgrid_PI_adv.Q_Load_low) annotation (Line(points={{41,-58},
          {44,-58},{44,-1},{39,-1}}, color={0,0,127}));
  connect(PV.y, microgrid_PI_adv.P_PV) annotation (Line(points={{-59,-10},{0,
          -10},{0,6},{18,6}},
                         color={0,0,127}));
  connect(gridConnected.y, microgrid_PI_adv.gridConnected) annotation (Line(
        points={{-59,80},{10,80},{10,18},{18,18}},     color={0,0,127}));
  connect(PGenCtrl.y, microgrid_PI_adv.PGenCtrl) annotation (Line(points={{-59,
          20},{-20,20},{-20,12},{18,12}}, color={0,0,127}));
  connect(PBattCtrl.y, microgrid_PI_adv.PBattCtrl) annotation (Line(points={{
          -59,50},{0,50},{0,15.2},{18,15.2}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=100));
end Test_no_gen;
