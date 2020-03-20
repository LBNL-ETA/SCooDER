within SCooDER.Components.Battery.Model;
model BatteryDegradation
  //parameter Real a=8.61e-6 "default Wang fitted";
  //parameter Real b=-5.13e-3 "default Wang fitted";
  //parameter Real c=7.63e-1 "default Wang fitted";
  parameter Real a=8.860644141827217e-06;
  parameter Real b=-0.005297550909189135;
  parameter Real c=0.7922675255918518;
  parameter Real d=-6.7e-3;
  parameter Real e=2.35;
  parameter Real f=14876;
  parameter Real R=8.314;
  parameter Real Ea=24.5e3;
  parameter Real V( unit="V") = 380 "Nominal battery voltage";
  parameter Real Pmax( unit="W") = 3300 "Maximum battery power";
  parameter Real Capacity = 6400 "Battery capacity at start of life [Wh]";

  parameter Real startTime = 0 "Set this value to the startTime of the simulation. Otherwise, the averages are calculated wrong. [s]";
  parameter Real TAvgInit( min=0, unit="K") = 293.15  "Average battery temperature before simulation started";
  parameter Real batAgeInit = 0 "Initial age of battery [s]";
  parameter Real IRateAvgInit = 0 "Average IRate of battery before simulation started [h-1]";
  parameter Real AhStart = 0 "Ah throughput of battery before simulation started [Ah]";

  Modelica.Blocks.Interfaces.RealInput T( start=293.15,min=0, unit="K") "Temperature outside [K]"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput SOH "Battery state of health [-]"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput P( unit="W") "Internal battery power (before losses are applied)"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));

  Real CapLossCyc "Capacity lost, because of charging cycles [%]";
  Real CapLossCal "Capacity lost, because of degradation over time [%]";

  Real TAvg(min=0, start=293.15, unit="K") "Average temperature of battery over battery lifetime";
  Real IRate "Time for the battery to be charged or discharged with full power [h-1]";
  Real Ah "Ah throughput in [Ah]";
  Real IRateAvg "Average I-Rate over battery lifetime [h-1]";
  Real batAge "Battery age [s]";
  Real TInt(min=0) "Integral of temperature since simulation start";

initial equation
    IRateAvg = (P/V)/(Capacity/V);
    Ah = 0;
    TAvg = TAvgInit;

equation
  batAge = batAgeInit + (time - startTime) + 1e-6 "Total Battery age [s]";
  der(TInt) = T "Integral of temperature over simulation time";
  TAvg = (TInt + (TAvgInit*batAgeInit))/batAge "Average temperature of battery lifetime (simulation time and pre simulation temperature) [K]";
  IRate = (P/V)/(Capacity/V) "I-rate of battery [h-1]";

  if time <= startTime then
    der(IRateAvg) = IRateAvgInit;
  else
    der(IRateAvg*(time - startTime +1e-6)) = IRate;
  end if;

  der(Ah) = abs(P/V)/3600/2 "Divided by 2, because it will count charging and discharing as Ah throughput, so it would be doubled otherwise";
  if (1 - CapLossCyc/100 - CapLossCal/100 <1e-6) then
          SOH = 1e-6;
  elseif (1 - CapLossCyc/100 - CapLossCal/100 >1) then
          SOH = 1;
  else
          SOH = 1 - CapLossCyc/100 - CapLossCal/100;
  end if;
  CapLossCal = f*sqrt(batAge/86400)*exp(-Ea/(R*TAvg)) "Capacity losses due to degradation by time [%]";
  CapLossCyc =( a*(TAvg^2) + b*TAvg + c)*exp((d*TAvg + e)*IRateAvg)*Ah "Capacity losses due to battery cycling [%]";

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html> <p>This model represents the degradation of a battery as a combination of calendar and cycle losses.</p> </html>"));
end BatteryDegradation;
