within SCooDER.Components.Controller.Examples;
model Test_loadOnOff
  extends Modelica.Icons.Example;
  Controller.Model.loadOnOff loadOnOff[3](tDelay={60,90,120})
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant const[3](k=100)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Math.Add add[3]
    annotation (Placement(transformation(extent={{-30,-70},{-10,-50}})));
  Modelica.Blocks.Sources.Pulse pulseUp[3](
    amplitude=-0.06,
    width=80,
    period=60,
    nperiod=1,
    offset=1,
    startTime=30)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Modelica.Blocks.Sources.Pulse pulseDn[3](
    amplitude=0.06,
    width=80,
    period=60,
    nperiod=1,
    offset=0,
    startTime(displayUnit="min") = 300)
    annotation (Placement(transformation(extent={{-60,-80},{-40,-60}})));
  Modelica.Blocks.Math.MultiSum sumP(nu=3)
    annotation (Placement(transformation(extent={{34,-6},{46,6}})));
equation
  connect(const.y, loadOnOff.P)
    annotation (Line(points={{-39,0},{-12,0}}, color={0,0,127}));
  connect(add.y, loadOnOff.Vpu)
    annotation (Line(points={{-9,-60},{0,-60},{0,-12}}, color={0,0,127}));
  connect(add.u2, pulseDn.y) annotation (Line(points={{-32,-66},{-36,-66},{-36,
          -70},{-39,-70}}, color={0,0,127}));
  connect(pulseUp.y, add.u1) annotation (Line(points={{-39,-40},{-36,-40},{-36,
          -54},{-32,-54}}, color={0,0,127}));
  connect(loadOnOff.y, sumP.u)
    annotation (Line(points={{11,0},{34,0}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=600, __Dymola_Algorithm="Dassl"));
end Test_loadOnOff;
