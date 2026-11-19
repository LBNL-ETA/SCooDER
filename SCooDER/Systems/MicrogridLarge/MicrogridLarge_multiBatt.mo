within SCooDER.Systems.MicrogridLarge;
model MicrogridLarge_multiBatt
  parameter Integer n_batt = 1 "Number of connected batteries";
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
  parameter Real Batt_etaDC[n_batt](min=0, max=1, unit="1")=fill(0.974, n_batt) "Conversion efficiency for DC Input"
                                                                                                                    annotation (Dialog(group="Battery"));
  parameter Real Batt_delayP[n_batt](min=0, unit="s")=fill(0.5, n_batt) "Time constant for Active Power control"
                                                                                                                annotation (Dialog(group="Battery"));
  parameter Real Batt_delayQ[n_batt](min=0, unit="s")=fill(0.5, n_batt) "Time constant for Reactive Power control"
                                                                                                                  annotation (Dialog(group="Battery"));
  parameter Real Batt_Smax[n_batt](min=0, unit="VA")=fill(10000, n_batt) "Maximal apparent power"
                                                                                                 annotation (Dialog(group="Battery"));
  parameter Real Batt_QIndmax[n_batt](min=0, unit="var")=fill(4000, n_batt) "Maximal reactive power (Inductive)"
                                                                                                                annotation (Dialog(group="Battery"));
  parameter Real Batt_QCapmax[n_batt](min=0, unit="var")=fill(4000, n_batt) "Maximal reactive power (Capacitive)"
                                                                                                                 annotation (Dialog(group="Battery"));
  parameter Boolean Batt_Ppref=true "Active power preference in the control loop"
                                                                                 annotation (Dialog(group="Battery"));
  parameter Real Batt_EMax[n_batt](min=0, unit="W.h")=fill(10000, n_batt) "Battery Capacity"
                                                                                            annotation (Dialog(group="Battery"));
  parameter Real Batt_Pmax[n_batt](min=0, unit="W")=fill(10000, n_batt) "Battery Power"
                                                                                       annotation (Dialog(group="Battery"));
  parameter Real Batt_SOC_start[n_batt](min=0, max=1, unit="1")=fill(0.5, n_batt) "Initial SOC value"
                                                                                                     annotation (Dialog(group="Battery"));
  parameter Real Batt_SOC_min[n_batt](min=0, max=1, unit="1")=fill(0.1, n_batt) "Minimum SOC value"
                                                                                                   annotation (Dialog(group="Battery"));
  parameter Real Batt_SOC_max[n_batt](min=0, max=1, unit="1")=fill(1, n_batt) "Maximum SOC value"
                                                                                                 annotation (Dialog(group="Battery"));
  parameter Real Batt_etaCha[n_batt](min=0, max=1, unit="1")=fill(0.96, n_batt) "Charging efficiency"
                                                                                                     annotation (Dialog(group="Battery"));
  parameter Real Batt_etaDis[n_batt](min=0, max=1, unit="1")=fill(0.96, n_batt) "Discharging efficiency"
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
  SCooDER.Components.Inverter.Model.Inverter_singleInput Batt[n_batt](
    each V_nominal=V_nominal,
    etaDC=Batt_etaDC,
    delayP=Batt_delayP,
    delayQ=Batt_delayQ,
    Smax=Batt_Smax,
    QIndmax=Batt_QIndmax,
    QCapmax=Batt_QCapmax,
    each Ppref=Batt_Ppref)
                      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-30,-10})));
  Components.Controller.Model.PowerController_PI_multiBatt
                                                         Controller(
    p_gen_min=p_gen_min,
    p_gen_max=p_gen_max,
    p_batt_min=-sum(Batt_Pmax),
    p_batt_max=sum(Batt_Pmax),
    p_pv_max=PV_Smax,
    p_load_max=p_loadshed_max,
    batt_g_gen=batt_g_gen,
    n_batt=n_batt)         annotation (Placement(transformation(
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
  Modelica.Blocks.Logical.GreaterThreshold islanded(threshold=0.5)
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

  SCooDER.Components.Battery.Model.Battery Batt_cell[n_batt](
    EMax=Batt_EMax,
    Pmax=Batt_Pmax,
    SOC_start=Batt_SOC_start,
    SOC_min=Batt_SOC_min,
    SOC_max=Batt_SOC_max,
    etaCha=Batt_etaCha,
    etaDis=Batt_etaDis) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-22,-50})));
  SCooDER.Components.Sensor.Model.Monitoring monitoring annotation (Placement(
        transformation(extent={{80,60},{120,100}}), iconTransformation(extent={{
            90,-10},{110,10}})));

  Modelica.Blocks.Math.Gain gain[n_batt](each k=-1) annotation (Placement(
        transformation(
        extent={{-4,-4},{4,4}},
        rotation=-90,
        origin={-34,-30})));
  Modelica.Blocks.Math.Gain gain1[n_batt](each k=-1) annotation (Placement(
        transformation(
        extent={{4,-4},{-4,4}},
        rotation=-90,
        origin={-24,-28})));
  Modelica.Blocks.Interfaces.RealInput PBattCtrl[n_batt]
    annotation (Placement(transformation(extent={{-140,30},{-100,70}})));
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

  for i in 1:n_batt loop
    connect(grid_monitoring.terminal_p, Batt[i].term_p);
    //connect(Batt[i].p, );
  end for;

  connect(Gen.term_p, PV.term_p) annotation (Line(points={{1.77636e-15,0},{
          1.77636e-15,20},{-60,20},{-60,0}},
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
  connect(islanded.y, Controller.GridConnected) annotation (Line(points={{-47.4,
          80},{-38,80},{-38,61},{-37,61}}, color={255,0,255}));
  connect(islanded.u, gridConnected)
    annotation (Line(points={{-61.2,80},{-120,80}}, color={0,0,127}));
  connect(Load_low.Q_in, Q_Load_low) annotation (Line(points={{67.6,-22},{68,
          -22},{68,-80},{90,-80},{90,-110}}, color={0,0,127}));
  connect(grid_monitoring.terminal_n, term_p)
    annotation (Line(points={{0,80},{0,100}}, color={0,120,120}));
  connect(PV.P_DC, P_PV) annotation (Line(points={{-56.4,-22},{-56,-22},{-56,
          -40},{-120,-40}}, color={0,0,127}));
  connect(PV.p, monitoring.P_PV) annotation (Line(points={{-52,1},{-52,4},{80,4},
          {80,80.1},{100.1,80.1}},
                             color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Gen.p, monitoring.P_Gen) annotation (Line(points={{8,1},{8,4},{80,4},
          {80,80.1},{100.1,80.1}},
                             color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Gen.FuelLevel, monitoring.SOC_Gen) annotation (Line(points={{8,-21},{
          8,-24},{14,-24},{14,4},{80,4},{80,80.1},{100.1,80.1}},
                                                            color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Batt.P_DC_cmd, gain.u)
    annotation (Line(points={{-34,-21},{-34,-25.2}}, color={0,0,127}));
  connect(gain.y, Batt_cell.PCtrl) annotation (Line(points={{-34,-34.4},{-34,
          -62},{-22,-62}}, color={0,0,127}));
  connect(Batt.P_DC, gain1.y)
    annotation (Line(points={{-24,-22},{-24,-23.6}},
                                                   color={0,0,127}));
  connect(gain1.u, Batt_cell.P) annotation (Line(points={{-24,-32.8},{-24,-39},
          {-22,-39}}, color={0,0,127}));
  connect(PGenCtrl, Controller.PGenCtrl) annotation (Line(points={{-120,20},{
          -76,20},{-76,52},{-41,52}}, color={0,0,127}));
  connect(grid_monitoring.GridConnected, islanded.y) annotation (Line(points={{
          -11,76},{-38,76},{-38,80},{-47.4,80}}, color={255,0,255}));
  connect(grid_monitoring.monitoring, monitoring) annotation (Line(
      points={{10,76},{80,76},{80,80},{100,80}},
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
    annotation (Line(points={{68,1},{68,8},{50,8},{50,38}}, color={0,0,127}));
  connect(P_Load_low, Load_low.P_in) annotation (Line(points={{70,-110},{70,-84},
          {64,-84},{64,-22},{64.2,-22}}, color={0,0,127}));
  connect(P_Load.y, monitoring.P_Load) annotation (Line(points={{44,61},{44,76},
          {80,76},{80,80.1},{100.1,80.1}}, color={0,0,127}), Text(
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
  connect(PBattCtrl, Controller.PBattCtrl) annotation (Line(points={{-120,50},{
          -80,50},{-80,56},{-41,56}},
                                  color={0,0,127}));
  connect(Controller.invBattCtrlBus, Batt.invCtrlBus) annotation (Line(
      points={{-34,40},{-34,2},{-44,2},{-44,-10},{-40,-10}},
      color={255,204,51},
      thickness=0.5));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=30));
end MicrogridLarge_multiBatt;
