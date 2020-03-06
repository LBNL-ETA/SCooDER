within SCooDER.Components.Battery.Model;
model BatteryRC
  parameter Modelica.SIunits.HeatCapacity C_battery=7e6;
  parameter Modelica.SIunits.ThermalResistance R_battery=0.004;
  Modelica.Blocks.Interfaces.RealInput TOutC "Outside temperature [°C]"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput PBatt "Power going into or coming from the battery [W]"
    annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
  Modelica.Blocks.Math.Abs abs1
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Interfaces.RealOutput TBattC "Battery temperature [°C]"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=
        C_battery)
    annotation (Placement(transformation(extent={{6,0},{26,20}})));
  Modelica.Thermal.HeatTransfer.Celsius.PrescribedTemperature
    prescribedTemperature
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Thermal.HeatTransfer.Celsius.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalResistor  thermalResistor(R=
        R_battery)
    annotation (Placement(transformation(extent={{-20,-10},{-40,10}})));
equation
  connect(abs1.u, PBatt) annotation (Line(points={{-82,-40},{-120,-40}},
                            color={0,0,127}));
  connect(prescribedTemperature.T, TOutC)
    annotation (Line(points={{-82,0},{-120,0}}, color={0,0,127}));
  connect(heatCapacitor.port, temperatureSensor.port)
    annotation (Line(points={{16,0},{40,0}}, color={191,0,0}));
  connect(temperatureSensor.T, TBattC)
    annotation (Line(points={{60,0},{110,0}}, color={0,0,127}));
  connect(abs1.y, prescribedHeatFlow.Q_flow)
    annotation (Line(points={{-59,-40},{-40,-40}}, color={0,0,127}));
  connect(prescribedHeatFlow.port, heatCapacitor.port)
    annotation (Line(points={{-20,-40},{16,-40},{16,0}}, color={191,0,0}));
  connect(prescribedTemperature.port, thermalResistor.port_b)
    annotation (Line(points={{-60,0},{-40,0}}, color={191,0,0}));
  connect(thermalResistor.port_a, heatCapacitor.port)
    annotation (Line(points={{-20,0},{16,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html> <p>RC model of a battery. It can be used to simulate the temperature of a battery based on power and R&C parameters.</p> </html>"));
end BatteryRC;
