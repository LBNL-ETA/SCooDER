within SCooDER.Components.Transformer.Examples;
model Test_MPZ
  "Example to test the functionality of the Mini Power zone (MPZ) transformer."
  extends Modelica.Icons.Example;
  Model.MPZ MPZ_dist
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage sou(f=60,
      V=208)
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));
  Sensor.Model.Probe3ph sens
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Buildings.Electrical.AC.OnePhase.Loads.Inductive load_inductive(pf=0.8,
      P_nominal=1000)
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Buildings.Electrical.AC.OnePhase.Loads.Resistive load_resistive(
      P_nominal=1000)
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Buildings.Electrical.AC.OnePhase.Loads.Capacitive load_capacitive(pf=
        0.8, P_nominal=1000)
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor
    sens_resistive
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor
    sens_inductive
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor
    sens_capacitive
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
equation
  connect(sou.terminal, sens.terminal_n)
    annotation (Line(points={{-80,0},{-60,0}}, color={0,120,120}));
  connect(sens.terminal_p, MPZ_dist.mpz_head)
    annotation (Line(points={{-40,0},{-20,0}}, color={0,120,120}));
  connect(sens_resistive.terminal_p, load_resistive.terminal)
    annotation (Line(points={{40,50},{60,50}}, color={0,120,120}));
  connect(sens_capacitive.terminal_p, load_capacitive.terminal)
    annotation (Line(points={{40,-50},{60,-50}}, color={0,120,120}));
  connect(sens_inductive.terminal_p, load_inductive.terminal)
    annotation (Line(points={{40,0},{60,0}}, color={0,120,120}));
  connect(sens_inductive.terminal_n, MPZ_dist.inv_2)
    annotation (Line(points={{20,0},{0,0}}, color={0,120,120}));
  connect(sens_resistive.terminal_n, MPZ_dist.inv_1) annotation (Line(
        points={{20,50},{10,50},{10,6},{0,6}}, color={0,120,120}));
  connect(sens_capacitive.terminal_n, MPZ_dist.inv_3) annotation (Line(
        points={{20,-50},{12,-50},{12,-6},{0,-6}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_MPZ;
