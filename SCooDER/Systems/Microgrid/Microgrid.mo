within SCooDER.Systems.Microgrid;
model Microgrid
  parameter Real p_gen_min=0 "Min power of Generator [W]" annotation (Dialog(group="Controller"));
  parameter Real p_gen_max=3000 "Max power of Generator [W]" annotation (Dialog(group="Controller"));
  parameter Real p_batt_min=-5000 "Min power of Battery [W]" annotation (Dialog(group="Controller"));
  parameter Real p_batt_max=5000 "Max power of Battery [W]" annotation (Dialog(group="Controller"));
  parameter Real p_pv_max=4000 "Max power of PV [W]" annotation (Dialog(group="Controller"));
  parameter Real p_load_max=4000 "Max power of Load shedding [W]" annotation (Dialog(group="Controller"));
  parameter Modelica.Units.SI.Voltage V_nominal=240 "Nominal voltage";
  parameter Real PV_etaDC=0.974 "Conversion efficiency for DC Input"
                                                                    annotation (Dialog(group="PV"));
  parameter Real PV_delayP=0.5 "Time constant for Active Power control"
                                                                       annotation (Dialog(group="PV"));
  parameter Real PV_delayQ=0.5 "Time constant for Reactive Power control"
                                                                         annotation (Dialog(group="PV"));
  parameter Real PV_Smax=7600 "Maximal apparent power"
                                                      annotation (Dialog(group="PV"));
  parameter Real PV_QIndmax=3300 "Maximal reactive power (Inductive)"
                                                                     annotation (Dialog(group="PV"));
  parameter Real PV_QCapmax=3300 "Maximal reactive power (Capacitive)"
                                                                      annotation (Dialog(group="PV"));
  parameter Boolean PV_Ppref=true "Active power preference in the control loop"
                                                                               annotation (Dialog(group="PV"));
  parameter Real Batt_etaDC=0.974 "Conversion efficiency for DC Input"
                                                                      annotation (Dialog(group="Batt"));
  parameter Real Batt_delayP=0.5 "Time constant for Active Power control"
                                                                         annotation (Dialog(group="Batt"));
  parameter Real Batt_delayQ=0.5 "Time constant for Reactive Power control"
                                                                           annotation (Dialog(group="Batt"));
  parameter Real Batt_Smax=7600 "Maximal apparent power"
                                                        annotation (Dialog(group="Batt"));
  parameter Real Batt_QIndmax=3300 "Maximal reactive power (Inductive)"
                                                                       annotation (Dialog(group="Batt"));
  parameter Real Batt_QCapmax=3300 "Maximal reactive power (Capacitive)"
                                                                        annotation (Dialog(group="Batt"));
  parameter Boolean Batt_Ppref=true "Active power preference in the control loop"
                                                                                 annotation (Dialog(group="Batt"));
  parameter Real Gen_etaDC=0.974 "Conversion efficiency for DC Input"
                                                                     annotation (Dialog(group="Gen"));
  parameter Real Gen_delayP=0.5 "Time constant for Active Power control"
                                                                        annotation (Dialog(group="Gen"));
  parameter Real Gen_delayQ=0.5 "Time constant for Reactive Power control"
                                                                          annotation (Dialog(group="Gen"));
  parameter Real Gen_Smax=7600 "Maximal apparent power"
                                                       annotation (Dialog(group="Gen"));
  parameter Real Gen_QIndmax=3300 "Maximal reactive power (Inductive)"
                                                                      annotation (Dialog(group="Gen"));
  parameter Real Gen_QCapmax=3300 "Maximal reactive power (Capacitive)"
                                                                       annotation (Dialog(group="Gen"));
  parameter Boolean Gen_Ppref=true "Active power preference in the control loop"
                                                                                annotation (Dialog(group="Gen"));
  parameter Real Gen_Capacity=300 "Tank Capacity [l]"
                                                     annotation (Dialog(group="Gen"));
  parameter Real Gen_SOC_start=1 "Initial SOC value [-]"
                                                        annotation (Dialog(group="Gen"));
  parameter Real Gen_Conso=2 "Fuel Consumption [l/Wh]"
                                                      annotation (Dialog(group="Gen"));
  SCooDER.Components.Load.Model.Load_PQ_metered Load annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={70,-10})));
  SCooDER.Components.DieselGenerator.Model.DieselGen Gen(
    V_nominal=V_nominal,
    etaDC=Gen_etaDC,
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
        origin={30,-10})));
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
        origin={-50,-10})));
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
        origin={-10,-10})));
  SCooDER.Components.Controller.Model.PowerController Controller(timestep=2)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,40})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_grid
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={0,72})));
  Modelica.Blocks.Logical.GreaterThreshold
                                        greaterThreshold(
                                                      threshold=0.5)
    annotation (Placement(transformation(extent={{-70,38},{-50,58}})));
  Modelica.Blocks.Interfaces.RealInput gridConnected
    annotation (Placement(transformation(extent={{-138,28},{-98,68}})));
  Modelica.Blocks.Interfaces.RealInput P_Load annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={20,-120})));
  Modelica.Blocks.Interfaces.RealInput Q_Load annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={80,-120})));
  Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_p
    annotation (Placement(transformation(extent={{-4,90},{16,110}})));
  Modelica.Blocks.Interfaces.RealInput P_PV
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));

  SCooDER.Components.Sensor.Model.Monitoring monitoring annotation (Placement(
        transformation(extent={{80,48},{120,88}}), iconTransformation(extent={{
            92,-10},{112,10}})));
equation
  connect(Gen.term_p, PV.term_p) annotation (Line(points={{30,0},{30,20},{-50,
          20},{-50,0}}, color={0,120,120}));
  connect(Batt.term_p, PV.term_p) annotation (Line(points={{-10,0},{-10,20},{-50,
          20},{-50,0}}, color={0,120,120}));
  connect(sens_grid.terminal_p, PV.term_p) annotation (Line(points={{-4.44089e-16,
          62},{-4.44089e-16,20},{-50,20},{-50,0}}, color={0,120,120}));
  connect(Batt.P_DC_cmd, Batt.P_DC) annotation (Line(points={{-14,-21},{-14,-32},
          {-4,-32},{-4,-22}}, color={0,0,127}));
  connect(Load.term_p, PV.term_p) annotation (Line(points={{70,0},{70,20},{-50,
          20},{-50,0}}, color={0,120,120}));
  connect(sens_grid.S, Controller.S)
    annotation (Line(points={{-9,78},{-30,78},{-30,51}}, color={0,0,127}));
  connect(Controller.loadCtrlBus, Load.loadCtrlBus) annotation (Line(
      points={{-21,30},{-20,30},{-20,26},{52,26},{52,-10},{60,-10}},
      color={255,204,51},
      thickness=0.5));
  connect(Controller.genCtrlBus, Gen.genCtrlBus) annotation (Line(
      points={{-27,30},{-26,30},{-26,22},{8,22},{8,-10},{20,-10}},
      color={255,204,51},
      thickness=0.5));
  connect(Controller.invBattCtrlBus, Batt.invCtrlBus) annotation (Line(
      points={{-33,30},{-32,30},{-32,-10},{-20,-10}},
      color={255,204,51},
      thickness=0.5));
  connect(Controller.invPVCtrlBus, PV.invCtrlBus) annotation (Line(
      points={{-39,30},{-38,30},{-38,26},{-72,26},{-72,-10},{-60,-10}},
      color={255,204,51},
      thickness=0.5));
  connect(greaterThreshold.y, Controller.GridConnected)
    annotation (Line(points={{-49,48},{-42,48}}, color={255,0,255}));
  connect(greaterThreshold.u, gridConnected) annotation (Line(points={{-72,48},
          {-72,49},{-118,49},{-118,48}}, color={0,0,127}));
  connect(Load.Q_in, Q_Load) annotation (Line(points={{77.6,-22},{78,-22},{78,-120},
          {80,-120}}, color={0,0,127}));
  connect(Load.P_in, P_Load) annotation (Line(points={{74.2,-22},{74,-22},{74,-80},
          {20,-80},{20,-120}}, color={0,0,127}));
  connect(sens_grid.terminal_n, term_p) annotation (Line(points={{6.66134e-16,
          82},{6.66134e-16,100},{6,100}}, color={0,120,120}));
  connect(PV.P_DC, P_PV) annotation (Line(points={{-46.4,-22},{-46,-22},{-46,-60},
          {-120,-60}}, color={0,0,127}));
  connect(sens_grid.S[1], monitoring.p) annotation (Line(points={{-9,78},{74,78},
          {74,68},{100,68}},       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sens_grid.S[2], monitoring.q) annotation (Line(points={{-9,78},{74,78},
          {74,68},{100,68}},       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sens_grid.V, monitoring.v) annotation (Line(points={{-9,72},{74,72},{74,
          68},{100,68}},          color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(sens_grid.I, monitoring.i) annotation (Line(points={{-9,66},{74,66},{74,
          68},{100,68}},    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PV.p, monitoring.P_PV) annotation (Line(points={{-42,1},{-42,4},{74,4},
          {74,68.1},{100.1,68.1}},
                             color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Batt.p, monitoring.P_Batt) annotation (Line(points={{-2,1},{-2,4},{74,
          4},{74,68.1},{100.1,68.1}},
                                color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Gen.p, monitoring.P_Gen) annotation (Line(points={{38,1},{38,4},{74,4},
          {74,68.1},{100.1,68.1}},
                             color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(Load.p, monitoring.P_Load) annotation (Line(points={{78,1},{78,4},{74,
          4},{74,68.1},{100.1,68.1}},
                                color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(Gen.FuelLevel, monitoring.SOC_Gen) annotation (Line(points={{38,-21},
          {38,-24},{46,-24},{46,68.1},{100.1,68.1}},
                                               color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=30));
end Microgrid;
