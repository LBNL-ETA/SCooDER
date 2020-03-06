within SCooDER.Components.Inverter.Interfaces;
expandable connector SiteCtrlBus "Control bus for a site of  inverter control"
  extends Modelica.Icons.SignalBus;
  Real pf1( start=1, min=0, max=1, unit="1") "Power factor control for Inverter 1" annotation (HideResult=false);
  Real plim1( start=1, min=0, max=1, unit="1") "Power limit control for Inverter 1" annotation (HideResult=false);
  Real batt_ctrl1( start=0, unit="W") "Power control for Battery 1" annotation (HideResult=false);
  Real pf2( start=1, min=0, max=1, unit="1") "Power factor control for Inverter 2" annotation (HideResult=false);
  Real plim2( start=1, min=0, max=1, unit="1") "Power limit control for Inverter 2" annotation (HideResult=false);
  Real batt_ctrl2( start=0, unit="W") "Power control for Battery 2" annotation (HideResult=false);
  Real pf3( start=1, min=0, max=1, unit="1") "Power factor control for Inverter 3" annotation (HideResult=false);
  Real plim3( start=1, min=0, max=1, unit="1") "Power limit control for Inverter 3" annotation (HideResult=false);
  Real batt_ctrl3( start=0, unit="W") "Power control for Battery 3" annotation (HideResult=false);
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
                  extent={{-20,2},{22,-2}},
                  lineColor={255,204,51},
                  lineThickness=0.5)}));

end SiteCtrlBus;
