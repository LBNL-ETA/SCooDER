within SCooDER.Components.Sensor.Model;
model Probe3ph
  parameter Modelica.SIunits.Voltage V_nominal = 208;
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_n terminal_n
    "Electrical connector side N"
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Interfaces.RealOutput Vy[3](each final quantity=
        "ElectricPotential", each final unit="V") "Voltage Line to Neutral"
                              annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,-40}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-90,-90})));
  Modelica.Blocks.Interfaces.RealOutput I[3](each final quantity="ElectricCurrent",
                                          each final unit="A") "Phase Current"           annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,-40}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-70,-90})));
  Modelica.Blocks.Interfaces.RealOutput S_old[3,Buildings.Electrical.PhaseSystems.OnePhase.n](
     each final quantity="Power", each final unit="W") "Phase powers"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,-40}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={70,-90})));
  Modelica.Blocks.Interfaces.RealOutput Test(final quantity="Power", final
            unit="VA") "Phase powers" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-70}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={90,-90})));

  Modelica.Blocks.Interfaces.RealOutput T1[3](each final quantity="Angle", each final
            unit="rad") "Test";
  Modelica.Blocks.Interfaces.RealOutput T2[3](each final quantity="Angle", each final
            unit="rad") "Test";
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_p
                        terminal_p "Electrical connector side P"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Modelica.Blocks.Interfaces.RealOutput P[3](each final quantity="ActivePower",
   each final unit="W") "Phase Active Power" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={22,-68}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,-90})));
  Modelica.Blocks.Interfaces.RealOutput S[3](each final quantity="ApparentPower",
      each final unit="VA") "Phase Apparent Power" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={48,-68}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,-90})));
  Modelica.Blocks.Interfaces.RealOutput Q[3](each final quantity="ReactivePower",
   each final unit="var") "Phase Reactive Power" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-56,-66}), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-10,-90})));
  Modelica.Blocks.Interfaces.RealOutput PF[3](each final quantity="PowerFactor",
   each final unit="") "Phase Power Factor" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-88,-66}),iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={10,-90})));
  Modelica.Blocks.Interfaces.RealOutput V_pu[3](each final quantity="ElectricPotential",
   each final unit="V") "Phase Voltage per Unit";

equation

  for i in 1:3 loop
    Vy[i] = Buildings.Electrical.PhaseSystems.OnePhase.systemVoltage(
      terminal_n.phase[i].v);
    V_pu[i] = Buildings.Electrical.PhaseSystems.OnePhase.systemVoltage(terminal_n.phase[i].v) / (V_nominal / sqrt(3));
    I[i]   = Buildings.Electrical.PhaseSystems.OnePhase.systemCurrent(terminal_n.phase[i].i);
    S_old[i, :] = Buildings.Electrical.PhaseSystems.OnePhase.phasePowers_vi(v=
      terminal_n.phase[i].v, i=terminal_n.phase[i].i);
    P[i] = S_old[i, 1];
    Q[i] = S_old[i, 2];
    //if S[i] > P[i] then
    S[i] = sqrt(P[i]^2 + Q[i]^2) * P[i]/sqrt(P[i]^2 + 1e-9);
    //else
    //  S[i] = 99;
    //end if;
    PF[i] = P[i] / (S[i] + 1e-9);
    //P[i] = Buildings.Electrical.PhaseSystems.OnePhase.activePower(v=terminal_n.phase[i].v, i=terminal_n.phase[i].i);
    //  Modelica.SIunits.Angle phi=
    //T1[i] = Buildings.Electrical.PhaseSystems.OnePhase.phase(terminal_n.phase[i].v) - Buildings.Electrical.PhaseSystems.OnePhase.phase(-terminal_n.phase[i].i);
    T1[i] = Buildings.Electrical.PhaseSystems.OnePhase.phase(terminal_n.phase[i].v);
    //T2[i] = Buildings.Electrical.PhaseSystems.OnePhase.phase(terminal_n.phase[i].i);
    //T2[i] = mod(terminal_n.phase[i].theta[1],360);

    T2[i] = terminal_n.phase[i].theta[1];

    //T2[i] = Modelica.ComplexMath.sin(terminal_n.phase[i].v);
    //T2[i] = 0;
    //T1[i] = 0;

    //Test[i] = PhaseSystem.phase(terminal.v) - PhaseSystem.phase(-terminal.i);
    //"Phase shift with respect to reference angle";
    //Test[i] = Buildings.Electrical.PhaseSystems.OnePhase.thetaRel(terminal_n.phase[i].theta);
  end for;
  //Test = terminal_n.phase[1];
  Test = 1;

  connect(terminal_n, terminal_p);
  annotation (defaultComponentName="sens",
 Icon(graphics={
        Rectangle(
          extent={{-70,28},{70,-30}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-60,60},{60,-60}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          points={{-92,0},{-70,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-100,-60},{-80,-80}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="V"),
        Polygon(
          points={{-0.48,33.6},{18,28},{18,59.2},{-0.48,33.6}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(points={{-37.6,15.7},{-54,22}},     color={0,0,0}),
        Line(points={{-22.9,34.8},{-32,50}},     color={0,0,0}),
        Line(points={{0,60},{0,42}}, color={0,0,0}),
        Line(points={{22.9,34.8},{32,50}},     color={0,0,0}),
        Line(points={{37.6,15.7},{54,24}},     color={0,0,0}),
        Line(points={{0,2},{9.02,30.6}}, color={0,0,0}),
        Ellipse(
          extent={{-5,7},{5,-3}},
          lineColor={0,0,0},
          fillColor={0,0,0},
          fillPattern=FillPattern.Solid),
        Line(
          points={{70,0},{92,0}},
          color={0,0,0},
          smooth=Smooth.None),
        Text(
          extent={{-120,100},{120,60}},
          lineColor={0,0,0},
          textString="%name"),
        Text(
          extent={{-80,-60},{-60,-80}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="I"),
        Text(
          extent={{-60,-60},{-40,-80}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="S"),
        Text(
          extent={{-40,-60},{-20,-80}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="P"),
        Text(
          extent={{-20,-60},{0,-80}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Q"),
        Text(
          extent={{0,-60},{20,-80}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="PF"),
        Text(
          extent={{60,-60},{80,-80}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="SX"),
        Text(
          extent={{80,-60},{100,-80}},
          lineColor={0,0,0},
          lineThickness=1,
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="X")}),
    Documentation(info="<html>
<p>
Ideal sensor that measures power, voltage and current in a three-phase unbalanced system
without a neutral cable.
The two components of the power <i>S</i> are the active and reactive power for each phase.
</p>
</html>", revisions="<html>
<ul>
<li>
November 8, 2016, by Michael Wetter:<br/>
Corrected wrong access to phase system.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/570\">#570</a>.
</li>
<li>
September 24, 2014, by Marco Bonvini:<br/>
Revised documentation.
</li>
</ul>
</html>"));
end Probe3ph;
