within SCooDER.Components.Battery.Model;
model BatteryRC
  parameter Modelica.SIunits.HeatCapacity C_battery=7e6;
  parameter Modelica.SIunits.ThermalResistance R_battery=0.004;
  parameter Real TInit = 293.15 "Initial battery temperature [K]";
  Modelica.Blocks.Interfaces.RealInput TOut "Outside temperature [K]"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput PBatt "Power going into or coming from the battery [W]"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Interfaces.RealOutput TBatt "Battery temperature [K]"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=
        C_battery, T(fixed=true, start=TInit))
    annotation (Placement(transformation(extent={{6,0},{26,20}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor  thermalResistor(R=
        R_battery)
    annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature prescribedTemperature
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow(T_ref(
        displayUnit="K"))
    annotation (Placement(transformation(extent={{-38,-50},{-18,-30}})));
equation
  connect(abs1.u, PBatt) annotation (Line(points={{-82,-40},{-120,-40}},
                            color={0,0,127}));
  connect(thermalResistor.port_a, heatCapacitor.port)
    annotation (Line(points={{-20,0},{16,0}}, color={191,0,0}));
  connect(heatCapacitor.port, temperatureSensor.port)
    annotation (Line(points={{16,0},{40,0}}, color={191,0,0}));
  connect(temperatureSensor.T, TBatt)
    annotation (Line(points={{60,0},{84,0},{84,0},{110,0}}, color={0,0,127}));
  connect(prescribedTemperature.port, thermalResistor.port_b)
    annotation (Line(points={{-60,0},{-40,0}}, color={191,0,0}));
  connect(TOut, prescribedTemperature.T)
    annotation (Line(points={{-120,0},{-82,0}}, color={0,0,127}));
  connect(abs1.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-59,-40},{-38,-40}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, heatCapacitor.port)
    annotation (Line(points={{-18,-40},{16,-40},{16,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html> <p>RC model of a battery. It can be used to simulate the temperature of a battery based on power and R&C parameters.</p> </html>"));
end BatteryRC;
