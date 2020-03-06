within SCooDER.Components.Inverter.Model;
model SpotLoad_D_PQ
  parameter Modelica.SIunits.ActivePower P1(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q1(start=0) "Positive = capacitive; Negative = inductive";
  parameter Modelica.SIunits.ActivePower P2(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q2(start=0) "Positive = capacitive; Negative = inductive";
  parameter Modelica.SIunits.ActivePower P3(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q3(start=0) "Positive = capacitive; Negative = inductive";
  parameter Modelica.SIunits.Voltage V_start=120;

  Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_n
    terminal_n
    annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.WyeToDelta
    wyeToWyeGround "Wye to wye grounded connection"
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
protected
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada "Adapter"
    annotation (Placement(transformation(extent={{32,-10},{52,10}})));
public
  InverterLoad_PQ PQ1(V_start=V_start, V_nominal=V_start)
    annotation (Placement(transformation(extent={{0,30},{-20,50}})));
  InverterLoad_PQ PQ3(V_start=V_start, V_nominal=V_start)
    annotation (Placement(transformation(extent={{0,-50},{-20,-30}})));
  InverterLoad_PQ PQ2(V_start=V_start, V_nominal=V_start)
    annotation (Placement(transformation(extent={{0,-10},{-20,10}})));
  Modelica.Blocks.Sources.RealExpression PQ1_Q(y=Q1)
    annotation (Placement(transformation(extent={{-80,36},{-60,56}})));
  Modelica.Blocks.Sources.RealExpression PQ1_P(y=-P1)
    annotation (Placement(transformation(extent={{-80,22},{-60,42}})));
  Modelica.Blocks.Sources.RealExpression PQ2_Q(y=Q2)
    annotation (Placement(transformation(extent={{-80,-4},{-60,16}})));
  Modelica.Blocks.Sources.RealExpression PQ2_P(y=-P2)
    annotation (Placement(transformation(extent={{-80,-18},{-60,2}})));
  Modelica.Blocks.Sources.RealExpression PQ3_Q(y=Q3)
    annotation (Placement(transformation(extent={{-80,-44},{-60,-24}})));
  Modelica.Blocks.Sources.RealExpression PQ3_P(y=-P3)
    annotation (Placement(transformation(extent={{-80,-58},{-60,-38}})));
equation
  connect(wyeToWyeGround.wye, terminal_n)
    annotation (Line(points={{80,0},{100,0}},         color={0,120,120}));
  connect(PQ1.terminal, ada.terminals[1]) annotation (Line(points={{0,40},{20,40},
          {20,0.533333},{32.2,0.533333}}, color={0,120,120}));
  connect(PQ2.terminal, ada.terminals[2])
    annotation (Line(points={{0,0},{32.2,0}}, color={0,120,120}));
  connect(PQ3.terminal, ada.terminals[3]) annotation (Line(points={{0,-40},{20,-40},
          {20,-0.533333},{32.2,-0.533333}}, color={0,120,120}));
  connect(PQ1_P.y,PQ1. Pow) annotation (Line(points={{-59,32},{-60,32},{-56,32},
          {-40,32},{-40,40},{-22,40}}, color={0,0,127}));
  connect(PQ1_Q.y,PQ1. Q)
    annotation (Line(points={{-59,46},{-40,46},{-22,46}}, color={0,0,127}));
  connect(PQ2_Q.y,PQ2. Q)
    annotation (Line(points={{-59,6},{-40,6},{-22,6}}, color={0,0,127}));
  connect(PQ2_P.y,PQ2. Pow) annotation (Line(points={{-59,-8},{-40,-8},{-40,0},{
          -22,0}}, color={0,0,127}));
  connect(PQ3_Q.y,PQ3. Q)
    annotation (Line(points={{-59,-34},{-42,-34},{-22,-34}}, color={0,0,127}));
  connect(PQ3_P.y,PQ3. Pow) annotation (Line(points={{-59,-48},{-40,-48},{-40,-40},
          {-22,-40}}, color={0,0,127}));
  connect(ada.terminal, wyeToWyeGround.delta)
    annotation (Line(points={{52,0},{56,0},{60,0}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SpotLoad_D_PQ;
