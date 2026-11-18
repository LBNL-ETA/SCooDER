within SCooDER.Components.Sensor.Model;
expandable connector Monitoring "Interface to Microgrid"
  extends Modelica.Icons.SignalBus;
  Real P_Grid( start=0, unit="W") "Measured AC active power" annotation (HideResult=false);
  Real Q_Grid( start=0, unit="var") "Measured AC reactive power" annotation (HideResult=false);
  Real V_Grid( start=120, unit="V") "Measured AC voltage" annotation (HideResult=false);
  Real P_Island( start=0, unit="W") "Measured AC active power" annotation (HideResult=false);
  Real Q_Island( start=0, unit="var") "Measured AC reactive power" annotation (HideResult=false);
  Real V_Island( start=120, unit="V") "Measured AC voltage" annotation (HideResult=false);

  Real P_Gen( start=0, unit="W") "Measured AC active power" annotation (HideResult=false);
  Real P_PV( start=0, unit="W") "Measured AC active power" annotation (HideResult=false);
  Real P_Load( start=0, unit="W") "Measured AC active power" annotation (HideResult=false);
  Real P_Batt( start=0, unit="W") "Measured AC active power" annotation (HideResult=false);
  Real SOC_Batt( start=0, unit="1") "Measured AC active power" annotation (HideResult=false);
  Real SOC_Gen( start=0, unit="1") "Measured AC active power" annotation (HideResult=false);
  Real SOE_Batt( start=0, unit="W.h") "Measured AC active power" annotation (HideResult=false);
   annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
            -100},{100,100}}), graphics={Rectangle(
                  extent={{-20,2},{22,-2}},
                  lineColor={255,204,51},
                  lineThickness=0.5)}));

end Monitoring;
