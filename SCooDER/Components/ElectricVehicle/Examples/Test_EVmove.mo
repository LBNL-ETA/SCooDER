within SCooDER.Components.ElectricVehicle.Examples;
model Test_EVmove
  extends Modelica.Icons.Example;

  parameter Integer n_evs=4;

  Battery.Model.Battery EVs[n_evs](
    EMax={60000, 60000, 1e-3, 1e-3},
    Pmax={15000, 15000, 0, 0},
    SOC_start={0.5,0.5,0.1,0.1})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Real evPset[n_evs];
  Real chSoc[n_evs];
  Real chP[n_evs];
  Real evLoc[n_evs];

  Modelica.Blocks.Sources.RealExpression connections[n_evs](y=evPset)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

  Modelica.Blocks.Sources.CombiTimeTable locations(table=[0,3,2,1,4; 4000,3,2,1,
        4; 4000,1,2,3,4; 6000,1,2,3,4; 6000,1,4,3,2; 8000,1,4,3,2; 8000,3,4,1,2;
        9000,3,4,1,2; 9000,3,1,2,4; 11000,3,1,2,4; 11000,2,1,3,4; 11000,2,1,3,4])
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Sources.RealExpression charger_Pset[n_evs](y={20000,20000,0,0})
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Sources.RealExpression charger_soc[n_evs](y=chSoc)
    annotation (Placement(transformation(extent={{40,0},{60,20}})));
  Modelica.Blocks.Sources.RealExpression charger_P[n_evs](y=chP)
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Modelica.Blocks.Sources.RealExpression ev_loc[n_evs](y=evLoc)
    annotation (Placement(transformation(extent={{40,40},{60,60}})));

equation
  for i in 1:n_evs loop
    evLoc[i] = locations.y[i];
    evPset[i] = charger_Pset[integer(locations.y[i])].y;
    chSoc[integer(locations.y[i])] = EVs[i].SOC;
    chP[integer(locations.y[i])] = EVs[i].P;
  end for;

  connect(connections.y, EVs.PCtrl)
    annotation (Line(points={{-39,0},{-12,0}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=18000, __Dymola_Algorithm="Dassl"));
end Test_EVmove;
