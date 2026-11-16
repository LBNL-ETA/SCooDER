within SCooDER.Systems.BidirEV.Examples;
model Test_singleEV_drive
  extends Modelica.Icons.Example;
  singleEV_drive EV(shift_time_s=39600, fileName=
        Modelica.Utilities.Files.loadResource("modelica://SCooDER/Systems/BidirEV/Examples/epdt_ev-data_20250701T2320.txt"))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant const(k=1000)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(const.y, EV.Pset)
    annotation (Line(points={{-39,0},{-12,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400, __Dymola_Algorithm="Dassl"));
end Test_singleEV_drive;
