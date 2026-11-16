within SCooDER.Systems.BidirEV;
model singleEV_drive
  parameter Real shift_time_s=0;
  parameter String fileName="";
  parameter Real EMax(min=0)=24000
    "Battery Capacity [Wh]";
  parameter Real Pmax(min=0)=10000
    "Battery Power [W]";
  parameter Real SOC_start(min=0, max=1, unit="1") = 0.5
    "Initial SOC value";
  parameter Real etaCha(min=0, max=1, unit="1") = 0.96
    "Charging efficiency";
  parameter Real etaDis(min=0, max=1, unit="1") = 0.96
    "Discharging efficiency";

  Components.Battery.Model.Battery EV(EMax=EMax, Pmax=Pmax,
    SOC_start=SOC_start, etaCha=etaCha, etaDis=etaDis)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
 Modelica.Blocks.Interfaces.RealInput Pset(unit="W") annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=0,
        origin={-120,0})));
  Modelica.Blocks.Interfaces.RealOutput SOC "State of Charge [-]"
    annotation (Placement(transformation(extent={{100,40},{120,60}})));
  Modelica.Blocks.Interfaces.RealOutput Pmea(start=0)
    annotation (Placement(transformation(extent={{100,-10},{120,10}})));
  Modelica.Blocks.Math.Gain toPercent(k=100)
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Modelica.Blocks.Sources.CombiTimeTable profiles(
    fileName=fileName,
    tableOnFile=true,
    tableName="tab",
    columns=2:5,
    shiftTime(displayUnit="h") = -1*shift_time_s)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica.Blocks.Logical.Switch drive
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Logical.GreaterThreshold
                                        checkDrive(threshold=1e-3)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  Modelica.Blocks.Math.Gain toW(k=-1e3)
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Modelica.Blocks.Interfaces.RealOutput Pnet(start=0)
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Math.Add net
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  Modelica.Blocks.Logical.Switch park
    annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
  Modelica.Blocks.Sources.Constant vacant(k=0)
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Logical.Not checkPark
    annotation (Placement(transformation(extent={{-20,-40},{0,-20}})));
  Modelica.Blocks.Math.Gain toW1(k=1e3)
    annotation (Placement(transformation(extent={{-60,-90},{-40,-70}})));
equation
  connect(EV.P, Pmea)
    annotation (Line(points={{41,0},{110,0}}, color={0,0,127}));
  connect(toPercent.y, SOC)
    annotation (Line(points={{81,50},{110,50}}, color={0,0,127}));
  connect(EV.SOC, toPercent.u)
    annotation (Line(points={{41,8},{48,8},{48,50},{58,50}}, color={0,0,127}));
  connect(drive.y, EV.PCtrl)
    annotation (Line(points={{11,0},{18,0}}, color={0,0,127}));
  connect(Pset, drive.u3) annotation (Line(points={{-120,0},{-54,0},{-54,-8},{-12,
          -8}}, color={0,0,127}));
  connect(checkDrive.y, drive.u2) annotation (Line(points={{-39,30},{-30,30},{-30,
          0},{-12,0}}, color={255,0,255}));
  connect(toW.u, profiles.y[1])
    annotation (Line(points={{-62,70},{-79,70}}, color={0,0,127}));
  connect(toW.y, drive.u1) annotation (Line(points={{-39,70},{-20,70},{-20,8},{
          -12,8}}, color={0,0,127}));
  connect(net.y, Pnet)
    annotation (Line(points={{81,-60},{110,-60}}, color={0,0,127}));
  connect(park.y, net.u1) annotation (Line(points={{41,-40},{50,-40},{50,-54},{
          58,-54}}, color={0,0,127}));
  connect(park.u1, Pmea) annotation (Line(points={{18,-32},{10,-32},{10,-20},{
          60,-20},{60,0},{110,0}}, color={0,0,127}));
  connect(vacant.y, park.u3)
    annotation (Line(points={{-39,-50},{-39,-48},{18,-48}}, color={0,0,127}));
  connect(checkPark.y, park.u2) annotation (Line(points={{1,-30},{8,-30},{8,-40},
          {18,-40}}, color={255,0,255}));
  connect(checkPark.u, drive.u2) annotation (Line(points={{-22,-30},{-30,-30},{
          -30,0},{-12,0}}, color={255,0,255}));
  connect(checkDrive.u, profiles.y[1]) annotation (Line(points={{-62,30},{-72,
          30},{-72,70},{-79,70}}, color={0,0,127}));
  connect(toW1.u, profiles.y[4]) annotation (Line(points={{-62,-80},{-72,-80},{-72,
          70},{-79,70}},                       color={0,0,127}));
  connect(toW1.y, net.u2) annotation (Line(points={{-39,-80},{50,-80},{50,-66},
          {58,-66}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=18000, __Dymola_Algorithm="Dassl"));
end singleEV_drive;
