within SCooDER.Systems.FLEXLAB;
expandable connector controlBus "Flexlab Control bus"
  extends Modelica.Icons.SignalBus;
  Real bess1Pctrl(start=0, unit="W") "Control of BESS 1" annotation (HideResult=false);
  Real bess2Pctrl(start=0, unit="W") "Control of BESS  2" annotation (HideResult=false);
  Real bess3Pctrl(start=0, unit="W") "Control of BESS  3" annotation (HideResult=false);
  Real evPctrl(start=0, unit="W") "Control of EV" annotation (HideResult=false);
   annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
                  extent={{-20,2},{22,-2}},
                  lineColor={255,204,51},
                  lineThickness=0.5)}));

end controlBus;
