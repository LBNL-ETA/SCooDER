within SCooDER.Components.uPMU.Examples;
model Test_uPMUSource

  Model.uPMUSource_1ph
                   uPMUSource
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Model.uPMUInput uPMUInput
    annotation (Placement(transformation(extent={{60,60},{40,80}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_1ph
    annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={0,70})));
  Modelica.Blocks.Sources.Sine P(
    freqHz=1,
    phase=0,
    offset=0,
    amplitude=1000)
    annotation (Placement(transformation(extent={{100,80},{80,100}})));
  Modelica.Blocks.Sources.Sine Frequency1(
    amplitude=5,
    freqHz=1/10,
    offset=60)
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Modelica.Blocks.Sources.Sine Voltage1(
    phase=0,
    amplitude=10,
    offset=120,
    freqHz=1/5)
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Constant Q(k=0)
    annotation (Placement(transformation(extent={{100,40},{80,60}})));
  Model.uPMUSource_3ph uPMUSource_3ph
    annotation (Placement(transformation(extent={{-38,-10},{-18,10}})));
  Modelica.Blocks.Sources.Sine Frequency2(
    amplitude=5,
    freqHz=1/5,
    offset=30)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Modelica.Blocks.Sources.Sine Voltage2(
    phase=0,
    offset=120,
    freqHz=1/10,
    amplitude=20)
    annotation (Placement(transformation(extent={{-100,0},{-80,20}})));
  Modelica.Blocks.Sources.Sine Frequency3(
    amplitude=5,
    freqHz=1/10,
    offset=90)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Sources.Sine Voltage3(
    phase=0,
    offset=120,
    freqHz=1/2.5,
    amplitude=30)
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  Components.Sensor.Model.Probe3ph sens_3ph_wye
    annotation (Placement(transformation(extent={{0,-10},{20,10}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Resistive load_wye(
    V_nominal=120,
    P_nominal=1200,
    loadConn=Buildings.Electrical.Types.LoadConnection.wye_to_wyeg)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Loads.Resistive load_delta(
    V_nominal=120,
    P_nominal=1200,
    loadConn=Buildings.Electrical.Types.LoadConnection.wye_to_delta)
    annotation (Placement(transformation(extent={{40,-40},{60,-20}})));
  Components.Sensor.Model.Probe3ph sens_3ph_delta
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
equation
  connect(uPMUSource.terminal, sens_1ph.terminal_n)
    annotation (Line(points={{-40,70},{-25,70},{-10,70}}, color={0,120,120}));
  connect(sens_1ph.terminal_p, uPMUInput.term_p)
    annotation (Line(points={{10,70},{25,70},{40,70}}, color={0,120,120}));
  connect(uPMUInput.P,P. y) annotation (Line(points={{62,74},{72,74},{72,90},{79,
          90}},          color={0,0,127}));
  connect(Voltage1.y, uPMUSource.V) annotation (Line(points={{-79,90},{-70,90},{
          -70,74},{-62,74}}, color={0,0,127}));
  connect(uPMUSource.f, Frequency1.y) annotation (Line(points={{-62,66},{-70,66},
          {-70,50},{-79,50}}, color={0,0,127}));
  connect(Q.y, uPMUInput.Q) annotation (Line(points={{79,50},{70,50},{70,66},{62,
          66}},     color={0,0,127}));
  connect(uPMUSource_3ph.V1, uPMUSource.V) annotation (Line(points={{-39,9},{-39,
          8},{-66,8},{-66,74},{-64,74},{-62,74}}, color={0,0,127}));
  connect(uPMUSource_3ph.f1, uPMUSource.f) annotation (Line(points={{-39,7},{-40,
          7},{-40,6},{-68,6},{-68,66},{-64,66},{-62,66}}, color={0,0,127}));
  connect(Voltage2.y, uPMUSource_3ph.V2) annotation (Line(points={{-79,10},{-74,
          10},{-74,3},{-39,3}}, color={0,0,127}));
  connect(Frequency2.y, uPMUSource_3ph.f2) annotation (Line(points={{-79,-20},{-74,
          -20},{-74,1},{-39,1}}, color={0,0,127}));
  connect(uPMUSource_3ph.V3, Voltage3.y) annotation (Line(points={{-39,-3},{-40,
          -3},{-40,-2},{-64,-2},{-68,-2},{-68,-60},{-79,-60}}, color={0,0,127}));
  connect(uPMUSource_3ph.f3, Frequency3.y) annotation (Line(points={{-39,-5},{-40,
          -5},{-40,-4},{-66,-4},{-66,-90},{-79,-90}}, color={0,0,127}));
  connect(uPMUSource_3ph.terminal, sens_3ph_wye.terminal_n)
    annotation (Line(points={{-18,0},{0,0}}, color={0,120,120}));
  connect(sens_3ph_wye.terminal_p, load_wye.terminal)
    annotation (Line(points={{20,0},{20,0},{40,0}}, color={0,120,120}));
  connect(load_delta.terminal, sens_3ph_delta.terminal_p)
    annotation (Line(points={{40,-30},{20,-30}}, color={0,120,120}));
  connect(sens_3ph_delta.terminal_n, uPMUSource_3ph.terminal) annotation (Line(
        points={{0,-30},{-10,-30},{-10,0},{-18,0}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
  experiment(StopTime=15), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_uPMUSource;
