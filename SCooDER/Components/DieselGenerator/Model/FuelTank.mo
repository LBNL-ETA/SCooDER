within SCooDER.Components.DieselGenerator.Model;
model FuelTank
  import Modelica.Constants.eps;
  parameter Real Capacity(min=0) = 300
    "Tank Capacity [l]";
  parameter Real SOC_start(min=0, max=1, unit="1") = 0
    "Initial SOC value";
  parameter Real SOC_min(min=0, max=1, unit="1") = 0
    "Minimum SOC value";
  parameter Real SOC_max(min=0, max=1, unit="1") = 1
    "Maximum SOC value";
  parameter Real Conso(min=0) = 0.2
    "Fuel Consumption [l/kWh]";
 Modelica.Blocks.Interfaces.RealInput PCtrl(start=0, unit="W")
    "Power control Command"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0})));
  Modelica.Blocks.Interfaces.RealOutput FuelLevel
                                                 "State of Charge [-]"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput PExt(start=0, unit="W") "Generator Power"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));

initial equation
  FuelLevel = SOC_start;
equation
  if (FuelLevel >= SOC_min) and (FuelLevel <= SOC_max) then
    PExt = PCtrl;
  else
    PExt = 0;
  end if;
  der(FuelLevel) = - Conso / 1000 / 3600 / Capacity * PExt;
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),Documentation(
        info="<html> <p>Battery model with SOH input to simulate batteries with changing battery capacities. The control signal goes into the battery and depending on SOC and maximum charging capability, the battery gets charged or discharged and outputs the updated SOC and the actual power of the battery.</p> </html>"));
end FuelTank;
