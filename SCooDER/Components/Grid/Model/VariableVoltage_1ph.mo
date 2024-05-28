within SCooDER.Components.Grid.Model;
model VariableVoltage_1ph "Variable single phase AC voltage source"
  extends Buildings.Electrical.Interfaces.Source(
    redeclare package PhaseSystem = Buildings.Electrical.PhaseSystems.OnePhase,
    redeclare replaceable
      Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_p terminal);
  parameter Modelica.Units.SI.Frequency f(start=60) "Frequency of the source";
  //parameter Modelica.SIunits.Voltage V(start = 110) "RMS voltage of the source";
  Modelica.Blocks.Interfaces.RealInput Vext(start=110)
    "RMS voltage of the source" annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,0}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,30})));
  parameter Modelica.Units.SI.Angle phiSou=0 "Phase shift of the source";
  Modelica.Units.SI.Angle thetaRel
    "Absolute angle of rotating system as offset to thetaRef";
equation
  if Connections.isRoot(terminal.theta) then
    PhaseSystem.thetaRef(terminal.theta) =  2*Modelica.Constants.pi*f*time;
  end if;
  thetaRel = PhaseSystem.thetaRel(terminal.theta);
  terminal.v =PhaseSystem.phaseVoltages(Vext, thetaRel + phiSou);

  annotation (
    defaultComponentName="fixVol",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}),
                   graphics={
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Line(
          points={{-44,0},{-24,40},{-4,0},{16,-40},{36,0}},
          color={0,0,0},
          smooth=Smooth.Bezier),
        Text(
          extent={{-120,100},{120,60}},
          lineColor={0,0,0},
          textString="%name"),
        Line(
          points={{60,0},{90,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Line(visible = definiteReference == true,
          points={{80,-46},{120,-46}},
          color={0,120,120},
          smooth=Smooth.None,
          thickness=0.5),
        Line(visible = definiteReference == true,
          points={{80,-46},{106,-20}},
          color={0,120,120},
          smooth=Smooth.None,
          thickness=0.5),
        Line(visible = definiteReference == true,
          points={{102,-22},{114,-30},{118,-48}},
          color={0,120,120},
          smooth=Smooth.Bezier),
        Text(
          extent={{-118,-60},{122,-100}},
          lineColor={0,0,0},
          textString="V = %Vext")}),
      Documentation(info="<html>
<p>
This is a constant voltage source. The complex voltage is specified by the RMS voltage
and the phase shift.
</p>
</html>",
 revisions="<html>
<ul>
<li>
November 8, 2016, by Michael Wetter:<br/>
Added <code>replaceable</code> to terminal redeclaration as they are redeclared by
<a href=\"modelica://Buildings.Electrical.AC.ThreePhasesBalanced.Sources.FixedVoltage\">
Buildings.Electrical.AC.ThreePhasesBalanced.Sources.FixedVoltage</a>.
</li>
<li>
September 4, 2014, by Michael Wetter:<br/>
Revised documentation.
</li>
<li>
August 5, 2014, by Marco Bonvini:<br/>
First implementation.
</li>
</ul>
</html>"));
end VariableVoltage_1ph;
