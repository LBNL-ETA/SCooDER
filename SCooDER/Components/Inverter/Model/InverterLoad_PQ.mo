within SCooDER.Components.Inverter.Model;
model InverterLoad_PQ
  parameter Real V_start(start=120) = 120;
  extends .SCooDER.Components.Inverter.Interfaces.Load_partial(
    redeclare package PhaseSystem =
        Buildings.Electrical.PhaseSystems.OnePhase,
    redeclare Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n
      terminal,
    V_nominal=V_start);
  Modelica.Blocks.Interfaces.RealInput Q(unit="var") "Reactive Power Input"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,60}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,60})));
equation
  i[1] = -homotopy(actual = (v[2]*Q + v[1]*P)/(v[1]^2 + v[2]^2), simplified= 0.0);
  i[2] = -homotopy(actual = (v[2]*P - v[1]*Q)/(v[1]^2 + v[2]^2), simplified= 0.0);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end InverterLoad_PQ;
