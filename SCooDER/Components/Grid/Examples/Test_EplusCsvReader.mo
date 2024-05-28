within SCooDER.Components.Grid.Examples;
model Test_EplusCsvReader
  extends Modelica.Icons.Example;
  Model.EplusCsvReader eplusCsvReader(fileName=
        "C:/Users/Christoph/Documents/PrivateRepos/ies/development/refbldg_mediumoffice_new2004_v1-4_7-2-USA_CA_Los.Angeles.Intl.AP.722950_TMY3_0.csv")
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
end Test_EplusCsvReader;
