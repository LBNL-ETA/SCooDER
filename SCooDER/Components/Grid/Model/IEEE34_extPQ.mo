within SCooDER.Components.Grid.Model;
model IEEE34_extPQ
  parameter Integer nodes=34 "Number of inputs";
  parameter Real V_nominal=4.16e3 "System Voltage";
  Network ieee34(V_nominal=V_nominal, redeclare
      Buildings.Electrical.Transmission.Grids.IEEE_34_AL120 grid)
    annotation (Placement(transformation(extent={{100,-10},{80,10}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid grid(f=60, V=V_nominal)
    annotation (Placement(transformation(extent={{-10,60},{10,80}})));
  Inverter.Model.SpotLoad_Y_PQ_extBus_firstorder
                                      Y_load[nodes](each V_start=V_nominal)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Interfaces.RealInput P_load[nodes](each start=0, each unit="W")
    "Positive = load; Negative = source" annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,20}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,80})));
  Modelica.Blocks.Interfaces.RealInput Q_load[nodes](each start=0, each unit="var")
    "Positive = capacitive; Negative = inductive" annotation (Placement(
        transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-20}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,50})));
  Modelica.Blocks.Sources.CombiTimeTable co2map(
    table=[0,0.363952; 3600,0.363462; 7200,0.360697; 10800,0.363249; 14400,
        0.360968; 18000,0.362209; 21600,0.359162; 25200,0.370051; 28800,
        0.375113; 32400,0.358662; 36000,0.335542; 39600,0.325327; 43200,
        0.326622; 46800,0.322070; 50400,0.342727; 54000,0.353910; 57600,
        0.365880; 61200,0.367662; 64800,0.364375; 68400,0.360138; 72000,
        0.361523; 75600,0.366650; 79200,0.369026; 82800,0.366617],
    columns={2},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Table with profiles for co2 mapping [co2/kWh]"
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  Modelica.Blocks.Math.Product co2calc
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Modelica.Blocks.Interfaces.RealOutput co2(unit="kg")
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Sources.RealExpression P_head_kW(y=(grid.P[1].real + grid.P[2].real
         + grid.P[3].real)/1e3)
    annotation (Placement(transformation(extent={{20,54},{40,74}})));
equation
  for i in 1:nodes loop
    Y_load[i].ctrls.P1 = P_load[i];
    Y_load[i].ctrls.Q1 = Q_load[i];
    Y_load[i].ctrls.P2 = P_load[i];
    Y_load[i].ctrls.Q2 = Q_load[i];
    Y_load[i].ctrls.P3 = P_load[i];
    Y_load[i].ctrls.Q3 = Q_load[i];
  end for;
  connect(grid.terminal, ieee34.terminal[1])
    annotation (Line(points={{0,60},{0,0},{80,0}},   color={0,120,120}));
  connect(Y_load.terminal_n, ieee34.terminal)
    annotation (Line(points={{-40,0},{80,0}}, color={0,120,120}));
  connect(co2map.y[1], co2calc.u1) annotation (Line(points={{41,90},{48,90},{48,
          76},{58,76}}, color={0,0,127}));
  connect(co2calc.y, co2)
    annotation (Line(points={{81,70},{110,70}}, color={0,0,127}));
  connect(P_head_kW.y, co2calc.u2)
    annotation (Line(points={{41,64},{58,64}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end IEEE34_extPQ;
