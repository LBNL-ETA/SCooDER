within SCooDER.Systems.ElectricVehicle;
model FleetEVs
  parameter Real NumberEVs = 14;
  parameter Integer NumberEVsInt = integer(floor(NumberEVs)) "Amount of EVs on site";
  parameter Modelica.SIunits.Time startTime(fixed=false) "Start time of simulation";

  Modelica.Blocks.Interfaces.RealInput PPlugCtrl[NumberEVsInt](each start= 0, unit="W") "Control of individual EVs when plugged in "
    annotation (Placement(transformation(extent={{-140,34},{-100,74}})));
  Modelica.Blocks.Interfaces.RealInput PluggedIn[NumberEVsInt](  each start= 1)        "This input sets an individual EV as plugged in, when >= 1"
    annotation (Placement(transformation(extent={{-140,-2},{-100,38}})));
  Modelica.Blocks.Interfaces.RealInput PDriveCtrl[NumberEVsInt](each start= 0,unit="W")          "Control of individual EVs when driving"
    annotation (Placement(transformation(extent={{-140,-38},{-100,2}})));
  Modelica.Blocks.Interfaces.RealInput T(start=293.15, min=0, unit="K")
    "Outside Temperature [K]"
    annotation (Placement(transformation(extent={{-140,70},{-100,110}})));
  Components.ElectricVehicle.EV eV[NumberEVsInt]
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput PSite(unit="W") "Load of site without EVs and PV "
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput PPv( start=0, unit="W") "PV generation on site "
    annotation (Placement(transformation(extent={{-140,-74},{-100,-34}})));
  Modelica.Blocks.Interfaces.RealInput PBase( start=0, unit="W") "Load of whole site at point of connection"
    annotation (Placement(transformation(extent={{-140,-110},{-100,-70}})));

initial equation
  startTime = time;
equation
  for i in 1:NumberEVsInt loop
    PPlugCtrl[i] = eV[i].PPlugCtrl;
    PDriveCtrl[i] = eV[i].PDriveCtrl;
    PluggedIn[i] = eV[i].PluggedIn;
    T = eV[i].TOut;
  end for;

  PSite = sum(eV.PPlug)-PPv+PBase;

annotation(dialog(enable=false),
             Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html>
        <p>Fleet of EVs on one site. The parameter sets the amount of EVs on site. The inputs are the individual EV controls, a PV generation on site, the general load of the site, and the outside Temperature. The output is the load of the whole site. 
    
    </p> </html>"));
end FleetEVs;
