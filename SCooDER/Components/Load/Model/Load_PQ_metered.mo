within SCooDER.Components.Load.Model;
model Load_PQ_metered
  parameter Real V_nominal(min=0, start=240) = 240
    "Nominal voltage";

  Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_p
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_Gen
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
        rotation=90,
        origin={-68,10})));
  Model.Load_PQ Load(V_nominal=V_nominal)
    "Negative (inductive/capacitive) load to simulate Inverter"
    annotation (Placement(transformation(extent={{-46,26},{-26,46}})));
  Modelica.Blocks.Interfaces.RealOutput p( start=0, unit="W")
    "active power output [W]"
    annotation (Placement(transformation(extent={{-100,70},{-120,90}})));
  Modelica.Blocks.Interfaces.RealOutput q( start=0, unit="var") "reactive power output [var]"
    annotation (Placement(transformation(extent={{-100,40},{-120,60}})));
  LoadCtrlBus loadCtrlBus annotation (Placement(transformation(extent={{-20,-120},
            {20,-80}}), iconTransformation(extent={{-10,-110},{10,-90}})));
  Modelica.Blocks.Interfaces.RealInput P_in(unit="W")
    "Power generation from DC (pos if produced)" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,42}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,42})));
  Modelica.Blocks.Interfaces.RealInput Q_in(unit="var")
    "Power generation from DC (pos if produced)" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,76}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,76})));
  Modelica.Blocks.Math.Add add(k2=-1)
    annotation (Placement(transformation(extent={{32,60},{12,80}})));
  Modelica.Blocks.Math.Add add1(k2=-1)
    annotation (Placement(transformation(extent={{70,26},{50,46}})));
equation
  connect(sens_Gen.terminal_n, term_p)
    annotation (Line(points={{-68,0},{-100,0}}, color={0,120,120}));

  connect(Load.terminal, sens_Gen.terminal_p) annotation (Line(points={{-46,36},
          {-68,36},{-68,20}},              color={0,120,120}));
  connect(sens_Gen.S[1], p) annotation (Line(points={{-77,4},{-82,4},{-82,80},{
          -110,80}},      color={0,0,127}));
  connect(q, sens_Gen.S[2]) annotation (Line(points={{-110,50},{-82,50},{-82,4},
          {-77,4}},      color={0,0,127}));
  connect(q, loadCtrlBus.q) annotation (Line(points={{-110,50},{-82,50},{-82,-99.9},
          {0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(p, loadCtrlBus.p) annotation (Line(points={{-110,80},{-82,80},{-82,-100},
          {0.1,-100},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(sens_Gen.V, loadCtrlBus.v) annotation (Line(points={{-77,10},{-78,10},
          {-78,-99.9},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(add.u1, Q_in)
    annotation (Line(points={{34,76},{120,76}}, color={0,0,127}));
  connect(add.y, Load.Q) annotation (Line(points={{11,70},{8,70},{8,42},{-24,42}},
        color={0,0,127}));
  connect(add1.u1, P_in)
    annotation (Line(points={{72,42},{120,42}}, color={0,0,127}));
  connect(add1.y, Load.Pow)
    annotation (Line(points={{49,36},{-24,36}}, color={0,0,127}));
  connect(add1.u2, loadCtrlBus.pctrl) annotation (Line(points={{72,30},{76,30},
          {76,-90},{0.1,-90},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(add.u2, loadCtrlBus.qctrl) annotation (Line(points={{34,64},{34,-92},
          {20,-92},{20,-99.9},{0.1,-99.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(P_in, loadCtrlBus.p_in) annotation (Line(points={{120,42},{84,42},{84,
          -100},{0,-100}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Load_PQ_metered;
