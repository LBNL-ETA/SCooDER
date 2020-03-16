within SCooDER.Components.ElectricVehicle.Examples;
model Test_EV_1_week
  Modelica.Blocks.Sources.Sine TemperatureSine(
    amplitude=20,
    freqHz=1/86400,
    offset=20)
    annotation (Placement(transformation(extent={{-74,-56},{-54,-36}})));
  SCooDER.Components.ElectricVehicle.EV eV(
    SOC_start=0,
    SOC_min=0,                             RDrive=0.008,
    Pmax=60000,
    Capacity=24000)
    annotation (Placement(transformation(extent={{32,8},{52,28}})));
  Modelica.Blocks.Sources.Pulse        PluggedInPulse(
    amplitude=1,
    width=90,
    period=43200,
    startTime=0)
    annotation (Placement(transformation(extent={{-74,12},{-54,32}})));
  Modelica.Blocks.Noise.NormalNoise DrivingPowerCtrl(
    samplePeriod=60,
    mu=-10000,
    sigma=7500)
    annotation (Placement(transformation(extent={{-74,-22},{-54,-2}})));
  inner Modelica.Blocks.Noise.GlobalSeed globalSeed
    annotation (Placement(transformation(extent={{38,62},{58,82}})));
  Modelica.Blocks.Sources.Constant ChargingPowerCtrl(k=5000)
    annotation (Placement(transformation(extent={{-74,46},{-54,66}})));
equation
  connect(TemperatureSine.y, eV.T_C) annotation (Line(points={{-53,-46},{-14,-46},
          {-14,14},{30,14}}, color={0,0,127}));
  connect(DrivingPowerCtrl.y, eV.PDriveCtrl) annotation (Line(points={{-53,-12},
          {-20,-12},{-20,18},{30,18}}, color={0,0,127}));
  connect(ChargingPowerCtrl.y, eV.PPlugCtrl) annotation (Line(points={{-53,56},{
          -20,56},{-20,26},{30,26}}, color={0,0,127}));
  connect(PluggedInPulse.y, eV.PluggedIn)
    annotation (Line(points={{-53,22},{30,22}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=604800),Documentation(info="<html><p>This is a model of an EV with degrading battery modeled for the first week of usage. Is is driven twice a day and plugged in for the rest of the time. The driving pattern is represented with random noise with the option of recharging the battery when braking.</p> </html>"));
end Test_EV_1_week;
