within SCooDER.Systems.Examples;
model PVandBatt
  Components.Battery.Model.Battery Battery(
    EMax=10000,
    Pmax=5000,
    SOC_start=0.5)
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Components.Photovoltaics.Model.PVandWeather_simple PV(weather_file="",
    n=10,
    A=1)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Math.Add sum_power(k2=-1)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
 Modelica.Blocks.Interfaces.RealInput BattCtrl(unit="W", start=0) annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,40}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0})));
 Modelica.Blocks.Interfaces.RealInput PVCtrl(unit="1", start=1) annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,-40}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0})));
  Modelica.Blocks.Interfaces.RealOutput P(unit="W", start=0)
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Interfaces.RealOutput SOC( unit="1", start=0.5)
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Interfaces.RealOutput Pmax(unit="W", start=0)
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Sources.RealExpression max_power(y=p_max)
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Real p_max(start=0);
  Modelica.Blocks.Interfaces.RealOutput Pmax_neg(unit="W", start=0)
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
  Modelica.Blocks.Math.Gain invert(k=-1)
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));
equation
  p_max = smooth(0, if noEvent(abs(P) > p_max) then abs(P) else p_max);
  connect(sum_power.u1, Battery.P)
    annotation (Line(points={{18,6},{0,6},{0,40},{-39,40}}, color={0,0,127}));
  connect(sum_power.u2, PV.P) annotation (Line(points={{18,-6},{0,-6},{0,-35},{-39,
          -35}}, color={0,0,127}));
  connect(BattCtrl, Battery.PCtrl)
    annotation (Line(points={{-120,40},{-62,40}}, color={0,0,127}));
  connect(PVCtrl, PV.scale)
    annotation (Line(points={{-120,-40},{-62,-40}}, color={0,0,127}));
  connect(sum_power.y, P)
    annotation (Line(points={{41,0},{110,0}}, color={0,0,127}));
  connect(Battery.SOC, SOC) annotation (Line(points={{-39,48},{0,48},{0,70},{110,
          70}}, color={0,0,127}));
  connect(max_power.y, Pmax)
    annotation (Line(points={{41,-40},{110,-40}}, color={0,0,127}));
  connect(invert.y, Pmax_neg)
    annotation (Line(points={{81,-70},{110,-70}}, color={0,0,127}));
  connect(invert.u, max_power.y) annotation (Line(points={{58,-70},{50,-70},{50,
          -40},{41,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end PVandBatt;
