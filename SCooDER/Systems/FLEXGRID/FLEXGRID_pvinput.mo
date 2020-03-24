within SCooDER.Systems.FLEXGRID;
model FLEXGRID_pvinput
  import SmartInverter = SCooDER;

  SmartInverter.Components.Transformer.Model.MPZ mpz_dist
    annotation (Placement(transformation(extent={{80,0},{60,20}})));
  SmartInverter.Components.Sensor.Model.Probe3ph sens_FLEXGRID(V_nominal=208)
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={90,40})));
  Modelica.Blocks.Interfaces.RealInput pv3(start=0,
    unit="W") "PV generation" annotation (Placement(transformation(
        origin={-110,12},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,-20})));
  Modelica.Blocks.Interfaces.RealInput pv1(start=0,
    unit="W") "PV generation" annotation (Placement(transformation(
        origin={-110,40},
        extent={{10,10},{-10,-10}},
        rotation=180), iconTransformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-110,20})));
  Modelica.Blocks.Interfaces.RealInput pv2(start=0,
    unit="W") "PV generation" annotation (Placement(transformation(
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
  SmartInverter.Components.Inverter.Model.Inverter inverter1
    annotation (Placement(transformation(extent={{26,40},{6,60}})));
  SmartInverter.Components.Inverter.Model.Inverter inverter2
    annotation (Placement(transformation(extent={{26,0},{6,20}})));
  SmartInverter.Components.Inverter.Model.Inverter inverter3
    annotation (Placement(transformation(extent={{26,-40},{6,-20}})));
  SmartInverter.Components.Inverter.Interfaces.InvCtrlBus
                                                     invCtrlBus1
                                                                annotation (
      Placement(transformation(extent={{-60,-110},{-40,-90}}),
                                                             iconTransformation(
          extent={{-60,-110},{-40,-90}})));
  SmartInverter.Components.Inverter.Interfaces.InvCtrlBus
                                                     invCtrlBus2
                                                                annotation (
      Placement(transformation(extent={{-10,-110},{10,-90}}),iconTransformation(
          extent={{-10,-110},{10,-90}})));
  SmartInverter.Components.Inverter.Interfaces.InvCtrlBus
                                                     invCtrlBus3
                                                                annotation (
      Placement(transformation(extent={{40,-110},{60,-90}}), iconTransformation(
          extent={{40,-110},{60,-90}})));
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
  connect(inverter3.P_Batt, battery3.P) annotation (Line(points={{4,-33},{-4,
          -33},{-4,-40},{-9,-40}}, color={0,0,127}));
  connect(inverter2.P_Batt, battery2.P) annotation (Line(points={{4,7},{-4,
          7},{-4,0},{-9,0}}, color={0,0,127}));
  connect(inverter1.P_Batt, battery1.P) annotation (Line(points={{4,47},{-4,
          47},{-4,40},{-9,40}}, color={0,0,127}));
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
  connect(invCtrlBus3, inverter3.invCtrlBus) annotation (Line(
      points={{50,-100},{50,-100},{50,-54},{16,-54},{16,-40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}}));
  connect(inverter2.invCtrlBus, invCtrlBus2) annotation (Line(
      points={{16,0},{16,0},{16,-14},{34,-14},{34,-86},{0,-86},{0,-100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(inverter1.invCtrlBus, invCtrlBus1) annotation (Line(
      points={{16,40},{16,40},{16,26},{32,26},{32,-84},{-50,-84},{-50,-100}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(pv1, inverter1.P_PV) annotation (Line(points={{-110,40},{-60,40},{-60,
          56},{4,56}}, color={0,0,127}));
  connect(pv2, inverter2.P_PV) annotation (Line(points={{-110,26},{-60,26},{-60,
          16},{4,16}}, color={0,0,127}));
  connect(pv3, inverter3.P_PV) annotation (Line(points={{-110,12},{-60,12},{-60,
          -24},{4,-24}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end FLEXGRID_pvinput;
