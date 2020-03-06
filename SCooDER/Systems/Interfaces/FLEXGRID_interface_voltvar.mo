within SCooDER.Systems.Interfaces;
model FLEXGRID_interface_voltvar
  parameter Real V_nominal(min=0, unit="V") = 120 "Nominal sytem voltage to scale Vp.u.";
  parameter Real v_max( start=1.05, unit="1")=1.05 "Voltage maximum [p.u.]";
  parameter Real v_maxdead( start=1.01, unit="1")=1.01 "Upper bound of deadband [p.u.]";
  parameter Real v_mindead( start=0.99, unit="1")=0.99 "Lower bound of deadband [p.u.]";
  parameter Real v_min( start=0.95, unit="1")=0.95 "Voltage minimum [p.u.]";
  parameter Real q_maxind( start=1000, unit="var")=1000 "Maximal Reactive Power (Inductive) [var]";
  parameter Real q_maxcap( start=1000, unit="var")=1000 "Maximal Reactive Power (Capacitive) [var]";
  Modelica.Blocks.Interfaces.RealInput batt_ctrl3(start=0, unit="W")
    "Battery Power" annotation (Placement(transformation(
        origin={-110,52},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-90})));
  Modelica.Blocks.Interfaces.RealInput batt_ctrl1(start=0, unit="W")
    "Battery Power" annotation (Placement(transformation(
        origin={-110,80},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-50})));
  Modelica.Blocks.Interfaces.RealInput batt_ctrl2(start=0, unit="W")
    "Battery Power" annotation (Placement(transformation(
        origin={-110,66},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-70})));
  Modelica.Blocks.Interfaces.RealInput plim3(
    start=1,
    min=0,
    max=1,
    unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
        origin={-110,-58},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,-110})));
  Modelica.Blocks.Interfaces.RealInput plim2(
    start=1,
    min=0,
    max=1,
    unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
        origin={-110,-44},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,-110})));
  Modelica.Blocks.Interfaces.RealInput plim1(
    start=1,
    min=0,
    max=1,
    unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
        origin={-110,-30},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-110})));
  Components.Inverter.Interfaces.InvCtrlBus invCtrlBus1 annotation (Placement(
        transformation(extent={{-50,90},{-30,110}}),
                                                   iconTransformation(extent={{
            -60,90},{-40,110}})));
  Components.Inverter.Interfaces.InvCtrlBus invCtrlBus2 annotation (Placement(
        transformation(extent={{-10,90},{10,110}}), iconTransformation(extent={
            {-10,90},{10,110}})));
  Components.Inverter.Interfaces.InvCtrlBus invCtrlBus3 annotation (Placement(
        transformation(extent={{40,90},{60,110}}),   iconTransformation(extent={{40,90},
            {60,110}})));
  Modelica.Blocks.Interfaces.RealOutput p1(start=0, unit="W")
                                                             "active power output [W]"
    annotation (Placement(transformation(extent={{100,80},{120,100}}),
        iconTransformation(extent={{100,80},{120,100}})));
  Modelica.Blocks.Interfaces.RealOutput q1(start=0, unit="var") "reactive power output [var]"
    annotation (Placement(transformation(extent={{100,60},{120,80}}),
        iconTransformation(extent={{100,60},{120,80}})));
  Modelica.Blocks.Interfaces.RealOutput p2(start=0, unit="W")
                                                             "active power output [W]"
    annotation (Placement(transformation(extent={{100,20},{120,40}}),
        iconTransformation(extent={{100,20},{120,40}})));
  Modelica.Blocks.Interfaces.RealOutput q2(start=0, unit="var") "reactive power output [var]"
    annotation (Placement(transformation(extent={{100,0},{120,20}}),
        iconTransformation(extent={{100,0},{120,20}})));
  Modelica.Blocks.Interfaces.RealOutput p3(start=0, unit="W")
                                                             "active power output [W]"
    annotation (Placement(transformation(extent={{100,-40},{120,-20}}),
        iconTransformation(extent={{100,-40},{120,-20}})));
  Modelica.Blocks.Interfaces.RealOutput q3(start=0, unit="var") "reactive power output [var]"
    annotation (Placement(transformation(extent={{100,-60},{120,-40}}),
        iconTransformation(extent={{100,-60},{120,-40}})));
  Components.Controller.Model.voltvar_param_bus voltvar1(
    V_nominal=V_nominal,
    v_max=v_max,
    v_maxdead=v_maxdead,
    v_mindead=v_mindead,
    v_min=v_min,
    q_maxind=q_maxind,
    q_maxcap=q_maxcap) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-80})));
  Components.Controller.Model.voltvar_param_bus voltvar2(
    V_nominal=V_nominal,
    v_max=v_max,
    v_maxdead=v_maxdead,
    v_mindead=v_mindead,
    v_min=v_min,
    q_maxind=q_maxind,
    q_maxcap=q_maxcap) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-80})));
  Components.Controller.Model.voltvar_param_bus voltvar3(
    V_nominal=V_nominal,
    v_max=v_max,
    v_maxdead=v_maxdead,
    v_mindead=v_mindead,
    v_min=v_min,
    q_maxind=q_maxind,
    q_maxcap=q_maxcap) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={40,-80})));
equation
  connect(batt_ctrl1, invCtrlBus1.batt_ctrl) annotation (Line(points={{-110,80},
          {-40,80},{-40,100.05},{-39.95,100.05}},
                                                color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(plim1, invCtrlBus1.plim) annotation (Line(points={{-110,-30},{-76,-30},
          {-76,-30},{-40,-30},{-40,100.05},{-39.95,100.05}},
                                       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(batt_ctrl2, invCtrlBus2.batt_ctrl) annotation (Line(points={{-110,66},
          {0,66},{0,100.05},{0.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(plim2, invCtrlBus2.plim) annotation (Line(points={{-110,-44},{0,-44},
          {0,100.05},{0.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(batt_ctrl3, invCtrlBus3.batt_ctrl) annotation (Line(points={{-110,52},
          {40,52},{40,100.05},{50.05,100.05}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(plim3, invCtrlBus3.plim) annotation (Line(points={{-110,-58},{40,-58},
          {40,100.05},{50.05,100.05}},  color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(q1, invCtrlBus1.q) annotation (Line(points={{110,70},{-40,70},{-40,100.05},
          {-39.95,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(p1, invCtrlBus1.p) annotation (Line(points={{110,90},{36,90},{36,90},{
          -40,90},{-40,100.05},{-39.95,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(p2, invCtrlBus2.p) annotation (Line(points={{110,30},{0,30},{0,100.05},
          {0.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(q2, invCtrlBus2.q) annotation (Line(points={{110,10},{0,10},{0,100.05},
          {0.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(p3, invCtrlBus3.p) annotation (Line(points={{110,-30},{40,-30},{40,100.05},
          {50.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(q3, invCtrlBus3.q) annotation (Line(points={{110,-50},{40,-50},{40,100.05},
          {50.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(voltvar1.invCtrlBus, invCtrlBus1) annotation (Line(
      points={{-40,-70},{-40,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(voltvar2.invCtrlBus, invCtrlBus2) annotation (Line(
      points={{0,-70},{0,-70},{0,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(voltvar3.invCtrlBus, invCtrlBus3) annotation (Line(
      points={{40,-70},{40,-70},{40,100},{50,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FLEXGRID_interface_voltvar;
