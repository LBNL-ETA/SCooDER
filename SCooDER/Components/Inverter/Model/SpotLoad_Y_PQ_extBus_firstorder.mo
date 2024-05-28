within SCooDER.Components.Inverter.Model;
model SpotLoad_Y_PQ_extBus_firstorder
  /*parameter Modelica.SIunits.ActivePower P1(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q1(start=0) "Positive = capacitive; Negative = inductive";
  parameter Modelica.SIunits.ActivePower P2(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q2(start=0) "Positive = capacitive; Negative = inductive";
  parameter Modelica.SIunits.ActivePower P3(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q3(start=0) "Positive = capacitive; Negative = inductive";*/
  parameter Modelica.Units.SI.Voltage V_start=120;
  parameter Real T_const(unit="s")=0.01 "Time constant for firstorder";

  Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_n
    terminal_n
    annotation (Placement(transformation(extent={{90,-10},{110,10}}), iconTransformation(extent={{90,-10},{110,10}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.WyeToWyeGround
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
  Interfaces.LoadCtrlBus ctrls annotation (Placement(transformation(extent={{-120,
            -20},{-80,20}}), iconTransformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder1(
    T=T_const,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0)
    annotation (Placement(transformation(extent={{-54,42},{-46,50}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder2(
    T=T_const,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0,
    k=-1)
    annotation (Placement(transformation(extent={{-54,28},{-46,36}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder3(
    T=T_const,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0)
    annotation (Placement(transformation(extent={{-54,2},{-46,10}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder4(
    T=T_const,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0,
    k=-1)
    annotation (Placement(transformation(extent={{-54,-12},{-46,-4}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder5(
    T=T_const,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0)
    annotation (Placement(transformation(extent={{-54,-38},{-46,-30}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder6(
    T=T_const,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0,
    k=-1)
    annotation (Placement(transformation(extent={{-54,-52},{-46,-44}})));
equation
  connect(ada.terminal, wyeToWyeGround.wyeg)
    annotation (Line(points={{52,0},{56,0},{60,0}}, color={0,120,120}));
  connect(wyeToWyeGround.wye, terminal_n)
    annotation (Line(points={{80,0},{100,0},{100,0}}, color={0,120,120}));
  connect(PQ1.terminal, ada.terminals[1]) annotation (Line(points={{0,40},{20,40},
          {20,0.533333},{32.2,0.533333}}, color={0,120,120}));
  connect(PQ2.terminal, ada.terminals[2])
    annotation (Line(points={{0,0},{32.2,0}}, color={0,120,120}));
  connect(PQ3.terminal, ada.terminals[3]) annotation (Line(points={{0,-40},{20,-40},
          {20,-0.533333},{32.2,-0.533333}}, color={0,120,120}));
  connect(firstOrder1.y, PQ1.Q)
    annotation (Line(points={{-45.6,46},{-22,46}}, color={0,0,127}));
  connect(firstOrder6.y, PQ3.Pow) annotation (Line(points={{-45.6,-48},{-40,-48},
          {-40,-40},{-22,-40}}, color={0,0,127}));
  connect(firstOrder5.y, PQ3.Q)
    annotation (Line(points={{-45.6,-34},{-22,-34}}, color={0,0,127}));
  connect(firstOrder4.y, PQ2.Pow) annotation (Line(points={{-45.6,-8},{-40,-8},
          {-40,0},{-22,0}}, color={0,0,127}));
  connect(firstOrder3.y, PQ2.Q)
    annotation (Line(points={{-45.6,6},{-22,6}}, color={0,0,127}));
  connect(firstOrder2.y, PQ1.Pow) annotation (Line(points={{-45.6,32},{-40,32},
          {-40,40},{-22,40}}, color={0,0,127}));
  connect(firstOrder1.u, ctrls.Q1) annotation (Line(points={{-54.8,46},{-74,46},
          {-74,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(firstOrder2.u, ctrls.P1) annotation (Line(points={{-54.8,32},{-74,32},
          {-74,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(firstOrder3.u, ctrls.Q2) annotation (Line(points={{-54.8,6},{-74,6},{
          -74,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(firstOrder4.u, ctrls.P2) annotation (Line(points={{-54.8,-8},{-74,-8},
          {-74,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(firstOrder5.u, ctrls.Q3) annotation (Line(points={{-54.8,-34},{-74,
          -34},{-74,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(firstOrder6.u, ctrls.P3) annotation (Line(points={{-54.8,-48},{-74,
          -48},{-74,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SpotLoad_Y_PQ_extBus_firstorder;
