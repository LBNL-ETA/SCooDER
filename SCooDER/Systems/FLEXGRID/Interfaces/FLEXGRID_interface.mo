within SCooDER.Systems.FLEXGRID.Interfaces;
model FLEXGRID_interface

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
  Modelica.Blocks.Interfaces.RealInput q_ctrl2(start=0, unit="var") "Reactive power control of inverter" annotation (Placement(transformation(
        origin={-110,10},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,-110})));
  Modelica.Blocks.Interfaces.RealInput q_ctrl3(start=0, unit="var") "Reactive power control of inverter" annotation (Placement(transformation(
        origin={-110,-4},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-110})));
  Modelica.Blocks.Interfaces.RealInput q_ctrl1(start=0, unit="var") "Reactive power control of inverter" annotation (Placement(transformation(
        origin={-110,24},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-110})));
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
equation
  connect(batt_ctrl1, invCtrlBus1.batt_ctrl) annotation (Line(points={{-110,80},
          {-40,80},{-40,100.05},{-39.95,100.05}},
                                                color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(plim1, invCtrlBus1.plim) annotation (Line(points={{-110,-30},{-76,-30},
          {-76,-28},{-40,-28},{-40,100.05},{-39.95,100.05}},
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
  connect(q1, invCtrlBus1.q) annotation (Line(points={{110,70},{-40,70},{-40,
          100.05},{-39.95,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(p1, invCtrlBus1.p) annotation (Line(points={{110,90},{36,90},{36,90},
          {-40,90},{-40,100.05},{-39.95,100.05}}, color={0,0,127}), Text(
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
  connect(p3, invCtrlBus3.p) annotation (Line(points={{110,-30},{40,-30},{40,
          100.05},{50.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(q3, invCtrlBus3.q) annotation (Line(points={{110,-50},{40,-50},{40,
          100.05},{50.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(q_ctrl1, invCtrlBus1.qctrl) annotation (Line(points={{-110,24},{-76,
          24},{-76,24},{-40,24},{-40,100.05},{-39.95,100.05}}, color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(q_ctrl2, invCtrlBus2.qctrl) annotation (Line(points={{-110,10},{0,10},
          {0,100.05},{0.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(q_ctrl3, invCtrlBus3.qctrl) annotation (Line(points={{-110,-4},{40,-4},
          {40,100.05},{50.05,100.05}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FLEXGRID_interface;
