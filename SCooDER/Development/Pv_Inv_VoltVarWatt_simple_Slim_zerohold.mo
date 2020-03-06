within SCooDER.Development;
model Pv_Inv_VoltVarWatt_simple_Slim_zerohold
  // Weather data
  parameter String weather_file = "" "Path to weather file";
  // PV generation
  parameter Real n(min=0, unit="1") = 26 "Number of PV modules";
  parameter Real A(min=0, unit="m2") = 1.65 "Net surface area per module";
  parameter Real eta(min=0, max=1, unit="1") = 0.158
    "Module conversion efficiency";
  parameter Real lat(unit="deg") = 37.9 "Latitude";
  parameter Real til(unit="deg") = 10 "Surface tilt";
  parameter Real azi(unit="deg") = 0 "Surface azimuth 0-S, 90-W, 180-N, 270-E ";
  // VoltVarWatt
  parameter Real thrP = 0.05 "P: over/undervoltage threshold";
  parameter Real hysP= 0.04 "P: Hysteresis";
  parameter Real thrQ = 0.04 "Q: over/undervoltage threshold";
  parameter Real hysQ = 0.01 "Q: Hysteresis";
  parameter Real SMax(unit="VA") = 7600 "Maximal Apparent Power";
  parameter Real QMaxInd(unit="var") = 3300 "Maximal Reactive Power (Inductive)";
  parameter Real QMaxCap(unit="var") = 3300 "Maximal Reactive Power (Capacitive)";
  parameter Real Ts(unit="s") = 60 "Time constant of zero order hold";

  SCooDER.Components.Photovoltaics.Model.PVModule_simple
    pVModule_simple(
    n=n,
    A=A,
    eta=eta,
    lat=lat,
    til=til,
    azi=azi)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon(
      computeWetBulbTemperature=false, filNam=weather_file)
    "Weather data reader with radiation data obtained from the inputs' connectors"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Modelica.Blocks.Interfaces.RealInput v(start=1, unit="1") "Voltage [p.u]"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput Q(start=0, unit="var")
    "Reactive power in kVar"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput P(unit="W", start=0)
    "Active power in kW"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Math.Gain WtokW(k=1/1e3)
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Modelica.Blocks.Math.Gain varTokvar(k=1/1e3)
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  Modelica.Blocks.Sources.RealExpression S_curtail_P(y=min(sqrt(SMax^2 - Q^2),
        WtokW.y)) annotation (Placement(transformation(extent={{0,-10},{80,10}})));
  SCooDER.Components.Controller.Model.voltVarWatt_param
    voltVarWatt_param(
    thrP=thrP,
    hysP=hysP,
    thrQ=thrQ,
    hysQ=hysQ,
    QMaxInd=QMaxInd*1000,
    QMaxCap=QMaxCap*1000)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold_v(samplePeriod=Ts)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold_q(samplePeriod=Ts)
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  Modelica.Blocks.Discrete.ZeroOrderHold zeroOrderHold_p(samplePeriod=Ts)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,30})));
equation
  connect(weaDatInpCon.weaBus, pVModule_simple.weaBus) annotation (Line(
      points={{-60,70},{-40,70},{-40,54},{-10,54}},
      color={255,204,51},
      thickness=0.5));
  connect(pVModule_simple.P, WtokW.u)
    annotation (Line(points={{11,50},{18,50}}, color={0,0,127}));
  connect(pVModule_simple.scale, voltVarWatt_param.Plim) annotation (Line(
        points={{-12,46},{-20,46},{-20,5},{-29,5}}, color={0,0,127}));
  connect(voltVarWatt_param.Qctrl, varTokvar.u) annotation (Line(points={{-29,-5},
          {-20,-5},{-20,-50},{18,-50}}, color={0,0,127}));
  connect(v, zeroOrderHold_v.u)
    annotation (Line(points={{-120,0},{-92,0}}, color={0,0,127}));
  connect(zeroOrderHold_v.y, voltVarWatt_param.v)
    annotation (Line(points={{-69,0},{-52,0}}, color={0,0,127}));
  connect(varTokvar.y, zeroOrderHold_q.u)
    annotation (Line(points={{41,-50},{58,-50}}, color={0,0,127}));
  connect(zeroOrderHold_q.y, Q)
    annotation (Line(points={{81,-50},{110,-50}}, color={0,0,127}));
  connect(P, zeroOrderHold_p.y)
    annotation (Line(points={{110,50},{90,50},{90,41}}, color={0,0,127}));
  connect(zeroOrderHold_p.u, S_curtail_P.y)
    annotation (Line(points={{90,18},{90,0},{84,0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Pv_Inv_VoltVarWatt_simple_Slim_zerohold;
