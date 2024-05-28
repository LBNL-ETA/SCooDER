within SCooDER.Components.Controller.Examples;
model Test_Pv_Inv_VoltVarWatt_simple_Slim
  extends Modelica.Icons.Example;
  parameter String weather_file = Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos");
  SCooDER.Components.Controller.Model.Pv_Inv_VoltVarWatt_simple_Slim
    VVW(weather_file=weather_file,
    QMaxInd=3000,
    QMaxCap=3000)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  SCooDER.Components.Inverter.Model.InverterLoad_PQ load_VVW(V_start=120)
    annotation (Placement(transformation(extent={{20,70},{0,50}})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_VVW
    annotation (Placement(transformation(extent={{80,60},{60,80}})));
  Buildings.Electrical.AC.OnePhase.Sensors.Probe ref_VVW(V_nominal=120)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={20,30})));
  Buildings.Electrical.AC.OnePhase.Sources.FixedVoltage fixVol(f=60, V=120)
    annotation (Placement(transformation(extent={{100,80},{80,100}})));
  Buildings.Electrical.AC.OnePhase.Lines.Line line_VVW(
    V_nominal=120,
    P_nominal=5000,
    l=500) annotation (Placement(transformation(extent={{60,60},{40,80}})));
  SCooDER.Components.Controller.Model.Pv_Inv_VoltVarWatt_simple_Slim
    base(
    weather_file=weather_file,
    thrP=1,
    hysP=1,
    QMaxInd=0,
    QMaxCap=0) annotation (Placement(transformation(extent={{-80,-50},{
            -60,-30}})));

  SCooDER.Components.Inverter.Model.InverterLoad_PQ load_base(V_start=120)
    annotation (Placement(transformation(extent={{20,-30},{0,-50}})));
  Buildings.Electrical.AC.OnePhase.Sensors.Probe ref_base(V_nominal=120)
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=-90,
        origin={20,-70})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_base
    annotation (Placement(transformation(extent={{80,-40},{60,-20}})));
  Buildings.Electrical.AC.OnePhase.Lines.Line line_base(
    V_nominal=120,
    P_nominal=5000,
    l=500) annotation (Placement(transformation(extent={{60,-40},{40,-20}})));
equation
  connect(ref_VVW.V, VVW.Vpu) annotation (Line(points={{17,23},{-90,23},{-90,60},
          {-82,60}}, color={0,0,127}));
  connect(ref_VVW.term, load_VVW.terminal) annotation (Line(points={{29,30},{40,
          30},{40,60},{20,60}}, color={0,120,120}));
  connect(ref_base.V, base.Vpu) annotation (Line(points={{17,-77},{-90,-77},{-90,
          -40},{-82,-40}}, color={0,0,127}));
  connect(ref_base.term, load_base.terminal) annotation (Line(points={{29,-70},{
          40,-70},{40,-40},{20,-40}}, color={0,120,120}));
  connect(line_VVW.terminal_n, sens_VVW.terminal_p)
    annotation (Line(points={{60,70},{60,70}}, color={0,120,120}));
  connect(line_base.terminal_n, sens_base.terminal_p)
    annotation (Line(points={{60,-30},{60,-30}}, color={0,120,120}));
  connect(fixVol.terminal, sens_VVW.terminal_n)
    annotation (Line(points={{80,90},{80,70}}, color={0,120,120}));
  connect(fixVol.terminal, sens_base.terminal_n)
    annotation (Line(points={{80,90},{80,-30}}, color={0,120,120}));
  connect(line_base.terminal_p, load_base.terminal)
    annotation (Line(points={{40,-30},{40,-40},{20,-40}}, color={0,120,120}));
  connect(line_VVW.terminal_p, load_VVW.terminal)
    annotation (Line(points={{40,70},{40,60},{20,60}}, color={0,120,120}));
  connect(VVW.P, load_VVW.Pow) annotation (Line(points={{-59,65},{-12,65},{-12,
          60},{-2,60}}, color={0,0,127}));
  connect(VVW.Q, load_VVW.Q) annotation (Line(points={{-59,55},{-20,55},{-20,54},
          {-2,54}}, color={0,0,127}));
  connect(base.P, load_base.Pow) annotation (Line(points={{-59,-35},{-12,-35},{
          -12,-40},{-2,-40}}, color={0,0,127}));
  connect(base.Q, load_base.Q) annotation (Line(points={{-59,-45},{-20,-45},{
          -20,-46},{-2,-46}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)),
  experiment(StartTime=0, StopTime=86400),
  Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Test_Pv_Inv_VoltVarWatt_simple_Slim;
