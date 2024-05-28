within SCooDER.Components.Inverter.Model;
model Inverter_prefP
  import Flexgrid = SCooDER;
  parameter Modelica.Units.SI.Voltage V_nominal(
    min=0,
    start=240) = 240 "Nominal voltage";
  parameter Real etaPV(min=0, max=1, unit="1") = 0.988*0.974
    "Conversion efficiency for PV";
  parameter Real etaBatt(min=0, max=1, unit="1") = 0.974
    "Conversion efficiency for battery";
  parameter Real delayP(unit="s") = 0.03
    "Time constant for Active Power control";
  parameter Real delayQ(unit="s") = 0.03
    "Time constant for Reactive Power control";
  parameter Real delaybattery(unit="s") = 0.03
    "Time constant for Battery control";
  parameter Real Smax(min=0, unit="VA") = 7600
    "Maximal apparent power";
  parameter Real QIndmax(min=0, unit="var") = 2500
    "Maximal reactive power (Inductive)";
  parameter Real QCapmax(min=0, unit="var") = 2500
    "Maximal reactive power (Capacitive)";

  Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_p
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealInput P_PV(unit="W")
    "Power generation from PV (pos if produced)" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,60}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,60})));
  Modelica.Blocks.Interfaces.RealInput P_Batt(unit="W")
    "Power to/from Battery (pos if produced)" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-30}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-30})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_Inverter
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-80,30})));
  Flexgrid.Components.Inverter.Model.InverterLoad_PQ Load(V_nominal=120)
    "Negative (inductive/capacitive) load to simulate Inverter"
    annotation (Placement(transformation(extent={{-70,40},{-50,60}})));
  Modelica.Blocks.Sources.RealExpression ReactivePower_Ctrl(y=q_ctrl)
    "Controlled q with constraints"
    annotation (Placement(transformation(extent={{-10,60},{-30,80}})));
  Real q_ctrl;
  Real active_pv( start=0);
  Real active_batt( start=0);
  Real p_out;
  Real p_max;
  Real batt_ctrl_filtered;
  Modelica.Blocks.Continuous.FirstOrder firstOrder_plim(
    k=1,
    T=delayP,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=1) "Time delay for Plim adjustment" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-70,-70})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder_q(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=0,
    T=delayQ)  "Time delay for pf adjustment" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,-70})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder_battctrl(
    initType=Modelica.Blocks.Types.Init.SteadyState,
    T=delaybattery,
    y_start=0,
    k=-1)      "Time delay for battery control" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={60,-70})));
  Modelica.Blocks.Interfaces.RealOutput BattCtrlInv
    "Battery control signal to battery"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
  Flexgrid.Components.Inverter.Interfaces.InvCtrlBus invCtrlBus annotation (
      Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(
          extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Sources.RealExpression SMax(y=Smax)
    annotation (Placement(transformation(extent={{-100,-44},{-80,-24}})));
  Modelica.Blocks.Math.Product S_max_calc
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Sources.RealExpression ActivePower_Ctrl(y=p_out)
    "Controlled active power generation with constraints"
    annotation (Placement(transformation(extent={{-10,40},{-30,60}})));
  Modelica.Blocks.Math.Gain effPV(k=etaPV)
    "Efficiency of PV system (DCDC and MPPT)"
    annotation (Placement(transformation(extent={{90,50},{70,70}})));
  Modelica.Blocks.Math.Product batt_final
    annotation (Placement(transformation(extent={{70,-34},{90,-14}})));
  Modelica.Blocks.Continuous.LimPID PI_batt(
    yMin=0,
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    yMax=1) "Proportional Integral controller for battery control"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Blocks.Math.Abs abs_active "Absolute of active power generation"
    annotation (Placement(transformation(extent={{0,-22},{20,-2}})));
  Modelica.Blocks.Sources.RealExpression Battery_Ctrl(y=batt_ctrl_filtered)
    "Controlledbattery power with constraints"
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  Modelica.Blocks.Interfaces.RealOutput P( start=0, unit="W")
                                                             "active power output [W]"
    annotation (Placement(transformation(extent={{-100,70},{-120,90}})));
  Modelica.Blocks.Interfaces.RealOutput Q( start=0, unit="var") "reactive power output [var]"
    annotation (Placement(transformation(extent={{-100,40},{-120,60}})));
  Modelica.Blocks.Sources.RealExpression ApparentPower_Output(y=sqrt(
        sens_Inverter.S[1]^2 + sens_Inverter.S[2]^2))
    "Apparent power output at sensor"
    annotation (Placement(transformation(extent={{-40,-22},{-20,-2}})));
equation
  p_max =S_max_calc.y;
  active_batt = smooth(0, noEvent(if (P_Batt > 0) then P_Batt*etaBatt else P_Batt*(1/etaBatt)));
  active_pv = homotopy(actual = smooth(0,if effPV.y > p_max then p_max else if effPV.y < 0 then 0 else effPV.y), simplified=effPV.y);
  batt_ctrl_filtered = homotopy(actual = smooth(0,if firstOrder_battctrl.y > p_max then p_max else if firstOrder_battctrl.y < -p_max then -p_max else firstOrder_battctrl.y), simplified=firstOrder_battctrl.y);
  p_out = active_pv + active_batt;
  q_ctrl = if (firstOrder_q.y > 0) then min(min(firstOrder_q.y, QCapmax), Smax-abs(p_out)) else max(max(firstOrder_q.y, (-1)*QIndmax), (-1)*(Smax-abs(p_out)));
  connect(sens_Inverter.terminal_n, term_p)
    annotation (Line(points={{-80,20},{-80,20},{-80,0},{-100,0}},
                                                color={0,120,120}));

  connect(firstOrder_battctrl.u, invCtrlBus.batt_ctrl) annotation (Line(points={{60,-82},
          {50,-82},{50,-100},{36,-100},{36,-99.95},{0.05,-99.95}},
        color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(firstOrder_plim.u, invCtrlBus.plim) annotation (Line(points={{-70,-82},
          {-60,-82},{-60,-100},{-20,-100},{-20,-99.95},{0.05,-99.95}},  color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(S_max_calc.u1,SMax. y)
    annotation (Line(points={{-62,-34},{-72,-34},{-79,-34}}, color={0,0,127}));
  connect(S_max_calc.u2, firstOrder_plim.y) annotation (Line(points={{-62,-46},{
          -70,-46},{-70,-60},{-70,-59}}, color={0,0,127}));
  connect(batt_final.y, BattCtrlInv) annotation (Line(points={{91,-24},{94,-24},
          {94,-80},{110,-80}}, color={0,0,127}));
  connect(ActivePower_Ctrl.y, Load.Pow)
    annotation (Line(points={{-31,50},{-31,50},{-48,50}},color={0,0,127}));
  connect(PI_batt.y, batt_final.u1) annotation (Line(points={{61,0},{64,0},{64,-18},
          {66,-18},{68,-18}}, color={0,0,127}));
  connect(S_max_calc.y, PI_batt.u_s) annotation (Line(points={{-39,-40},{26,-40},
          {26,0},{38,0}}, color={0,0,127}));
  connect(abs_active.y, PI_batt.u_m)
    annotation (Line(points={{21,-12},{21,-12},{50,-12}}, color={0,0,127}));
  connect(Load.terminal, sens_Inverter.terminal_p) annotation (Line(points={{-70,50},
          {-80,50},{-80,40}},              color={0,120,120}));
  connect(effPV.u, P_PV)
    annotation (Line(points={{92,60},{120,60},{120,60}}, color={0,0,127}));
  connect(Battery_Ctrl.y, batt_final.u2)
    annotation (Line(points={{61,-30},{68,-30}}, color={0,0,127}));
  connect(sens_Inverter.S[1],P)  annotation (Line(points={{-89,24},{-94,24},{-94,
          80},{-110,80}}, color={0,0,127}));
  connect(Q, sens_Inverter.S[2]) annotation (Line(points={{-110,50},{-94,50},{-94,
          24},{-89,24}}, color={0,0,127}));
  connect(Q, invCtrlBus.q) annotation (Line(points={{-110,50},{-110,50},{-94,50},
          {-94,-100},{20,-100},{20,-99.95},{0.05,-99.95}},            color={0,0,
          127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(P, invCtrlBus.p) annotation (Line(points={{-110,80},{-94,80},{-94,-100},
          {-36,-100},{-36,-99.95},{0.05,-99.95}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(sens_Inverter.V, invCtrlBus.v) annotation (Line(points={{-89,30},{-94,
          30},{-94,-100},{-36,-100},{-36,-99.95},{0.05,-99.95}},  color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(firstOrder_q.u, invCtrlBus.qctrl) annotation (Line(points={{-10,-82},{
          -10,-82},{-10,-99.95},{0.05,-99.95}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(ReactivePower_Ctrl.y, Load.Q) annotation (Line(points={{-31,70},{-40,70},
          {-40,56},{-48,56}}, color={0,0,127}));
  connect(ApparentPower_Output.y, abs_active.u)
    annotation (Line(points={{-19,-12},{-10,-12},{-2,-12}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Inverter_prefP;
