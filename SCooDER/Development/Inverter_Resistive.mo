within SCooDER.Development;
model Inverter_Resistive
  import Flexgrid = SCooDER;
  parameter Modelica.SIunits.Voltage V_nominal(min=0, start=240)
    "Nominal voltage (V_nominal >= 0)";
  parameter Real etaPV(min=0, max=1, unit="1") = 0.95
    "Inverter conversion efficiency";
  parameter Real etaBatt(min=0, max=1, unit="1") = 0.95
    "Inverter conversion efficiency";

  Buildings.Electrical.AC.OnePhase.Interfaces.Terminal_n term_p
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Blocks.Math.Add P_sum "Sum of Power generation/demand"
    annotation (Placement(transformation(extent={{50,-10},{30,10}})));
  Modelica.Blocks.Interfaces.RealInput Power_PV(unit="W")
    "Power generation from PV (pos if produced)" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,40}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,40})));
  Modelica.Blocks.Interfaces.RealInput Power_Battery(unit="W")
    "Power to/from Battery (pos if produced)" annotation (Placement(
        transformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-40}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=180,
        origin={120,-40})));
  Modelica.Blocks.Interfaces.RealInput pf(start = 1) "Powerfactor of Inverter" annotation (
     Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-120}), iconTransformation(
        extent={{-20,-20},{20,20}},
        rotation=90,
        origin={0,-122})));
  Buildings.Electrical.AC.OnePhase.Sensors.GeneralizedSensor sens_Inverter
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Math.Gain efficiency_PV(k=-1*etaPV)
    "Inverter DC-AC conversion efficiency and Invert signal"
    annotation (Placement(transformation(extent={{90,30},{70,50}})));
  Modelica.Blocks.Math.Gain invert1(k=-1*etaBatt)
    annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
  Buildings.Electrical.AC.OnePhase.Loads.Impedance Z_R(
    R=100,
    RMin=1,
    RMax=1e5,
    use_R_in=true)
         "Impedance with variable R"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,40})));
  //Modelica.Blocks.Sources.RealExpression ActivePower(y=if (P_sum.y>1 or P_sum.y<-1) then ((sens_Inverter.V^2/P_sum.y) - 1)/(10000 - 1) else 10000)
  //Modelica.Blocks.Sources.RealExpression ActivePower(y=if (P_sum.y>1 or P_sum.y<-1) then ((sens_Inverter.V^2/abs(P_sum.y)) - 1)/(10000 - 1) else 1)
  Modelica.Blocks.Sources.RealExpression ActivePower(y=if ((sens_Inverter.V^2/abs(P_sum.y)) - 1)/(1e5 - 1)<1 then ((sens_Inverter.V^2/abs(P_sum.y)) - 1)/(1e5 - 1) else 1)
    annotation (Placement(transformation(extent={{20,50},{0,70}})));
  //Modelica.Blocks.Sources.RealExpression ActivePower(y=homotopy(actual = smooth(0,noEvent(if (P_sum.y>1 or P_sum.y<-1) then ((sens_Inverter.V^2/P_sum.y) - 1)/(10000 - 1) else 10000)), simplified=10000))
  Modelica.Blocks.Sources.RealExpression ReactivePower_C(y=1)
    annotation (Placement(transformation(extent={{20,10},{0,30}})));
  Modelica.Blocks.Sources.RealExpression ReactivePower_L(y=0)
    annotation (Placement(transformation(extent={{20,-30},{0,-10}})));
  Modelica.Blocks.Continuous.FirstOrder filter_Z_R(
    k=1,
    initType=Modelica.Blocks.Types.Init.SteadyState,
    y_start=1,
    T=1)    annotation (Placement(transformation(
        extent={{-6,6},{6,-6}},
        rotation=180,
        origin={-14,60})));
  Flexgrid.Development.invert_load invert_load1
    annotation (Placement(transformation(extent={{-58,50},{-78,70}})));
equation
  //Z_R.y_R = smooth(1, noEvent(if (P_sum.y>1 or P_sum.y<-1) then ((sens_Inverter.V^2/P_sum.y) - 1)/(10000 - 1) else 10000));
  //filter_Z_R.u = if (P_sum.y>1 or P_sum.y<-1) then ((sens_Inverter.V^2/P_sum.y) - 1)/(10000 - 1) else 10000;

  connect(sens_Inverter.terminal_n, term_p)
    annotation (Line(points={{-80,0},{-100,0}}, color={0,120,120}));
  connect(Power_PV, efficiency_PV.u)
    annotation (Line(points={{120,40},{92,40}}, color={0,0,127}));
  connect(invert1.u, Power_Battery)
    annotation (Line(points={{92,-40},{120,-40}}, color={0,0,127}));
  connect(filter_Z_R.y, Z_R.y_R)
    annotation (Line(points={{-20.6,60},{-34,60},{-34,50}}, color={0,0,127}));
  connect(efficiency_PV.y, P_sum.u1)
    annotation (Line(points={{69,40},{62,40},{62,6},{52,6}}, color={0,0,127}));
  connect(invert1.y, P_sum.u2) annotation (Line(points={{69,-40},{69,-23},{52,-23},
          {52,-6}}, color={0,0,127}));
  connect(ActivePower.y, filter_Z_R.u)
    annotation (Line(points={{-1,60},{-6.8,60}},           color={0,0,127}));
  connect(invert_load1.term_p, Z_R.terminal) annotation (Line(points={{-57,60},
          {-48,60},{-48,40},{-40,40}}, color={0,120,120}));
  connect(invert_load1.term_n, sens_Inverter.terminal_p) annotation (Line(
        points={{-79,60},{-70,60},{-70,0},{-60,0}}, color={0,120,120}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Inverter_Resistive;
