within SCooDER.Systems;
model generic_wye_voltvar
  parameter Real V_nominal(min=0, unit="V") = 240 "Nominal sytem voltage to scale Vp.u.";
  parameter Real v_max( start=1.05, unit="1")=1.05 "Voltage maximum [p.u.]";
  parameter Real v_maxdead( start=1.01, unit="1")=1.01 "Upper bound of deadband [p.u.]";
  parameter Real v_mindead( start=0.99, unit="1")=0.99 "Upper bound of deadband [p.u.]";
  parameter Real v_min( start=0.95, unit="1")=0.95 "Voltage minimum [p.u.]";
  parameter Real q_maxind( start=1000, unit="var")=2500 "Maximal Reactive Power (Inductive) [var]";
  parameter Real q_maxcap( start=1000, unit="var")=2500 "Maximal Reactive Power (Capacitive) [var]";
  parameter String weaName = "C:/Users/Christoph/Documents/SmartInverter/smartinverter_simulation/ExampleData/USA_CA_San.Francisco.Intl.AP.724940_TMY3_CONVERTED.mos" "Path to weather file";
  parameter Real n(min=0, unit="1") = 14 "Number of PV modules";
  parameter Modelica.SIunits.Area A(min=0) = 1.65 "Net surface area per module [m2]";
  parameter Real lat(unit="deg") = 37.9 "Latitude [deg]";
  parameter Real til(unit="deg") = 10 "Surface tilt [deg]";
  parameter Real azi(unit="deg") = 0 "Surface azimuth [deg] 0-S, 90-W, 180-N, 270-E ";
  parameter Real Smax(min=0, unit="VA") = 7600
    "Maximal apparent power";
  parameter Real QIndmax(min=0, unit="var") = 2500
    "Maximal reactive power (Inductive)";
  parameter Real QCapmax(min=0, unit="var") = 2500
    "Maximal reactive power (Capacitive)";

  generic_direct_wye  generic(
    n=n,
    A=A,
    lat=lat,
    til=til,
    azi=azi,
    Smax=Smax,
    QIndmax=QIndmax,
    QCapmax=QCapmax)
    annotation (Placement(transformation(extent={{-20,20},{20,60}})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon1(
    computeWetBulbTemperature=false, filNam=weaName)
    "Weather data reader with radiation data obtained from the inputs' connectors"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Interfaces.generic_interface_voltvar interface_voltvar(
    V_nominal=V_nominal,
    v_max=v_max,
    v_maxdead=v_maxdead,
    v_mindead=v_mindead,
    v_min=v_min,
    q_maxind=q_maxind,
    q_maxcap=q_maxcap)
    annotation (Placement(transformation(extent={{-20,-30},{20,10}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_p
             terminal_p "Electric terminal side p"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Sources.Constant const_scale(k=1)
    annotation (Placement(transformation(extent={{-70,30},{-50,50}})));
  Components.Inverter.Interfaces.InvCtrlBus invCtrlBus annotation (Placement(
        transformation(extent={{-120,-40},{-80,0}}), iconTransformation(extent={
            {-110,-10},{-90,10}})));
equation
  connect(weaDatInpCon1.weaBus, generic.weaBus) annotation (Line(
      points={{-60,80},{-30,80},{-30,56},{-20,56}},
      color={255,204,51},
      thickness=0.5));
  connect(generic.invCtrlBus1, interface_voltvar.invCtrlBus1) annotation (Line(
      points={{-10,20},{-10,15},{-10,10}},
      color={255,204,51},
      thickness=0.5));
  connect(generic.invCtrlBus2, interface_voltvar.invCtrlBus2) annotation (Line(
      points={{0,20},{0,15},{0,10}},
      color={255,204,51},
      thickness=0.5));
  connect(generic.invCtrlBus3, interface_voltvar.invCtrlBus3) annotation (Line(
      points={{10,20},{10,15},{10,10}},
      color={255,204,51},
      thickness=0.5));
  connect(terminal_p, generic.terminal_p) annotation (Line(points={{110,0},{60,0},
          {60,58},{22,58}}, color={0,120,120}));
  connect(interface_voltvar.invCtrlBus, invCtrlBus) annotation (Line(
      points={{-20,-10},{-60,-10},{-60,-20},{-100,-20}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(const_scale.y, generic.scale2)
    annotation (Line(points={{-49,40},{-22,40}}, color={0,0,127}));
  connect(generic.scale1, const_scale.y) annotation (Line(points={{-22,44},{-34,
          44},{-34,40},{-49,40}}, color={0,0,127}));
  connect(generic.scale3, const_scale.y) annotation (Line(points={{-22,36},{-34,
          36},{-34,40},{-49,40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
  experiment(StartTime=2.09952e+07, StopTime=2.22039e+07),
  Diagram(coordinateSystem(preserveAspectRatio=false)));
end generic_wye_voltvar;
