within SCooDER.Components.ElectricVehicle.Examples;
model Test_100kEVs
  extends Modelica.Icons.Example;
  parameter Integer n_evs=100;
  Modelica.Blocks.Sources.Sine TemperatureSine(
    amplitude=20,
    f=1/86400,
    offset=293.15)
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  EV_simple EVs[n_evs]
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Modelica.Blocks.Sources.Constant ChargingPowerCtrl(k=5000)
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));
  Modelica.Blocks.Sources.Constant DrivingPowerCtr(k=-10000)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Modelica.Blocks.Sources.Pulse PluggedInPulse(
    amplitude=1,
    width=90,
    period=43200,
    startTime=0)
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Sources.RealExpression sumSOC(y=sum(EVs.SOC))
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Routing.Replicator replicator(nout=n_evs)
    annotation (Placement(transformation(extent={{-50,40},{-30,60}})));
  Modelica.Blocks.Routing.Replicator replicator1(nout=n_evs)
    annotation (Placement(transformation(extent={{-50,0},{-30,20}})));
  Modelica.Blocks.Routing.Replicator replicator2(nout=n_evs)
    annotation (Placement(transformation(extent={{-50,-40},{-30,-20}})));
equation
  connect(ChargingPowerCtrl.y, replicator.u)
    annotation (Line(points={{-59,50},{-52,50}}, color={0,0,127}));
  connect(replicator.y, EVs.PPlugCtrl) annotation (Line(points={{-29,50},{-20,50},
          {-20,8},{-2,8}}, color={0,0,127}));
  connect(PluggedInPulse.y, replicator1.u)
    annotation (Line(points={{-59,10},{-52,10}}, color={0,0,127}));
  connect(DrivingPowerCtr.y, replicator2.u)
    annotation (Line(points={{-59,-30},{-52,-30}}, color={0,0,127}));
  connect(replicator2.y, EVs.PDriveCtrl) annotation (Line(points={{-29,-30},{
          -16,-30},{-16,0},{-2,0}}, color={0,0,127}));
  connect(replicator1.y, EVs.PluggedIn) annotation (Line(points={{-29,10},{-24,
          10},{-24,4},{-2,4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=86400, __Dymola_Algorithm="Dassl"),
                                    Documentation(info="<html><p>This Example tests the scaleup of EVs.</p> </html>"));
end Test_100kEVs;
