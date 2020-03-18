within SCooDER.Systems.ElectricVehicle;
model FleetEVs
  parameter Integer nin = 1;

  Modelica.Blocks.Interfaces.RealInput PPlugCtrl[nin]
    annotation (Placement(transformation(extent={{-140,34},{-100,74}})));
  Modelica.Blocks.Interfaces.RealInput PluggedIn[nin]
    annotation (Placement(transformation(extent={{-140,-2},{-100,38}})));
  Modelica.Blocks.Interfaces.RealInput PDriveCtrl[nin]
    annotation (Placement(transformation(extent={{-140,-38},{-100,2}})));
  Modelica.Blocks.Interfaces.RealInput T_C
    annotation (Placement(transformation(extent={{-140,70},{-100,110}})));
  Components.ElectricVehicle.EV eV[nin]
    annotation (Placement(transformation(extent={{-24,6},{-4,26}})));
  Modelica.Blocks.Interfaces.RealOutput PSite
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput PPv
    annotation (Placement(transformation(extent={{-140,-74},{-100,-34}})));
  Modelica.Blocks.Interfaces.RealInput PBase
    annotation (Placement(transformation(extent={{-140,-110},{-100,-70}})));

equation
  for i in 1:nin loop
    PPlugCtrl[i] = eV[i].PPlugCtrl;
    PDriveCtrl[i] = eV[i].PDriveCtrl;
    PluggedIn[i] = eV[i].PluggedIn;
    T_C = eV[i].T_C;
  end for;

  PSite = sum(PPlugCtrl)-PPv+PBase;

  //Components.ElectricVehicle.EV eV_[nin]
  //  annotation (Placement(transformation(extent={{-40,56},{-20,76}})));
 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FleetEVs;
