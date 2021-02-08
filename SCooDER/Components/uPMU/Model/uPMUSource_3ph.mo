within SCooDER.Components.uPMU.Model;
model uPMUSource_3ph "Voltage reference from uPMU"
  extends
    Buildings.Electrical.AC.ThreePhasesUnbalanced.Sources.BaseClasses.PartialSource;
  constant Modelica.SIunits.Angle angle120 = 2*Modelica.Constants.pi/3 "Phase shift between the phase voltages";
  Buildings.Electrical.AC.ThreePhasesUnbalanced.Interfaces.Adapter3to3 ada "Adapter between the different connectors" annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  uPMUSource_1ph phase1(phiSou=0) annotation (Placement(transformation(extent={{-60,50},{-40,70}})));
  uPMUSource_1ph phase2(phiSou=angle120) annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  uPMUSource_1ph phase3(phiSou=2*angle120) annotation (Placement(transformation(extent={{-60,-70},{-40,-50}})));
  Modelica.Blocks.Interfaces.RealInput V1(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,70}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,90})));
  Modelica.Blocks.Interfaces.RealInput f1(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,50}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,70})));
  Modelica.Blocks.Interfaces.RealInput V2(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,10}), iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,30})));
  Modelica.Blocks.Interfaces.RealInput f2(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-10}),iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,10})));
  Modelica.Blocks.Interfaces.RealInput V3(unit="V", start=120) "RMS voltage of the source" annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-50}),iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-30})));
  Modelica.Blocks.Interfaces.RealInput f3(unit="Hz", start=60) "Frequency of the source" annotation (Placement(transformation(
        extent={{20,-20},{-20,20}},
        rotation=180,
        origin={-120,-70}),iconTransformation(
        extent={{10,-10},{-10,10}},
        rotation=180,
        origin={-110,-50})));
equation

  connect(ada.terminal, connection3to4.terminal4)
    annotation (Line(points={{10,0},{25,0},{40,0}}, color={0,120,120}));
  connect(phase1.terminal, ada.terminals[1]) annotation (Line(points={{-40,60},{
          -26,60},{-26,0.533333},{-9.8,0.533333}}, color={0,120,120}));
  connect(phase2.terminal, ada.terminals[2])
    annotation (Line(points={{-40,0},{-9.8,0}}, color={0,120,120}));
  connect(phase3.terminal, ada.terminals[3]) annotation (Line(points={{-40,-60},
          {-26,-60},{-26,-0.533333},{-9.8,-0.533333}}, color={0,120,120}));
  connect(V1, phase1.V) annotation (Line(points={{-120,70},{-92,70},{-92,64},{-62,
          64}}, color={0,0,127}));
  connect(f1, phase1.f) annotation (Line(points={{-120,50},{-92,50},{-92,56},{-62,
          56}}, color={0,0,127}));
  connect(V2, phase2.V) annotation (Line(points={{-120,10},{-92,10},{-92,4},{-62,
          4}}, color={0,0,127}));
  connect(f2, phase2.f) annotation (Line(points={{-120,-10},{-92,-10},{-92,-4},
        {-62,-4}},  color={0,0,127}));
  connect(V3, phase3.V) annotation (Line(points={{-120,-50},{-92,-50},{-92,-56},
          {-62,-56}}, color={0,0,127}));
  connect(f3, phase3.f) annotation (Line(points={{-120,-70},{-91,-70},{-91,-64},
          {-62,-64}}, color={0,0,127}));
end uPMUSource_3ph;
