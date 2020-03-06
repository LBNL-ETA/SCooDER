within SCooDER.Components.Inverter.Examples;
model Test_InverterLoad_pf
   "Example to test the functionality of the load model."
  extends Modelica.Icons.Example;

  Model.InverterLoad_pf inverterLoad_pf
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Sine pf1(
    offset=0,
    freqHz=1,
    amplitude=1,
    phase=0.78539816339745)
    annotation (Placement(transformation(extent={{60,10},{40,30}})));
  Modelica.Blocks.Sources.Sine Psine1(
    phase=0,
    offset=0,
    freqHz=0.5,
    amplitude=1000)
    annotation (Placement(transformation(extent={{80,-10},{60,10}})));
  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=60, V=120)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(inverterLoad_pf.Pow, Psine1.y)
    annotation (Line(points={{12,0},{59,0}}, color={0,0,127}));
  connect(inverterLoad_pf.pf_in, pf1.y)
    annotation (Line(points={{12,6},{28,6},{28,20},{39,20}}, color={0,0,127}));
  connect(fixVol.terminal, inverterLoad_pf.terminal)
    annotation (Line(points={{-40,0},{-25,0},{-10,0}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_InverterLoad_pf;
