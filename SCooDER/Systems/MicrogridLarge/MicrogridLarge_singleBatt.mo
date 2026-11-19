within SCooDER.Systems.MicrogridLarge;
model MicrogridLarge_singleBatt
  parameter Real p_gen_min(min=0, unit="W")=0 "Min power of Generator" annotation (Dialog(group="Controller"));
  parameter Real p_gen_max(min=0, unit="W")=3000 "Max power of Generator" annotation (Dialog(group="Controller"));
  //parameter Real p_batt_min(min=0, unit="W")=-5000 "Min power of Battery" annotation (Dialog(group="Controller"));
  //parameter Real p_batt_max(min=0, unit="W")=5000 "Max power of Battery" annotation (Dialog(group="Controller"));
  //parameter Real p_pv_max(min=0, unit="W")=5000 "Max power of PV" annotation (Dialog(group="Controller"));
  parameter Real p_loadshed_max(min=0, unit="W")=0 "Max power of Load shedding" annotation (Dialog(group="Controller"));
  parameter Real batt_g_gen=1 "Prefer battery over generator?" annotation (Dialog(group="Controller"));
  parameter Real V_nominal=240 "Nominal voltage";
  parameter Real PV_etaDC(min=0, max=1, unit="1")=0.974 "Conversion efficiency for DC Input"
                                                                                            annotation (Dialog(group="PV"));
  parameter Real PV_delayP(min=0, unit="s")=0.5 "Time constant for Active Power control"
                                                                                        annotation (Dialog(group="PV"));
  parameter Real PV_delayQ(min=0, unit="s")=0.5 "Time constant for Reactive Power control"
                                                                                          annotation (Dialog(group="PV"));
  parameter Real PV_Smax(min=0, unit="VA")=6000 "Maximal apparent power"
                                                                        annotation (Dialog(group="PV"));
  parameter Real PV_QIndmax(min=0, unit="var")=2000 "Maximal reactive power (Inductive)"
                                                                                        annotation (Dialog(group="PV"));
  parameter Real PV_QCapmax(min=0, unit="var")=2000 "Maximal reactive power (Capacitive)"
                                                                                         annotation (Dialog(group="PV"));
  parameter Boolean PV_Ppref=true "Active power preference in the control loop"
                                                                               annotation (Dialog(group="PV"));
  parameter Real Batt_etaDC(min=0, max=1, unit="1")=0.974 "Conversion efficiency for DC Input"
                                                                                              annotation (Dialog(group="Battery"));
  parameter Real Batt_delayP(min=0, unit="s")=0.5 "Time constant for Active Power control"
                                                                                          annotation (Dialog(group="Battery"));
  parameter Real Batt_delayQ(min=0, unit="s")=0.5 "Time constant for Reactive Power control"
                                                                                            annotation (Dialog(group="Battery"));
  parameter Real Batt_Smax(min=0, unit="VA")=10000 "Maximal apparent power"
                                                                           annotation (Dialog(group="Battery"));
  parameter Real Batt_QIndmax(min=0, unit="var")=4000 "Maximal reactive power (Inductive)"
                                                                                          annotation (Dialog(group="Battery"));
  parameter Real Batt_QCapmax(min=0, unit="var")=4000 "Maximal reactive power (Capacitive)"
                                                                                           annotation (Dialog(group="Battery"));
  parameter Boolean Batt_Ppref=true "Active power preference in the control loop"
                                                                                 annotation (Dialog(group="Battery"));
  parameter Real Batt_EMax(min=0, unit="W.h")=10000 "Battery Capacity"
                                                                      annotation (Dialog(group="Battery"));
  parameter Real Batt_Pmax(min=0, unit="W")=10000 "Battery Power"
                                                                 annotation (Dialog(group="Battery"));
  parameter Real Batt_SOC_start(min=0, max=1, unit="1")=0.5 "Initial SOC value"
                                                                               annotation (Dialog(group="Battery"));
  parameter Real Batt_SOC_min(min=0, max=1, unit="1")=0.1 "Minimum SOC value"
                                                                             annotation (Dialog(group="Battery"));
  parameter Real Batt_SOC_max(min=0, max=1, unit="1")=1 "Maximum SOC value"
                                                                           annotation (Dialog(group="Battery"));
  parameter Real Batt_etaCha(min=0, max=1, unit="1")=0.96 "Charging efficiency"
                                                                               annotation (Dialog(group="Battery"));
  parameter Real Batt_etaDis(min=0, max=1, unit="1")=0.96 "Discharging efficiency"
                                                                                  annotation (Dialog(group="Battery"));
  parameter Real Gen_minP(min=0, unit="W")=0 "Minimum loading for startup" annotation (Dialog(group="Gen"));
  parameter Real Gen_delayP(min=0, unit="s")=0.5 "Time constant for Active Power control"
                                                                                         annotation (Dialog(group="Gen"));
  parameter Real Gen_delayQ(min=0, unit="s")=0.5 "Time constant for Reactive Power control"
                                                                                           annotation (Dialog(group="Gen"));
  parameter Real Gen_Smax(min=0, unit="VA")=5000 "Maximal apparent power"
                                                                         annotation (Dialog(group="Gen"));
  parameter Real Gen_QIndmax(min=0, unit="var")=2000 "Maximal reactive power (Inductive)"
                                                                                         annotation (Dialog(group="Gen"));
  parameter Real Gen_QCapmax(min=0, unit="var")=2000 "Maximal reactive power (Capacitive)"
                                                                                          annotation (Dialog(group="Gen"));
  parameter Boolean Gen_Ppref=true "Active power preference in the control loop"
                                                                                annotation (Dialog(group="Gen"));
  parameter Real Gen_etaDC(min=0, max=1, unit="1")=0.974 "Conversion efficiency for DC Input"
                                                                                             annotation (Dialog(group="Gen"));
  parameter Real Gen_Capacity(min=0, unit="l")=300 "Tank Capacity"
                                                                  annotation (Dialog(group="Gen"));
  parameter Real Gen_SOC_start(min=0, max=1, unit="1")=0.5 "Initial SOC value"
                                                                              annotation (Dialog(group="Gen"));
  parameter Real Gen_Conso=0.2 "Fuel Consumption [l/kWh]"
                                                         annotation (Dialog(group="Gen"));
  SCooDER.Components.DieselGenerator.Model.DieselGen Gen(
    V_nominal=V_nominal,
    etaDC=Gen_etaDC,
    minP=Gen_minP,
    delayP=Gen_delayP,
    delayQ=Gen_delayQ,
    Smax=Gen_Smax,
    QIndmax=Gen_QIndmax,
    QCapmax=Gen_QCapmax,
    Ppref=Gen_Ppref,
    Capacity=Gen_Capacity,
    SOC_start=Gen_SOC_start,
    Conso=Gen_Conso) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={0,-10})));
  SCooDER.Components.Inverter.Model.Inverter_PV_singleInput PV(
    V_nominal=V_nominal,
    etaDC=PV_etaDC,
    delayP=PV_delayP,
    delayQ=PV_delayQ,
    Smax=PV_Smax,
    QIndmax=PV_QIndmax,
    QCapmax=PV_QCapmax,
    Ppref=PV_Ppref,
    ChargingCapability=false) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-60,-10})));
  SCooDER.Components.Inverter.Model.Inverter_singleInput Batt(
    V_nominal=V_nominal,
    etaDC=Batt_etaDC,
    delayP=Batt_delayP,
    delayQ=Batt_delayQ,
    Smax=Batt_Smax,
    QIndmax=Batt_QIndmax,
    QCapmax=Batt_QCapmax,
    Ppref=Batt_Ppref) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-30,-10})));
  Components.Controller.Model.PowerController_PI_multiBatt
                                                         Controller(
    p_gen_min=p_gen_min,
    p_gen_max=p_gen_max,
    p_batt_min=-Batt_Pmax,
    p_batt_max=Batt_Pmax,
    p_pv_max=PV_Smax,
    p_load_max=p_loadshed_max,
    batt_g_gen=batt_g_gen) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,50})));
  SCooDER.Components.Sensor.Model.Grid_monitoring grid_monitoring annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,70})));
  SCooDER.Components.Load.Model.Load_PQ_metered Load_low(V_nominal=V_nominal)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={60,-10})));
  Modelica.Blocks.Logical.GreaterThreshold
                                        greaterThreshold(
                                                      threshold=0.5)
    annotation (Placement(transformation(extent={{-60,74},{-48,86}})));
  Modelica.Blocks.Interfaces.RealInput gridConnected
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput P_Load_low annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,-110})));
  Modelica.Blocks.Interfaces.RealInput Q_Load_low annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,-110})));
  Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_p
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,100}),
        iconTransformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={0,100})));
  Modelica.Blocks.Interfaces.RealInput P_PV
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));

  SCooDER.Components.Battery.Model.Battery Batt_model(
    EMax=Batt_EMax,
    Pmax=Batt_Pmax,
    SOC_start=Batt_SOC_start,
    SOC_min=Batt_SOC_min,
    SOC_max=Batt_SOC_max,
    etaCha=Batt_etaCha,
    etaDis=Batt_etaDis) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-22,-48})));
  SCooDER.Components.Sensor.Model.Monitoring monitoring annotation (Placement(
        transformation(extent={{80,60},{120,100}}), iconTransformation(extent={{
            90,-10},{110,10}})));

  Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-34,-30})));
  Modelica.Blocks.Math.Gain gain1(k=-1) annotation (Placement(transformation(
        extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={-24,-28})));
  Modelica.Blocks.Interfaces.RealInput PBattCtrl
    annotation (Placement(transformation(extent={{-140,32},{-100,72}})));
  Modelica.Blocks.Interfaces.RealInput PGenCtrl
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  SCooDER.Components.Load.Model.Load_PQ_metered Load_high(V_nominal=V_nominal)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={30,-10})));
  Modelica.Blocks.Interfaces.RealInput P_Load_high annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-110})));
  Modelica.Blocks.Interfaces.RealInput Q_Load_high annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-110})));
  Modelica.Blocks.Math.Add P_Load annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={44,50})));
equation
  connect(Gen.term_p, PV.term_p) annotation (Line(points={{1.77636e-15,0},{
          1.77636e-15,20},{-60,20},{-60,0}},
                    color={0,120,120}));
  connect(Batt.term_p, PV.term_p) annotation (Line(points={{-30,0},{-30,20},{
          -60,20},{-60,0}},
                        color={0,120,120}));
  connect(grid_monitoring.terminal_p, PV.term_p) annotation (Line(points={{0,60},{
          0,20},{-60,20},{-60,0}},  color={0,120,120}));
  connect(Load_low.term_p, PV.term_p) annotation (Line(points={{60,0},{60,20},{
          -60,20},{-60,0}}, color={0,120,120}));
  connect(grid_monitoring.S, Controller.S)
    annotation (Line(points={{-11,64},{-26,64},{-26,61}}, color={0,0,127}));
  connect(Controller.genCtrlBus, Gen.genCtrlBus) annotation (Line(
      points={{-30,40},{-30,24},{-12,24},{-12,-10},{-10,-10}},
      color={255,204,51},
      thickness=0.5));
  connect(Controller.invPVCtrlBus, PV.invCtrlBus) annotation (Line(
      points={{-38,40},{-38,26},{-72,26},{-72,-10},{-70,-10}},
      color={255,204,51},
      thickness=0.5));
  connect(greaterThreshold.y, Controller.GridConnected) annotation (Line(points={{-47.4,
          80},{-38,80},{-38,61},{-37,61}},          color={255,0,255}));
  connect(greaterThreshold.u, gridConnected) annotation (Line(points={{-61.2,80},
          {-120,80}},                    color={0,0,127}));
  connect(Load_low.Q_in, Q_Load_low) annotation (Line(points={{67.6,-22},{68,
          -22},{68,-80},{90,-80},{90,-110}}, color={0,0,127}));
  connect(grid_monitoring.terminal_n, term_p)
    annotation (Line(points={{0,80},{0,100}}, color={0,120,120}));
  connect(PV.P_DC, P_PV) annotation (Line(points={{-56.4,-22},{-56,-22},{-56,
          -40},{-120,-40}}, color={0,0,127}));
  connect(PV.p, monitoring.P_PV) annotation (Line(points={{-52,1},{-52,4},{78,4},
          {78,80.1},{100.1,80.1}},
                             color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Batt.p, monitoring.P_Batt) annotation (Line(points={{-22,1},{-22,4},{
          78,4},{78,80},{90,80},{90,80.1},{100.1,80.1}},
                                color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Gen.p, monitoring.P_Gen) annotation (Line(points={{8,1},{8,4},{78,4},
          {78,80.1},{100.1,80.1}},
                             color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Gen.FuelLevel, monitoring.SOC_Gen) annotation (Line(points={{8,-21},{
          8,-24},{12,-24},{12,4},{78,4},{78,80.1},{100.1,80.1}},
                                                            color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Batt_model.SOC, monitoring.SOC_Batt) annotation (Line(points={{-14,-37},
          {-14,-32},{-18,-32},{-18,4},{78,4},{78,80.1},{100.1,80.1}},
                                                    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Batt_model.SOE, monitoring.SOE_Batt) annotation (Line(points={{-17,-37},
          {-17,-32},{-18,-32},{-18,4},{78,4},{78,80.1},{100.1,80.1}},
                                                            color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Batt.P_DC_cmd, gain.u)
    annotation (Line(points={{-34,-21},{-34,-25.2}}, color={0,0,127}));
  connect(gain.y, Batt_model.PCtrl) annotation (Line(points={{-34,-34.4},{-34,
          -60},{-22,-60}},
                     color={0,0,127}));
  connect(Batt.P_DC, gain1.y)
    annotation (Line(points={{-24,-22},{-24,-23.6}},
                                                   color={0,0,127}));
  connect(gain1.u, Batt_model.P)
    annotation (Line(points={{-24,-32.8},{-24,-37},{-22,-37}},
                                                            color={0,0,127}));
  connect(PGenCtrl, Controller.PGenCtrl) annotation (Line(points={{-120,20},{-80,
          20},{-80,52},{-41,52}},     color={0,0,127}));
  connect(grid_monitoring.GridConnected, greaterThreshold.y) annotation (Line(
        points={{-11,76},{-38,76},{-38,80},{-47.4,80}}, color={255,0,255}));
  connect(grid_monitoring.monitoring, monitoring) annotation (Line(
      points={{10,76},{78,76},{78,80},{100,80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Load_high.term_p, PV.term_p) annotation (Line(points={{30,0},{30,20},
          {-60,20},{-60,0}}, color={0,120,120}));
  connect(Load_high.P_in, P_Load_high) annotation (Line(points={{34.2,-22},{34,
          -22},{34,-80},{10,-80},{10,-110}}, color={0,0,127}));
  connect(Load_high.Q_in, Q_Load_high) annotation (Line(points={{37.6,-22},{38,
          -22},{38,-84},{30,-84},{30,-110}}, color={0,0,127}));
  connect(Load_high.p, P_Load.u1)
    annotation (Line(points={{38,1},{38,38}}, color={0,0,127}));
  connect(Load_low.p, P_Load.u2)
    annotation (Line(points={{68,1},{68,6},{50,6},{50,38}}, color={0,0,127}));
  connect(P_Load_low, Load_low.P_in) annotation (Line(points={{70,-110},{70,-84},
          {64,-84},{64,-22},{64.2,-22}}, color={0,0,127}));
  connect(P_Load.y, monitoring.P_Load) annotation (Line(points={{44,61},{44,76},
          {78,76},{78,80.1},{100.1,80.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Load_high.loadCtrlBus, Controller.loadHighCtrlBus) annotation (Line(
      points={{20,-10},{14,-10},{14,26},{-26,26},{-26,40}},
      color={255,204,51},
      thickness=0.5));
  connect(Controller.loadLowCtrlBus, Load_low.loadCtrlBus) annotation (Line(
      points={{-22,40},{-22,28},{48,28},{48,-10},{50,-10}},
      color={255,204,51},
      thickness=0.5));
  connect(Controller.invBattCtrlBus[1], Batt.invCtrlBus) annotation (Line(
      points={{-34,40},{-34,2},{-44,2},{-44,-10},{-40,-10}},
      color={255,204,51},
      thickness=0.5));
  connect(PBattCtrl, Controller.PBattCtrl[1]) annotation (Line(points={{-120,52},
          {-82,52},{-82,56},{-41,56}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=30));
end MicrogridLarge_singleBatt;
