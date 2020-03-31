within SCooDER.Components.Battery.Model;
model BatterySOH

  parameter Real EMaxNom(min=0) = 6400
    "Battery Capacity [Wh]";
  parameter Real Pmax(min=0) = 3300
    "Battery Power [W]";
  parameter Real SOC_start(min=0, max=1, unit="1") = 0
    "Initial SOC value";
  parameter Real SOC_min(min=0, max=1, unit="1") = 0
    "Minimum SOC value";
  parameter Real SOC_max(min=0, max=1, unit="1") = 1
    "Maximum SOC value";
  parameter Real etaCha(min=0, max=1, unit="1") = 0.96
    "Charging efficiency";
  parameter Real etaDis(min=0, max=1, unit="1") = 0.96
    "Discharging efficiency";

  Modelica.SIunits.Energy EMax "Remaining max battery capacity considering SOH";
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
  Modelica.Blocks.Interfaces.RealOutput PInt
    "Internal battery power getting stored in the battery (after losses) and beeing provided by the battery (before losses) [W]"
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput SOE "State of Energy [Wh]"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Sources.RealExpression soe_calc(y=soc_model.SOC*EMax)
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Sources.RealExpression power_calc(y=PInt)
    annotation (Placement(transformation(extent={{-22,70},{-2,90}})));
  Modelica.Blocks.Interfaces.RealInput SOH "State of Health [-]"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
  Charge soc_model(
    etaCha=etaCha,
    etaDis=etaDis,
    SOC_start=SOC_start)
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
  Modelica.Blocks.Sources.Constant Wh_to_Ws(k=3600*EMaxNom)
    annotation (Placement(transformation(extent={{-100,62},{-80,82}})));
  Modelica.Blocks.Math.Product Product
    annotation (Placement(transformation(extent={{-68,44},{-48,64}})));

  Modelica.Blocks.Interfaces.RealOutput PExt
    "Charging power (before losses) and discharging power (after losses) measured outside (external) of battery [W]"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Interfaces.RealOutput P "Actual power (before losses) [W]"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
equation
  if (soc_model.SOC>=SOC_min) and (soc_model.SOC<=SOC_max) then
    if (PInt < 0) then
      PInt =max(Pmax*(-1), PCtrl);
    else
      PInt =min(Pmax, PCtrl);
    end if;
  else
    if (PCtrl < 0) and (soc_model.SOC > SOC_min) then
      PInt =max(Pmax*(-1), PCtrl);
    elseif (PCtrl > 0) and (soc_model.SOC < SOC_max) then
      PInt =min(Pmax, PCtrl);
    else
      PInt = 0;
    end if;
  end if;
  PExt = if (PInt > 0) then PInt*etaCha else PInt*(1/etaDis);
  EMax = EMaxNom * 3600 * SOH "Adapt EMax by SOH";
  P = max(abs(PExt), abs(PInt)) "Power flow inside the battery (before losses are applied) [W]";

  connect(soe_calc.y, SOE)
    annotation (Line(points={{41,50},{110,50}}, color={0,0,127}));
  connect(power_calc.y, soc_model.P)
    annotation (Line(points={{-1,80},{18,80}},color={0,0,127}));
  connect(soc_model.SOC, SOC) annotation (Line(points={{41,80},{110,80}},
                     color={0,0,127}));
  connect(SOH, Product.u2) annotation (Line(points={{-120,40},{-94,40},{-94,48},
          {-70,48}}, color={0,0,127}));
  connect(Wh_to_Ws.y, Product.u1) annotation (Line(points={{-79,72},{-76,
          72},{-76,60},{-70,60}}, color={0,0,127}));
  connect(Product.y, soc_model.EMax) annotation (Line(points={{-47,54},{-30,54},
          {-30,90},{4,90},{4,84},{18,84}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),Documentation(
        info="<html> <p>Battery model with SOH input to simulate batteries with changing battery capacities. The control signal goes into the battery and depending on SOC and maximum charging capability, the battery gets charged or discharged and outputs the updated SOC and the actual power of the battery.</p> </html>"));
end BatterySOH;
