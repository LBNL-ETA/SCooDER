within SCooDER.Systems;
model FLEXGRID_old
  import SmartInverter = SCooDER;

  SmartInverter.Components.Transformer.Model.MPZ mpz_dist
    annotation (Placement(transformation(extent={{80,0},{60,20}})));
  SmartInverter.Components.Sensor.Model.Probe3ph sens_FLEXGRID(V_nominal=208)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,40})));
  Modelica.Blocks.Interfaces.RealInput scale3(start=1,
    min=0,
    max=1,
    unit="1") "Shading of PV module" annotation (Placement(transformation(
        origin={-110,12},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-20})));
  Modelica.Blocks.Interfaces.RealInput scale1(start=1,
    min=0,
    max=1,
    unit="1") "Shading of PV module" annotation (Placement(transformation(
        origin={-110,40},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,20})));
  Modelica.Blocks.Interfaces.RealInput scale2(start=1,
    min=0,
    max=1,
    unit="1") "Shading of PV module" annotation (Placement(transformation(
        origin={-110,26},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,0})));
  SmartInverter.Components.Battery.Model.Battery battery1
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));
  SmartInverter.Components.Battery.Model.Battery battery2
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  SmartInverter.Components.Battery.Model.Battery battery3
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  SmartInverter.Components.Photovoltaics.Model.PVModule_simple pv1
    annotation (Placement(transformation(extent={{-64,46},{-44,66}})));
  SmartInverter.Components.Photovoltaics.Model.PVModule_simple pv2(n=28)
    annotation (Placement(transformation(extent={{-64,6},{-44,26}})));
  SmartInverter.Components.Photovoltaics.Model.PVModule_simple pv3
    annotation (Placement(transformation(extent={{-64,-34},{-44,-14}})));
  Buildings.BoundaryConditions.WeatherData.Bus
                  weaBus "Bus with weather data"
    annotation (Placement(transformation(extent={{-110,70},{-90,90}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Lines.TwoPortMatrixRL FL_feed(
    Z12=20*(1.0/5280.0)*{0.0953,0.8515},
    Z13=20*(1.0/5280.0)*{0.0953,0.7266},
    Z23=20*(1.0/5280.0)*{0.0953,0.7802},
    V_nominal=208,
    Z11=20*(1.0/5280.0)*{0.4013,1.4133},
    Z22=20*(1.0/5280.0)*{0.4013,1.4133},
    Z33=20*(1.0/5280.0)*{0.4013,1.4133}) annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={90,70})));

  Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Terminal_p
             terminal_p "Electric terminal side p"
    annotation (Placement(transformation(extent={{100,80},{120,100}}),
        iconTransformation(extent={{100,80},{120,100}})));
  SmartInverter.Systems.Interfaces.FLEXGRID_interface fLEXGRID_interface
    annotation (Placement(transformation(extent={{30,-80},{50,-60}})));
  Modelica.Blocks.Interfaces.RealInput batt_ctrl3(start=0, unit="W")
    "Battery Power" annotation (Placement(transformation(
        origin={-26,-110},
        extent={{10,10},{-10,-10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-90})));
  Modelica.Blocks.Interfaces.RealInput batt_ctrl1(start=0, unit="W")
    "Battery Power" annotation (Placement(transformation(
        origin={-54,-110},
        extent={{10,10},{-10,-10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-50})));
  Modelica.Blocks.Interfaces.RealInput batt_ctrl2(start=0, unit="W")
    "Battery Power" annotation (Placement(transformation(
        origin={-40,-110},
        extent={{10,10},{-10,-10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-70})));
  Modelica.Blocks.Interfaces.RealInput pf2(start=1,
    min=0,
    max=1,
    unit="1") "Power Factor of Inverter" annotation (Placement(transformation(
        origin={20,-110},
        extent={{10,10},{-10,-10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-10,-110})));
  Modelica.Blocks.Interfaces.RealInput pf3(
    start=1,
    min=0,
    max=1,
    unit="1") "Power Factor of Inverter" annotation (Placement(transformation(
        origin={34,-110},
        extent={{10,10},{-10,-10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,-110})));
  Modelica.Blocks.Interfaces.RealInput pf1(start=1,
    min=0,
    max=1,
    unit="1") "Power Factor of Inverter" annotation (Placement(transformation(
        origin={6,-110},
        extent={{10,10},{-10,-10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-110})));
  Modelica.Blocks.Interfaces.RealInput plim3(
    start=1,
    min=0,
    max=1,
    unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
        origin={90,-110},
        extent={{10,10},{-10,-10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={90,-110})));
  Modelica.Blocks.Interfaces.RealInput plim2(
    start=1,
    min=0,
    max=1,
    unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
        origin={76,-110},
        extent={{10,10},{-10,-10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={70,-110})));
  Modelica.Blocks.Interfaces.RealInput plim1(
    start=1,
    min=0,
    max=1,
    unit="1") "Power Limit of Inverter" annotation (Placement(transformation(
        origin={50,-110},
        extent={{10,10},{-10,-10}},
        rotation=270), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-110})));
  SmartInverter.Components.Inverter.Model.Inverter inverter1
    annotation (Placement(transformation(extent={{26,40},{6,60}})));
  SmartInverter.Components.Inverter.Model.Inverter inverter2
    annotation (Placement(transformation(extent={{26,0},{6,20}})));
  SmartInverter.Components.Inverter.Model.Inverter inverter3
    annotation (Placement(transformation(extent={{26,-40},{6,-20}})));
equation
  connect(sens_FLEXGRID.terminal_p,mpz_dist. mpz_head)
    annotation (Line(points={{90,30},{90,10},{80,10}},
                                               color={0,120,120}));
  connect(inverter1.term_p,mpz_dist. inv_1) annotation (Line(points={{26,50},{
          40,50},{40,16},{60,16}},
                              color={0,120,120}));
  connect(mpz_dist.inv_2, inverter2.term_p)
    annotation (Line(points={{60,10},{26,10}},     color={0,120,120}));
  connect(mpz_dist.inv_3, inverter3.term_p) annotation (Line(points={{60,4},{40,
          4},{40,-30},{26,-30}}, color={0,120,120}));
  connect(inverter2.P_PV, pv2.P)
    annotation (Line(points={{4,16},{-20,16},{-43,16}},
                                             color={0,0,127}));
  connect(inverter3.P_PV, pv3.P)
    annotation (Line(points={{4,-24},{-20,-24},{-43,-24}},
                                                 color={0,0,127}));
  connect(inverter1.P_PV, pv1.P)
    annotation (Line(points={{4,56},{-20,56},{-43,56}},
                                               color={0,0,127}));
  connect(inverter3.P_Batt, battery3.P) annotation (Line(points={{4,-33},{-4,
          -33},{-4,-40},{-9,-40}}, color={0,0,127}));
  connect(inverter2.P_Batt, battery2.P) annotation (Line(points={{4,7},{-4,
          7},{-4,0},{-9,0}}, color={0,0,127}));
  connect(inverter1.P_Batt, battery1.P) annotation (Line(points={{4,47},{-4,
          47},{-4,40},{-9,40}}, color={0,0,127}));
  connect(scale1, pv1.scale)
    annotation (Line(points={{-110,40},{-66,40},{-66,52}}, color={0,0,127}));
  connect(scale2, pv2.scale) annotation (Line(points={{-110,26},{-92,26},{-92,
          12},{-66,12}},
                    color={0,0,127}));
  connect(scale3, pv3.scale) annotation (Line(points={{-110,12},{-94,12},{-94,
          -28},{-66,-28}},
                      color={0,0,127}));
  connect(pv1.weaBus, weaBus) annotation (Line(
      points={{-64,60},{-80,60},{-80,80},{-100,80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pv2.weaBus, weaBus) annotation (Line(
      points={{-64,20},{-80,20},{-80,80},{-100,80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pv3.weaBus, weaBus) annotation (Line(
      points={{-64,-20},{-80,-20},{-80,80},{-100,80}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(FL_feed.terminal_p, sens_FLEXGRID.terminal_n)
    annotation (Line(points={{90,60},{90,50}}, color={0,120,120}));
  connect(FL_feed.terminal_n, terminal_p) annotation (Line(points={{90,80},{90,
          80},{90,90},{110,90}}, color={0,120,120}));
  connect(inverter3.batt_ctrl_inv, battery3.PCtrl) annotation (Line(points=
          {{5,-38},{0,-38},{0,-54},{-40,-54},{-40,-40},{-32,-40}}, color={0,
          0,127}));
  connect(inverter2.batt_ctrl_inv, battery2.PCtrl) annotation (Line(points=
          {{5,2},{0,2},{0,-14},{-40,-14},{-40,0},{-32,0}}, color={0,0,127}));
  connect(inverter1.batt_ctrl_inv, battery1.PCtrl) annotation (Line(points=
          {{5,42},{0,42},{0,26},{-40,26},{-40,40},{-32,40}}, color={0,0,127}));
  connect(inverter1.invCtrlBus, fLEXGRID_interface.invCtrlBus1) annotation (
      Line(
      points={{16,40},{14,40},{14,28},{32,28},{32,-60},{35,-60}},
      color={255,204,51},
      thickness=0.5));
  connect(fLEXGRID_interface.invCtrlBus2, inverter2.invCtrlBus) annotation (
      Line(
      points={{40,-60},{40,-60},{40,-48},{34,-48},{34,-10},{16,-10},{16,0}},
      color={255,204,51},
      thickness=0.5));
  connect(fLEXGRID_interface.invCtrlBus3, inverter3.invCtrlBus) annotation (
      Line(
      points={{45,-60},{46,-60},{46,-54},{16,-54},{16,-40}},
      color={255,204,51},
      thickness=0.5));
  connect(fLEXGRID_interface.batt_ctrl1, batt_ctrl1) annotation (Line(points={{29,-75},
          {-54,-75},{-54,-108},{-54,-110}},                               color=
         {0,0,127}));
  connect(fLEXGRID_interface.batt_ctrl2, batt_ctrl2) annotation (Line(points={{29,-77},
          {-40,-77},{-40,-110}},                    color={0,0,127}));
  connect(fLEXGRID_interface.batt_ctrl3, batt_ctrl3) annotation (Line(points={{29,-79},
          {2,-79},{2,-80},{-26,-80},{-26,-110}},                    color={0,0,
          127}));
  connect(fLEXGRID_interface.pf1, pf1) annotation (Line(points={{37,-81},{36,
          -81},{36,-88},{22,-88},{6,-88},{6,-110}}, color={0,0,127}));
  connect(fLEXGRID_interface.pf2, pf2) annotation (Line(points={{39,-81},{39,
          -91.5},{20,-91.5},{20,-110}}, color={0,0,127}));
  connect(fLEXGRID_interface.pf3, pf3) annotation (Line(points={{41,-81},{41,
          -94.5},{34,-94.5},{34,-110}}, color={0,0,127}));
  connect(plim1, fLEXGRID_interface.plim1) annotation (Line(points={{50,-110},{
          50,-96},{45,-96},{45,-81}}, color={0,0,127}));
  connect(plim2, fLEXGRID_interface.plim2) annotation (Line(points={{76,-110},{
          76,-110},{76,-94},{48,-94},{48,-81},{50,-81},{47,-81}}, color={0,0,
          127}));
  connect(plim3, fLEXGRID_interface.plim3) annotation (Line(points={{90,-110},{
          90,-110},{90,-81},{49,-81}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FLEXGRID_old;
