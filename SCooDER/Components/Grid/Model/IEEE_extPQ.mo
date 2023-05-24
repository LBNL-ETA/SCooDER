within SCooDER.Components.Grid.Model;
model IEEE_extPQ
  parameter Integer nodes=13 "Number of inputs";
  parameter Real V_nominal=4.16e3 "System Voltage";
  parameter Boolean use_pf=true "Flag to use power factor instead of Q input";
  parameter Boolean smartinverter=true "Flag to use smart inverter";
  parameter Real pf[nodes]={0.95 for i in 1:nodes} "Fixed power factor when use_pf == true";
  replaceable parameter Buildings.Electrical.Transmission.Grids.PartialGrid networkmodel=Records.IEEE_13_simple
    "Record that describe the grid with the number of nodes, links, connections, etc.";
  Network network(V_nominal=V_nominal/sqrt(3), grid=networkmodel) annotation (Placement(transformation(extent={{100,-20},{80,0}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.Grid grid(f=60, V=V_nominal)
    annotation (Placement(transformation(extent={{60,20},{80,40}})));
  Inverter.Model.SpotLoad_Y_PQ_extBus_firstorder Load[nodes](each V_start=
        V_nominal/sqrt(3))
    annotation (Placement(transformation(extent={{-60,-20},{-40,0}})));
  Modelica.Blocks.Interfaces.RealInput P_load[nodes](each start=0, each unit="W")
    "Positive = load; Negative = source" annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,20}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,30})));
  Modelica.Blocks.Interfaces.RealInput Q_load[nodes](each start=0, each unit="var") if not use_pf
    "Positive = capacitive; Negative = inductive" annotation (Placement(
        transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-20}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,0})));
  Modelica.Blocks.Sources.CombiTimeTable co2map(
    tableOnFile=false,
    table=[0,0.363952; 3600,0.363462; 7200,0.360697; 10800,0.363249; 14400,
        0.360968; 18000,0.362209; 21600,0.359162; 25200,0.370051; 28800,
        0.375113; 32400,0.358662; 36000,0.335542; 39600,0.325327; 43200,
        0.326622; 46800,0.322070; 50400,0.342727; 54000,0.353910; 57600,
        0.365880; 61200,0.367662; 64800,0.364375; 68400,0.360138; 72000,
        0.361523; 75600,0.366650; 79200,0.369026; 82800,0.366617],
    columns={2},
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic)
    "Table with profiles for co2 mapping [co2/kWh]"
    annotation (Placement(transformation(extent={{20,-100},{40,-80}})));
  Modelica.Blocks.Math.Product co2calc
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));
  Modelica.Blocks.Interfaces.RealOutput co2(unit="kg")
    annotation (Placement(transformation(extent={{100,-100},{120,-80}}),
        iconTransformation(extent={{100,-100},{120,-80}})));
  Modelica.Blocks.Sources.RealExpression P_head_W(y=grid.P[1].real + grid.P[2].real
         + grid.P[3].real)
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  Modelica.Blocks.Math.Gain gain_Q[nodes](each k=1) if not use_pf
    annotation (Placement(transformation(extent={{-80,-24},{-72,-16}})));
  Modelica.Blocks.Math.Gain gain_P[nodes](each k=1)
    annotation (Placement(transformation(extent={{-80,16},{-72,24}})));
  Modelica.Blocks.Math.Gain gain_Ppv[nodes](each k=1) if smartinverter
    annotation (Placement(transformation(extent={{-60,76},{-52,84}})));
  Modelica.Blocks.Interfaces.RealInput P_pv[nodes](each start=0, each unit="W") if smartinverter
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,80}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-30})));
  Controller.Model.voltVarWatt_param VoltVarWatt[nodes] if smartinverter
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Sensor.Model.Probe3ph sens[nodes](each V_nominal=V_nominal/sqrt(3))
    annotation (Placement(transformation(extent={{-10,0},{-30,-20}})));
  Modelica.Blocks.Math.Gain Vpu[nodes](each k=1/(V_nominal/sqrt(3))) if
                                                              smartinverter
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-80,40})));
  Modelica.Blocks.Math.Product mul[nodes] if
                                            smartinverter
    annotation (Placement(transformation(extent={{-20,56},{-12,64}})));
  Inverter.Model.SpotLoad_Y_PQ_extBus_firstorder PV_Inverter[nodes](each
      V_start=V_nominal/sqrt(3)) if
                             smartinverter
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Blocks.Math.Add add[nodes](each k2=-1) if smartinverter
    annotation (Placement(transformation(extent={{-34,52},{-26,60}})));
  Modelica.Blocks.Sources.RealExpression const[nodes](each y=1) if smartinverter
    annotation (Placement(transformation(extent={{-90,58},{-86,70}})));
  Modelica.Blocks.Math.Gain Qctrl[nodes](each k=1) if  smartinverter
    annotation (Placement(transformation(extent={{-34,40},{-26,48}})));
  Modelica.Blocks.Math.Gain PV_curtail[nodes](each k=-1) if
                                                       smartinverter
    annotation (Placement(transformation(extent={{-8,56},{0,64}})));
  Modelica.Blocks.Interfaces.RealOutput P_pcc[nodes](each unit="W")
    annotation (Placement(transformation(extent={{100,60},{120,80}}),
        iconTransformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Sources.RealExpression P_pcc_W[nodes](y={sens[n].P[1] +
        sens[n].P[2] + sens[n].P[3] for n in 1:nodes})
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Interfaces.RealOutput P_head(each unit="W") annotation (
      Placement(transformation(extent={{100,80},{120,100}}), iconTransformation(
          extent={{100,80},{120,100}})));
  Modelica.Blocks.Math.Gain W_to_kW(each k=1/1e3) if   smartinverter
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={50,-70})));
  Modelica.Blocks.Logical.Switch sw_vvw[nodes]
    annotation (Placement(transformation(extent={{-76,54},{-68,46}})));
  Modelica.Blocks.Logical.GreaterThreshold en_vvw[nodes](threshold=0.5)
    annotation (Placement(transformation(extent={{-94,46},{-86,54}})));
  Modelica.Blocks.Interfaces.RealInput En_vvw[nodes](each start=1, each unit="1") if
                                                                                   smartinverter
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,50}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-90})));
equation
  for i in 1:nodes loop
    Load[i].ctrls.P1 = gain_P[i].y;
    Load[i].ctrls.P2 = gain_P[i].y;
    Load[i].ctrls.P3 = gain_P[i].y;
  end for;

  if use_pf then
    for i in 1:nodes loop
      Load[i].ctrls.Q1 = gain_P[i].y*tan(acos(pf[i]));
      Load[i].ctrls.Q2 = gain_P[i].y*tan(acos(pf[i]));
      Load[i].ctrls.Q3 = gain_P[i].y*tan(acos(pf[i]));
    end for;
  else
    for i in 1:nodes loop
      connect(gain_Q[i].y, Load[i].ctrls.Q1);
      connect(gain_Q[i].y, Load[i].ctrls.Q2);
      connect(gain_Q[i].y, Load[i].ctrls.Q3);
    end for;
  end if;

  // Smartinverter
  if smartinverter then
    for i in 1:nodes loop
      connect(PV_curtail[i].y, PV_Inverter[i].ctrls.P1);
      connect(PV_curtail[i].y, PV_Inverter[i].ctrls.P2);
      connect(PV_curtail[i].y, PV_Inverter[i].ctrls.P3);
      connect(Qctrl[i].y, PV_Inverter[i].ctrls.Q1);
      connect(Qctrl[i].y, PV_Inverter[i].ctrls.Q2);
      connect(Qctrl[i].y, PV_Inverter[i].ctrls.Q3);
    end for;
  end if;

  connect(grid.terminal, network.terminal[1])
    annotation (Line(points={{70,20},{70,-10},{80,-10}}, color={0,120,120}));
  connect(co2calc.y, co2)
    annotation (Line(points={{81,-90},{110,-90}},
                                                color={0,0,127}));
  connect(gain_P.u, P_load)
    annotation (Line(points={{-80.8,20},{-120,20}}, color={0,0,127}));
  connect(gain_Q.u, Q_load)
    annotation (Line(points={{-80.8,-20},{-120,-20}}, color={0,0,127}));
  connect(gain_Ppv.u, P_pv)
    annotation (Line(points={{-60.8,80},{-120,80}}, color={0,0,127}));
  connect(Load.terminal_n, sens.terminal_p)
    annotation (Line(points={{-40,-10},{-30,-10}}, color={0,120,120}));
  connect(sens.terminal_n, network.terminal)
    annotation (Line(points={{-10,-10},{80,-10}}, color={0,120,120}));
  connect(sens.Vy[1], Vpu.u) annotation (Line(points={{-11,-1.66667},{-11,32},{-80,
          32},{-80,35.2}},                            color={0,0,127}));
  connect(gain_Ppv.y, mul.u1) annotation (Line(points={{-51.6,80},{-30,80},{-30,
          62.4},{-20.8,62.4}}, color={0,0,127}));
  connect(add.y, mul.u2) annotation (Line(points={{-25.6,56},{-24,56},{-24,57.6},
          {-20.8,57.6}}, color={0,0,127}));
  connect(add.u2, VoltVarWatt.PLim) annotation (Line(points={{-34.8,53.6},{-36.4,
          53.6},{-36.4,55},{-39,55}}, color={0,0,127}));
  connect(const.y, add.u1) annotation (Line(points={{-85.8,64},{-38,64},{-38,58.4},
          {-34.8,58.4}},       color={0,0,127}));
  connect(VoltVarWatt.QCtrl, Qctrl.u) annotation (Line(points={{-39,45},{-36.5,45},
          {-36.5,44},{-34.8,44}}, color={0,0,127}));
  connect(mul.y, PV_curtail.u)
    annotation (Line(points={{-11.6,60},{-8.8,60}},  color={0,0,127}));
  connect(PV_Inverter.terminal_n, sens.terminal_p) annotation (Line(points={{-40,
          20},{-34,20},{-34,-10},{-30,-10}}, color={0,120,120}));
  connect(P_pcc_W.y, P_pcc)
    annotation (Line(points={{41,70},{110,70}}, color={0,0,127}));
  connect(P_head_W.y, P_head)
    annotation (Line(points={{41,90},{110,90}}, color={0,0,127}));
  connect(W_to_kW.u, P_head_W.y)
    annotation (Line(points={{50,-65.2},{50,90},{41,90}}, color={0,0,127}));
  connect(co2map.y[1], co2calc.u2) annotation (Line(points={{41,-90},{46,-90},{46,
          -96},{58,-96}}, color={0,0,127}));
  connect(W_to_kW.y, co2calc.u1)
    annotation (Line(points={{50,-74.4},{50,-84},{58,-84}}, color={0,0,127}));
  connect(en_vvw.y, sw_vvw.u2)
    annotation (Line(points={{-85.6,50},{-76.8,50}}, color={255,0,255}));
  connect(sw_vvw.y, VoltVarWatt.Vpu)
    annotation (Line(points={{-67.6,50},{-62,50}}, color={0,0,127}));
  connect(sw_vvw.u1, Vpu.y) annotation (Line(points={{-76.8,46.8},{-80,46.8},{-80,
          44.4}}, color={0,0,127}));
  connect(sw_vvw.u3, const.y) annotation (Line(points={{-76.8,53.2},{-80,53.2},{
          -80,64},{-85.8,64}}, color={0,0,127}));
  connect(en_vvw.u, En_vvw)
    annotation (Line(points={{-94.8,50},{-120,50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end IEEE_extPQ;
