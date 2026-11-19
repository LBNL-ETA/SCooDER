within SCooDER.Systems.MicrogridLarge.Examples;
model Test_MicrogridLarge_multiBatt
  extends Modelica.Icons.Example;
  parameter Integer n_batt = 1;
  MicrogridLarge_multiBatt microgridLarge_multiBat(
    n_batt=n_batt,
    Batt_delayP=fill(0.1, n_batt),
    Batt_EMax=fill(50, n_batt),
    Batt_Pmax=fill(3500, n_batt),
    Batt_SOC_start=fill(0.95, n_batt),
    Gen_Capacity=0.01)
    annotation (Placement(transformation(extent={{20,0},{60,40}})));
  Buildings.Electrical.AC.OnePhase.Sources.Grid grid(f=60, V=240)
    annotation (Placement(transformation(extent={{30,70},{50,90}})));
  Modelica.Blocks.Sources.Ramp ramp1(
    height=5500,
    duration=10,
    offset=2000,
    startTime=10)
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Modelica.Blocks.Sources.Step step1(height=-4000, startTime=40)
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Blocks.Sources.Ramp ramp2(
    height=-3500,
    duration=20,
    startTime=55)
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Modelica.Blocks.Math.Add3 pload
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Modelica.Blocks.Sources.Constant qload(k=0)
    annotation (Placement(transformation(extent={{20,-70},{40,-50}})));
  Modelica.Blocks.Sources.Constant PV(k=3000)
    annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
  Modelica.Blocks.Sources.Step Islanding(
    height=-1,
    offset=1,
    startTime=5)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Sources.Constant Battery(k=0)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
equation
  connect(grid.terminal, microgridLarge_multiBat.term_p)
    annotation (Line(points={{40,70},{40,40}}, color={0,120,120}));
  connect(pload.y, microgridLarge_multiBat.P_Load_low)
    annotation (Line(points={{41,-30},{54,-30},{54,-2}},color={0,0,127}));
  connect(pload.u1, ramp1.y) annotation (Line(points={{18,-22},{-14,-22},{-14,-20},
          {-19,-20}}, color={0,0,127}));
  connect(pload.u2, step1.y) annotation (Line(points={{18,-30},{-14,-30},{-14,-50},
          {-19,-50}}, color={0,0,127}));
  connect(pload.u3,ramp2. y) annotation (Line(points={{18,-38},{-10,-38},{-10,-80},
          {-19,-80}}, color={0,0,127}));
  connect(qload.y, microgridLarge_multiBat.Q_Load_low)
    annotation (Line(points={{41,-60},{58,-60},{58,-2}},color={0,0,127}));
  connect(PV.y, microgridLarge_multiBat.P_PV) annotation (Line(points={{-39,10},
          {0,10},{0,12},{16,12}}, color={0,0,127}));
  connect(Islanding.y, microgridLarge_multiBat.gridConnected) annotation (Line(
        points={{-39,70},{8,70},{8,36},{16,36}}, color={0,0,127}));
  connect(microgridLarge_multiBat.Q_Load_high, microgridLarge_multiBat.Q_Load_low)
    annotation (Line(points={{46,-2},{46,-12},{58,-12},{58,-2}},
                                                               color={0,0,127}));
  connect(microgridLarge_multiBat.P_Load_high, microgridLarge_multiBat.Q_Load_low)
    annotation (Line(points={{42,-2},{42,-12},{58,-12},{58,-2}},
                                                               color={0,0,127}));
  connect(microgridLarge_multiBat.PGenCtrl, microgridLarge_multiBat.Q_Load_low)
    annotation (Line(points={{16,24},{4,24},{4,-12},{58,-12},{58,-2}},color={0,0,
          127}));
  connect(Battery.y, microgridLarge_multiBat.PBattCtrl[1]) annotation (Line(
        points={{-39,40},{6,40},{6,30},{16,30}},     color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=120, __Dymola_Algorithm="Dassl"));
end Test_MicrogridLarge_multiBatt;
