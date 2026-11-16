within SCooDER.Systems.BidirEV;
model singleEV
  Components.Battery.Model.Battery EV(EMax=12000, Pmax=10000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
 Modelica.Blocks.Interfaces.RealInput Pset(unit="W") annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0})));
  Modelica.Blocks.Interfaces.RealOutput SOC "State of Charge [-]"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput Pmea(start=0)
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Math.Gain toPercent(k=100)
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
equation
  connect(EV.PCtrl, Pset)
    annotation (Line(points={{-12,0},{-120,0}}, color={0,0,127}));
  connect(EV.P, Pmea)
    annotation (Line(points={{11,0},{110,0}}, color={0,0,127}));
  connect(toPercent.y, SOC)
    annotation (Line(points={{81,50},{110,50}}, color={0,0,127}));
  connect(EV.SOC, toPercent.u)
    annotation (Line(points={{11,8},{40,8},{40,50},{58,50}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end singleEV;
