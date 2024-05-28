within SCooDER.Components.Grid.Model;
model LTC_ctrl
  parameter Real maxStepsUp=16 "Maximal steps regulation up";
  parameter Real maxStepsDn=16 "Maximal steps regulation dn";
  parameter Real deadBand=2 "Deadband";
  parameter Real y_start=0 "Start value";

  parameter Modelica.Units.SI.Time samplePeriod=60 "Sample period";
  parameter Modelica.Units.SI.Time startTime=0
    "Time instant of first sample trigger";

  Real y_int;


  Modelica.Blocks.Math.Feedback err
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=deadBand/2)
    annotation (Placement(transformation(extent={{-50,70},{-30,90}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=-1*deadBand/2)
    annotation (Placement(transformation(extent={{-50,30},{-30,50}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal
    annotation (Placement(transformation(extent={{-20,70},{0,90}})));
  Modelica.Blocks.Math.BooleanToReal booleanToReal1(realTrue=-1)
    annotation (Placement(transformation(extent={{-20,30},{0,50}})));
  Modelica.Blocks.Math.Add add
    annotation (Placement(transformation(extent={{20,50},{40,70}})));
  Modelica.Blocks.Interfaces.RealInput set
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
  Modelica.Blocks.Interfaces.RealInput mea annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120})));
 Modelica.Blocks.Interfaces.RealOutput
            y(start=0) "Control signal"                           annotation (Placement(
       transformation(extent={{100,-10},{120,10}})));
 Modelica.Blocks.Interfaces.RealOutput totAct(start=0)  "Total actuations"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
initial equation
  pre(y_int) = y_start;
  pre(totAct) = 0;

equation

  when sample(startTime, samplePeriod) then
     y_int = if pre(y_int) + add.y > maxStepsUp then maxStepsUp else if pre(y_int) + add.y < -1*maxStepsDn then -1*maxStepsDn else pre(y_int) + add.y;
     y = y_int;
     totAct = pre(totAct) + abs(y_int - pre(y_int));
  end when;


  connect(err.y, greaterThreshold.u) annotation (Line(points={{-71,0},{-60,0},{-60,
          80},{-52,80}}, color={0,0,127}));
  connect(lessThreshold.u, err.y) annotation (Line(points={{-52,40},{-60,40},{-60,
          0},{-71,0}}, color={0,0,127}));
  connect(booleanToReal.y, add.u1) annotation (Line(points={{1,80},{10,80},{10,66},
          {18,66}}, color={0,0,127}));
  connect(booleanToReal1.y, add.u2) annotation (Line(points={{1,40},{10,40},{10,
          54},{18,54}}, color={0,0,127}));
  connect(err.u1, set)
    annotation (Line(points={{-88,0},{-120,0}}, color={0,0,127}));
  connect(mea, err.u2) annotation (Line(points={{0,-120},{0,-80},{-80,-80},{-80,
          -8}}, color={0,0,127}));
  connect(greaterThreshold.y, booleanToReal.u)
    annotation (Line(points={{-29,80},{-22,80}}, color={255,0,255}));
  connect(lessThreshold.y, booleanToReal1.u)
    annotation (Line(points={{-29,40},{-22,40}}, color={255,0,255}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=60, __Dymola_Algorithm="Dassl"));
end LTC_ctrl;
