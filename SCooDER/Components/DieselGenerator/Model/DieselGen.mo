within SCooDER.Components.DieselGenerator.Model;
model DieselGen
  parameter Real V_nominal(min=0, start=240, unit="V") = 240
    "Nominal voltage";
  parameter Real etaDC(min=0, max=1, unit="1") = 0.974 "Conversion efficiency for DC Input";
  parameter Real minP(min=0, unit="W") = 0 "Minimum loading for startup";
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
  parameter Real Capacity(min=0, unit="l")=300 "Tank Capacity";
  parameter Real SOC_start(min=0, max=1, unit="1")=1 "Initial SOC value";
  parameter Real Conso=0.2 "Fuel Consumption [l/kWh]";

  Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_p
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_Gen
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-68,10})));
  SCooDER.Components.Inverter.Model.InverterLoad_PQ Load(V_nominal=V_nominal)
    "Negative (inductive/capacitive) load to simulate Inverter"
    annotation (Placement(transformation(extent={{-46,26},{-26,46}})));
  Modelica.Blocks.Sources.RealExpression ReactivePower_Ctrl(y=q_ctrl)
    "Controlled q with constraints"
    annotation (Placement(transformation(extent={{8,42},{-12,62}})));

  Real q_ctrl;
  Real S_margin;
  Real p_max;
  Real p_min;
  Real q_max;
  Real p_run;
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
  GenCtrlBus          genCtrlBus annotation (Placement(transformation(extent={{-20,
            -120},{20,-80}}), iconTransformation(extent={{-10,-110},{10,-90}})));
  Controller.Model.LimPID_variable PID(controllerType=Modelica.Blocks.Types.SimpleController.PI,
      withFeedForward=false)
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
  Modelica.Blocks.Sources.RealExpression P_max_cmd(y=p_max) "P cmd max"
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter1
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  Modelica.Blocks.Sources.RealExpression P_min_cmd(y=p_min) "P cmd min"
    annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
  Modelica.Blocks.Math.Gain measGain(k=-1) "load convention to gen convention"
    annotation (Placement(transformation(extent={{-70,-56},{-60,-46}})));
  Modelica.Blocks.Interfaces.RealOutput FuelLevel(start=0)
    "Level of remaining Fuel [-]"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  FuelTank fuelTank(
    Capacity=Capacity,
    SOC_start=SOC_start,
    SOC_min=0,
    SOC_max=1,
    Conso=Conso)
    annotation (Placement(transformation(extent={{50,-30},{70,-10}})));
  Modelica.Blocks.Sources.RealExpression P_cmd(y=p_run) "P cmd min"
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
equation
  p_run = if firstOrder_p.y > minP then firstOrder_p.y else 0;
  if Ppref then
    p_max = Smax;
    S_margin = sqrt(Smax^2 - p^2);
    q_max = if (firstOrder_q.y > 0) then min(QCapmax, S_margin) else min(QIndmax, S_margin);
  else
    q_max = if (firstOrder_q.y > 0) then min(QCapmax, Smax) else min(QIndmax, Smax);
    S_margin = sqrt(Smax^2 - q^2);
    p_max = S_margin;
  end if;
  p_min = 0;
  q_ctrl = sign(firstOrder_q.y)* min(abs(firstOrder_q.y),q_max);

  connect(sens_Gen.terminal_n, term_p)
    annotation (Line(points={{-68,0},{-100,0}}, color={0,120,120}));

  connect(Load.terminal, sens_Gen.terminal_p) annotation (Line(points={{-46,36},
          {-68,36},{-68,20}},              color={0,120,120}));
  connect(sens_Gen.S[1], p) annotation (Line(points={{-77,4},{-82,4},{-82,80},{
          -110,80}},      color={0,0,127}));
  connect(q, sens_Gen.S[2]) annotation (Line(points={{-110,50},{-82,50},{-82,4},
          {-77,4}},      color={0,0,127}));
  connect(ReactivePower_Ctrl.y, Load.Q) annotation (Line(points={{-13,52},{-24,
          52},{-24,42}},      color={0,0,127}));
  connect(firstOrder_p.u,genCtrlBus. pctrl) annotation (Line(points={{-30,-82},{
          -30,-99.9},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(firstOrder_q.u,genCtrlBus. qctrl) annotation (Line(points={{50,-82},{50,
          -99.9},{0.1,-99.9}},    color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(q,genCtrlBus. q) annotation (Line(points={{-110,50},{-82,50},{-82,
          -99.9},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(p,genCtrlBus. p) annotation (Line(points={{-110,80},{-82,80},{-82,
          -104},{0.1,-104},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sens_Gen.V,genCtrlBus. v) annotation (Line(points={{-77,10},{-78,10},
          {-78,-99.9},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(PID.u_s, variableLimiter1.y)
    annotation (Line(points={{18,-20},{11,-20}}, color={0,0,127}));
  connect(P_min_cmd.y, variableLimiter1.limit2) annotation (Line(points={{-29,-40},
          {-20,-40},{-20,-28},{-12,-28}},
                                       color={0,0,127}));
  connect(variableLimiter1.limit1, P_max_cmd.y) annotation (Line(points={{-12,-12},
          {-20,-12},{-20,0},{-29,0}},
                                    color={0,0,127}));
  connect(PID.u_max, P_max_cmd.y) annotation (Line(points={{18,-12},{18,0},{-29,
          0}},         color={0,0,127}));
  connect(PID.u_min, variableLimiter1.limit2) annotation (Line(points={{18,-28.6},
          {18,-40},{-20,-40},{-20,-28},{-12,-28}},         color={0,0,127}));
  connect(measGain.y, PID.u_m) annotation (Line(points={{-59.5,-51},{-59.5,-52},
          {-54,-52},{-54,-54},{30,-54},{30,-32}},
                                      color={0,0,127}));
  connect(measGain.u, sens_Gen.S[1]) annotation (Line(points={{-71,-51},{-80,-51},
          {-80,4},{-77,4}},            color={0,0,127}));
  connect(PID.y, fuelTank.PCtrl)
    annotation (Line(points={{41,-20},{48,-20}}, color={0,0,127}));
  connect(fuelTank.PExt, Load.Pow) annotation (Line(points={{71,-20},{76,-20},{76,
          36},{-24,36}},    color={0,0,127}));
  connect(fuelTank.FuelLevel, FuelLevel) annotation (Line(points={{71,-12},{96,-12},
          {96,80},{110,80}},      color={0,0,127}));
  connect(P_cmd.y, variableLimiter1.u)
    annotation (Line(points={{-29,-20},{-12,-20}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DieselGen;
