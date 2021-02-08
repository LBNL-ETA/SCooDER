within SCooDER.Systems.Examples;
model Annual_Flexgrid
  generic_wye_voltvarwatt_simple generic_wye_voltvarwatt_simple1(weaName=
        Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage grid(f=60, V=
        120)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Components.Inverter.Interfaces.InvCtrlBus invCtrlBus annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}),iconTransformation(extent={
            {-110,-10},{-90,10}})));
equation
  connect(generic_wye_voltvarwatt_simple1.terminal_p, grid.terminal)
    annotation (Line(points={{11,0},{60,0}}, color={0,120,120}));
  connect(invCtrlBus, generic_wye_voltvarwatt_simple1.invCtrlBus) annotation (
      Line(
      points={{-100,0},{-10,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Annual_Flexgrid;
