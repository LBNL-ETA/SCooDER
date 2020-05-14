within SCooDER.Components.Battery.Model.Submodels;
model BatteryDegradation
  //parameter Real a=8.61e-6 "Default Wang fitted";
  //parameter Real b=-5.13e-3 "Default Wang fitted";
  //parameter Real c=7.63e-1 "Default Wang fitted";
  //parameter Real d=-6.7e-3 "Default Wang fitted";
  //parameter Real e=2.35 "Default Wang fitted";
  parameter Real a=8.612e-06 "Fitting parameter (a) [1/(Ah*K2)]";
  parameter Real b=-0.005125 "Fitting parameter (b) [1/(Ah*K)]";
  parameter Real c=0.7629 "Fitting parameter (c) [1/(Ah)]";
  parameter Real d=-0.00672 "Fitting parameter (d) [1/(K*Cr)]";
  parameter Real e=2.347 "Fitting parameter (e) [1/(Cr)]";
  parameter Real f=14876 "Fitting parameter (f) [1/sqrt(day)]";
  parameter Real R=8.314 "Fitting parameter (R) [J/(mol*K)]";
  parameter Real Ea=24.5e3 "Fitting parameter (Ea) [J/(mol)]";
  parameter Real V(unit="V") = 345 "Nominal battery voltage";
  parameter Real Capacity = 24000 "Nominal battery capacity at start of life [Wh]";

  parameter Real startTime(min=0, unit="s", fixed=false) "Start time of simulation";
  parameter Real TAvgInit(min=0, unit="K") = 293.15  "Initial average battery temperature";
  parameter Real batAgeInit(min=0, unit="s") = 60 "Initial age of battery";
  parameter Real CRateAvgInit(min=0) = 1 "Initial average CRate of battery before simulation started [W/Wh]";
  parameter Real AhInit(min=0) = 1 "Initial energy throughput of battery [Ah]";
  parameter Real FlagLowCycle(min=0, max=1) = 0 "Consider low cycling of calendar aging (0.5 C constantly) [1=true; 0=false]";

  Modelica.Blocks.Interfaces.RealInput TBatt(
    start=293.15,
    min=0,
    unit="K") "Temperature Battery [K]"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput SOH "Battery state of health [-]"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput P( unit="W") "Internal battery power (before losses are applied)"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));

  Real CapLossCyc "Capacity lost, because of charging cycles [%]";
  Real CapLossCal "Capacity lost, because of degradation over time [%]";
  Real TAvg "Average temperature of battery over battery lifetime";
  Real CRate "Time for the battery to be charged or discharged with full power [h-1]";
  Real Ah "Ah throughput in [Ah]";
  Real CRateAvg "Average C-Rate over battery lifetime [h-1]";
  Real batAge "Battery age [s]";
  Real TInt "Integral of temperature since simulation start";
  Real Ah_calendar "Ah throughput embedded in calendar aging (0.5 C cycling) [Ah]";

initial equation
  startTime = time;
  Ah = AhInit;
  TAvg = TAvgInit;
  CRateAvg = CRateAvgInit;

equation
  batAge = batAgeInit + (time - startTime) + 1e-6;
  der(TInt) = TBatt;
  TAvg = (TInt + (TAvgInit * batAgeInit)) / batAge;
  der(CRate) = abs(P) / Capacity;
  CRateAvg = (CRate + (CRateAvgInit * batAgeInit)) / batAge;
  der(Ah) = abs(P / V) / 3600;
  if (1 - CapLossCyc / 100 - CapLossCal / 100 < 1e-6) then
    SOH = 1e-6;
  elseif (1 - CapLossCyc / 100 - CapLossCal / 100 > 1) then
    SOH = 1;
  else
    SOH = 1 - CapLossCyc / 100 - CapLossCal / 100;
  end if;
  CapLossCal = f * sqrt(batAge / 86400) * exp(-Ea / (R * TAvg)) "Capacity losses due to degradation by time [%]";

  Ah_calendar = Capacity / V * 0.5 * batAge / 3600;
  if (FlagLowCycle == 1) then
    if (Ah > Ah_calendar) then
      CapLossCyc = (a * TAvg^2 + b*TAvg + c) * exp((d * TAvg + e) * CRateAvg) * (Ah - Ah_calendar) "Capacity losses due to battery cycling [%]";
    else
      CapLossCyc = 0;
    end if;
  else
    CapLossCyc = (a * TAvg^2 + b*TAvg + c) * exp((d * TAvg + e) * CRateAvg) * Ah "Capacity losses due to battery cycling [%]";
  end if;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html> <p>This model represents the degradation of a battery as a combination of calendar and cycle losses. 
        It is based on the paper 'Degradation of lithium ion batteries employing graphite negatives and nickele-cobalte-manganese oxide + spinel manganese oxide positives: 
        Part 1, aging mechanisms and life estimation' (Wang, John, et al.). The combined battery loss of calendar and cycle losses in percent is based on the following equation:
        </p><bk/>
        <p>QLoss_calendar,% = f * sqrt(batAge / 86400) * exp(-Ea / (R * TAvg))</p>
        <p>QLoss_cycle,% = (a * TAvg^2 + b*TAvg + c) * exp((d * TAvg + e) * CRateAvg) * Ah</p>
        <p>QLoss,% = QLoss_calendar,% + QLoss_cycle,%</p>
        with<bk/>
        
        <ul>
        <li>a,b,c,d,e,f being custom fitted parameters</li>
        <li>TAvg being the average temperature of the battery over its lifetime [K]</li>
        <li>CRateAvg being the average C-Rate of the battery over its lifetime [W/Wh]</li>
        <li>Ah being the energy throughput of the battery over its lifetime [Ah]</li>
        <li>batAge being the battery age [s]</li>
        <li>Ea being the activation energy [kJ/mol]</li>
        <li>R being the gas constant [J/(mol*K)]</li>
        
        </ul>
        <h3> References </h3>
        Wang, John, Justin Purewal, Ping Liu, Jocelyn Hicks-Garner, Souren Soukazian, Elena Sherman, Adam Sorenson, Luan Vu, Harshad Tataria, and Mark W. Verbrugge. 'Degradation of lithium ion batteries employing graphite negatives and nickel–cobalt–manganese oxide+ spinel manganese oxide positives: Part 1, aging mechanisms and life estimation.' Journal of Power Sources 269 (2014): 937-948.
        </html>"));
end BatteryDegradation;
