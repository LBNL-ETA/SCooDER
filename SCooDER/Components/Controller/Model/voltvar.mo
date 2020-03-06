within SCooDER.Components.Controller.Model;
model voltvar

  Modelica.Blocks.Interfaces.RealInput v_pu( start=1, unit="1") "Voltage [p.u.]" annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput q_control( start=0, unit="var") "Q control signal" annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput v_max( start=1.05, unit="1") "Voltage maximum [p.u.]" annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealInput v_maxdead( start=1.01, unit="1") "Upper bound of deadband [p.u.]" annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput v_mindead( start=0.99, unit="1") "Upper bound of deadband [p.u.]" annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealInput v_min( start=0.95, unit="1") "Voltage minimum [p.u.]" annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Modelica.Blocks.Interfaces.RealInput q_maxind( start=1000, unit="var") "Maximal Reactive Power (Inductive)" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={20,120})));
  Modelica.Blocks.Interfaces.RealInput q_maxcap( start=1000, unit="var") "Maximal Reactive Power (Capacitive)" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={-40,120})));
equation
  q_control = smooth(0,
    if v_pu > v_max then q_maxind * (-1)
    elseif v_pu > v_maxdead then (v_maxdead - v_pu)/abs(v_max - v_maxdead) * q_maxind
    elseif v_pu < v_min then q_maxcap
    elseif v_pu < v_mindead then (v_mindead - v_pu)/abs(v_min - v_mindead) * q_maxcap
    else 0);

end voltvar;
