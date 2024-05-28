within SCooDER.Components.Grid.Model;
model IEEE13_extPQ_ltc
  extends IEEE13_extPQ_base(
    redeclare Modelica.Blocks.Sources.RealExpression P_head_W(y=grid.P[1].real + grid.P[2].real + grid.P[3].real));

  parameter Real V_set=V_nominal/sqrt(3)/20 "Setpoint voltage for LTC";
  parameter Real maxStepsUp=16 "Maximal steps regulation up";
  parameter Real maxStepsDn=16 "Maximal steps regulation dn";
  parameter Real deadBand=2 "Deadband";
  parameter Modelica.Units.SI.Time samplePeriod=15 "Sample period";
  parameter Real vtRatio=20 "Ratio of voltage transformer";
  parameter Real maxRange=0.1 "Maximal LTC range";
  parameter Integer sensLoc=2 "Location for sensing of LTC";

  Modelica.Blocks.Routing.Replicator replicator(nout=3)
    annotation (Placement(transformation(extent={{-10,-80},{10,-60}})));
  LTC_ctrl LTC_ctrl1(
    maxStepsUp=maxStepsUp,
    maxStepsDn=maxStepsDn,
    deadBand=deadBand,
    samplePeriod=samplePeriod)
    annotation (Placement(transformation(extent={{-70,-60},{-50,-80}})));
  Modelica.Blocks.Sources.Constant Vset(k=V_set)
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));
  Modelica.Blocks.Discrete.FirstOrderHold firstOrderHold(samplePeriod=
        samplePeriod/10)
    annotation (Placement(transformation(extent={{-14,-56},{-26,-44}})));
  Modelica.Blocks.Math.Add LTC(k1=V_nominal*maxRange/maxStepsUp)
    annotation (Placement(transformation(extent={{-36,-76},{-24,-64}})));
  Modelica.Blocks.Math.Gain VT(k=1/vtRatio)
    annotation (Placement(transformation(extent={{-36,-56},{-48,-44}})));
  Modelica.Blocks.Sources.Constant Vnom(k=V_nominal)
    annotation (Placement(transformation(extent={{-60,-96},{-48,-84}})));
  VariableGrid grid(f=60)
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
equation
  connect(Vset.y,LTC_ctrl1. set)
    annotation (Line(points={{-79,-70},{-72,-70}}, color={0,0,127}));
  connect(replicator.u,LTC. y)
    annotation (Line(points={{-12,-70},{-23.4,-70}}, color={0,0,127}));
  connect(LTC_ctrl1.y,LTC. u1) annotation (Line(points={{-49,-70},{-44,-70},{-44,
          -66.4},{-37.2,-66.4}}, color={0,0,127}));
  connect(firstOrderHold.y,VT. u)
    annotation (Line(points={{-26.6,-50},{-34.8,-50}}, color={0,0,127}));
  connect(VT.y,LTC_ctrl1. mea) annotation (Line(points={{-48.6,-50},{-60,-50},{-60,
          -58}}, color={0,0,127}));
  connect(Vnom.y,LTC. u2) annotation (Line(points={{-47.4,-90},{-44,-90},{-44,-73.6},
          {-37.2,-73.6}}, color={0,0,127}));
  connect(replicator.y, grid.V_ext) annotation (Line(points={{11,-70},{40,-70},{
          40,53},{59,53}}, color={0,0,127}));
  connect(firstOrderHold.u, sens[sensLoc].Vy[1]) annotation (Line(points={{-12.8,
          -50},{0,-50},{0,32},{-11,32},{-11,29.3333}},
                                                   color={0,0,127}));
  connect(grid.terminal, ieee13.terminal[1])
    annotation (Line(points={{70,40},{70,20},{82,20}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end IEEE13_extPQ_ltc;
