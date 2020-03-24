within SCooDER.Components.Controller.Model;
model Pv_Inv_VoltVarWatt_simple_Slim_uStoarge
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
  // Battery
  parameter Real P_discharge(unit="W", min=0) = 1000 "Battery Maximal Discharge";
  parameter Real EMax(unit="W.h", min=0) = 1000 "Battery Capacity";
  parameter Real SOC_start(min=0, max=1, unit="1") = 0.1 "Initial SOC value";
  parameter Real SOC_min(min=0, max=1, unit="1") = 0.1 "Minimum SOC value";
  parameter Real SOC_max(min=0, max=1, unit="1") = 1 "Maximum SOC value";
  parameter Real etaCha(min=0, max=1, unit="1") = 0.96 "Charging efficiency";
  parameter Real etaDis(min=0, max=1, unit="1") = 0.96 "Discharging efficiency";

  SCooDER.Components.Photovoltaics.Model.PVModule_simple PV(
    n=n,
    A=A,
    eta=eta,
    lat=lat,
    til=til,
    azi=azi)
    annotation (Placement(transformation(extent={{-10,70},{10,90}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 Weather(
      computeWetBulbTemperature=false, filNam=weather_file)
    "Weather data reader with radiation data obtained from the inputs' connectors"
    annotation (Placement(transformation(extent={{-80,74},{-60,94}})));
  Modelica.Blocks.Interfaces.RealInput Vpu(start=1, unit="1") "Voltage [p.u]"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput Q(start=0, unit="var") "Reactive power"
    annotation (Placement(transformation(extent={{100,-20},{120,0}})));
  Modelica.Blocks.Interfaces.RealOutput P(unit="W", start=0) "Active power"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Sources.RealExpression P_feedin(y=min(sqrt(SMax^2 - Q^2), PV.P))
    annotation (Placement(transformation(extent={{-26,30},{54,50}})));
  voltVarWatt_param VoltVarWatt(
    thrP=thrP,
    hysP=hysP,
    thrQ=thrQ,
    hysQ=hysQ,
    QMaxInd=QMaxInd,
    QMaxCap=QMaxCap)
    annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  SCooDER.Components.Battery.Model.Battery battery(
    SOC_start=SOC_start,
    SOC_min=SOC_min,
    etaCha=etaCha,
    etaDis=etaDis,
    SOC_max=SOC_max,
    EMax=EMax*1000)
    annotation (Placement(transformation(extent={{40,-90},{60,-70}})));
  Modelica.Blocks.Sources.RealExpression P_battery_control(y=if (PV.P - P) > 0.1
         then (PV.P - P) else -1*min(sqrt(SMax^2 - Q^2) - P_feedin.y,
        P_discharge))
    annotation (Placement(transformation(extent={{-80,-90},{0,-70}})));
  Modelica.Blocks.Interfaces.RealOutput SOC(start=SOC_min, unit="1") "State of Charge"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput P_Batt(start=0, unit="W")
    "Power demand Battery"
    annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
  Modelica.Blocks.Interfaces.RealOutput SOE(unit="W.h") "State of Energy"
    annotation (Placement(transformation(extent={{100,-80},{120,-60}})));
  Modelica.Blocks.Math.Add Sum_P
    annotation (Placement(transformation(extent={{70,20},{90,40}})));
  Modelica.Blocks.Sources.RealExpression P_battery(y=if P_Batt < 0 then -1*P_Batt
               else 0)
    annotation (Placement(transformation(extent={{-26,10},{54,30}})));
  Modelica.Blocks.Sources.RealExpression P_curtailed(y=PV.P - P_feedin.y)
    annotation (Placement(transformation(extent={{-80,-60},{0,-40}})));
equation
  connect(Weather.weaBus, PV.weaBus) annotation (Line(
      points={{-60,84},{-10,84}},
      color={255,204,51},
      thickness=0.5));
  connect(PV.scale,VoltVarWatt.PLim)  annotation (Line(points={{-12,76},{-40,76},
          {-40,5},{-49,5}}, color={0,0,127}));
  connect(VoltVarWatt.Vpu, Vpu)
    annotation (Line(points={{-72,0},{-120,0}}, color={0,0,127}));
  connect(SOC, battery.SOC) annotation (Line(points={{110,-50},{70,-50},{70,-72},
          {61,-72}}, color={0,0,127}));
  connect(Sum_P.y, P)
    annotation (Line(points={{91,30},{110,30}}, color={0,0,127}));
  connect(P_feedin.y, Sum_P.u1) annotation (Line(points={{58,40},{64,40},{64,36},
          {68,36}}, color={0,0,127}));
  connect(Sum_P.u2, P_battery.y) annotation (Line(points={{68,24},{64,24},{64,20},
          {58,20}}, color={0,0,127}));
  connect(Q,VoltVarWatt.QCtrl)  annotation (Line(points={{110,-10},{-40,-10},{-40,
          -5},{-49,-5}}, color={0,0,127}));
  connect(P_battery_control.y, battery.PCtrl)
    annotation (Line(points={{4,-80},{38,-80}}, color={0,0,127}));
  connect(battery.SOE, SOE) annotation (Line(points={{61,-75},{80.5,-75},{80.5,-70},
          {110,-70}}, color={0,0,127}));
  connect(battery.P,P_Batt)  annotation (Line(points={{61,-80},{80,-80},
          {80,-90},{110,-90}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Pv_Inv_VoltVarWatt_simple_Slim_uStoarge;
