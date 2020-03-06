within SCooDER.Components.ElectricVehicle;
model EV
  parameter Real CapNom(min=0) = 24000 "Battery capacity at start of life [Wh]";
  parameter Real PMax(min=0, unit="W") = 60000  "Max battery power [W]";
  parameter Real SOC_start(min=0, max=1, unit="1") = 0.1
    "Initial SOC value";
  parameter Real SOC_min(min=0, max=1, unit="1") = 0.1
    "Minimum SOC value";
  parameter Real SOC_max(min=0, max=1, unit="1") = 1
    "Maximum SOC value";
  parameter Real etaCha(min=0, max=1, unit="1") = 0.96
    "Charging efficiency";
  parameter Real etaDis(min=0, max=1, unit="1") = 0.96
    "Discharging efficiency";

  parameter Modelica.SIunits.HeatCapacity CBatt = 7e6 "C parameter for battery [J/K]"
annotation (Dialog(group="RC parameters"));
  parameter Modelica.SIunits.ThermalResistance RPlug=0.004 "R parameter for battery while stationary [K/W]"
annotation (Dialog(group="RC parameters"));

  parameter Modelica.SIunits.ThermalResistance RDrive=0.004 "R parameter for battery while driving [K/W]"
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
  parameter Real V( unit="V") = 380;
  parameter Real Pmax( unit="W") = 3300;
  parameter Real Capacity = 6400 "Battery capacity at start of life [Wh]";

  parameter Real startTime = 0;
  parameter Real TAvgInit = 20 "Average battery temperature before simulation started [C]"
  annotation (Dialog(group="Battery initialization parameters"));
  parameter Real batAgeInit = 0 "Initial age of battery [s]"
  annotation (Dialog(group="Battery initialization parameters"));
  parameter Real IRateAvgInit = 0 "Average IRate of battery before simulation started"
  annotation (Dialog(group="Battery initialization parameters"));
  parameter Real AhStart = 0 "Ah throughput of battery before simulation started"
  annotation (Dialog(group="Battery initialization parameters"));

  SCooDER.Components.Battery.Model.BatterySOH battery(
    PInt(start=0),
    EMaxNom=CapNom,
    Pmax=PMax,
    SOC_start=SOC_start,
    SOC_min=SOC_min,
    SOC_max=SOC_max,
    etaCha=etaCha,
    etaDis=etaDis)
    annotation (Placement(transformation(extent={{-46,30},{-26,50}})));
  Modelica.Blocks.Interfaces.RealInput T_C "Outside temperature [°C]"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Interfaces.RealInput PPlugCtrl
    "Battery control signal [W]"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealOutput TBatt "Battery temperature [°C]"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput SOE "Energy stored in battery [Wh]"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput SOC "SOC of battery [-]"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Battery.Model.BatteryDegradation battery_degradation(
    a=a,
    b=b,
    c=c,
    d=d,
    e=e,
    f=f,
    R=R,
    Ea=Ea,
    Pmax=PMax,
    Capacity=CapNom,
    TAvgInit=TAvgInit,
    batAgeInit=batAgeInit,
    IRateAvgInit=IRateAvgInit,
    AhStart=AhStart)
    annotation (Placement(transformation(extent={{58,-22},{78,-2}})));
  Modelica.Blocks.Interfaces.BooleanInput PluggedIn "Boolean parameter for connection of EV to grid"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Modelica.Blocks.Interfaces.RealInput PDriveCtrl "Control signal of EV for driving [W]"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Modelica.Blocks.Interfaces.RealOutput PPlug "Actual power through EV plug [W]"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput PDrive "Actual power of EV while driving [W]"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));

  BatteryRCFlex batteryRCFlex(C_battery=CBatt)
    annotation (Placement(transformation(extent={{14,-14},{34,6}})));
  Modelica.Blocks.Sources.RealExpression RValue(y=if PluggedIn then RPlug else
        RDrive) annotation (Placement(transformation(extent={{-18,-4},{2,16}})));
  Modelica.Blocks.Sources.RealExpression PPlug_value(y=if PluggedIn then
        battery.PExt else 0)
    annotation (Placement(transformation(extent={{68,-50},{88,-30}})));
  Modelica.Blocks.Sources.RealExpression PDrive_value(y=if PluggedIn then 0
         else battery.PExt)
    annotation (Placement(transformation(extent={{68,-90},{88,-70}})));
equation
  connect(battery.SOE, SOE)
    annotation (Line(points={{-25,45},{94,45},{94,40},{110,40}},
                                                             color={0,0,127}));
  connect(battery.SOC, SOC)
    annotation (Line(points={{-25,48},{94,48},{94,80},{110,80}},
                                                           color={0,0,127}));
  connect(switch1.u1, PPlugCtrl) annotation (Line(points={{-82,48},{-92,
          48},{-92,80},{-120,80}}, color={0,0,127}));
  connect(PDriveCtrl, switch1.u3) annotation (Line(points={{-120,0},{-94,0},{-94,
          32},{-82,32}},     color={0,0,127}));
  connect(switch1.y, battery.PCtrl)
    annotation (Line(points={{-59,40},{-48,40}}, color={0,0,127}));
  connect(battery_degradation.SOH, battery.SOH) annotation (Line(points={{79,-12},
          {84,-12},{84,54},{-56,54},{-56,44},{-48,44}}, color={0,0,127}));
  connect(PluggedIn, switch1.u2)
    annotation (Line(points={{-120,40},{-82,40}}, color={255,0,255}));
  connect(batteryRCFlex.TBattC, battery_degradation.T_C) annotation (Line(
        points={{35,-4},{50,-4},{50,-12},{56,-12}},   color={0,0,127}));
  connect(T_C, batteryRCFlex.TOutC) annotation (Line(points={{-120,-40},{-86,-40},
          {-86,-4},{12,-4}},  color={0,0,127}));
  connect(batteryRCFlex.TBattC, TBatt) annotation (Line(points={{35,-4},{
          50,-4},{50,0},{110,0}}, color={0,0,127}));
  connect(PPlug_value.y, PPlug)
    annotation (Line(points={{89,-40},{110,-40}}, color={0,0,127}));
  connect(PDrive_value.y, PDrive)
    annotation (Line(points={{89,-80},{110,-80}}, color={0,0,127}));
  connect(batteryRCFlex.R, RValue.y)
    annotation (Line(points={{12,0},{8,0},{8,6},{3,6}}, color={0,0,127}));
  connect(battery.P, batteryRCFlex.PBatt) annotation (Line(points={{-25,32},{-20,
          32},{-20,-8},{12,-8}}, color={0,0,127}));
  connect(battery_degradation.P, battery.P) annotation (Line(points={{56,-16},{-20,
          -16},{-20,32},{-25,32}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400), Documentation(info="<html>
    <p>Simplified EV model. This model simulated the battery behavior of an EV based on control signals while driving or charging/discharging when connected to the grid. It considers temperature and utilization of the battery to calculate battery degradation. The state of health of the battery is then again used to update the capacity of the EV's battery during the simulation.
    
    </p> </html>"));
end EV;
