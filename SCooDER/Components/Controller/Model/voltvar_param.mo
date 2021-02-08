within SCooDER.Components.Controller.Model;
model voltvar_param
  parameter Real v_max( start=1.05, unit="1")=1.05 "Voltage maximum [p.u.]";
  parameter Real v_maxdead( start=1.01, unit="1")=1.01 "Upper bound of deadband [p.u.]";
  parameter Real v_mindead( start=0.99, unit="1")=0.99 "Lower bound of deadband [p.u.]";
  parameter Real v_min( start=0.95, unit="1")=0.95 "Voltage minimum [p.u.]";
  parameter Real q_maxind( start=1000, unit="var")=1000 "Maximal Reactive Power (Inductive) [var]";
  parameter Real q_maxcap( start=1000, unit="var")=1000 "Maximal Reactive Power (Capacitive) [var]";

  SCooDER.Components.Controller.Model.voltvar voltvar
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.RealExpression Param1(y=v_max) annotation (Placement(transformation(extent={{-62,30},
            {-42,50}})));
  Modelica.Blocks.Sources.RealExpression Param2(y=v_maxdead) annotation (Placement(transformation(extent={{-62,10},
            {-42,30}})));
  Modelica.Blocks.Sources.RealExpression Param3(y=v_mindead) annotation (Placement(transformation(extent={{-62,-30},
            {-42,-10}})));
  Modelica.Blocks.Sources.RealExpression Param4(y=v_min) annotation (Placement(transformation(extent={{-62,-50},
            {-42,-30}})));
  Modelica.Blocks.Sources.RealExpression Param5(y=q_maxcap) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-4,50})));
  Modelica.Blocks.Sources.RealExpression Param6(y=q_maxind) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={14,50})));
  Modelica.Blocks.Interfaces.RealOutput QCtrl(unit="var", start=0)
    "Q control signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput Vpu(start=1, unit="1") "Voltage [p.u.]"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
equation
  connect(Param1.y, voltvar.VMax) annotation (Line(points={{-41,40},{-22,40},{-22,
          8},{-12,8}}, color={0,0,127}));
  connect(Param2.y, voltvar.VMaxDead) annotation (Line(points={{-41,20},{-26,20},
          {-26,4},{-12,4}}, color={0,0,127}));
  connect(Param3.y, voltvar.VMinDead) annotation (Line(points={{-41,-20},{-26,-20},
          {-26,-4},{-12,-4}}, color={0,0,127}));
  connect(voltvar.VMin, Param4.y) annotation (Line(points={{-12,-8},{-22,-8},{-22,
          -40},{-41,-40}}, color={0,0,127}));
  connect(Param5.y, voltvar.QMaxCap)
    annotation (Line(points={{-4,39},{-4,25.5},{-4,12}}, color={0,0,127}));
  connect(Param6.y, voltvar.QMaxInd) annotation (Line(points={{14,39},{14,39},{
          14,20},{2,20},{2,12}}, color={0,0,127}));
  connect(voltvar.Vpu, Vpu)
    annotation (Line(points={{-12,0},{-120,0}}, color={0,0,127}));
  connect(voltvar.QCtrl, QCtrl)
    annotation (Line(points={{11,0},{110,0},{110,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end voltvar_param;
