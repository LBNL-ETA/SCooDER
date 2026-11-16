within SCooDER.Components.DieselGenerator.Model;
model DieselGen
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
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));
  Modelica.Blocks.Sources.RealExpression P_max_cmd(y=p_max) "P cmd max"
    annotation (Placement(transformation(extent={{-60,-22},{-40,-2}})));
  Modelica.Blocks.Nonlinear.VariableLimiter variableLimiter1
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Sources.RealExpression P_min_cmd(y=p_min) "P cmd min"
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Math.Gain measGain(k=-1) "load convention to gen convention"
    annotation (Placement(transformation(extent={{-62,-60},{-52,-50}})));
  Modelica.Blocks.Interfaces.RealOutput FuelLevel(start=0)
    "Level of remaining Fuel [-]"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  FuelTank fuelTank(
    Capacity=Capacity,
    SOC_start=SOC_start,
    SOC_min=0,
    SOC_max=1,
    Conso=Conso)
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  parameter Real Capacity=300 "Tank Capacity [l]";
  parameter Real SOC_start=1 "Initial SOC value [-]";
  parameter Real Conso=2 "Fuel Consumption [l/Wh]";
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
    annotation (Line(points={{8,-30},{1,-30}},   color={0,0,127}));
  connect(P_min_cmd.y, variableLimiter1.limit2) annotation (Line(points={{-39,-40},
          {-34,-40},{-34,-38},{-22,-38}},
                                       color={0,0,127}));
  connect(firstOrder_p.y, variableLimiter1.u)
    annotation (Line(points={{-30,-59},{-30,-30},{-22,-30}},color={0,0,127}));
  connect(variableLimiter1.limit1, P_max_cmd.y) annotation (Line(points={{-22,-22},
          {-34,-22},{-34,-12},{-39,-12}},
                                    color={0,0,127}));
  connect(PID.u_max, P_max_cmd.y) annotation (Line(points={{8,-22},{4,-22},{4,
          -12},{-39,-12}},
                       color={0,0,127}));
  connect(PID.u_min, variableLimiter1.limit2) annotation (Line(points={{8,-38.6},
          {4,-38.6},{4,-50},{-32,-50},{-32,-38},{-22,-38}},color={0,0,127}));
  connect(measGain.y, PID.u_m) annotation (Line(points={{-51.5,-55},{10,-55},{
          10,-54},{20,-54},{20,-42}}, color={0,0,127}));
  connect(measGain.u, sens_Gen.S[1]) annotation (Line(points={{-63,-55},{-64,
          -55},{-64,-54},{-77,-54},{-77,4}},
                                       color={0,0,127}));
  connect(PID.y, fuelTank.PCtrl)
    annotation (Line(points={{31,-30},{38,-30}}, color={0,0,127}));
  connect(fuelTank.PExt, Load.Pow) annotation (Line(points={{61,-30},{88,-30},{
          88,36},{-24,36}}, color={0,0,127}));
  connect(fuelTank.FuelLevel, FuelLevel) annotation (Line(points={{61,-22},{72,
          -22},{72,80},{110,80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DieselGen;
