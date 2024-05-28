within SCooDER.Components.ElectricVehicle;
model EV_simple
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

  parameter Modelica.Units.SI.HeatCapacity CBatt=7e6 "C parameter for battery"
    annotation (Dialog(group="RC parameters"));
  parameter Modelica.Units.SI.ThermalResistance RPlug=0.004
    "R parameter for battery while stationary"
    annotation (Dialog(group="RC parameters"));

  parameter Modelica.Units.SI.ThermalResistance RDrive=0.004
    "R parameter for battery while driving"
    annotation (Dialog(group="RC parameters"));

  parameter Real V(unit="V") = 345 "Nominal battery Voltage";
  parameter Real TAvgInit(min=0, unit="K") = 293.15 "Average battery temperature before simulation started"
  annotation (Dialog(group="Battery initialization parameters"));
  parameter Real batAgeInit(min=0, unit="s") = 60 "Initial age of battery"
  annotation (Dialog(group="Battery initialization parameters"));
  parameter Real CRateAvgInit(min=0) = 0.1 "Average IRate of battery before simulation started"
  annotation (Dialog(group="Battery initialization parameters"));
  parameter Real AhInit(min=0) = 1 "Ah throughput of battery before simulation started"
   annotation (Dialog(group="Battery initialization parameters"));

  parameter Real FlagLowCycle(min=0, max=1) = 0 "Consider low cycling of calendar aging (0.5 C constantly) [1=true; 0=false]"
  annotation (Dialog(group="Battery initialization parameters"));
  parameter Modelica.Units.SI.Time startTime(fixed=false)
    "Start time of simulation";

  SCooDER.Components.Battery.Model.Submodels.BatterySOH battery(
    PInt(start=0),
    EMaxNom=CapNom,
    Pmax=PMax,
    SOC_start=SOC_start,
    SOC_min=SOC_min,
    SOC_max=SOC_max,
    etaCha=etaCha,
    etaDis=etaDis)
    annotation (Placement(transformation(extent={{-28,32},{-8,52}})));
  Modelica.Blocks.Interfaces.RealInput PPlugCtrl(start=0, unit="W")
    "Battery control signal "
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Modelica.Blocks.Interfaces.RealOutput SOE "Energy stored in battery [Wh]"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Modelica.Blocks.Interfaces.RealOutput SOC "SOC of battery [-]"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealInput PDriveCtrl(start=0,unit="W")
    "Control signal of EV for driving"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

  Modelica.Blocks.Interfaces.RealInput PluggedIn( start=1)
                                                          "The car is plugged in if this value is >=1, otherwise it is driving"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));

  Modelica.Blocks.Sources.RealExpression PCtrl_value(y=if PluggedIn >= 1 then
        PPlugCtrl else PDriveCtrl)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Modelica.Blocks.Sources.RealExpression fixedSOH(y=1)
    annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
initial equation
  startTime=time;
equation
  connect(battery.SOE, SOE)
    annotation (Line(points={{-7,47},{94,47},{94,40},{110,40}},
                                                             color={0,0,127}));
  connect(battery.SOC, SOC)
    annotation (Line(points={{-7,50},{94,50},{94,80},{110,80}},
                                                           color={0,0,127}));
  connect(PCtrl_value.y, battery.PCtrl) annotation (Line(points={{-39,40},{-34,40},
          {-34,42},{-30,42}}, color={0,0,127}));
  connect(fixedSOH.y, battery.SOH) annotation (Line(points={{-39,60},{-34,60},{
          -34,46},{-30,46}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400), Documentation(info="<html>
    <p>Simplified EV model. This model simulated the battery behavior of an EV based on control signals while driving or charging/discharging when connected to the grid. It considers temperature and utilization of the battery to calculate battery degradation. The state of health of the battery is then again used to update the capacity of the EV's battery during the simulation.
    
    </p> </html>"));
end EV_simple;
