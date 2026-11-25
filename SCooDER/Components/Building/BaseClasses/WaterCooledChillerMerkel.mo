within SCooDER.Components.Building.BaseClasses;
model WaterCooledChillerMerkel "Water cooled chiller with Merkel wet cooling tower, scaled from McQuay WSC 471 kW"
  replaceable package MediumW = Buildings.Media.Water "Medium model for water";

  parameter Modelica.Units.SI.Temperature TSetSup
    "Supply water temperature set point";
  parameter Modelica.Units.SI.HeatFlowRate QEva_flow_min = -Modelica.Constants.inf
    "Maximum heat flow rate for cooling (negative)";
  parameter Modelica.Units.SI.PressureDifference dp_nominal=45000
    "Nominal chilled water pump head";
  parameter Modelica.Units.SI.HeatFlowRate QEva_flow_nominal(max=0) = -300000
    "Nominal cooling capacity of the chiller (negative)";
  parameter Modelica.Units.SI.TemperatureDifference dTApp = 4
    "Condenser water temperature set point above ambient wet bulb temperature";
  parameter Modelica.Units.SI.Temperature TConEntMin = 288.15
    "Lowest condenser water set point";
  parameter Modelica.Units.SI.Temperature TWetBulDes = 295.15
    "Design ambient wet bulb temperature for the cooling tower";
  parameter Real fraMinCW(min=0, max=1, final unit="1") = 0.5
    "Minimum condenser water flow as fraction of nominal";
  parameter Modelica.Units.SI.PressureDifference dpPumCW_nominal = 50000
    "Nominal condenser water pump head";
  parameter Real ratPFan_mFlow(final unit="J/kg") = 340
    "Tower fan power at full speed per unit of nominal condenser water flow rate (W per kg/s), default as in Buildings.DHC.Plants.Combined.Subsystems.CoolingTowerGroup";
  parameter Real ratCooAir_nominal(min=0, final unit="1") = 1.45
    "Water to air mass flow rate ratio at design condition, default as in Buildings.DHC.Plants.Combined.Subsystems.CoolingTowerGroup";
  parameter Real yFan_min(final unit="1") = 0.1
    "Minimum tower fan speed";
  final parameter Real sca(final unit="1") = QEva_flow_nominal/(-471200)
    "Scaling factor with respect to the 471 kW reference chiller";
  final parameter Modelica.Units.SI.HeatFlowRate QCon_flow_nominal =
    QEva_flow_nominal*(1 + 1/chi.per.COP_nominal)
    "Nominal heat flow rate rejected at the condenser (negative)";
  final parameter Modelica.Units.SI.TemperatureDifference dTCon_nominal =
    -QCon_flow_nominal/(chi.m1_flow_nominal*Buildings.Utilities.Psychrometrics.Constants.cpWatLiq)
    "Nominal condenser water temperature range";
  final parameter Modelica.Units.SI.Power PFan_nominal = ratPFan_mFlow*chi.m1_flow_nominal
    "Tower fan power at full speed";

  Buildings.Fluid.Chillers.ElectricEIR chi(
    redeclare package Medium1 = MediumW,
    redeclare package Medium2 = MediumW,
    dp1_nominal=20000,
    dp2_nominal=0,
    per=Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_McQuay_WSC_471kW_5_89COP_Vanes(
      QEva_flow_nominal=QEva_flow_nominal,
      mEva_flow_nominal=1000*0.01035*sca,
      mCon_flow_nominal=1000*0.01924*sca))
    "Water cooled chiller"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={0,0})));
  parameter Buildings.Fluid.HeatExchangers.CoolingTowers.Data.Merkel.Generic datCooTow(
    Q_flow_nominal=QCon_flow_nominal,
    PFan_Q_flow_nominal=-PFan_nominal/(-QCon_flow_nominal),
    ratCooAir_nominal=ratCooAir_nominal,
    TAirInWB_nominal=TWetBulDes,
    TCooIn_nominal=chi.per.TConEnt_nominal + dTCon_nominal,
    TCooOut_nominal=chi.per.TConEnt_nominal,
    dp_nominal=20000)
    "Cooling tower performance data";
  Buildings.Fluid.HeatExchangers.CoolingTowers.Merkel cooTow(
    redeclare package Medium = MediumW,
    dat=datCooTow,
    yMin=yFan_min)
    "Merkel wet cooling tower with variable speed fan"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={200,20})));
  Buildings.Fluid.Movers.Preconfigured.FlowControlled_m_flow pumCW(
    redeclare package Medium = MediumW,
    m_flow_nominal=chi.m1_flow_nominal,
    addPowerToMedium=false,
    dp_nominal=dpPumCW_nominal)
    "Variable speed condenser water pump"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={260,20})));
  Modelica.Blocks.Sources.RealExpression mConSet(
    y=if chi.QEva_flow/QEva_flow_nominal > 0.02 then chi.m1_flow_nominal*max(fraMinCW, min(1.0, chi.QEva_flow/QEva_flow_nominal)) else 0)
    "Condenser water flow set point following chiller load"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={260,70}, rotation=270)));
  Buildings.Fluid.Sources.Boundary_pT refPresCW(redeclare package Medium = MediumW,
    nPorts=1) "Reference pressure of condenser water loop"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={150,-30})));
  Buildings.Controls.Continuous.LimPID conTow(
    controllerType=Modelica.Blocks.Types.SimpleController.PI,
    k=0.5,
    Ti=120,
    yMin=0.05,
    reverseActing=false)
    "Cooling tower fan speed controller"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={140,50})));
  Modelica.Blocks.Math.Add addApp "Wet bulb temperature plus approach"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={50,100})));
  Modelica.Blocks.Sources.Constant appSet(k=dTApp) "Approach temperature"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={0,110})));
  Modelica.Blocks.Math.Max maxSet "Condenser water set point with lower limit"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={100,60})));
  Modelica.Blocks.Sources.Constant TMinSet(k=TConEntMin)
    "Lowest condenser water set point"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={60,40})));
  Modelica.Blocks.Math.Add addPCT "Cooling tower fan plus condenser pump power"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={310,60})));
  Buildings.Utilities.IO.SignalExchange.Read reaPCooTow(
    description="Electric power consumed by cooling tower fan and condenser water pump",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electric power consumed by cooling tower fan and condenser pump"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={350,60})));
  Modelica.Blocks.Interfaces.RealOutput PCooTow
    "Electric power consumed by cooling tower fan and condenser water pump"
    annotation (Placement(transformation(extent={{380,50},{400,70}}), iconTransformation(extent={{100,50},{120,70}})));

  Modelica.Blocks.Sources.Constant TSetChws(k=TSetSup)
    "Chilled water temperature set point"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-60,-30})));
  Modelica.Fluid.Interfaces.FluidPort_a ret(redeclare package Medium = MediumW)
    "Return water port"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}}), iconTransformation(extent={{90,-10},{110,10}})));
  Modelica.Fluid.Interfaces.FluidPort_b sup(redeclare package Medium = MediumW)
    "Supply water port"
    annotation (Placement(transformation(extent={{-200,-90},{-180,-70}}), iconTransformation(extent={{-110,-10},{-90,10}})));
  Buildings.BoundaryConditions.WeatherData.Bus weaBus "Bus with weather data"
    annotation (Placement(transformation(extent={{-110,120},{-90,140}}), iconTransformation(extent={{-110,90},{-90,110}})));
  Modelica.Blocks.Interfaces.RealOutput PChi
    "Electric power consumed by chiller"
    annotation (Placement(transformation(extent={{10,70},{30,90}}), iconTransformation(extent={{100,90},{120,110}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPChi(
    description="Electric power consumed by chiller",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electric power consumed by chiller"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={20,50}, rotation=90)));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemRet(redeclare package Medium =
        MediumW, m_flow_nominal=chi.m2_flow_nominal)
    "Return water temperature sensor"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={60,-80}, rotation=180)));
  Buildings.Utilities.IO.SignalExchange.Read reaTRet(
    description="Return water temperature of chiller",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Return water temperature of chiller"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={60,-130}, rotation=270)));
  Buildings.Fluid.Sensors.VolumeFlowRate senSupFlo(redeclare package Medium =
        MediumW, m_flow_nominal=chi.m2_flow_nominal)
    "Supply flow sensor"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-150,-80}, rotation=180)));
  Buildings.Utilities.IO.SignalExchange.Read reaFloSup(
    description="Supply water flow rate of chiller",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="m3/s")) "Supply water flow rate of chiller"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-150,-130}, rotation=270)));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemSup(
    redeclare package Medium = MediumW,
    m_flow_nominal=chi.m2_flow_nominal) "Supply water temperature sensor"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-60,-80}, rotation=180)));
  Buildings.Fluid.Movers.Preconfigured.FlowControlled_dp pum(
    redeclare package Medium = MediumW,
    m_flow_nominal=chi.m2_flow_nominal,
    addPowerToMedium=false,
    dp_nominal=dp_nominal) "Chilled water pump"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, origin={-100,-80})));
  Modelica.Blocks.Sources.Constant dp(k=dp_nominal) "Chilled water pump head"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-100,-40}, rotation=270)));
  Buildings.Fluid.Sources.Boundary_pT refPres(redeclare package Medium =
        MediumW, nPorts=1) "Reference pressure"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-190,-40}, rotation=270)));
  Buildings.Utilities.IO.SignalExchange.Read reaTSup(
    description="Supply water temperature of chiller",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.None,
    y(unit="K")) "Supply water temperature of chiller"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-60,-130}, rotation=270)));
  Modelica.Blocks.Sources.BooleanConstant on(k=true) "Chiller on"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-60,40})));
  Modelica.Blocks.Interfaces.RealOutput PPum
    "Electric power consumed by distribution pump"
    annotation (Placement(transformation(extent={{-150,-10},{-130,10}}), iconTransformation(extent={{100,70},{120,90}})));
  Buildings.Utilities.IO.SignalExchange.Read reaPPumDis(
    description="Electric power consumed by chilled water distribution pump",
    KPIs=Buildings.Utilities.IO.SignalExchange.SignalTypes.SignalsForKPIs.ElectricPower,
    y(unit="W")) "Electric power consumed by distribution pump"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, origin={-140,-40}, rotation=90)));

equation
  connect(TSetChws.y, chi.TSet) annotation (Line(points={{-49,-30},{-22,-30},{-22,-3},{-12,-3}}, color={0,0,127}));
  connect(on.y, chi.on) annotation (Line(points={{-49,40},{-22,40},{-22,3},{-12,3}}, color={255,0,255}));
  connect(chi.P, reaPChi.u) annotation (Line(points={{11,9},{20,9},{20,38}}, color={0,0,127}));
  connect(reaPChi.y, PChi) annotation (Line(points={{20,61},{20,80}}, color={0,0,127}));
  // chilled water loop
  connect(senTemRet.port_a, ret) annotation (Line(points={{70,-80},{110,-80}}, color={0,127,255}));
  connect(chi.port_a2, senTemRet.port_b) annotation (Line(points={{10,-6},{40,-6},{40,-80},{50,-80}}, color={0,127,255}));
  connect(chi.port_b2, senTemSup.port_a) annotation (Line(points={{-10,-6},{-40,-6},{-40,-80},{-50,-80}}, color={0,127,255}));
  connect(senTemSup.port_b, pum.port_a) annotation (Line(points={{-70,-80},{-90,-80}}, color={0,127,255}));
  connect(pum.port_b, senSupFlo.port_a) annotation (Line(points={{-110,-80},{-140,-80}}, color={0,127,255}));
  connect(senSupFlo.port_b, sup) annotation (Line(points={{-160,-80},{-190,-80}}, color={0,127,255}));
  connect(refPres.ports[1], senSupFlo.port_a) annotation (Line(points={{-190,-50},{-190,-60},{-130,-60},{-130,-80},{-140,-80}}, color={0,127,255}));
  connect(dp.y, pum.dp_in) annotation (Line(points={{-100,-51},{-100,-68}}, color={0,0,127}));
  connect(senTemRet.T, reaTRet.u) annotation (Line(points={{60,-91},{60,-118}}, color={0,0,127}));
  connect(senTemSup.T, reaTSup.u) annotation (Line(points={{-60,-91},{-60,-118}}, color={0,0,127}));
  connect(senSupFlo.V_flow, reaFloSup.u) annotation (Line(points={{-150,-91},{-150,-118}}, color={0,0,127}));
  connect(pum.P, reaPPumDis.u) annotation (Line(points={{-111,-71},{-140,-71},{-140,-52}}, color={0,0,127}));
  connect(reaPPumDis.y, PPum) annotation (Line(points={{-140,-29},{-140,0}}, color={0,0,127}));
  // condenser water loop
  connect(pumCW.port_b, chi.port_a1) annotation (Line(points={{270,20},{280,20},{280,160},{-20,160},{-20,6},{-10,6}}, color={0,127,255}));
  connect(chi.port_b1, cooTow.port_a) annotation (Line(points={{10,6},{40,6},{40,20},{190,20}}, color={0,127,255}));
  connect(cooTow.port_b, pumCW.port_a) annotation (Line(points={{210,20},{250,20}}, color={0,127,255}));
  connect(refPresCW.ports[1], pumCW.port_a) annotation (Line(points={{160,-30},{240,-30},{240,20},{250,20}}, color={0,127,255}));
  connect(mConSet.y, pumCW.m_flow_in) annotation (Line(points={{260,59},{260,32}}, color={0,0,127}));
  // tower fan control
  connect(weaBus.TWetBul, cooTow.TWetBul) annotation (Line(points={{-100,130},{-100,150},{180,150},{180,24},{188,24}}, color={255,204,51}, thickness=0.5));
  connect(weaBus.TWetBul, addApp.u1) annotation (Line(points={{-100,130},{-100,150},{30,150},{30,106},{38,106}}, color={255,204,51}, thickness=0.5));
  connect(appSet.y, addApp.u2) annotation (Line(points={{11,110},{25,110},{25,94},{38,94}}, color={0,0,127}));
  connect(addApp.y, maxSet.u1) annotation (Line(points={{61,100},{80,100},{80,66},{88,66}}, color={0,0,127}));
  connect(TMinSet.y, maxSet.u2) annotation (Line(points={{71,40},{80,40},{80,54},{88,54}}, color={0,0,127}));
  connect(maxSet.y, conTow.u_s) annotation (Line(points={{111,60},{120,60},{120,50},{128,50}}, color={0,0,127}));
  connect(cooTow.TLvg, conTow.u_m) annotation (Line(points={{211,14},{220,14},{220,0},{140,0},{140,38}}, color={0,0,127}));
  connect(conTow.y, cooTow.y) annotation (Line(points={{151,50},{170,50},{170,28},{188,28}}, color={0,0,127}));
  // power
  connect(pumCW.P, addPCT.u1) annotation (Line(points={{271,29},{285,29},{285,66},{298,66}}, color={0,0,127}));
  connect(cooTow.PFan, addPCT.u2) annotation (Line(points={{211,28},{220,28},{220,45},{290,45},{290,54},{298,54}}, color={0,0,127}));
  connect(addPCT.y, reaPCooTow.u) annotation (Line(points={{321,60},{338,60}}, color={0,0,127}));
  connect(reaPCooTow.y, PCooTow) annotation (Line(points={{361,60},{390,60}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
      Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}, fillColor={255,255,255}, fillPattern=FillPattern.Solid),
      Text(extent={{-100,-110},{100,-140}}, textString="%name", textColor={0,0,255})}),
    Diagram(coordinateSystem(extent={{-220,-150},{410,200}})),
    Documentation(info="<html><p>Water cooled chiller (Buildings ElectricEIR, McQuay WSC record scaled to the nominal capacity) rejecting heat through a Merkel wet cooling tower. Tower fan power at full speed and the water to air flow ratio default to the values used in Buildings.DHC.Plants.Combined.Subsystems.CoolingTowerGroup (340 W per kg/s of condenser water). The tower fan is controlled to hold the condenser water leaving the tower at wet bulb temperature plus an approach, and the condenser water pump follows the chiller load.</p></html>"));
end WaterCooledChillerMerkel;
