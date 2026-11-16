within SCooDER.Components.Inverter.Model;
model Inverter_singleInput
  parameter Real V_nominal(min=0, start=240) = 240
    "Nominal voltage";
  parameter Real etaDC(min=0, max=1, unit="1") = 0.974 "Conversion efficiency for DC Input";
  parameter Real delayP(unit="s") = 0.03
    "Time constant for Active Power control";
  parameter Real delayQ(unit="s") = 0.03
    "Time constant for Reactive Power control";
  parameter Real Smax(min=0, unit="VA") = 7600
    "Maximal apparent power";
  parameter Real QIndmax(min=0, unit="var") = 3300
    "Maximal reactive power (Inductive)";
  parameter Real QCapmax(min=0, unit="var") = 3300
    "Maximal reactive power (Capacitive)";
  parameter Boolean Ppref = true
    "Active power preference in the control loop";
  parameter Boolean ChargingCapability = true "Does the inverter support negative P?";

  Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_p
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_Gen
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-68,10})));
  SCooDER.Components.Inverter.Model.InverterLoad_PQ Load(V_nominal=V_nominal)
    "Negative (inductive/capacitive) load to simulate Inverter"
    annotation (Placement(transformation(extent={{-46,26},{-26,46}})));
  Modelica.Blocks.Sources.RealExpression ActivePower_Ctrl(y=effDC.y)
    "Controlled active power generation with constraints"
    annotation (Placement(transformation(extent={{8,26},{-12,46}})));
  Modelica.Blocks.Sources.RealExpression ReactivePower_Ctrl(y=q_ctrl)
    "Controlled q with constraints"
    annotation (Placement(transformation(extent={{8,42},{-12,62}})));

  Real q_ctrl;
  Real S_margin;
  Real p_max;
  Real p_min;
  Real q_max;
  Modelica.Blocks.Continuous.FirstOrder firstOrder_p(
    k=1,
    T=delayP,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=0) "Time delay for P adjustment" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-70})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder_q(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=0,
    T=delayQ)  "Time delay for Q adjustment" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-70})));
  Modelica.Blocks.Interfaces.RealOutput p( start=0, unit="W")
    "active power output [W]"
    annotation (Placement(transformation(extent={{-100,70},{-120,90}})));
  Modelica.Blocks.Interfaces.RealOutput q( start=0, unit="var") "reactive power output [var]"
    annotation (Placement(transformation(extent={{-100,40},{-120,60}})));
  Interfaces.InvCtrlBus_single invCtrlBus annotation (Placement(transformation(
          extent={{-20,-120},{20,-80}}), iconTransformation(extent={{-10,-110},
            {10,-90}})));
  Modelica.Blocks.Math.Gain effDC(k=etaDC) "Efficiency of DC system (DCDC)"
    annotation (Placement(transformation(extent={{90,50},{70,70}})));
  Modelica.Blocks.Interfaces.RealInput P_DC(unit="W")
    "Power generation from DC (pos if produced)" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,60}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,60})));
  Modelica.Blocks.Interfaces.RealOutput P_DC_cmd(start=0, unit="W")
    "Power command for DC source"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  SCooDER.Components.Controller.Model.LimPID_variable PID(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    Ti=0.1,
    withFeedForward=false)
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));
  Modelica.Blocks.Sources.RealExpression P_max_cmd(y=p_max) "P cmd max"
    annotation (Placement(transformation(extent={{-12,-18},{8,2}})));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter1
    annotation (Placement(transformation(extent={{20,-40},{40,-20}})));
  Modelica.Blocks.Sources.RealExpression P_min_cmd(y=p_min) "P cmd min"
    annotation (Placement(transformation(extent={{-12,-60},{8,-40}})));
  Modelica.Blocks.Math.Gain measGain(k=-1) "load convention to gen convention"
    annotation (Placement(transformation(extent={{-62,-60},{-52,-50}})));
equation
  if Ppref then
    p_max = Smax;
    S_margin = sqrt(Smax^2 - p^2);
    q_max = if (firstOrder_q.y > 0) then min(QCapmax, S_margin) else min(QIndmax, S_margin);
  else
    q_max = if (firstOrder_q.y > 0) then min(QCapmax, Smax) else min(QIndmax, Smax);
    S_margin = sqrt(Smax^2 - q^2);
    p_max = S_margin;
  end if;
  p_min = if ChargingCapability then -p_max else 0;
  q_ctrl = sign(firstOrder_q.y)* min(abs(firstOrder_q.y),q_max);

  connect(sens_Gen.terminal_n, term_p)
    annotation (Line(points={{-68,0},{-100,0}}, color={0,120,120}));

  connect(ActivePower_Ctrl.y, Load.Pow)
    annotation (Line(points={{-13,36},{-24,36}},         color={0,0,127}));
  connect(Load.terminal, sens_Gen.terminal_p) annotation (Line(points={{-46,36},
          {-68,36},{-68,20}},              color={0,120,120}));
  connect(sens_Gen.S[1], p) annotation (Line(points={{-77,4},{-82,4},{-82,80},{
          -110,80}},      color={0,0,127}));
  connect(q, sens_Gen.S[2]) annotation (Line(points={{-110,50},{-82,50},{-82,4},
          {-77,4}},      color={0,0,127}));
  connect(ReactivePower_Ctrl.y, Load.Q) annotation (Line(points={{-13,52},{-24,
          52},{-24,42}},      color={0,0,127}));
  connect(firstOrder_p.u,invCtrlBus. pctrl) annotation (Line(points={{-30,-82},{
          -30,-99.9},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(firstOrder_q.u,invCtrlBus. qctrl) annotation (Line(points={{50,-82},{50,
          -99.9},{0.1,-99.9}},    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(q,invCtrlBus. q) annotation (Line(points={{-110,50},{-82,50},{-82,
          -99.9},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(p,invCtrlBus. p) annotation (Line(points={{-110,80},{-82,80},{-82,
          -104},{0.1,-104},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sens_Gen.V,invCtrlBus. v) annotation (Line(points={{-77,10},{-78,10},
          {-78,-99.9},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(effDC.u,P_DC)
    annotation (Line(points={{92,60},{120,60},{120,60}}, color={0,0,127}));
  connect(PID.u_s, variableLimiter1.y)
    annotation (Line(points={{58,-30},{41,-30}}, color={0,0,127}));
  connect(P_min_cmd.y, variableLimiter1.limit2) annotation (Line(points={{9,-50},
          {14,-50},{14,-38},{18,-38}}, color={0,0,127}));
  connect(firstOrder_p.y, variableLimiter1.u)
    annotation (Line(points={{-30,-59},{-30,-30},{18,-30}}, color={0,0,127}));
  connect(PID.y, P_DC_cmd) annotation (Line(points={{81,-30},{90,-30},{90,-40},{
          110,-40}}, color={0,0,127}));
  connect(variableLimiter1.limit1, P_max_cmd.y) annotation (Line(points={{18,-22},
          {12,-22},{12,-8},{9,-8}}, color={0,0,127}));
  connect(PID.u_max, P_max_cmd.y) annotation (Line(points={{58,-22},{52,-22},{52,
          -8},{9,-8}}, color={0,0,127}));
  connect(PID.u_min, variableLimiter1.limit2) annotation (Line(points={{58,-38.6},
          {50,-38.6},{50,-50},{14,-50},{14,-38},{18,-38}}, color={0,0,127}));
  connect(measGain.y, PID.u_m) annotation (Line(points={{-51.5,-55},{10,-55},{
          10,-56},{70,-56},{70,-42}}, color={0,0,127}));
  connect(measGain.u, sens_Gen.S[1]) annotation (Line(points={{-63,-55},{-63,
          -25.5},{-77,-25.5},{-77,4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Inverter_singleInput;
