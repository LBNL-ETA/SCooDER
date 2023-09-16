within SCooDER.Systems.FLEXLAB;
expandable connector monitoringBus "Flexlab Monitoring bus"
  extends Modelica.Icons.SignalBus;
  Real bess1Soc(start=0, unit="1") "State of charge of BESS1" annotation (HideResult=false);
  Real bess2Soc(start=0, unit="1") "State of charge of BESS2" annotation (HideResult=false);
  Real bess3Soc(start=0, unit="1") "State of charge of BESS3" annotation (HideResult=false);
  Real evSoc(start=0, unit="1") "State of charge of EV" annotation (HideResult=false);
   annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
                  extent={{-20,2},{22,-2}},
                  lineColor={255,204,51},
                  lineThickness=0.5)}));

end monitoringBus;
