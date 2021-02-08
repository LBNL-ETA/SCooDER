within SCooDER.Development;
partial model VoltageSource "Interface for voltage sources"
  extends Modelica.Electrical.Analog.Interfaces.OnePort;

  parameter Modelica.SIunits.Voltage offset=0 "Voltage offset";
  parameter Modelica.SIunits.Time startTime=0 "Time offset";
  replaceable Modelica.Blocks.Interfaces.SignalSource signalSource(
      final offset = offset, final startTime=startTime)
  annotation (Placement(transformation(extent={{70,70},{90,90}})));
equation
  v = signalSource.y;
  annotation (
    Icon(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Ellipse(
          extent={{-50,50},{50,-50}},
          lineColor={0,0,255},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,80},{150,120}},
          textString="%name",
          lineColor={0,0,255}),
        Line(points={{-90,0},{90,0}}, color={0,0,255}),
        Text(
          extent={{-120,50},{-20,0}},
          lineColor={0,0,255},
          textString="+"),
        Text(
          extent={{20,50},{120,0}},
          lineColor={0,0,255},
          textString="-")}),
    Documentation(revisions="<html>
<ul>
<li><i> 1998   </i>
       by Christoph Clauss<br> initially implemented<br>
       </li>
</ul>
</html>",
        info="<html>
<p>The VoltageSource partial model prepares voltage sources by providing the pins, and the offset and startTime parameters, which are the same at all voltage sources. The source behavior is taken from Modelica.Blocks signal sources by inheritance and usage of the replaceable possibilities.</p>
</html>"));
end VoltageSource;
