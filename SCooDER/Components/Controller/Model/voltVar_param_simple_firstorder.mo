within SCooDER.Components.Controller.Model;
model voltVar_param_simple_firstorder

  Modelica.Blocks.Interfaces.RealInput Vpu(start=1, unit="1") "Voltage [p.u]"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput QCon(start=0, unit="var") "Q control signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  parameter Real thr = 0.05 "over/undervoltage threshold";
  parameter Real hys= 0.01 "Hysteresis";
  final parameter Modelica.SIunits.PerUnit vMaxDea=1 + hys "Upper bound of deaband [p.u.]";
  final parameter Modelica.SIunits.PerUnit vMax=1 + thr "Voltage maximum [p.u.]";
  final parameter Modelica.SIunits.PerUnit vMinDea=1 - hys "Upper bound of deaband [p.u.]";
  final parameter Modelica.SIunits.PerUnit vMin=1 - thr "Voltage minimum [p.u.]";
  parameter Real QMaxInd(unit="var") = 1000 "Maximal Reactive Power (Inductive)";
  parameter Real QMaxCap(unit="var") = 1000 "Maximal Reactive Power (Capacitive)";
  parameter Real Tfirstorder(unit="s") = 1 "Time constant of first order";
  SCooDER.Components.Controller.Model.voltVar_param_simple
    voltVar_param1(
    thr=thr,
    hys=hys,
    QMaxInd=QMaxInd,
    QMaxCap=QMaxCap)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(T=Tfirstorder)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
equation

  connect(voltVar_param1.Vpu, Vpu)
    annotation (Line(points={{-12,0},{-120,0}}, color={0,0,127}));
  connect(voltVar_param1.QCon, firstOrder.u)
    annotation (Line(points={{11,0},{11,0},{58,0}}, color={0,0,127}));
  connect(firstOrder.y, QCon)
    annotation (Line(points={{81,0},{94,0},{110,0}},        color={0,0,127}));
  annotation (Documentation(info="<html>
This model is similar to <a href=\"modelica://CyDER.HIL.Controls.voltVar\">
CyDER.HIL.Controls.voltVar</a> 
with the only differences that input variables have been 
changed to parameters.
</html>"));
end voltVar_param_simple_firstorder;
