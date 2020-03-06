within SCooDER.Components.Inverter.Model;
model InverterLoad_pf
  "Model of Inverter as incuctive and resistive load with pf -1 to 1"
  extends .SCooDER.Components.Inverter.Interfaces.Load_partial(
    redeclare package PhaseSystem =
        Buildings.Electrical.PhaseSystems.OnePhase,
    redeclare Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n
      terminal,
    V_nominal(start=120));

  Modelica.Blocks.Interfaces.RealInput pf_in(unit="1") "Power factor" annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,60}),  iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,60})));
protected
  Modelica.Blocks.Interfaces.RealInput pf_internal
    "Hidden value of the input load for the conditional connector";
  Modelica.SIunits.Power Q = P*tan(-acos(pf_internal))
    "Reactive power";
equation
  connect(pf_in, pf_internal);

  i[1] = -homotopy(actual = (v[2]*Q + v[1]*P)/(v[1]^2 + v[2]^2), simplified= 0.0);
  i[2] = -homotopy(actual = (v[2]*P - v[1]*Q)/(v[1]^2 + v[2]^2), simplified= 0.0);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end InverterLoad_pf;
