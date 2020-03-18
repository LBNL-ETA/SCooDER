within SCooDER.Systems.ElectricVehicle.Examples;
model SimpleExample

  SCooDER.Systems.ElectricVehicle.FleetEVs fleetEVs(nin=2)
    annotation (Placement(transformation(extent={{-10,-4},{10,16}})));
  Modelica.Blocks.Sources.Constant TemperatureC(k=20)
    annotation (Placement(transformation(extent={{-60,44},{-40,64}})));
  Modelica.Blocks.Sources.Constant PPlug1(k=10000)
    annotation (Placement(transformation(extent={{-64,10},{-44,30}})));
  Modelica.Blocks.Sources.Constant PPlug2(k=5000)
    annotation (Placement(transformation(extent={{-94,10},{-74,30}})));
  Modelica.Blocks.Sources.Sine PV(
    amplitude=20000,
    freqHz=1/86400,
    offset=20000)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Sources.Sine PBase(
    amplitude=20000,
    freqHz=1/3600/4,
    offset=30000)
    annotation (Placement(transformation(extent={{32,-32},{12,-12}})));
  Modelica.Blocks.Sources.Pulse PluggedInPulse(
    amplitude=2,
    width=90,
    period=86400/2)
    annotation (Placement(transformation(extent={{-92,-20},{-72,0}})));
  Modelica.Blocks.Sources.Sine DrivingCtrl1(
    amplitude=5000,
    freqHz=1/3600,
    offset=-10000)
    annotation (Placement(transformation(extent={{-60,-24},{-50,-14}})));
  Modelica.Blocks.Sources.Sine DrivingCtrl2(
    amplitude=5000,
    freqHz=1/3600,
    offset=-4000)
    annotation (Placement(transformation(extent={{-46,-36},{-36,-26}})));
equation
  connect(TemperatureC.y, fleetEVs.T_C) annotation (Line(points={{-39,54},{-32,
          54},{-32,15},{-12,15}}, color={0,0,127}));
  connect(PV.y, fleetEVs.PPv) annotation (Line(points={{-59,-40},{-22,-40},{-22,
          0},{-18,0},{-18,0.6},{-12,0.6}}, color={0,0,127}));
  connect(PBase.y, fleetEVs.PBase) annotation (Line(points={{11,-22},{-18,-22},
          {-18,-3},{-12,-3}}, color={0,0,127}));
  connect(PPlug2.y, fleetEVs.PPlugCtrl[1]) annotation (Line(points={{-73,20},{
          -68,20},{-68,4},{-30,4},{-30,10.4},{-12,10.4}}, color={0,0,127}));
  connect(PPlug1.y, fleetEVs.PPlugCtrl[2]) annotation (Line(points={{-43,20},{
          -42,20},{-42,12},{-40,12},{-40,12.4},{-12,12.4}}, color={0,0,127}));
  connect(PluggedInPulse.y, fleetEVs.PluggedIn[1]) annotation (Line(points={{
          -71,-10},{-26,-10},{-26,6.8},{-12,6.8}}, color={0,0,127}));
  connect(PluggedInPulse.y, fleetEVs.PluggedIn[2]) annotation (Line(points={{
          -71,-10},{-26,-10},{-26,8},{-14,8},{-14,8.8},{-12,8.8}}, color={0,0,
          127}));
  connect(DrivingCtrl1.y, fleetEVs.PDriveCtrl[1]) annotation (Line(points={{
          -49.5,-19},{-28,-19},{-28,4},{-20,4},{-20,3.2},{-12,3.2}}, color={0,0,
          127}));
  connect(DrivingCtrl2.y, fleetEVs.PDriveCtrl[2]) annotation (Line(points={{
          -35.5,-31},{-35.5,-32},{-28,-32},{-28,4},{-12,4},{-12,5.2}}, color={0,
          0,127}));
  annotation (experiment(StopTime=86400));
end SimpleExample;
