within SCooDER.Components.Battery.Model;
model BatteryAdv  "Advanced battery model with temperature modeling and degradation modeling"

  parameter Real CapNom(min=0) = 24000 "Battery capacity at start of life [Wh]";
  parameter Real PMax(min=0, unit="W") = 60000  "Max battery power";
  parameter Real SOC_start(min=0, max=1, unit="1") = 0
    "Initial SOC value";
  parameter Real SOC_min(min=0, max=1, unit="1") = 0
    "Minimum SOC value";
  parameter Real SOC_max(min=0, max=1, unit="1") = 1
    "Maximum SOC value";
  parameter Real etaCha(min=0, max=1, unit="1") = 0.96
    "Charging efficiency";
  parameter Real etaDis(min=0, max=1, unit="1") = 0.96
    "Discharging efficiency";
    parameter Real TBattInit( min = 0, unit="K") = 293.15  "Temperature of battery at simulation start";
    parameter Real TOutInit( min = 0, unit="K") = 293.15  "Outside temperature at simulation start";

  parameter Modelica.SIunits.HeatCapacity CBatt = 7e6 "C parameter for battery"
annotation (Dialog(group="RC parameters"));

  parameter Real a=8.860644141827217e-06
  annotation (Dialog(group="Battery degradation parameters"));
  parameter Real b=-0.005297550909189135
  annotation (Dialog(group="Battery degradation parameters"));
  parameter Real c=0.7922675255918518
  annotation (Dialog(group="Battery degradation parameters"));
  parameter Real d=-6.7e-3
  annotation (Dialog(group="Battery degradation parameters"));
  parameter Real e=2.35
  annotation (Dialog(group="Battery degradation parameters"));
  parameter Real f=14876
  annotation (Dialog(group="Battery degradation parameters"));
  parameter Real R=8.314
  annotation (Dialog(group="Battery degradation parameters"));
  parameter Real Ea=24.5e3
  annotation (Dialog(group="Battery degradation parameters"));
  parameter Real V( unit="V") = 380 "Nominal battery Voltage";

  parameter Real TAvgInit( min=0, unit="K") = 293.15 "Average battery temperature before simulation started"
  annotation (Dialog(group="Battery initialization parameters"));
  parameter Real batAgeInit( min=0) = 0 "Initial age of battery [s]"
  annotation (Dialog(group="Battery initialization parameters"));
  parameter Real IRateAvgInit = 0 "Average IRate of battery before simulation started"
  annotation (Dialog(group="Battery initialization parameters"));
  parameter Real AhStart = 0 "Ah throughput of battery before simulation started"
 annotation (Dialog(group="Battery initialization parameters"));

  parameter Modelica.SIunits.Time startTime(fixed=false) "Start time of simulation";

  Submodels.BatterySOH batterySOH(
    EMaxNom=CapNom,
    Pmax=PMax,
    SOC_start=SOC_start,
    SOC_min=SOC_min,
    SOC_max=SOC_max,
    etaCha=etaCha,
    etaDis=etaDis,
    PInt(start=0))
    annotation (Placement(transformation(extent={{-54,-10},{-34,10}})));
  Submodels.BatteryRCFlex
                      batteryRCFlex(
    C_battery=CBatt,
    TInit=TBattInit,
    TOut(start=TOutInit))
    annotation (Placement(transformation(extent={{20,-22},{40,-2}})));
  Submodels.BatteryDegradation batteryDegradation(
    TAvgInit=TAvgInit,
    TBatt(start=TOutInit),
    a=a,
    b=b,
    c=c,
    d=d,
    e=e,
    f=f,
    R=R,
    Ea=Ea,
    V=V,
    Capacity=CapNom,
    batAgeInit=batAgeInit,
    TAvg(start=TAvgInit))
    annotation (Placement(transformation(extent={{54,-22},{74,-2}})));
  Modelica.Blocks.Interfaces.RealInput PCtrl( start=0, unit="W")
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput TOut( start=293.15, min=0, unit="K")
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealOutput SOC
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Interfaces.RealOutput TBatt
    annotation (Placement(transformation(extent={{100,-30},{120,-10}})));
  Modelica.Blocks.Interfaces.RealOutput SOE
    annotation (Placement(transformation(extent={{100,10},{120,30}})));
  Modelica.Blocks.Interfaces.RealOutput P
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));

  Modelica.Blocks.Interfaces.RealInput RFlex( start=0.004, min = 0)
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
initial equation
  startTime=time;
equation
  connect(batteryRCFlex.TBatt, batteryDegradation.TBatt)
    annotation (Line(points={{41,-12},{52,-12}}, color={0,0,127}));
  connect(batterySOH.PCtrl, PCtrl)
    annotation (Line(points={{-56,0},{-120,0}}, color={0,0,127}));
  connect(TOut, batteryRCFlex.TOut) annotation (Line(points={{-120,40},{-16,40},{-16,
          -12},{18,-12}}, color={0,0,127}));
  connect(batteryDegradation.SOH, batterySOH.SOH) annotation (Line(points={{75,-12},
          {78,-12},{78,-26},{-60,-26},{-60,4},{-56,4}}, color={0,0,127}));
  connect(batteryRCFlex.TBatt, TBatt) annotation (Line(points={{41,-12},{46,-12},{
          46,0},{92,0},{92,-20},{110,-20}}, color={0,0,127}));
  connect(batterySOH.SOE, SOE)
    annotation (Line(points={{-33,5},{92,5},{92,20},{110,20}}, color={0,0,127}));
  connect(batterySOH.SOC, SOC)
    annotation (Line(points={{-33,8},{88,8},{88,60},{110,60}}, color={0,0,127}));
  connect(batterySOH.PExt, P) annotation (Line(points={{-33,-4},{-24,-4},{-24,-60},
          {110,-60}}, color={0,0,127}));
  connect(RFlex, batteryRCFlex.R)
    annotation (Line(points={{-120,80},{8,80},{8,-8},{18,-8}}, color={0,0,127}));
  connect(batterySOH.PInt, batteryRCFlex.PBatt) annotation (Line(points={{-33,0},
          {-20,0},{-20,-16},{18,-16}}, color={0,0,127}));
  connect(batterySOH.PInt, batteryDegradation.P) annotation (Line(points={{-33,
          0},{-20,0},{-20,-24},{46,-24},{46,-16},{52,-16}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BatteryAdv;
