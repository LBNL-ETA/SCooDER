within SCooDER.Components.ElectricVehicle.Examples;
model Test_EVtransport_extTable
  parameter Integer n_evs=10 "number of evs in system";
  parameter Integer n_cha=24 "number of charging stations in system";
  parameter Integer n_site=13 "number of sites in system";
  parameter String fileName="C:/Users/Christoph/Documents/PrivateRepos/ies/resources/transportation/test_10-24-13-1.txt";

  Modelica.Blocks.Sources.RealExpression charger_Pset[n_cha](y=ChargerSine.y*
        ones(n_cha))
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Sources.Sine ChargerSine(
    amplitude=1000,
    freqHz=1/86400,
    offset=2000)
    annotation (Placement(transformation(extent={{-90,60},{-70,80}})));

  EV_transport_extTable EV_transport(
    n_evs=n_evs,
    n_cha=n_cha,
    n_site=n_site,
    fileName=fileName)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(charger_Pset.y, EV_transport.PPlugCtrl) annotation (Line(points={{-39,
          70},{-26,70},{-26,7},{-12,7}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=86000,
      __Dymola_NumberOfIntervals=24,
      __Dymola_Algorithm="Dassl"));
end Test_EVtransport_extTable;
