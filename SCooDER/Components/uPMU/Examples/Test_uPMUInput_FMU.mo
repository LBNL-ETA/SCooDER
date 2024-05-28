within SCooDER.Components.uPMU.Examples;
model Test_uPMUInput_FMU

  Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada_1
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Components.Sensor.Model.Probe3ph sens_all
    annotation (Placement(transformation(extent={{70,-10},{50,10}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens2
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=180,
        origin={-10,0})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.FixedVoltage source(f=60, V=
        208)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,0})));
  Model.uPMUInput uPMUInput
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens1
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-10,40})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens3
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-10,-40})));
  Buildings.Electrical.AC.OnePhase.Loads.Resistive loa
    annotation (Placement(transformation(extent={{-20,30},{-40,50}})));
  Buildings.Electrical.AC.OnePhase.Loads.Resistive loa1
    annotation (Placement(transformation(extent={{-20,-50},{-40,-30}})));
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
equation
  connect(sens1.terminal_p, ada_1.terminals[1]) annotation (Line(points={{0,40},{
          10,40},{10,-0.266667},{20.2,-0.266667}},       color={0,120,120}));
  connect(sens3.terminal_p, ada_1.terminals[3]) annotation (Line(points={{0,-40},
          {10,-40},{10,0.266667},{20.2,0.266667}},           color={0,120,
          120}));
  connect(sens1.terminal_n, loa.terminal)
    annotation (Line(points={{-20,40},{-20,40}}, color={0,120,120}));
  connect(sens3.terminal_n, loa1.terminal)
    annotation (Line(points={{-20,-40},{-20,-40}}, color={0,120,120}));
  connect(uPMUInput.P, P) annotation (Line(points={{-62,4},{-80,4},{-80,
          40},{-120,40}}, color={0,0,127}));
  connect(uPMUInput.Q, Q) annotation (Line(points={{-62,-4},{-80,-4},{-80,
          -40},{-120,-40}}, color={0,0,127}));
  connect(sens_all.terminal_n, source.terminal)
    annotation (Line(points={{70,0},{80,0}}, color={0,120,120}));
  connect(sens_all.terminal_p, ada_1.terminal)
    annotation (Line(points={{50,0},{40,0}}, color={0,120,120}));
  connect(sens2.terminal_p, uPMUInput.term_p)
    annotation (Line(points={{-20,0},{-40,0}}, color={0,120,120}));
  connect(sens2.terminal_n, ada_1.terminals[2])
    annotation (Line(points={{0,0},{20.2,0}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_uPMUInput_FMU;
