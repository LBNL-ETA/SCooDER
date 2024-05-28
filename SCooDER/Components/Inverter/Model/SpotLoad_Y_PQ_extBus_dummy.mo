within SCooDER.Components.Inverter.Model;
model SpotLoad_Y_PQ_extBus_dummy
  /*parameter Modelica.SIunits.ActivePower P1(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q1(start=0) "Positive = capacitive; Negative = inductive";
  parameter Modelica.SIunits.ActivePower P2(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q2(start=0) "Positive = capacitive; Negative = inductive";
  parameter Modelica.SIunits.ActivePower P3(start=0) "Positive = load; Negative = source";
  parameter Modelica.SIunits.ReactivePower Q3(start=0) "Positive = capacitive; Negative = inductive";*/
  parameter Modelica.Units.SI.Voltage V_start=120;
  parameter Real T_const(unit="s")=0.01 "Time constant for firstorder";

  Interfaces.LoadCtrlBus ctrls annotation (Placement(transformation(extent={{-120,
            -20},{-80,20}}), iconTransformation(extent={{-110,-10},{-90,10}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end SpotLoad_Y_PQ_extBus_dummy;
