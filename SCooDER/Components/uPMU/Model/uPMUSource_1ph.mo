within SCooDER.Components.uPMU.Model;
model uPMUSource_1ph "Voltage reference from uPMU"
  extends Buildings.Electrical.Interfaces.Source(
    redeclare package PhaseSystem =
      Buildings.Electrical.PhaseSystems.OnePhase,
    redeclare replaceable Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_p terminal);
  parameter Modelica.Units.SI.Angle phiSou=0 "Phase shift of the source";
protected
  Modelica.Units.SI.Angle thetaRel
    "Absolute angle of rotating system as offset to thetaRef";
public
  Modelica.Blocks.Interfaces.RealInput V(unit="V", start=120)
    "RMS voltage of the source" annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,40}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,40})));
  Modelica.Blocks.Interfaces.RealInput f(unit="Hz", start=60) "Frequency of the source"
    annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-40}), iconTransformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-40})));
equation
  if Connections.isRoot(terminal.theta) then
    PhaseSystem.thetaRef(terminal.theta) =  2*Modelica.Constants.pi*f*time;
  end if;
  thetaRel = PhaseSystem.thetaRel(terminal.theta);
  terminal.v = PhaseSystem.phaseVoltages(V, thetaRel + phiSou);

  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end uPMUSource_1ph;
