within SCooDER.Systems.FleetEVs;
model FleetEVs "Fleet of multiple EVs on one site"
  parameter Real NumberEVs = 17;
  parameter Integer NumberEVsInt = integer(floor(NumberEVs)) "Amount of EVs on site";
  parameter Real startTime(fixed=false) "Start time of simulation";

  Modelica.Blocks.Interfaces.RealInput PPlugCtrl[NumberEVsInt](each start=0, unit="W") "Control of individual EVs when plugged in "
    annotation (Placement(transformation(extent={{-140,70},{-100,110}})));
  Modelica.Blocks.Interfaces.RealInput PRegCtrl[NumberEVsInt](each start=0, unit="W")
    "Control of individual EVs frequency regulation when plugged in "
    annotation (Placement(transformation(extent={{-140,-50},{-100,-10}})));
  Modelica.Blocks.Interfaces.RealInput PluggedIn[NumberEVsInt](each start=1)        "This input sets an individual EV as plugged in, when >= 1"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput PDriveCtrl[NumberEVsInt](each start=0,unit="W")          "Control of individual EVs when driving"
    annotation (Placement(transformation(extent={{-140,10},{-100,50}})));
  Modelica.Blocks.Interfaces.RealInput T(start=293.15, min=0, unit="K")
    "Outside Temperature [K]"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Components.ElectricVehicle.EV
     eV[NumberEVsInt](each FlagLowCycle=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput PSite(unit="W")
  "Load of site without EVs and PV "
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealInput PPv( start=0, unit="W") "PV generation on site "
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealInput PBase( start=0, unit="W") "Load of whole site at point of connection"
    annotation (Placement(transformation(extent={{-140,-110},{-100,-70}})));

  Modelica.Blocks.Interfaces.RealOutput Time
  annotation (Placement(transformation(extent={{100,60},{120,80}})));
Modelica.Blocks.Sources.RealExpression realExpression(y=time)
  annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Modelica.Blocks.Interfaces.RealInput PRegCtrl_hidden[NumberEVsInt](each start=
       0, unit="W")
    "Hidden control of individual EVs frequency regulation when plugged in "
    annotation (Placement(transformation(extent={{-180,-50},{-140,-10}})));
initial equation
  startTime = time;
equation
  for i in 1:NumberEVsInt loop
    eV[i].PPlugCtrl = PPlugCtrl[i];
    eV[i].PDriveCtrl = PDriveCtrl[i];
    eV[i].PluggedIn = PluggedIn[i];
    eV[i].TOut = T;
    eV[i].PRegCtrl = PRegCtrl_hidden[i];
  end for;

  PSite = sum(eV.PPlug)-PPv+PBase-sum(PRegCtrl);

connect(realExpression.y, Time)
  annotation (Line(points={{81,70},{110,70}}, color={0,0,127}));
annotation(dialog(enable=false),
             Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)), Documentation(info="<html>
        <p>Fleet of EVs on one site. The parameter sets the amount of EVs on site. The inputs are the individual EV controls, a PV generation on site, the general load of the site, and the outside Temperature. The output is the load of the whole site. 
    
    </p> </html>"));
end FleetEVs;
