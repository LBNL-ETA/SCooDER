within SCooDER.Components.ElectricVehicle.Examples;
model Test_EV_10_years
  extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Sine TemperatureSine(
    amplitude=20,
    f=1/86400,
    offset=293.15)
    annotation (Placement(transformation(extent={{-40,-58},{-20,-38}})));
  SCooDER.Components.ElectricVehicle.EV eV(
    SOC_start=0,
    SOC_min=0,                             RDrive=0.008)
    annotation (Placement(transformation(extent={{32,8},{52,28}})));
  Modelica.Blocks.Sources.Constant ChargingPowerCtrl(k=5000)
    annotation (Placement(transformation(extent={{-40,46},{-20,66}})));
  Modelica.Blocks.Sources.Constant DrivingPowerCtrl(k=-10000)
    annotation (Placement(transformation(extent={{-40,-22},{-20,-2}})));
  Modelica.Blocks.Sources.Pulse        PluggedInPulse(
    amplitude=1,
    width=90,
    period=43200,
    startTime=0)
    annotation (Placement(transformation(extent={{-40,12},{-20,32}})));
  Modelica.Blocks.Sources.Constant RegulationCtrl(k=0)
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
equation
  connect(TemperatureSine.y, eV.TOut) annotation (Line(points={{-19,-48},{20,-48},
          {20,14},{30,14}}, color={0,0,127}));
  connect(ChargingPowerCtrl.y, eV.PPlugCtrl) annotation (Line(points={{-19,56},{
          14,56},{14,26},{30,26}},   color={0,0,127}));
  connect(DrivingPowerCtrl.y, eV.PDriveCtrl) annotation (Line(points={{-19,-12},
          {0,-12},{0,18},{30,18}}, color={0,0,127}));
  connect(PluggedInPulse.y, eV.PluggedIn)
    annotation (Line(points={{-19,22},{30,22}}, color={0,0,127}));
  connect(RegulationCtrl.y, eV.PRegCtrl) annotation (Line(points={{-19,-80},{26,
          -80},{26,10},{30,10}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=315360000),
                                Documentation(info="<html> <p> This package contains examples of EV model applications </p> </html>"));
end Test_EV_10_years;
