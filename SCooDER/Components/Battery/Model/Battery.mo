within SCooDER.Components.Battery.Model;
model Battery
  parameter Real EMax(min=0) = 6400
    "Battery Capacity [Wh]";
  parameter Real Pmax(min=0) = 3300
    "Battery Power [W]";
  parameter Real SOC_start(min=0, max=1, unit="1") = 0.1
    "Initial SOC value";
  parameter Real SOC_min(min=0, max=1, unit="1") = 0.1
    "Minimum SOC value";
  parameter Real SOC_max(min=0, max=1, unit="1") = 1
    "Maximum SOC value";
  parameter Real etaCha(min=0, max=1, unit="1") = 0.96
    "Charging efficiency";
  parameter Real etaDis(min=0, max=1, unit="1") = 0.96
    "Discharging efficiency";
  Real PEff;
 Modelica.Blocks.Interfaces.RealInput PCtrl(unit="W")
    "Power control to charge (positive) discharge (negativ) the battery"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0})));
  Modelica.Blocks.Interfaces.RealOutput SOC "State of Charge [-]"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Modelica.Blocks.Interfaces.RealOutput P "Power demand Battery"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Buildings.Electrical.DC.Storage.BaseClasses.Charge soc_model(
    etaCha=etaCha,
    etaDis=etaDis,
    SOC_start=SOC_start,
    EMax=EMax*3600) "Charge model"
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Modelica.Blocks.Interfaces.RealOutput SOE "State of Energy [Wh]"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Sources.RealExpression soe_calc(y=soc_model.SOC*EMax)
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Sources.RealExpression power_calc(y=PEff)
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
equation
  if (soc_model.SOC>=SOC_min) and (soc_model.SOC<=SOC_max) then
    if (P < 0) then
      P = max(Pmax*(-1), PCtrl);
    else
      P = min(Pmax, PCtrl);
    end if;
  else
    if (PCtrl < 0) and (soc_model.SOC > SOC_min) then
      P = max(Pmax*(-1), PCtrl);
    elseif (PCtrl > 0) and (soc_model.SOC < SOC_max) then
      P = min(Pmax, PCtrl);
    else
      P = 0;
    end if;
  end if;
  PEff =if (P > 0) then P*etaCha else P*(1/etaDis);

  connect(soc_model.SOC, SOC) annotation (Line(
      points={{41,80},{110,80}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(soe_calc.y, SOE)
    annotation (Line(points={{41,50},{110,50}}, color={0,0,127}));
  connect(power_calc.y, soc_model.P)
    annotation (Line(points={{1,80},{18,80}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=86400));
end Battery;
