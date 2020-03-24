within SCooDER.Components.Controller.Model;
model voltvar

  Modelica.Blocks.Interfaces.RealInput Vpu(start=1, unit="1") "Voltage [p.u.]"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput QCtrl(start=0, unit="var")
    "Q control signal"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput VMax(start=1.05, unit="1")
    "Voltage maximum [p.u.]"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput VMaxDead(start=1.01, unit="1")
    "Upper bound of deadband [p.u.]"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput VMinDead(start=0.99, unit="1")
    "Upper bound of deadband [p.u.]"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealInput VMin(start=0.95, unit="1")
    "Voltage minimum [p.u.]"
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealInput QMaxInd(start=1000, unit="var")
    "Maximal Reactive Power (Inductive)" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={20,120})));
  Modelica.Blocks.Interfaces.RealInput QMaxCap(start=1000, unit="var")
    "Maximal Reactive Power (Capacitive)" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,120})));
equation
  QCtrl = smooth(0, if Vpu > VMax then QMaxInd*(-1) elseif Vpu > VMaxDead then
    (VMaxDead - Vpu)/abs(VMax - VMaxDead)*QMaxInd elseif Vpu < VMin then
    QMaxCap elseif Vpu < VMinDead then (VMinDead - Vpu)/abs(VMin - VMinDead)*
    QMaxCap else 0);

end voltvar;
