within SCooDER.Components.Conversion.Model;
model DCtoAC_2

  Buildings.Electrical.DC.Interfaces.Terminal_p terminal_p
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n "Negative pin"
    annotation (Placement(transformation(extent={{-90,-50},{-110,-30}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p "Positive pin"
    annotation (Placement(transformation(extent={{-110,10},{-90,30}})));
equation
  terminal_p.v[1] = p.v;
  terminal_p.v[2] = n.v;
  terminal_p.i[1] = p.i;
  terminal_p.i[2] = n.i;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DCtoAC_2;
