within SCooDER.Components.uPMU.Model;
model uPMUInput
  parameter Real V_nominal(unit="V", start=120) = 120;
  Components.Inverter.Model.InverterLoad_PQ PQ_inverterLoad(V_start=V_nominal)
    annotation (Placement(transformation(extent={{40,-10},{20,10}})));
  Modelica.Blocks.Interfaces.RealInput Q(unit="var") "Reactive Power Input"
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-40}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-40})));
  Modelica.Blocks.Interfaces.RealInput P(unit="W") "Active Power Input"
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,40}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,40})));
  Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_p
    annotation (Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));
equation

  connect(P, PQ_inverterLoad.Pow) annotation (Line(points={{-120,40},{-60,40},{-60,
          0},{18,0}}, color={0,0,127}));
  connect(PQ_inverterLoad.terminal, term_p)
    annotation (Line(points={{40,0},{100,0}}, color={0,120,120}));
  connect(PQ_inverterLoad.Q, Q) annotation (Line(points={{18,6},{0,6},{0,-40},{-120,
          -40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end uPMUInput;
