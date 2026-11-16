within SCooDER.Components.Load.Model;
expandable connector LoadCtrlBus "Control bus for Load"
  extends Modelica.Icons.SignalBus;
  Real pctrl( start = 0, unit="W") "Active power control for Generator" annotation (HideResult=false);
  Real qctrl( start=0, unit="var") "Reactive power control for Inverter" annotation (HideResult=false);
  Real p( start=0, unit="W") "Measured AC active power" annotation (HideResult=false);
  Real q( start=0, unit="var") "Measured AC reactive power" annotation (HideResult=false);
  Real v( start=120, unit="V") "Measured AC voltage" annotation (HideResult=false);
   annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
                  extent={{-20,2},{22,-2}},
                  lineColor={255,204,51},
                  lineThickness=0.5)}));

end LoadCtrlBus;
