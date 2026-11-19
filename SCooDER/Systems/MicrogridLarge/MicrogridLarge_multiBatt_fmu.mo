within SCooDER.Systems.MicrogridLarge;
model MicrogridLarge_multiBatt_fmu
  parameter Integer n_batt = 1 "Number of connected batteries";
  MicrogridLarge_multiBatt microgrid
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Electrical.AC.OnePhase.Sources.Grid gri(f=60, V=240)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Modelica.Blocks.Interfaces.RealInput gridConnected(each start=1, unit="1")
    "Microgrid grid-connected (>0.5) or islanded (<0.5)"
    annotation (Placement(transformation(extent={{-120,80},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput P_pv(each start=0, unit="W")
    "PV active power"
    annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
  Modelica.Blocks.Interfaces.RealInput P_load_high(each start=0, unit="W")
    "Laod active power" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-10})));
  Modelica.Blocks.Interfaces.RealInput Q_load_high(each start=0, unit="var")
    "Laod reactive power" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-30})));
  Modelica.Blocks.Interfaces.RealInput PBattCtrl[n_batt](unit="W")
    annotation (Placement(transformation(extent={{-120,60},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput PGenCtrl(each start=0, unit="W")
    annotation (Placement(transformation(extent={{-120,40},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput P_load_low(each start=0, unit="W")
    "Laod active power" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-50})));
  Modelica.Blocks.Interfaces.RealInput Q_load_low(each start=0, unit="var")
    "Laod reactive power" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-70})));
equation
  connect(microgrid.P_PV, P_pv) annotation (Line(points={{-12,-4},{-80,-4},{-80,
          30},{-110,30}}, color={0,0,127}));
  connect(gridConnected, microgrid.gridConnected) annotation (Line(points={{-110,90},
          {-20,90},{-20,8},{-12,8}},              color={0,0,127}));
  connect(PBattCtrl, microgrid.PBattCtrl) annotation (Line(points={{-110,70},{-40,
          70},{-40,5},{-12,5}},         color={0,0,127}));
  connect(PGenCtrl, microgrid.PGenCtrl) annotation (Line(points={{-110,50},{-60,
          50},{-60,2},{-12,2}}, color={0,0,127}));
  connect(microgrid.P_Load_high, P_load_high) annotation (Line(points={{1,-11},
          {1,-20},{-88,-20},{-88,-10},{-110,-10}}, color={0,0,127}));
  connect(microgrid.Q_Load_high, Q_load_high)
    annotation (Line(points={{3,-11},{3,-30},{-110,-30}}, color={0,0,127}));
  connect(microgrid.P_Load_low, P_load_low) annotation (Line(points={{7,-11},{7,
          -30},{6,-30},{6,-50},{-110,-50}}, color={0,0,127}));
  connect(microgrid.Q_Load_low, Q_load_low)
    annotation (Line(points={{9,-11},{9,-70},{-110,-70}}, color={0,0,127}));
  connect(gri.terminal, microgrid.term_p)
    annotation (Line(points={{0,40},{0,10}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end MicrogridLarge_multiBatt_fmu;
