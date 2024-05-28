within SCooDER.Components.Controller.Model;
model voltVar_param_simple

  Modelica.Blocks.Interfaces.RealInput Vpu(start=1, unit="1") "Voltage [p.u]"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput QCon(start= 0, unit="var") "Q control signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  parameter Real thr = 0.05 "over/undervoltage threshold";
  parameter Real hys = 0.01 "Hysteresis";
  final parameter Modelica.Units.SI.PerUnit vMaxDea=1 + hys
    "Upper bound of deaband [p.u.]";
  final parameter Modelica.Units.SI.PerUnit vMax=1 + thr
    "Voltage maximum [p.u.]";
  final parameter Modelica.Units.SI.PerUnit vMinDea=1 - hys
    "Upper bound of deaband [p.u.]";
  final parameter Modelica.Units.SI.PerUnit vMin=1 - thr
    "Voltage minimum [p.u.]";
  parameter Real QMaxInd(unit="var") = 1000 "Maximal Reactive Power (Inductive)";
  parameter Real QMaxCap(unit="var") = 1000 "Maximal Reactive Power (Capacitive)";
equation
  QCon =smooth(0, if Vpu > vMax then QMaxInd*(-1) elseif Vpu > vMaxDea then (
    vMaxDea - Vpu)/abs(vMax - vMaxDea)*QMaxInd elseif Vpu < vMin then QMaxCap
     elseif Vpu < vMinDea then (vMinDea - Vpu)/abs(vMin - vMinDea)*QMaxCap
     else 0);
  annotation (Documentation(info="<html>
This model is similar to <a href=\"modelica://CyDER.HIL.Controls.voltVar\">
CyDER.HIL.Controls.voltVar</a> 
with the only differences that input variables have been 
changed to parameters.
</html>"));
end voltVar_param_simple;
