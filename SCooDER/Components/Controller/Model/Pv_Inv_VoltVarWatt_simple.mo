within SCooDER.Components.Controller.Model;
model Pv_Inv_VoltVarWatt_simple
  // Weather data
  parameter String weather_file = Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos") "Path to weather file";
  // PV generation
  parameter Real n(min=0, unit="1") = 14 "Number of PV modules";
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
  parameter Real QMaxInd(unit="var") = 1000 "Maximal Reactive Power (Inductive)";
  parameter Real QMaxCap(unit="var") = 1000 "Maximal Reactive Power (Capacitive)";

  SCooDER.Components.Photovoltaics.Model.PVModule_simple PV(
    n=n,
    A=A,
    eta=eta,
    til=til,
    azi=azi)
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon(
      computeWetBulbTemperature=false, filNam=weather_file)
    "Weather data reader with radiation data obtained from the inputs' connectors"
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  voltVarWatt_param VoltVarWatt(
    thrP=thrP,
    hysP=hysP,
    thrQ=thrQ,
    hysQ=hysQ,
    QMaxInd=QMaxInd,
    QMaxCap=QMaxCap)
    annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
  Modelica.Blocks.Interfaces.RealInput Vpu(start=1, unit="1") "Voltage [p.u]"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealOutput Q(start=0, unit="var")
    "Reactive power"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}})));
  Modelica.Blocks.Interfaces.RealOutput P(unit="W", start=0)
    "Active power"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
equation
  connect(weaDatInpCon.weaBus, PV.weaBus) annotation (Line(
      points={{-60,70},{-40,70},{-40,54},{-10,54}},
      color={255,204,51},
      thickness=0.5));
  connect(VoltVarWatt.Vpu, Vpu)
    annotation (Line(points={{-52,0},{-120,0}}, color={0,0,127}));
  connect(PV.scale,VoltVarWatt.PLim)  annotation (Line(points={{-12,46},
          {-20,46},{-20,5},{-29,5}}, color={0,0,127}));
  connect(PV.P, P)
    annotation (Line(points={{11,50},{110,50}}, color={0,0,127}));
  connect(Q,VoltVarWatt.QCtrl)  annotation (Line(points={{110,-50},{-20,
          -50},{-20,-5},{-29,-5}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Pv_Inv_VoltVarWatt_simple;
