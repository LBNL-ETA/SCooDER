within SCooDER.Systems.ElectricVehicle;
model FleetEVs
  parameter Integer nin = 1 "Amount of EVs on site";

  Modelica.Blocks.Interfaces.RealInput PPlugCtrl[nin] "Control of individual EVs when plugged in [W]"
    annotation (Placement(transformation(extent={{-140,34},{-100,74}})));
  Modelica.Blocks.Interfaces.RealInput PluggedIn[nin] "This input sets an individual EV as plugged in, when >= 1"
    annotation (Placement(transformation(extent={{-140,-2},{-100,38}})));
  Modelica.Blocks.Interfaces.RealInput PDriveCtrl[nin] "Control of individual EVs when driving [W]"
    annotation (Placement(transformation(extent={{-140,-38},{-100,2}})));
  Modelica.Blocks.Interfaces.RealInput T_C "Outside Temperature [C]"
    annotation (Placement(transformation(extent={{-140,70},{-100,110}})));
  Components.ElectricVehicle.EV eV[nin]
    annotation (Placement(transformation(extent={{-24,6},{-4,26}})));
  Modelica.Blocks.Interfaces.RealOutput PSite "Load of site without EVs and PV [W]"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput PPv "PV generation on site [W]"
    annotation (Placement(transformation(extent={{-140,-74},{-100,-34}})));
  Modelica.Blocks.Interfaces.RealInput PBase "Load of whole site at point of connection [W]"
    annotation (Placement(transformation(extent={{-140,-110},{-100,-70}})));

equation
  for i in 1:nin loop
    PPlugCtrl[i] = eV[i].PPlugCtrl;
    PDriveCtrl[i] = eV[i].PDriveCtrl;
    PluggedIn[i] = eV[i].PluggedIn;
    T_C = eV[i].T_C;
  end for;

  PSite = sum(PPlugCtrl)-PPv+PBase;

 annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html>
        <p>Fleet of EVs on one site. The parameter sets the amount of EVs on site. The inputs are the individual EV controls, a PV generation on site, the general load of the site, and the outside Temperature. The output is the load of the whole site. 
    
    </p> </html>"));
end FleetEVs;
