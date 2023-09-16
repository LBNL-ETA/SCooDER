within SCooDER.Components.Grid.Model;
model IEEE13_extPQ_base
  parameter Integer nodes=13 "Number of inputs";
  parameter Real V_nominal=4.16e3 "System Voltage";
  parameter Boolean use_pf=true "Flag to use power factor instead of Q input";
  parameter Boolean smartinverter=true "Flag to use smart inverter";
  parameter Real pf[nodes]={0.95 for i in 1:nodes} "Fixed power factor when use_pf == true";
  Network ieee13(V_nominal=V_nominal/sqrt(3), redeclare Records.IEEE_13_simple
      grid)
    annotation (Placement(transformation(extent={{102,10},{82,30}})));
  Inverter.Model.SpotLoad_Y_PQ_extBus            Load[nodes](each V_start=
        V_nominal/sqrt(3))
    annotation (Placement(transformation(extent={{-60,-12},{-40,8}})));
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
        origin={-120,-10}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,50})));
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
  replaceable Modelica.Blocks.Sources.RealExpression P_head_W(y=0)
    annotation (Placement(transformation(extent={{20,80},{40,100}})));
  Modelica.Blocks.Math.Gain gain_Q[nodes](each k=1) if not use_pf
    annotation (Placement(transformation(extent={{-72,-14},{-64,-6}})));
  Modelica.Blocks.Math.Gain gain_P[nodes](each k=1)
    annotation (Placement(transformation(extent={{-72,0},{-64,8}})));
  Modelica.Blocks.Math.Gain gain_Ppv[nodes](each k=1) if smartinverter
    annotation (Placement(transformation(extent={{-60,76},{-52,84}})));
  Modelica.Blocks.Interfaces.RealInput P_pv[nodes](each start=0, each unit="W")
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,80}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-10})));
  Controller.Model.voltVarWatt_param VoltVarWatt[nodes] if smartinverter
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));
  Sensor.Model.Probe3ph sens[nodes](each V_nominal=V_nominal/sqrt(3))
    annotation (Placement(transformation(extent={{-10,30},{-30,10}})));
  Modelica.Blocks.Math.Gain Vpu[nodes](each k=1/(V_nominal/sqrt(3))) if
                                                              smartinverter
    annotation (Placement(transformation(extent={{-4,-4},{4,4}},
        rotation=90,
        origin={-80,40})));
  Modelica.Blocks.Math.Product mul[nodes] if
                                            smartinverter
    annotation (Placement(transformation(extent={{-34,52},{-26,60}})));
  Inverter.Model.SpotLoad_Y_PQ_extBus            PV_Inverter[nodes](each
      V_start=V_nominal/sqrt(3)) if
                             smartinverter
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
  Modelica.Blocks.Sources.RealExpression const[nodes](each y=1) if smartinverter
    annotation (Placement(transformation(extent={{-90,58},{-86,70}})));
  Modelica.Blocks.Math.Gain Qctrl[nodes](each k=1) if  smartinverter
    annotation (Placement(transformation(extent={{-34,40},{-26,48}})));
  Modelica.Blocks.Math.Gain PV_curtail[nodes](each k=1) if
                                                       smartinverter
    annotation (Placement(transformation(extent={{-20,52},{-12,60}})));
  Modelica.Blocks.Interfaces.RealOutput P_pcc[nodes](each unit="W")
    annotation (Placement(transformation(extent={{100,60},{120,80}}),
        iconTransformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Sources.RealExpression P_pcc_W[nodes](y={sens[n].P[1] +
        sens[n].P[2] + sens[n].P[3] for n in 1:nodes})
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  Modelica.Blocks.Interfaces.RealOutput P_head(unit="W") annotation (
      Placement(transformation(extent={{100,80},{120,100}}), iconTransformation(
          extent={{100,80},{120,100}})));
  Modelica.Blocks.Math.Gain W_to_kW(k=1/1e3) if   smartinverter
    annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={50,-70})));
  Modelica.Blocks.Logical.Switch sw_vvw[nodes]
    annotation (Placement(transformation(extent={{-76,54},{-68,46}})));
  Modelica.Blocks.Logical.GreaterThreshold en_vvw[nodes](each threshold=0.5)
    annotation (Placement(transformation(extent={{-94,46},{-86,54}})));
  Modelica.Blocks.Interfaces.RealInput En_vvw[nodes](each start=1, each unit=
        "1") if                                                                    smartinverter
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,50}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-90})));
  Modelica.Blocks.Interfaces.RealInput P_cha[nodes](each start=0, each unit="W")
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-40}),iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-30})));
  Inverter.Model.SpotLoad_Y_PQ_extBus Cha[nodes](each V_start=V_nominal/sqrt(3))
    annotation (Placement(transformation(extent={{-60,-34},{-40,-14}})));
  Controller.Model.loadOnOff chaCtrl[nodes](Vmax=10, Vmin=0)
    annotation (Placement(transformation(extent={{-90,-50},{-70,-30}})));
  Modelica.Blocks.Sources.RealExpression P_loadonly[nodes](y={P_load[n] - P_pv[n] - P_cha[n]
        for n in 1:nodes}) annotation (Placement(transformation(extent={{-100,-6},{-80,14}})));
equation
  for i in 1:nodes loop
    Load[i].ctrls.P1 = gain_P[i].y;
    Load[i].ctrls.P2 = gain_P[i].y;
    Load[i].ctrls.P3 = gain_P[i].y;
    Cha[i].ctrls.P1 = chaCtrl[i].y;
    Cha[i].ctrls.P2 = chaCtrl[i].y;
    Cha[i].ctrls.P3 = chaCtrl[i].y;
    //gain_P[i].u = P_load[i] - P_pv[i] - P_cha[i];
  end for;

  if use_pf then
    for i in 1:nodes loop
      Load[i].ctrls.Q1 = gain_P[i].y*tan(acos(pf[i]));
      Load[i].ctrls.Q2 = gain_P[i].y*tan(acos(pf[i]));
      Load[i].ctrls.Q3 = gain_P[i].y*tan(acos(pf[i]));
      Cha[i].ctrls.Q1 =chaCtrl[i].y*tan(acos(pf[i]));
      Cha[i].ctrls.Q2 =chaCtrl[i].y*tan(acos(pf[i]));
      Cha[i].ctrls.Q3 =chaCtrl[i].y*tan(acos(pf[i]));
    end for;
  else
    for i in 1:nodes loop
      connect(gain_Q[i].y, Load[i].ctrls.Q1);
      connect(gain_Q[i].y, Load[i].ctrls.Q2);
      connect(gain_Q[i].y, Load[i].ctrls.Q3);
      Cha[i].ctrls.Q1 = 0;
      Cha[i].ctrls.Q2 = 0;
      Cha[i].ctrls.Q3 = 0;
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

  connect(co2calc.y, co2)
    annotation (Line(points={{81,-90},{110,-90}},
                                                color={0,0,127}));
  connect(gain_Q.u, Q_load)
    annotation (Line(points={{-72.8,-10},{-120,-10}}, color={0,0,127}));
  connect(gain_Ppv.u, P_pv)
    annotation (Line(points={{-60.8,80},{-120,80}}, color={0,0,127}));
  connect(Load.terminal_n, sens.terminal_p)
    annotation (Line(points={{-40,-2},{-36,-2},{-36,20},{-30,20}},
                                                   color={0,120,120}));
  connect(sens.terminal_n, ieee13.terminal)
    annotation (Line(points={{-10,20},{82,20}},
                                              color={0,120,120}));
  connect(sens.Vy[1], Vpu.u) annotation (Line(points={{-11,28.3333},{-11,32},{
          -80,32},{-80,35.2}},                        color={0,0,127}));
  connect(gain_Ppv.y, mul.u1) annotation (Line(points={{-51.6,80},{-38,80},{-38,
          58.4},{-34.8,58.4}}, color={0,0,127}));
  connect(VoltVarWatt.QCtrl, Qctrl.u) annotation (Line(points={{-39,45},{-36.5,45},
          {-36.5,44},{-34.8,44}}, color={0,0,127}));
  connect(mul.y, PV_curtail.u)
    annotation (Line(points={{-25.6,56},{-20.8,56}}, color={0,0,127}));
  connect(PV_Inverter.terminal_n, sens.terminal_p) annotation (Line(points={{-40,20},
          {-30,20}},                         color={0,120,120}));
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
  connect(Cha.terminal_n, sens.terminal_p) annotation (Line(points={{-40,-24},{-36,
          -24},{-36,20},{-30,20}}, color={0,120,120}));
  connect(VoltVarWatt.PLim, mul.u2) annotation (Line(points={{-39,55},{-37.5,55},
          {-37.5,53.6},{-34.8,53.6}}, color={0,0,127}));
  connect(P_cha, chaCtrl.P)
    annotation (Line(points={{-120,-40},{-92,-40}}, color={0,0,127}));
  connect(Vpu.y, chaCtrl.Vpu) annotation (Line(points={{-80,44.4},{-80,44},{-96,
          44},{-96,-52},{-80,-52}}, color={0,0,127}));
  connect(P_loadonly.y, gain_P.u)
    annotation (Line(points={{-79,4},{-72.8,4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end IEEE13_extPQ_base;
