within SCooDER.Dynamic.Sensor.Model;
model dynToPQ
  Modelica.Electrical.Analog.Interfaces.PositivePin p_i
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
  Modelica.Electrical.Analog.Interfaces.NegativePin n_i
    annotation (Placement(transformation(extent={{110,-10},{90,10}})));
  Modelica.Electrical.Analog.Interfaces.PositivePin p_v
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

  parameter Modelica.SIunits.Frequency f_max = 1000
    "Maximum frequency of interest";
  parameter Modelica.SIunits.Frequency f_res = 60
    "Frequency resolution";
  parameter Integer n_out = 2 "Frequency bracket output [f_res*(nout-1) : f_res*nout]";
  Real vrms;
  Real irms;

  dynToPh dynToPh1(
    f_max=f_max,
    f_res=f_res,
    n_out=n_out)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Interfaces.RealOutput q(unit="var") "Reactive power"
    annotation (Placement(
        transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-30,-110})));
  Modelica.Blocks.Interfaces.RealOutput p(unit="W") "Active power"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={-70,-110})));
equation
  vrms = dynToPh1.v_amplitude / sqrt(2);
  irms = dynToPh1.i_amplitude / sqrt(2);
  p = vrms*irms*cos(Modelica.SIunits.Conversions.from_deg(dynToPh1.v_phase-dynToPh1.i_phase));
  q = vrms*irms*sin(Modelica.SIunits.Conversions.from_deg(dynToPh1.v_phase-dynToPh1.i_phase));
  connect(dynToPh1.p_i, p_i)
    annotation (Line(points={{-10,0},{-100,0}}, color={0,0,255}));
  connect(dynToPh1.n_i, n_i)
    annotation (Line(points={{10,0},{100,0}}, color={0,0,255}));
  connect(dynToPh1.p_v, p_v)
    annotation (Line(points={{0,10},{0,100}}, color={0,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end dynToPQ;
