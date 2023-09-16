within SCooDER.Systems.FLEXLAB;
expandable connector powerBus "Flexlab Power bus"
  extends Modelica.Icons.SignalBus;
  Real P(start=0, unit="W") "Active Power Total" annotation (HideResult=false);
  Real Q(start=0, unit="var") "Reactive Power Total" annotation (HideResult=false);
  Real pv1P(start=0, unit="W") "Active Power Inverter 1" annotation (HideResult=false);
  Real pv1Q(start=0, unit="var") "Reactive Power Inverter 1" annotation (HideResult=false);
  Real pv2P(start=0, unit="W") "Active Power Inverter 2" annotation (HideResult=false);
  Real pv2Q(start=0, unit="var") "Reactive Power Inverter 2" annotation (HideResult=false);
  Real pv3P(start=0, unit="W") "Active Power Inverter 3" annotation (HideResult=false);
  Real pv3Q(start=0, unit="var") "Reactive Power Inverter 3" annotation (HideResult=false);
  Real evP(start=0, unit="W") "Active Power EV" annotation (HideResult=false);
  Real evQ(start=0, unit="var") "Reactive Power EV" annotation (HideResult=false);
   annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
                  extent={{-20,2},{22,-2}},
                  lineColor={255,204,51},
                  lineThickness=0.5)}));

end powerBus;
