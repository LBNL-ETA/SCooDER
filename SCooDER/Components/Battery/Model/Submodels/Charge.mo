within SCooDER.Components.Battery.Model.Submodels;
model Charge "Model to compute the battery charge"
  extends Modelica.Blocks.Icons.Block;
  parameter Modelica.SIunits.Efficiency etaCha(max=1) = 0.9
    "Efficiency during charging";
  parameter Modelica.SIunits.Efficiency etaDis(max=1) = 0.9
    "Efficiency during discharging";
  parameter Real SOC_start(min=0, max=1, unit="1")=0.1
    "Initial state of charge";

  Modelica.SIunits.Power PAct "Actual power";
  Modelica.Blocks.Interfaces.RealInput P(final quantity="Power",
                                         final unit="W") annotation (Placement(transformation(
          extent={{-140,-20},{-100,20}}),iconTransformation(extent={{-140,-20},{
            -100,20}})));
  Modelica.Blocks.Interfaces.RealOutput SOC(min=0, max=1) "State of charge [1]" annotation (Placement(transformation(
          extent={{100,-10},{120,10}}), iconTransformation(extent={{100,-10},{120,
            10}})));
  Modelica.Blocks.Interfaces.RealInput EMax( displayUnit = "Wh") "Remaining battery capacity [Wh]"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
protected
  Boolean underCharged "Flag, true if battery is undercharged";
  Boolean overCharged "Flag, true if battery is overcharged";
initial equation
  pre(underCharged) = SOC_start < 0;
  pre(overCharged)  = SOC_start > 1;

  SOC = SOC_start;
equation
  // Charge balance of battery
  PAct = if P > 0 then etaCha*P else (1/etaDis)*P;
  der(SOC)=PAct/(EMax+1e-6);

  // Equations to warn if state of charge exceeds 0 and 1
  underCharged = SOC < 0;
  overCharged = SOC > 1;
  when change(underCharged) or change(overCharged) then
    assert(SOC >= 0, "Warning: Battery is below minimum charge.",
    level=AssertionLevel.warning);
    assert(SOC <= 1, "Warning: Battery is above maximum charge.",
    level=AssertionLevel.warning);
  end when;

  annotation ( Documentation(info="<html>
<p>
This model represents the charge/discharge mechanism of a battery.
</p>
<p>
This model two parameters <i>&eta;<sub>CHA</sub></i> and <i>&eta;<sub>DIS</sub></i> that represent
the efficiency during the charge and discharge of the battery.
</p>
<p>
The model given the power <i>P</i> that should be provide or taken from the battery
and compute the actual power flowing through the battery as
</p>

<table summary=\"equations\" border = \"1\" cellspacing=\"0\" cellpadding=\"2\" style=\"border-collapse:collape;\">
<tr><th>Equation</th><th>Condition</th></tr>
<tr>
<td>P<sub>actual</sub> = P &eta;<sub>CHA</sub></td>
<td>P &ge; 0</td>
</tr>
<tr>
<td>P<sub>actual</sub> = P (2 - &eta;<sub>DIS</sub>)</td>
<td>P &lt; 0</td>
</tr>
</table>

<p>
Additionally the model has an EMax input, representing the maximum capacity of the battery. This value is set as a variable input, so it has the flexibility to e.g. be combined with battery degradation models.
<p>


<p>
The actual power is then used to compute the variation of the state of charge <code>SOC</code>.
The state of charge is the state variable of this model and is a real value between 0 and 1.
</p>

<p align=\"center\" style=\"font-style:italic;\">
 d SOC / dt = P<sub>actual</sub>
</p>

<p>
<b>Note:</b>The input power <i>P</i> has to be controlled in order
to avoid the state of charge <code>SOC</code>
exceeding the range between 0 and 1.
</p>

</html>", revisions="<html>
<ul>
<li>
March 5, 2020, by Joscha Mueller:<br/>
Revised documentation.
</li>
</ul>
</html>"));
end Charge;
