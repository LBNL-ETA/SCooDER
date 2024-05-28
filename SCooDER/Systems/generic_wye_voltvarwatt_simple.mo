within SCooDER.Systems;
model generic_wye_voltvarwatt_simple
  parameter Real V_nominal(min=0, unit="V") = 240 "Nominal sytem voltage to scale Vp.u.";
  /*parameter Real v_max( start=1.05, unit="1")=1.05 "Voltage maximum [p.u.]";
  parameter Real v_maxdead( start=1.01, unit="1")=1.01 "Upper bound of deadband [p.u.]";
  parameter Real v_mindead( start=0.99, unit="1")=0.99 "Upper bound of deadband [p.u.]";
  parameter Real v_min( start=0.95, unit="1")=0.95 "Voltage minimum [p.u.]";
  parameter Real q_maxind( start=1000, unit="var")=2500 "Maximal Reactive Power (Inductive) [var]";
  parameter Real q_maxcap( start=1000, unit="var")=2500 "Maximal Reactive Power (Capacitive) [var]";*/
  parameter String weaName = Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos") "Path to weather file";
  parameter Real n(min=0, unit="1") = 14 "Number of PV modules";
  parameter Modelica.Units.SI.Area A(min=0) = 1.65
    "Net surface area per module [m2]";
  parameter Real lat(unit="deg") = 37.9 "Latitude [deg]";
  parameter Real til(unit="deg") = 10 "Surface tilt [deg]";
  parameter Real azi(unit="deg") = 0 "Surface azimuth [deg] 0-S, 90-W, 180-N, 270-E ";
  parameter Real Smax(min=0, unit="VA") = 7600
    "Maximal apparent power";
  parameter Real QIndmax(min=0, unit="var") = 2500
    "Maximal reactive power (Inductive)";
  parameter Real QCapmax(min=0, unit="var") = 2500
    "Maximal reactive power (Capacitive)";
  // VoltVarWatt
  parameter Real thrP = 0.05 "P: over/undervoltage threshold";
  parameter Real hysP= 0.04 "P: Hysteresis";
  parameter Real thrQ = 0.04 "Q: over/undervoltage threshold";
  parameter Real hysQ = 0.01 "Q: Hysteresis";
  parameter Real Tfirstorder(unit="s") = 1 "Time constant of first order";

  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDatInpCon1(
    computeWetBulbTemperature=false, filNam=weaName)
    "Weather data reader with radiation data obtained from the inputs' connectors"
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_p
             terminal_p "Electric terminal side p"
    annotation (Placement(transformation(extent={{100,-10},{120,10}}),
        iconTransformation(extent={{100,-10},{120,10}})));
  Components.Inverter.Interfaces.InvCtrlBus invCtrlBus annotation (Placement(
        transformation(extent={{-120,-40},{-80,0}}), iconTransformation(extent={
            {-110,-10},{-90,10}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 wye
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Components.Inverter.Model.InverterLoad_PQ load1(V_start=120)
    annotation (Placement(transformation(extent={{36,50},{16,30}})));
  Modelica.Blocks.Math.Gain kW_to_W1(k=1000)
    annotation (Placement(transformation(extent={{-10,42},{-4,48}})));
  Modelica.Blocks.Math.Gain kvar_to_var1(k=1000)
    annotation (Placement(transformation(extent={{-10,32},{-4,38}})));
  Components.Controller.Model.Pv_Inv_VoltVarWatt_simple_Slim_weabus inv1(
    n=n,
    A=A,
    lat=lat,
    til=til,
    azi=azi,
    SMax=Smax/1000,
    QMaxInd=QIndmax/1000,
    QMaxCap=QCapmax/1000,
    thrP=thrP,
    hysP=hysP,
    thrQ=thrQ,
    hysQ=hysQ)
    annotation (Placement(transformation(extent={{-44,30},{-24,50}})));
  Components.Inverter.Model.InverterLoad_PQ load2(V_start=120)
    annotation (Placement(transformation(extent={{36,10},{16,-10}})));
  Modelica.Blocks.Math.Gain kW_to_W2(k=1000)
    annotation (Placement(transformation(extent={{-10,2},{-4,8}})));
  Modelica.Blocks.Math.Gain kvar_to_var2(k=1000)
    annotation (Placement(transformation(extent={{-10,-8},{-4,-2}})));
  Components.Controller.Model.Pv_Inv_VoltVarWatt_simple_Slim_weabus inv2(
    n=n,
    A=A,
    lat=lat,
    til=til,
    azi=azi,
    SMax=Smax/1000,
    QMaxInd=QIndmax/1000,
    QMaxCap=QCapmax/1000,
    thrP=thrP,
    hysP=hysP,
    thrQ=thrQ,
    hysQ=hysQ)
    annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
  Components.Inverter.Model.InverterLoad_PQ load3(V_start=120)
    annotation (Placement(transformation(extent={{36,-30},{16,-50}})));
  Modelica.Blocks.Math.Gain kW_to_W3(k=1000)
    annotation (Placement(transformation(extent={{-10,-38},{-4,-32}})));
  Modelica.Blocks.Math.Gain kvar_to_var3(k=1000)
    annotation (Placement(transformation(extent={{-10,-48},{-4,-42}})));
  Components.Controller.Model.Pv_Inv_VoltVarWatt_simple_Slim_weabus inv3(
    n=n,
    A=A,
    lat=lat,
    til=til,
    azi=azi,
    SMax=Smax/1000,
    QMaxInd=QIndmax/1000,
    QMaxCap=QCapmax/1000,
    thrP=thrP,
    hysP=hysP,
    thrQ=thrQ,
    hysQ=hysQ)
    annotation (Placement(transformation(extent={{-44,-50},{-24,-30}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens1 annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={48,30})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens3 annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={50,-30})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens2 annotation (
      Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={50,0})));
  Modelica.Blocks.Math.Gain vpu1(k=1/V_nominal)
    annotation (Placement(transformation(extent={{-72,36},{-64,44}})));
  Modelica.Blocks.Math.Gain vpu2(k=1/V_nominal)
    annotation (Placement(transformation(extent={{-72,-4},{-64,4}})));
  Modelica.Blocks.Math.Gain vpu3(k=1/V_nominal)
    annotation (Placement(transformation(extent={{-72,-44},{-64,-36}})));
  Modelica.Blocks.Sources.RealExpression activePower(y=sens1.S[1] + sens2.S[1]
         + sens3.S[1])
    annotation (Placement(transformation(extent={{-50,-106},{-90,-86}})));
  Modelica.Blocks.Sources.RealExpression reactivePower(y=sens1.S[2] + sens2.S[2]
         + sens3.S[2])
    annotation (Placement(transformation(extent={{-50,-92},{-90,-72}})));
  Modelica.Blocks.Sources.Constant const_voltage(k=0)
    annotation (Placement(transformation(extent={{-80,-70},{-90,-60}})));
  Modelica.Blocks.Math.Gain qctrl(k=1)
    annotation (Placement(transformation(extent={{-94,26},{-86,34}})));
  Modelica.Blocks.Math.Gain batt_ctrl(k=1)
    annotation (Placement(transformation(extent={{-94,0},{-86,8}})));
  Modelica.Blocks.Math.Gain plim(k=1)
    annotation (Placement(transformation(extent={{-94,14},{-86,22}})));
equation
  connect(wye.terminal, terminal_p)
    annotation (Line(points={{90,0},{110,0}}, color={0,120,120}));
  connect(kW_to_W1.y, load1.Pow) annotation (Line(points={{-3.7,45},{6,45},{6,40},
          {14,40}}, color={0,0,127}));
  connect(kvar_to_var1.y, load1.Q)
    annotation (Line(points={{-3.7,35},{14,35},{14,34}},color={0,0,127}));
  connect(kW_to_W1.u, inv1.P)
    annotation (Line(points={{-10.6,45},{-23,45}},color={0,0,127}));
  connect(kvar_to_var1.u, inv1.Q)
    annotation (Line(points={{-10.6,35},{-23,35}},color={0,0,127}));
  connect(kW_to_W2.y, load2.Pow)
    annotation (Line(points={{-3.7,5},{6,5},{6,0},{14,0}},  color={0,0,127}));
  connect(kvar_to_var2.y, load2.Q)
    annotation (Line(points={{-3.7,-5},{14,-5},{14,-6}},color={0,0,127}));
  connect(kW_to_W2.u, inv2.P)
    annotation (Line(points={{-10.6,5},{-23,5}},color={0,0,127}));
  connect(kvar_to_var2.u, inv2.Q)
    annotation (Line(points={{-10.6,-5},{-23,-5}},color={0,0,127}));
  connect(kW_to_W3.y, load3.Pow) annotation (Line(points={{-3.7,-35},{6,-35},{6,
          -40},{14,-40}}, color={0,0,127}));
  connect(kvar_to_var3.y, load3.Q)
    annotation (Line(points={{-3.7,-45},{14,-45},{14,-46}},color={0,0,127}));
  connect(kW_to_W3.u, inv3.P)
    annotation (Line(points={{-10.6,-35},{-23,-35}},color={0,0,127}));
  connect(kvar_to_var3.u, inv3.Q)
    annotation (Line(points={{-10.6,-45},{-23,-45}},color={0,0,127}));
  connect(weaDatInpCon1.weaBus, inv1.weaBus) annotation (Line(
      points={{-70,80},{-60,80},{-60,47},{-44,47}},
      color={255,204,51},
      thickness=0.5));
  connect(inv2.weaBus, weaDatInpCon1.weaBus) annotation (Line(
      points={{-44,7},{-60,7},{-60,80},{-70,80}},
      color={255,204,51},
      thickness=0.5));
  connect(inv3.weaBus, weaDatInpCon1.weaBus) annotation (Line(
      points={{-44,-33},{-60,-33},{-60,80},{-70,80}},
      color={255,204,51},
      thickness=0.5));
  connect(sens2.terminal_p, load2.terminal)
    annotation (Line(points={{40,0},{36,0}}, color={0,120,120}));
  connect(load1.terminal, sens1.terminal_p)
    annotation (Line(points={{36,40},{48,40}}, color={0,120,120}));
  connect(load3.terminal, sens3.terminal_p)
    annotation (Line(points={{36,-40},{50,-40}}, color={0,120,120}));
  connect(sens2.terminal_n, wye.terminals[2]) annotation (Line(points={{60,0},{66,
          0},{66,0},{70.2,0}}, color={0,120,120}));
  connect(sens3.terminal_n, wye.terminals[3]) annotation (Line(points={{50,-20},
          {64,-20},{64,-0.533333},{70.2,-0.533333}}, color={0,120,120}));
  connect(sens1.terminal_n, wye.terminals[1]) annotation (Line(points={{48,20},{
          64,20},{64,0.533333},{70.2,0.533333}}, color={0,120,120}));
  connect(inv1.Vpu, vpu1.y)
    annotation (Line(points={{-46,40},{-63.6,40}}, color={0,0,127}));
  connect(vpu3.y, inv3.Vpu)
    annotation (Line(points={{-63.6,-40},{-46,-40}}, color={0,0,127}));
  connect(vpu2.y, inv2.Vpu)
    annotation (Line(points={{-63.6,0},{-46,0}}, color={0,0,127}));
  connect(sens3.V, vpu3.u) annotation (Line(points={{59,-30},{64,-30},{64,-54},
          {-80,-54},{-80,-40},{-72.8,-40}}, color={0,0,127}));
  connect(sens2.V, vpu2.u) annotation (Line(points={{50,-9},{50,-12},{-80,-12},
          {-80,0},{-72.8,0}}, color={0,0,127}));
  connect(sens1.V, vpu1.u) annotation (Line(points={{57,30},{64,30},{64,60},{
          -80,60},{-80,40},{-72.8,40}}, color={0,0,127}));
  connect(const_voltage.y, invCtrlBus.v) annotation (Line(points={{-90.5,-65},{
          -99.9,-65},{-99.9,-19.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(reactivePower.y, invCtrlBus.q) annotation (Line(points={{-92,-82},{
          -100,-82},{-100,-19.9},{-99.9,-19.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(activePower.y, invCtrlBus.p) annotation (Line(points={{-92,-96},{
          -99.9,-96},{-99.9,-19.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(batt_ctrl.u, invCtrlBus.batt_ctrl) annotation (Line(points={{-94.8,4},
          {-99.9,4},{-99.9,-19.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(plim.u, invCtrlBus.plim) annotation (Line(points={{-94.8,18},{-99.9,
          18},{-99.9,-19.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(qctrl.u, invCtrlBus.qctrl) annotation (Line(points={{-94.8,30},{-99.9,
          30},{-99.9,-19.9}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
  experiment(StartTime=2.09952e+07, StopTime=2.22039e+07),
  Diagram(coordinateSystem(preserveAspectRatio=false)));
end generic_wye_voltvarwatt_simple;
