within SCooDER.Components.Inverter.Interfaces;
expandable connector LoadCtrlBus "Control bus for load control"
  extends Modelica.Icons.SignalBus;
  Real P1(start=0, unit="W") "Positive = load; Negative = source";
  Real Q1(start=0, unit="var") "Positive = capacitive; Negative = inductive";
  Real P2(start=0, unit="W") "Positive = load; Negative = source";
  Real Q2(start=0, unit="var") "Positive = capacitive; Negative = inductive";
  Real P3(start=0, unit="W") "Positive = load; Negative = source";
  Real Q3(start=0, unit="var") "Positive = capacitive; Negative = inductive";

   annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
                  extent={{-20,2},{22,-2}},
                  lineColor={255,204,51},
                  lineThickness=0.5)}));

end LoadCtrlBus;
