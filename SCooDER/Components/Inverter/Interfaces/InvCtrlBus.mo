within SCooDER.Components.Inverter.Interfaces;
expandable connector InvCtrlBus
  "Control bus for inverter control"
  extends Modelica.Icons.SignalBus;
  Real qctrl( start=0, unit="var") "Reactive power control for Inverter" annotation (HideResult=false);
  Real plim( start=1, min=0, max=1, unit="1") "Power limit control for Inverter" annotation (HideResult=false);
  Real batt_ctrl( start=0, unit="W") "Power control for Battery" annotation (HideResult=false);
  Real batt_soc(start=0, unit="1") "Battery State of Charge" annotation (HideResult=false);
  Real p( start=0, unit="W") "Measured AC active power" annotation (HideResult=false);
  Real q( start=0, unit="var") "Measured AC reactive power" annotation (HideResult=false);
  Real v( start=120, unit="V") "Measured AC voltage" annotation (HideResult=false);
   annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
                  extent={{-20,2},{22,-2}},
                  lineColor={255,204,51},
                  lineThickness=0.5)}));

end InvCtrlBus;
