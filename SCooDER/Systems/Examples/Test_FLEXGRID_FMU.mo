within SCooDER.Systems.Examples;
model Test_FLEXGRID_FMU
  extends Modelica.Icons.Example;
  FLEXGRID.FLEXGRID_FMU fLEXGRID_FMU
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  Modelica.Blocks.Sources.Sine Voltage1(
    phase=0,
    offset=120,
    f=1/5,
    amplitude=10)
    annotation (Placement(transformation(extent={{60,60},{40,80}})));
  Modelica.Blocks.Sources.Constant Scale(k=1) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,0})));
  Modelica.Blocks.Sources.Constant Batt_ctrl(k=0)
    annotation (Placement(transformation(extent={{-60,-40},{-40,-20}})));
  Modelica.Blocks.Sources.Constant Plim(
                                       k=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={14,-50})));
  Modelica.Blocks.Sources.Constant f_fix(k=60) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={70,0})));
  Modelica.Blocks.Sources.Constant v_fix1(k=120) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={70,30})));
  Modelica.Blocks.Sources.Constant Q_ctrl(k=1000) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-20,-50})));
equation
  connect(Scale.y, fLEXGRID_FMU.scale2)
    annotation (Line(points={{-69,0},{-46,0},{-22,0}}, color={0,0,127}));
  connect(Scale.y, fLEXGRID_FMU.scale3) annotation (Line(points={{-69,0},{-46,
          0},{-46,-4},{-22,-4}}, color={0,0,127}));
  connect(Scale.y, fLEXGRID_FMU.scale1) annotation (Line(points={{-69,0},{-46,
          0},{-46,4},{-22,4}}, color={0,0,127}));
  connect(fLEXGRID_FMU.batt_ctrl1, Batt_ctrl.y) annotation (Line(points={{-22,
          -10},{-32,-10},{-32,-30},{-39,-30}}, color={0,0,127}));
  connect(fLEXGRID_FMU.batt_ctrl2, Batt_ctrl.y) annotation (Line(points={{-22,
          -14},{-32,-14},{-32,-30},{-39,-30}}, color={0,0,127}));
  connect(fLEXGRID_FMU.batt_ctrl3, Batt_ctrl.y) annotation (Line(points={{-22,
          -17.6},{-32,-17.6},{-32,-30},{-39,-30}}, color={0,0,127}));
  connect(fLEXGRID_FMU.plim1, Plim.y)
    annotation (Line(points={{10,-22},{10,-39},{14,-39}}, color={0,0,127}));
  connect(fLEXGRID_FMU.plim2, Plim.y)
    annotation (Line(points={{14,-22},{14,-39}}, color={0,0,127}));
  connect(f_fix.y, fLEXGRID_FMU.f1) annotation (Line(points={{59,0},{40,0},{
          40,14},{22,14}}, color={0,0,127}));
  connect(f_fix.y, fLEXGRID_FMU.f2)
    annotation (Line(points={{59,0},{40,0},{40,6},{22,6}}, color={0,0,127}));
  connect(f_fix.y, fLEXGRID_FMU.f3) annotation (Line(points={{59,0},{40,0},{
          40,-2},{22,-2}}, color={0,0,127}));
  connect(v_fix1.y, fLEXGRID_FMU.V2) annotation (Line(points={{59,30},{34,30},
          {34,10},{22,10}}, color={0,0,127}));
  connect(v_fix1.y, fLEXGRID_FMU.V3) annotation (Line(points={{59,30},{52,30},
          {34,30},{34,2},{22,2}}, color={0,0,127}));
  connect(Plim.y, fLEXGRID_FMU.plim3) annotation (Line(points={{14,-39},{16,-39},
          {18,-39},{18,-40},{18,-22}}, color={0,0,127}));
  connect(Voltage1.y, fLEXGRID_FMU.V1) annotation (Line(points={{39,70},{32,
          70},{32,18},{22,18}}, color={0,0,127}));
  connect(fLEXGRID_FMU.q_ctrl1, Q_ctrl.y) annotation (Line(points={{-6,-22},{
          -6,-22},{-6,-40},{-6,-39},{-14,-39},{-20,-39}}, color={0,0,127}));
  connect(fLEXGRID_FMU.q_ctrl2, Q_ctrl.y) annotation (Line(points={{-2,-22},{
          -2,-22},{-2,-40},{-2,-39},{-12,-39},{-20,-39}}, color={0,0,127}));
  connect(fLEXGRID_FMU.q_ctrl3, Q_ctrl.y) annotation (Line(points={{2,-22},{2,
          -22},{2,-40},{2,-39},{-10,-39},{-20,-39}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_FLEXGRID_FMU;
