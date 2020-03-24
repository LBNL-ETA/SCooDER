within SCooDER.Components.Controller.Model;
model voltvar_param_bus
  parameter Real V_nominal(min=0, unit="V") = 120 "Nominal sytem voltage to scale Vp.u.";
  parameter Real v_max( start=1.05, unit="1")=1.05 "Voltage maximum [p.u.]";
  parameter Real v_maxdead( start=1.01, unit="1")=1.01 "Upper bound of deadband [p.u.]";
  parameter Real v_mindead( start=0.99, unit="1")=0.99 "Lower bound of deadband [p.u.]";
  parameter Real v_min( start=0.95, unit="1")=0.95 "Voltage minimum [p.u.]";
  parameter Real q_maxind( start=1000, unit="var")=1000 "Maximal Reactive Power (Inductive) [var]";
  parameter Real q_maxcap( start=1000, unit="var")=1000 "Maximal Reactive Power (Capacitive) [var]";
  voltvar_param voltvar(
    v_max=v_max,
    v_maxdead=v_maxdead,
    v_mindead=v_mindead,
    v_min=v_min,
    q_maxind=q_maxind,
    q_maxcap=q_maxcap)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Inverter.Interfaces.InvCtrlBus InvCtrlBus annotation (Placement(
        transformation(extent={{80,-20},{120,20}}), iconTransformation(extent={{
            90,-10},{110,10}})));
  Modelica.Blocks.Math.Gain voltageScale(k=1/V_nominal)
    annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));
equation
  connect(voltageScale.y, voltvar.Vpu)
    annotation (Line(points={{-31,0},{-12,0}}, color={0,0,127}));
  connect(voltageScale.u,InvCtrlBus. v) annotation (Line(points={{-54,0},{-60,0},
          {-60,30},{60,30},{60,0.1},{100.1,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(voltvar.QCtrl,InvCtrlBus. qctrl) annotation (Line(points={{11,0},{
          100.1,0},{100.1,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end voltvar_param_bus;
