within SCooDER.Components.Controller.Model;
model voltVarWatt_param_firstorder

  Modelica.Blocks.Interfaces.RealInput Vpu(start=1, unit="1") "Voltage [p.u]"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput Qctrl(start=0, unit="var")
    "Reactive power control signal"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));

  parameter Real thrP = 0.05 "P: over/undervoltage threshold";
  parameter Real hysP= 0.04 "P: Hysteresis";

  parameter Real thrQ = 0.04 "Q: over/undervoltage threshold";
  parameter Real hysQ = 0.01 "Q: Hysteresis";
  parameter Real QMaxInd(unit="var") = 1000 "Maximal Reactive Power (Inductive)";
  parameter Real QMaxCap(unit="var") = 1000 "Maximal Reactive Power (Capacitive)";

  parameter Real Tfirstorder(unit="s") = 1 "Time constant of first order";

  voltVar_param_simple_firstorder voltWatt(
    Tfirstorder=Tfirstorder,
    thr=thrP,
    hys=hysP,
    QMaxInd=-1,
    QMaxCap=0)
    annotation (Placement(transformation(extent={{-8,40},{12,60}})));
  voltVar_param_simple_firstorder voltVar(
    thr=thrQ,
    hys=hysQ,
    QMaxInd=QMaxInd,
    QMaxCap=QMaxCap,
    Tfirstorder=Tfirstorder)
    annotation (Placement(transformation(extent={{-8,-60},{12,-40}})));
  Modelica.Blocks.Interfaces.RealOutput Plim(start=1, unit="1")
    "Reactive power control signal"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Math.Add sub(k2=-1)
    annotation (Placement(transformation(extent={{40,40},{60,60}})));
  Modelica.Blocks.Sources.Constant const_p(k=1)
    annotation (Placement(transformation(extent={{0,70},{20,90}})));
equation

  connect(voltVar.QCon, Qctrl)
    annotation (Line(points={{13,-50},{110,-50}}, color={0,0,127}));
  connect(voltWatt.Vpu, Vpu) annotation (Line(points={{-10,50},{-40,50},{-40,0},
          {-120,0}}, color={0,0,127}));
  connect(voltVar.Vpu, Vpu) annotation (Line(points={{-10,-50},{-40,-50},{-40,0},
          {-120,0}}, color={0,0,127}));
  connect(sub.y, Plim)
    annotation (Line(points={{61,50},{110,50}}, color={0,0,127}));
  connect(sub.u2, voltWatt.QCon) annotation (Line(points={{38,44},{20,44},{20,50},
          {13,50}}, color={0,0,127}));
  connect(const_p.y, sub.u1) annotation (Line(points={{21,80},{30,80},{30,56},{38,
          56}}, color={0,0,127}));
  annotation (Documentation(info="<html>
This model is similar to <a href=\"modelica://CyDER.HIL.Controls.voltVar\">
CyDER.HIL.Controls.voltVar</a> 
with the only differences that input variables have been 
changed to parameters.
</html>"));
end voltVarWatt_param_firstorder;
