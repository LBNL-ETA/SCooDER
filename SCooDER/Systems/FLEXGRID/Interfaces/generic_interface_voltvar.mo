within SCooDER.Systems.FLEXGRID.Interfaces;
model generic_interface_voltvar
  parameter Real V_nominal(min=0, unit="V") = 120 "Nominal sytem voltage to scale Vp.u.";
  parameter Real v_max( start=1.05, unit="1")=1.05 "Voltage maximum [p.u.]";
  parameter Real v_maxdead( start=1.01, unit="1")=1.01 "Upper bound of deadband [p.u.]";
  parameter Real v_mindead( start=0.99, unit="1")=0.99 "Lower bound of deadband [p.u.]";
  parameter Real v_min( start=0.95, unit="1")=0.95 "Voltage minimum [p.u.]";
  parameter Real q_maxind( start=1000, unit="var")=1000 "Maximal Reactive Power (Inductive) [var]";
  parameter Real q_maxcap( start=1000, unit="var")=1000 "Maximal Reactive Power (Capacitive) [var]";
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
  Components.Inverter.Interfaces.InvCtrlBus invCtrlBus annotation (Placement(
        transformation(extent={{-120,-20},{-80,20}}), iconTransformation(extent=
           {{-110,-10},{-90,10}})));
  Modelica.Blocks.Sources.RealExpression activePower(y=p1 + p2 + p3)
    annotation (Placement(transformation(extent={{-50,40},{-80,60}})));
  Modelica.Blocks.Sources.RealExpression reactivePower1(y=q1 + q2 + q3)
    annotation (Placement(transformation(extent={{-50,20},{-80,40}})));
  Modelica.Blocks.Sources.Constant const_voltage(k=0)
    annotation (Placement(transformation(extent={{-60,-40},{-80,-20}})));
equation
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
  connect(voltvar1.InvCtrlBus, invCtrlBus1) annotation (Line(
      points={{-40,-70},{-40,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(voltvar2.InvCtrlBus, invCtrlBus2) annotation (Line(
      points={{0,-70},{0,-70},{0,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(voltvar3.InvCtrlBus, invCtrlBus3) annotation (Line(
      points={{40,-70},{40,-70},{40,100},{50,100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(invCtrlBus1.plim, invCtrlBus.plim) annotation (
    Line(
      points={{-39.95,100.05},{-40,100.05},{-40,0},{-70,0},{-70,0.1},{-99.9,0.1}},
      color={255,204,51},
      thickness=0.5),
    Text(
      string="%first",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right),
    Text(
      string="%second",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(invCtrlBus1.batt_ctrl, invCtrlBus.batt_ctrl) annotation (
    Line(
      points={{-39.95,100.05},{-40,100.05},{-40,0},{-70,0},{-70,0.1},{-99.9,0.1}},
      color={255,204,51},
      thickness=0.5),
    Text(
      string="%first",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right),
    Text(
      string="%second",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(invCtrlBus2.plim, invCtrlBus.plim) annotation (
    Line(
      points={{0.05,100.05},{0,100.05},{0,0},{-50,0},{-50,0.1},{-99.9,0.1}},
      color={255,204,51},
      thickness=0.5),
    Text(
      string="%first",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right),
    Text(
      string="%second",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(invCtrlBus2.batt_ctrl, invCtrlBus.batt_ctrl) annotation (
    Line(
      points={{0.05,100.05},{0,100.05},{0,0},{-50,0},{-50,0.1},{-99.9,0.1}},
      color={255,204,51},
      thickness=0.5),
    Text(
      string="%first",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right),
    Text(
      string="%second",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(invCtrlBus3.plim, invCtrlBus.plim) annotation (
    Line(
      points={{50.05,100.05},{40,100.05},{40,0},{-30,0},{-30,0.1},{-99.9,0.1}},
      color={255,204,51},
      thickness=0.5),
    Text(
      string="%first",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right),
    Text(
      string="%second",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(invCtrlBus3.batt_ctrl, invCtrlBus.batt_ctrl) annotation (
    Line(
      points={{50.05,100.05},{40,100.05},{40,0},{-30,0},{-30,0.1},{-99.9,0.1}},
      color={255,204,51},
      thickness=0.5),
    Text(
      string="%first",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right),
    Text(
      string="%second",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));

  connect(reactivePower1.y, invCtrlBus.q) annotation (Line(points={{-81.5,30},{
          -88,30},{-88,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(activePower.y, invCtrlBus.p) annotation (Line(points={{-81.5,50},{-88,
          50},{-88,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(const_voltage.y, invCtrlBus.v) annotation (Line(points={{-81,-30},{
          -88,-30},{-88,0.1},{-99.9,0.1}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end generic_interface_voltvar;
