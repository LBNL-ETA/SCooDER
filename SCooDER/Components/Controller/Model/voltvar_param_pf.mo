within SCooDER.Components.Controller.Model;
model voltvar_param_pf
  parameter Real v_max( start=1.05, unit="1")=1.05 "Voltage maximum [p.u.]";
  parameter Real v_maxdead( start=1.01, unit="1")=1.01 "Upper bound of deadband [p.u.]";
  parameter Real v_mindead( start=0.99, unit="1")=0.99 "Lower bound of deadband [p.u.]";
  parameter Real v_min( start=0.95, unit="1")=0.95 "Voltage minimum [p.u.]";
  parameter Real q_maxind( start=1000, unit="var")=1000 "Maximal Reactive Power (Inductive) [var]";
  parameter Real q_maxcap( start=1000, unit="var")=1000 "Maximal Reactive Power (Capacitive) [var]";

  Utility.QToPf qToPf annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  SCooDER.Components.Controller.Model.voltvar voltvar
    annotation (Placement(transformation(extent={{-28,-10},{-8,10}})));
  Modelica.Blocks.Sources.RealExpression Param1(y=v_max) annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Blocks.Sources.RealExpression Param2(y=v_maxdead) annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Blocks.Sources.RealExpression Param3(y=v_mindead) annotation (Placement(transformation(extent={{-80,-30},{-60,-10}})));
  Modelica.Blocks.Sources.RealExpression Param4(y=v_min) annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Sources.RealExpression Param5(y=q_maxcap) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-22,50})));
  Modelica.Blocks.Sources.RealExpression Param6(y=q_maxind) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-4,50})));
  Modelica.Blocks.Interfaces.RealOutput PF( start=1, unit="1")
    "pf control signal"                                                            annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput P(start=0, unit="W") "active power [W]" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,50})));
  Modelica.Blocks.Interfaces.RealInput Vpu(start=1, unit="1") "Voltage [p.u.]"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
equation
  connect(voltvar.QCtrl, qToPf.Q)
    annotation (Line(points={{-7,0},{0.5,0},{8,0}}, color={0,0,127}));
  connect(Param1.y, voltvar.VMax) annotation (Line(points={{-59,40},{-40,40},{-40,
          8},{-30,8}}, color={0,0,127}));
  connect(Param2.y, voltvar.VMaxDead) annotation (Line(points={{-59,20},{-44,20},
          {-44,4},{-30,4}}, color={0,0,127}));
  connect(Param3.y, voltvar.VMinDead) annotation (Line(points={{-59,-20},{-44,-20},
          {-44,-4},{-30,-4}}, color={0,0,127}));
  connect(voltvar.VMin, Param4.y) annotation (Line(points={{-30,-8},{-40,-8},{-40,
          -40},{-59,-40}}, color={0,0,127}));
  connect(Param5.y, voltvar.QMaxCap)
    annotation (Line(points={{-22,39},{-22,25.5},{-22,12}}, color={0,0,127}));
  connect(Param6.y, voltvar.QMaxInd) annotation (Line(points={{-4,39},{-4,39},{
          -4,20},{-16,20},{-16,12}}, color={0,0,127}));
  connect(voltvar.Vpu, Vpu) annotation (Line(points={{-30,0},{-90,0},{-90,-50},
          {-120,-50}}, color={0,0,127}));
  connect(P,qToPf.P)  annotation (Line(points={{-120,50},{-90,50},{-90,80},{20,
          80},{20,14},{20,12}},             color={0,0,127}));
  connect(qToPf.PF,PF)
    annotation (Line(points={{31,0},{110,0}},         color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end voltvar_param_pf;
